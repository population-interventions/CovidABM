
import pandas as pd
import numpy as np
import random
import tqdm
import math

import process.serial.tornadoPlot as tornadoPlot
import process.shared.utilities as util
import process.shared.globalVars as gl

FUDGE_APPEND = ''

def GetPrefixList(conf):
	if 'prefixList' not in conf:
		return ['']
	return [''] + conf['prefixList']


def GetTornadoRange(df, sensitivity, metricList, percentile):
	lower = df[sensitivity].quantile(percentile)
	upper = df[sensitivity].quantile(1 - percentile)
	
	output = {}
	for metric in metricList:
		output[metric] = [
			df[df[sensitivity] <= lower][metric].mean(),
			df[df[sensitivity] >= upper][metric].mean()
		]
	return output, [lower, upper]


def GetRandomRange(df, drawMetric, metricList, percentile):
	# Randomise by draw value since parameter draws are by draw value.
	drawVals = list(set(list(df.index.get_level_values(drawMetric))))
	drawCount = math.floor(len(drawVals) * percentile)
	random.shuffle(drawVals)
	
	lowerDraws = drawVals[: drawCount]
	upperDraws = drawVals[-drawCount:]

	output = {}
	for metric in metricList:
		output[metric] = [
			df.loc[lowerDraws, :][metric].mean(),
			df.loc[upperDraws, :][metric].mean()
		]
	return output, [0, 0]


def CalculateOptimalityColumn(df, costPerHaly, identifyIndex=False, stackIndex=False):
	if identifyIndex is not False:
		df = util.IdentifyIndex(df, identifyIndex)
	df['nmb'] = -1*(df['cost'] + costPerHaly * df['haly'])
	df = df['nmb'].unstack('draw_index')
	drawCount = len(list(df.columns.values))
	
	if stackIndex is False:
		dfOpt = df.idxmax()
		df['count'] = dfOpt.value_counts()
		df = (df.fillna(0)[['count']]) / drawCount
		return df['count']
	
	df = df.unstack(stackIndex)
	dfOpt = df.idxmax()
	dfOpt = dfOpt.groupby(stackIndex).apply(lambda r : r.value_counts())
	dfOpt = dfOpt.unstack(stackIndex)

	dfOpt.index = pd.MultiIndex.from_tuples(dfOpt.index)
	dfOpt.index.names = df.index.names
	dfOpt = dfOpt.fillna(0) / drawCount
	
	dfOpt = (0*df[0] + dfOpt).fillna(0)
	dfOpt = dfOpt.stack(stackIndex)
	return dfOpt
	

def CalculateOptimalityRanking(df, costPerHaly, identifyIndex=False, stackIndex=False):
	dfVal = util.IdentifyIndex(df, (identifyIndex if identifyIndex is not False else []) + ['draw_index'])
	dfVal = -1*(dfVal['cost'] + costPerHaly * dfVal['haly'])
	
	dfMedCalc = util.IdentifyIndex(df, (identifyIndex if identifyIndex is not False else []))
	dfMedCalc = -1*(dfMedCalc['cost'] + costPerHaly * dfMedCalc['haly'])
	
	dfMed_05 = util.IdentifyIndex(dfMedCalc, ['draw_index'], quantile=0.05)
	dfMed_50 = util.IdentifyIndex(dfMedCalc, ['draw_index'], quantile=0.5)
	dfMed_95 = util.IdentifyIndex(dfMedCalc, ['draw_index'], quantile=0.95)
	
	outputList = []
	for i in range(len(dfVal.index.values)):
		dfOpt = CalculateOptimalityColumn(df, costPerHaly, identifyIndex=identifyIndex, stackIndex=stackIndex)
		if i == 0:
			dfOptFirst = dfOpt
		
		maxIndex = dfOpt.idxmax()
		maxOptimality = dfOpt[maxIndex]
		globalOpt = dfOptFirst[maxIndex]
		toFilter = {list(dfOpt.index.names)[i] : maxIndex[i] for i in range(len(maxIndex))}
		df = util.FilterOutIndexVal(df, toFilter)
		
		toFilter['rank'] = i + 1
		toFilter['optimality'] = maxOptimality
		toFilter['globalOpt'] = globalOpt
		toFilter['meanValue'] = dfVal[maxIndex]
		toFilter['p_05'] = dfMed_05[maxIndex]
		toFilter['p_50'] = dfMed_50[maxIndex]
		toFilter['p_95'] = dfMed_95[maxIndex]
		outputList.append(toFilter)
	
	dfOut = pd.DataFrame(outputList).set_index(list(dfMed_50.index.names)).sort_index()
	return dfOut


def DoAggregate(df, name, conf, subfolder):
	if 'filterOutIndex' in conf:
		df = util.FilterOutIndexVal(df, conf['filterOutIndex'])
	df = df.groupby(util.ListRemove(list(df.index.names), conf['firstMeanOn'])).mean()
	df = df.unstack(util.ListRemove(list(df.index.names), conf['thenDescribeOn']))
	util.OutputToFile(df, '{}/single/{}_sourceRows'.format(subfolder, name))
	remainingIndex = util.ListRemove(list(df.columns.names), None)
	df = df.describe(percentiles=conf['percentiles']).stack(remainingIndex)
	pctNames = ['{}%'.format(math.floor(x*100)) for x in conf['percentiles']]
	for aggName in ['count', 'mean', 'min', 'max'] + pctNames:
		util.OutputToFile(df.loc[aggName, :], '{}/single/{}_{}'.format(subfolder, name, aggName.replace('%', '')))
	print('{} done'.format(name))


def DoOptimality(df, name, prefix, conf, heatStruct, subfolder):
	if 'filterOutIndex' in conf:
		df = util.FilterOutIndexVal(df, conf['filterOutIndex'])
	df = df[[prefix + conf['halyCol'], prefix + conf['costCol']]]
	df = df.rename(columns={prefix + conf['halyCol'] : 'haly', prefix + conf['costCol'] : 'cost'})
	
	if 'values' in conf:
		dfOut = pd.DataFrame()
		for costPerHaly in range(conf['values'][0], conf['values'][1] + conf['values'][2], conf['values'][2]):
			dfOut[costPerHaly] = CalculateOptimalityColumn(
				df, costPerHaly,
				identifyIndex=conf['identifyIndex'] if 'identifyIndex' in conf else False,
				stackIndex=conf['stackIndex'] if 'stackIndex' in conf else False
			)
		util.OutputToFile(dfOut, '{}/{}optimal/{}'.format(subfolder, prefix, name))
			
	if 'rankingValue' in conf:
		df = CalculateOptimalityRanking(
			df, conf['rankingValue'],
			identifyIndex=conf['identifyIndex'] if 'identifyIndex' in conf else False,
			stackIndex=conf['stackIndex'] if 'stackIndex' in conf else False
		)
		util.OutputToFile(df, '{}/{}optimal/{}'.format(subfolder, prefix, name))
	
	if 'heatmapValue' in conf:
		df = CalculateOptimalityColumn(
			df, conf['heatmapValue'],
			identifyIndex=conf['identifyIndex'] if 'identifyIndex' in conf else False,
			stackIndex=conf['stackIndex'] if 'stackIndex' in conf else False
		)
		util.OutputToFile(df, '{}/{}optimal/{}_pre'.format(subfolder, prefix, name))
		df = util.ToHeatmap(df.to_frame().reset_index(), heatStruct)
		util.OutputToFile(df, '{}/{}optimal/{}'.format(subfolder, prefix, name))


def MakeRankmap(outputName, subfolder, conf):
	print('MakeRankmap')
	df = pd.DataFrame()
	for name, target in conf['metricCols'].items():
		path = '{}/{}.csv'.format(subfolder, target[0])
		if len(target) > 2 and target[2] == True:
			path = '{}.csv'.format(target[0])
		df[name] = pd.read_csv(
			path,
			index_col=list(range(len(conf['index']))))[target[1]]
	
	if 'deriveRanks' in conf:
		for name, deriveConf in conf['deriveRanks'].items():
			if 'value' in deriveConf:
				df[name] = df[deriveConf['value']].rank(
					ascending=deriveConf['ascending'], method='min')
			elif 'average' in deriveConf:
				df[name] = df[deriveConf['average']].mean(axis=1).rank(
					ascending=deriveConf['ascending'], method='min')
	
	if 'sortBy' in conf:
		df = df.sort_values(conf['sortBy'])
	if 'orderCols' in conf:
		df = df[conf['orderCols']]
	util.OutputToFile(df, '{}/rankmaps/{}'.format(subfolder, outputName))	


def DoSingleProcess(conf, subfolder, heatStruct, measureCols_raw, onHpc):
	df = False
	print('DoSingleProcess', 'aggregates')

	if 'rerun_drawAve' in conf:
		df = pd.read_csv(
			subfolder + '/single/single{}.csv'.format(FUDGE_APPEND),
			index_col=list(range(len(measureCols_raw) + 1)))
		dfAve = df.groupby(level=util.ListRemove(list(range(len(measureCols_raw) + 1)), 0), axis=0).mean()
		util.OutputToFile(dfAve, subfolder + '/single/single_drawAve')
	
	if 'aggregates' in conf:
		df = pd.read_csv(
			subfolder + '/single/single{}.csv'.format(FUDGE_APPEND),
			index_col=list(range(len(measureCols_raw) + 1)))
		for name, aggData in conf['aggregates'].items():
			DoAggregate(df, name, aggData, subfolder)
	
	if 'optimality' in conf:
		if df is False:
			df = pd.read_csv(
				subfolder + '/single/single{}.csv'.format(FUDGE_APPEND),
				index_col=list(range(len(measureCols_raw) + 1)))
		for prefix in GetPrefixList(conf):	
			print('DoSingleProcess', 'optimality', prefix)
			for name, aggData in conf['optimality'].items():
				DoOptimality(df, name, prefix, aggData, heatStruct, subfolder)
	
	if 'rankmaps' in conf:
		for name, data in conf['rankmaps'].items():
			MakeRankmap(name, subfolder, data)


def MakeTornadoPlots(tornadoConf, subfolder, measureCols_raw, onHpc, percentile=0.2):
	df = pd.read_csv(
		subfolder + '/single/single{}.csv'.format(FUDGE_APPEND),
		index_col=list(range(len(measureCols_raw) + 1)))
	#df = util.AggregateDuplicateIndex(df)
	
	tornadoData = {}
	senValues = {}
	for randName in ['rand_{}'.format(i) for i in range(10)]:
		tornadoData[randName], senValues[randName] = GetRandomRange(
			df, 'draw_index', tornadoConf['metrics'], percentile
		)
		
	for senMetric in tornadoConf['senList']:
		tornadoData[senMetric], senValues[senMetric] = GetTornadoRange(
			df, senMetric, 
			tornadoConf['metrics'], percentile
		)
	
	
	tornadoData = pd.DataFrame(tornadoData).transpose().to_dict()
	for metric in tornadoConf['metrics']:
		tornadoData[metric] = {
			k : {'value' : v, 'range' : senValues[k]}
			for k, v in tornadoData[metric].items()}
	
	for metric in tornadoConf['metrics']:
		#median = df[metric].quantile(0.5)
		mean = np.float64(df[metric].mean())
		lower = df[metric].quantile(percentile)
		upper = df[metric].quantile(1 - percentile)
		tornadoData[metric][metric] = {
			'value' : [df[df[metric] <= lower][metric].mean(), df[df[metric] >= upper][metric].mean()],
			'range' : [lower, upper]
		}
		tornadoPlot.MakePlot(
			metric, tornadoData[metric], mean,
			saveDir=subfolder + '/tornado',
			 showBrowser=not onHpc, outputData=True)


def MakeSingleHeatmaps(conf, subfolder, heatStruct, measureCols_raw, describe=False):
	df = pd.read_csv(
		subfolder + '/single/single{}.csv'.format(FUDGE_APPEND),
		index_col=list(range(len(measureCols_raw) + 1)))
	#df = util.AggregateDuplicateIndex(df)
	
	for prefix in GetPrefixList(conf):
		for metric in util.PreAddList(prefix, conf['metrics']):
			util.MakeDescribedHeatmapSet(
				'{}/{}heatmapSingle/'.format(subfolder, prefix), df[metric],
				heatStruct, 'heatmap_{}'.format(metric),
				identifyIndex=False, describe=describe)
			
		if 'identifyIndex' in conf:
			for idName, idList in conf['identifyIndex'].items():
				for metric in util.PreAddList(prefix, conf['metrics']):
					util.MakeDescribedHeatmapSet(
						'{}/{}heatmapSingle/'.format(subfolder, prefix), df[metric],
						heatStruct, '{}_{}'.format(idName, metric),
						identifyIndex=idList, describe=describe)


def SingleFixVaccineNames(df):
	#print(df)
	#print(df['costVaccineFixed'])
	indexOrder = list(df.index.names)
	df = df.unstack('Vaccine schedule')
	for schedule in ['CG then OT', 'CG then OT 60+', 'CG then MV', 'CG then MV 60+']:
		df.loc[:, ('costVaccineFixed', schedule)] = df['costVaccineFixed']['CG']
		df.loc[:, ('mid_costVaccineFixed', schedule)] = df['mid_costVaccineFixed']['CG']
	for schedule in ['OT', 'OT 60+', 'MV', 'MV 60+']:
		df.loc[:, ('costVaccineFixed', schedule)] = df['costVaccineFixed']['CG'] * 2/3
		df.loc[:, ('mid_costVaccineFixed', schedule)] = df['mid_costVaccineFixed']['CG'] / 3
		
	df = df.stack('Vaccine schedule')
	df = df.reorder_levels(indexOrder).sort_index()
	#print(df)
	#print(df['costVaccineFixed'])
	return df


def SingleFixMask(df):
	filterIncrease = util.GetMultiIndexFilter(df, {'Mask wearing' : 'Increased', 'Mask stockpile' : 'No Stockpile'})
	filterBothInt = util.GetMultiIndexFilter(df, {'Mask wearing' : 'Increased', 'Mask stockpile' : 'Stockpile N95'})
	filterIncAny = util.GetMultiIndexFilter(df, {'Mask wearing' : 'Increased'})
	costMaskFixed_otherCols = ['mid_{}_{}_costMaskFixed'.format(x[0], x[1]) for x in gl.singleList]
	costMask_cols = ['mid_{}_{}_costMask'.format(x[0], x[1]) for x in gl.singleList] + ['costMask']
	
	print(df['mid_182_546_costMask'])
	print(df['mid_182_546_costMaskFixed'])
	
	# Remove the mask costs for increased no stockpile
	df.loc[filterIncrease, 'costMaskFixed'] = 0
	df.loc[filterIncrease, costMask_cols] = 0
	
	# Remove the extra mask costs for increased with stockpile
	df.loc[filterBothInt, 'costMaskFixed'] = df.loc[filterBothInt, 'costMaskFixed'] * 0.5
	df.loc[filterBothInt, costMask_cols] = df.loc[filterBothInt, costMask_cols] * 0.5
	
	# Copy the correct costMaskFixed to mid_ columns
	for col in costMaskFixed_otherCols:
		df[col] = df['costMaskFixed']
	
	maskPromote = df.loc[filterIncAny, 'sen_maskPromote']
	# Recalculate and add the increased wearing daily advertising cost
	for time in tqdm.tqdm(['mid_{}_{}_'.format(x[0], x[1]) for x in gl.singleList] + ['']):
		lockdownTime = df.loc[filterIncAny, ['{}totStage{}'.format(time, s) for s in [3, 4, 5]]].sum(axis=1)
		adCost = maskPromote * lockdownTime
		df.loc[filterIncAny, time + 'costMask'] = df.loc[filterIncAny, time + 'costMask'] + adCost
		
		# also copy over fixed vaccine costs
		df[time + 'costVaccineFixed'] = df['costVaccineFixed']
	
	print(df['mid_182_546_costMask'])
	print(df['mid_182_546_costMaskFixed'])
	
	return df


def FixSingle(subfolder, measureCols_raw):
	print('FixSingle')
	df = pd.read_csv(
		subfolder + '/single/single_broken{}.csv'.format(FUDGE_APPEND),
		index_col=list(range(len(measureCols_raw) + 1)))
	
	df = SingleFixMask(df)
	util.OutputToFile(df, subfolder + '/single/single{}'.format(FUDGE_APPEND))

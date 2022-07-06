
import pandas as pd
import numpy as np

import process.serial.tornadoPlot as tornadoPlot
import process.shared.utilities as util

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


def CalculateOptimalityColumn(df, costPerHaly, identifyIndex=False):
	if identifyIndex is not False:
		df = df.groupby(util.ListRemove(list(df.index.names), identifyIndex)).mean()
	df['nmb'] = -1*(df['cost'] + costPerHaly * df['haly'])
	df = df['nmb'].unstack('draw_index')
	
	drawCount = len(list(df.columns.values))
	dfOpt = df.idxmax()
	df['count'] = dfOpt.value_counts()
	df = (df.fillna(0)[['count']]) / drawCount
	return df['count']
	

def DoAggregate(df, name, conf, subfolder):
	if conf['method'] == 'tony_known_unknown_system':
		df = df.groupby(util.ListRemove(list(df.index.names), 'draw_index')).mean()
		df = df.unstack(util.ListRemove(list(df.index.names), conf['index']))
		util.OutputToFile(df, '{}/single/{}'.format(subfolder, name))
		df = df.describe(percentiles=conf['percentiles'])
		util.OutputToFile(df, '{}/single/{}_describe'.format(subfolder, name))


def DoOptimality(df, name, conf, subfolder):
	df = df[[conf['halyCol'], conf['costCol']]]
	df = df.rename(columns={conf['halyCol'] : 'haly', conf['costCol'] : 'cost'})
	
	dfOut = pd.DataFrame()
	for costPerHaly in range(conf['values'][0], conf['values'][1], conf['values'][2]):
		dfOut[costPerHaly] = CalculateOptimalityColumn(
			df, costPerHaly,
			identifyIndex=conf['identifyIndex'] if 'identifyIndex' in conf else False)
	util.OutputToFile(dfOut, '{}/optimal/{}'.format(subfolder, name))
	

def DoSingleProcess(conf, subfolder, measureCols_raw, onHpc):
	df = pd.read_csv(
		subfolder + '/single/single.csv',
		index_col=list(range(len(measureCols_raw) + 1)))
	
	if 'aggregates' in conf:
		for name, aggData in conf['aggregates'].items():
			DoAggregate(df, name, aggData, subfolder)
	if 'optimality' in conf:
		for name, aggData in conf['optimality'].items():
			DoOptimality(df, name, aggData, subfolder)


def MakeTornadoPlots(tornadoConf, subfolder, measureCols_raw, onHpc, percentile=0.2):
	df = pd.read_csv(
		subfolder + '/single/single.csv',
		index_col=list(range(len(measureCols_raw) + 1)))
	
	tornadoData = {}
	senValues = {}
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
		median = df[metric].quantile(0.5)
		lower = df[metric].quantile(percentile)
		upper = df[metric].quantile(1 - percentile)
		tornadoData[metric][metric] = {
			'value' : [df[df[metric] <= lower][metric].mean(), df[df[metric] >= upper][metric].mean()],
			'range' : [lower, upper]
		}
		tornadoPlot.MakePlot(
			metric, tornadoData[metric], median,
			saveDir=subfolder + '/tornado', showBrowser=not onHpc)

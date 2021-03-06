import math
import pandas as pd
import numpy as np
from tqdm import tqdm
import time
import os
import re

from process.shared.utilities import OutputToFile, GetCohortData


############### Shared ###############

def Output(df, path):
	index = df.index.to_frame(index=False)
	index = index.drop(columns=['run'])
	df.index = pd.MultiIndex.from_frame(index)
	df = df.rename('value')
	
	# Consider the following as a nicer replacement:
	#"for name, subDf in df.groupby(level=0):"
	for value in index.draw_index.unique():
		rdf = df[df.index.isin([value], level=0)]
		rdf = rdf.reset_index()
		rdf = rdf.drop(columns='draw_index')
		OutputToFile(rdf, path + '_' + str(value), index=False)


############### Infection Step 1 ###############

def SetAgeRange(x):
	if x < 18:
		return 0
	elif x < 35:
		return 18
	elif x < 65:
		return 35
	else:
		return 65


def ProcessInfectChunk(df, chortDf, outputPrefix, months):
	df.columns = df.columns.set_levels(df.columns.levels[1].astype(int), level=1)
	df.columns = df.columns.set_levels(df.columns.levels[2].astype(int), level=2)
	df = df.sort_values(['cohort', 'day'], axis=1)
	
	col_index = df.columns.to_frame()
	col_index = col_index.reset_index(drop=True)
	col_index['year'] = np.floor(col_index['day']/365).astype(int)
	col_index = pd.merge(
		col_index, chortDf,
		on='cohort',
		how='left',
		sort=False)
	col_index['age_min'] = col_index['age'].apply(SetAgeRange)
	df.columns = pd.MultiIndex.from_frame(col_index)
	
	df = df.groupby(level=[5, 3], axis=1).sum()
	
	OutputToFile(df, outputPrefix)


def ProcessInfectCohorts(measureCols, filename, cohortFile, outputPrefix, months):
	cohortData = GetCohortData(cohortFile)
	chunksize = 4 ** 7
	
	for chunk in tqdm(
			pd.read_csv(filename + '.csv', 
				index_col=list(range(2 + len(measureCols))),
				header=list(range(3)),
				dtype={'day' : int, 'cohort' : int},
				chunksize=chunksize),
			total=4):
		ProcessInfectChunk(chunk, cohortData, outputPrefix, months)
		 
############### Sum vaccine and non-vaccine infections ###############

def GetInfectionTable(measureCols, path, filename):
	df = pd.read_csv(
		path + filename + '.csv', 
		index_col=list(range(2 + len(measureCols))),
		header=list(range(2)))
	index = df.index.to_frame()
	index = index.drop(columns=['run'])
	df.index = pd.MultiIndex.from_frame(index)
	return df
	

def AddAndCleanInfections(subfolder, measureCols):
	df_infect_vac = GetInfectionTable(measureCols, subfolder + '/Report_process/', 'infect_vac')
	df_infect_NoVac = GetInfectionTable(measureCols, subfolder + '/Report_process/', 'infect_noVac')
	OutputToFile(df_infect_vac + df_infect_NoVac, subfolder + '/Report_process/infect_total')

############### Stage Step 1 ###############
 
def MakeStageMeanDf(df, stageName, stageNum):
	df = df.apply(lambda c: [1 if x == stageNum else 0 for x in c])
	df = df.groupby(level=[1], axis=1).mean()
	col_index = df.columns.to_frame()
	col_index = col_index.reset_index(drop=True)
	col_index['stage'] = stageName
	df.columns = pd.MultiIndex.from_frame(col_index)
	return df

def ProcessChunkStage(df, outputPrefix):
	df.columns = df.columns.set_levels(df.columns.levels[1].astype(int), level=1)
	df.columns = df.columns.set_levels(df.columns.levels[2].astype(int), level=2)
	
	df.columns = df.columns.droplevel([0, 2])
	
	col_index = df.columns.to_frame()
	col_index = col_index.reset_index(drop=True)
	col_index['year'] = np.floor(col_index['day']/365).astype(int)
	df.columns = pd.MultiIndex.from_frame(col_index)
	
	
	df = pd.concat([MakeStageMeanDf(df, 's1', 0),
					MakeStageMeanDf(df, 's1b', 1),
					MakeStageMeanDf(df, 's2', 2),
					MakeStageMeanDf(df, 's3', 3),
					MakeStageMeanDf(df, 's4', 4)], axis=1)
	
	index = df.index.to_frame()
	index = index.drop(columns=['run'])
	df.index = pd.MultiIndex.from_frame(index)
	
	OutputToFile(df, outputPrefix)


def ProcessStageCohorts(measureCols, filename, outputPrefix):
	chunksize = 4 ** 7
	
	for chunk in tqdm(
			pd.read_csv(filename + '.csv', 
				index_col=list(range(2 + len(measureCols))),
				header=list(range(3)),
				dtype={'day' : int, 'cohort' : int},
				chunksize=chunksize),
			total=4):
		ProcessChunkStage(chunk, outputPrefix)


############### Median Table Shared ###############

def SmartFormat(x, exponent=10**0):
	if x > 1:
		return '{:,.2f}'.format(x/exponent)
	return '{:,.2f}%'.format(x*100)


def ShapeMedianTable(df, measure, groupMeasure, toSort):
	df = df.transpose()[measure]
	df = df.unstack(groupMeasure)
	df = df.reset_index().set_index(toSort).sort_index()
	return df


def OutputMedianUncertainTables(df, outFile, groupMeasure, toSort, exponent=10**0):
	def Format(x):
		if x > 1:
			return '{:,.2f}'.format(x/exponent)
		return '{:,.2f}%'.format(x*100)

	df = df.describe(percentiles=[0.05, 0.95])
	df_med = ShapeMedianTable(df, '50%', groupMeasure, toSort).applymap(Format)
	df_upper = ShapeMedianTable(df, '95%', groupMeasure, toSort).applymap(Format)
	df_lower = ShapeMedianTable(df, '5%', groupMeasure, toSort).applymap(Format)
	df_out = df_med + ' (' + df_lower + ' to ' + df_upper + ')'
	OutputToFile(df_out, outFile)
	

def ConstructMedian(df, groupMeasure, measure, outFile):
	df = df.unstack(groupMeasure)
	OutputMedianUncertainTables(df, outFile, groupMeasure, measure)
	

def ConstructGroupedMedian(df, groupMeasure, measure, outFile):
	df = df.unstack('draw_index').stack(measure)
	df = df.transpose().describe().transpose()['mean']
	df = df.unstack([groupMeasure] + measure)
	OutputMedianUncertainTables(df, outFile, groupMeasure, measure)
	

def ConstructGroupedMedianCompare(df, groupMeasure, measure, compareCol, outFile):
	df = df.unstack('draw_index').stack(measure)
	df = df.transpose().describe().transpose()['mean']
	df = df.unstack([groupMeasure] + measure)
	df = df.sub(df[0], axis=0) * -1
	OutputMedianUncertainTables(df, outFile, groupMeasure, measure)
	

############### Median Table Processing ###############

def OutputReportTables(subfolder, name, measureCols, groupMeasure, compareCol=False, dropRun=False):
	filePath = subfolder + '/Report_process/' + name
	df = pd.read_csv(
		filePath + '.csv', 
		index_col=list(range((2 if dropRun else 1) + len(measureCols))),
		header=list(range(2)))
	
	measure = ['year', 'age_min']
	if dropRun:
		df = df.droplevel('run', axis=0)
	
	#print('ConstructMedian Infect')
	print('ConstructGroupedMedian', name)
	ConstructGroupedMedian(df, groupMeasure, measure, subfolder + '/Report_out/{}_medianAverage'.format(name))
	if compareCol:
		print('ConstructGroupedMedianCompare', name)
		ConstructGroupedMedianCompare(
			df, groupMeasure, measure, 
			subfolder + '/Report_out/{}_medianAverage_diff'.format(name), compareCol=compareCol)

	
def OutputStageReportTables(subfolder, measureCols, groupMeasure, compareCol=False):
	stageFile = subfolder + '/Report_process/stage'
	stageDf = pd.read_csv(
		stageFile + '.csv', 
		index_col=list(range(1 + len(measureCols))),
		header=[0, 1])
	
	measure = ['year']
	stageDf = stageDf.reorder_levels([1, 0], axis=1)
	stageDf = stageDf['s3'] + stageDf['s4']
	
	#print('ConstructMedian Stage')
	#ConstructMedian(stageDf, measure, subfolder + '/Report_out/medianAll_stage')
	print('ConstructGroupedMedian Stage')
	ConstructGroupedMedian(stageDf, groupMeasure, measure, subfolder + '/Report_out/medianAverage_stage')
	if compareCol:
		print('ConstructGroupedMedianCompare Stage')
		ConstructGroupedMedianCompare(
			stageDf, groupMeasure, measure,
			subfolder + '/Report_out/medianAverage_diff_stage', compareCol=compareCol)
	
############### Take averages of 100 runs ###############


def GroupedMedianByVaccinationSpeed_sum(df, measure):
	df = df.unstack('draw_index').stack(measure)
	df = df.transpose().describe().transpose()['mean']
	df = df.unstack(measure)
	return df


def GroupedMedianByVaccinationSpeed_mean(df, measure):
	df = df.unstack('draw_index').stack(measure)
	df = df.transpose().describe().transpose()['mean']
	df = df.unstack(measure)
	return df


def ProcessAverageOverSeeds(subfolder, measureCols):
	print('Process Rollout Median load stage file')
	stageFile = subfolder + '/Report_process/stage'
	stageDf = pd.read_csv(
		stageFile + '.csv',
		index_col=list(range(1 + len(measureCols))),
		header=[0, 1])
	
	stageDf = GroupedMedianByVaccinationSpeed_mean(stageDf, ['year', 'stage'])
	OutputToFile(stageDf, subfolder + '/Report_process/average_seeds_stage')

	print('Process Rollout Median load infect file')
	infectFile = subfolder + '/Report_process/infect_total'
	infectDf = pd.read_csv(
		infectFile + '.csv', 
		index_col=list(range(1 + len(measureCols))),
		header=list(range(2)))

	infectDf = GroupedMedianByVaccinationSpeed_sum(infectDf, ['year', 'age_min'])
	OutputToFile(infectDf, subfolder + '/Report_process/average_seeds_infect')


############### Median Table Processing ###############

def SplitDfByMeasure(df, measure=False, formatFunc=False):
	print(df)
	if measure:
		df = df.unstack(measure)
		
	df = df.describe(percentiles=[0.05, 0.95])
	df = df.transpose()
	if measure:
		df = df.unstack(measure)
	#print(df[['50%']].applymap(formatFunc))
	if not formatFunc:
		formatFunc = SmartFormat
	
	df_med = df[['50%']].applymap(formatFunc)
	df_upper = df[['95%']].applymap(formatFunc)
	df_lower = df[['5%']].applymap(formatFunc)
	
	if measure:
		df_med.columns = df_med.columns.droplevel(0)
		df_upper.columns = df_upper.columns.droplevel(0)
		df_lower.columns = df_lower.columns.droplevel(0)
	else:
		df_med = df_med.rename(columns={'50%' : 'value'})
		df_upper = df_upper.rename(columns={'95%' : 'value'})
		df_lower = df_lower.rename(columns={'5%' : 'value'})
	
	df_out = df_med + ' (' + df_lower + ' to ' + df_upper + ')'
	return df_out


def OutputLineCompare(
		infectDf, df_s34=False, df_s4=False, path='', measure=False,
		paramList=False, doFourOnly=False, formatFunc=False):
	if measure:
		print('Output ' + measure)
	else:
		print('Output Full')
	infectDf = SplitDfByMeasure(infectDf, measure, formatFunc)
	if type(df_s34) != bool:
		df_s34 = SplitDfByMeasure(df_s34, measure, formatFunc)
	if type(df_s4) != bool:
		df_s4 = SplitDfByMeasure(df_s4, measure, formatFunc)

	if paramList:
		for param in paramList:
			df = infectDf[[param]].transpose().reset_index(drop=True)
			df = df.rename(index={0 : measure + '_' + str(param)})
			OutputToFile(df, path)
			if type(df_s34) != bool:
				df = df_s34[[param]].transpose().reset_index(drop=True)
				df = df.rename(index={0 : measure + '_' + str(param) + '_s34'})
				OutputToFile(df, path)
			if doFourOnly and param in doFourOnly:
				df = df_s4[[param]].transpose().reset_index(drop=True)
				df = df.rename(index={0 : measure + '_' + str(param) + '_s4'})
				OutputToFile(df, path)
				
	else:
		df = infectDf.transpose().reset_index(drop=True)
		df = df.rename(index={0 : 'full'})
		OutputToFile(df, path)
		if type(df_s34) != bool:
			df = df_s34.transpose().reset_index(drop=True)
			df = df.rename(index={0 : 'full_s34'})
			OutputToFile(df, path)


def MakeTableFive(subfolder, measureCols, table5Rows, groupMeasure, doDiff=False):
	print('MakeTableFive load average stage file')
	stageFile = subfolder + '/Report_process/average_seeds_stage'
	stageDf = pd.read_csv(
		stageFile + '.csv', 
		index_col=list(range(len(measureCols))),
		header=[0, 1])
	
	df_s34 = stageDf.reorder_levels([1, 0], axis=1)
	df_s34 = df_s34['s3'] + df_s34['s4']
	df_s34 = df_s34.unstack(groupMeasure)
	df_s34 = df_s34.groupby(level=[1], axis=1).mean()
	
	df_s4 = stageDf.reorder_levels([1, 0], axis=1)
	df_s4 = df_s4['s4']
	df_s4 = df_s4.unstack(groupMeasure)
	df_s4 = df_s4.groupby(level=[1], axis=1).mean()
	
	print('MakeTableFive load average infect file')
	infectFile = subfolder + '/Report_process/average_seeds_infect'
	df_inf = pd.read_csv(
		infectFile + '.csv', 
		index_col=list(range(len(measureCols))),
		header=list(range(2)))
	df_inf = df_inf.unstack(groupMeasure)
	df_inf = df_inf.groupby(level=[2], axis=1).sum()
	
	path = subfolder + '/Report_out/table5'
	if doDiff:
		path = path + '_diff'
		df_s34 = df_s34.sub(df_s34[0], axis=0) * -1
		df_s4 = df_s4.sub(df_s4[0], axis=0) * -1
		df_inf = df_inf.sub(df_inf[0], axis=0) * -1

	for values in table5Rows:
		OutputLineCompare(df_inf, df_s34, df_s4, path, *values)

	
############### Process GDP ###############
	
def ProcessGDP(subfolder, inputDir, measureCols, groupMeasure, doDiff=False):
	print('ProcessGDP')
	
	gdp_effects = pd.read_csv(
		inputDir + '/gdp_cost' + '.csv',
		header=[0])
	gdp_effects = gdp_effects.set_index(['stage'])
	
	stageFile = subfolder + '/Report_process/average_seeds_stage'
	stageDf = pd.read_csv(
		stageFile + '.csv',
		index_col=list(range(1 + len(measureCols))),
		header=[0, 1])
	
	stageDf = stageDf.transpose().reorder_levels([1, 0], axis=0).unstack('year') * 365 / 7
	stageDf = stageDf.mul(gdp_effects['gdpPerWeek'], axis=0).transpose()
	stageDf = stageDf.unstack([groupMeasure]).groupby(level=[1], axis=1).sum()
	stageDf = stageDf.unstack('year').reorder_levels([1, 0], axis=1)
	
	if '1' in stageDf.columns.get_level_values('year'):
		stageDf['1'] = stageDf['0'] + stageDf['1']
	stageDf = stageDf.reorder_levels([1, 0], axis=1)
	
	path = subfolder + '/Report_out/gdp'
	if doDiff:
		path = path + '_diff'
		stageDf = stageDf.sub(stageDf[0], axis=0) * -1
	OutputMedianUncertainTables(stageDf, path, groupMeasure, ['year'], exponent=10**0)


############### Organisation (mostly for commenting) ###############

def ProcessInfectionCohorts(subfolder, measureCols, months):
	print('Processing vaccination infection for PMSLT')
	ProcessInfectCohorts(
		measureCols,
		subfolder + '/traces/processed_infectVac',
		subfolder + '/shared/cohortData',
		subfolder + '/Report_process/infect_vac',
		months)
	print('Processing non-vaccination infection for PMSLT')
	ProcessInfectCohorts(
		measureCols,
		subfolder + '/traces/processed_infectNoVac',
		subfolder + '/shared/cohortData',
		subfolder + '/Report_process/infect_noVac',
		months)
	print('Processing mort for PMSLT')
	ProcessInfectCohorts(
		measureCols,
		subfolder + '/traces/processed_mort',
		subfolder + '/shared/cohortData',
		subfolder + '/Report_process/mort',
		months)
	print('Processing hosp PMSLT')
	ProcessInfectCohorts(
		measureCols,
		subfolder + '/traces/processed_hosp',
		subfolder + '/shared/cohortData',
		subfolder + '/Report_process/hosp',
		months)


def ProcessStages(subfolder, measureCols):
	ProcessStageCohorts(measureCols,
						subfolder + '/traces/processed_stage',
						subfolder + '/Report_process/stage')


def ProcessInfection(subfolder, measureCols, months=12):
	ProcessInfectionCohorts(subfolder, measureCols, months)

###############  ###############

def DoProcessingForReport(subfolder, inputDir, measureCols, table5Rows, groupMeasure, doDiff=False, compareCol=False, months=12):
	ProcessStages(subfolder, measureCols)
	ProcessInfection(subfolder, measureCols, months)
	AddAndCleanInfections(subfolder, measureCols)
	
	OutputReportTables(subfolder, 'infect_total', measureCols, groupMeasure, compareCol=compareCol)
	OutputReportTables(subfolder, 'mort', measureCols, groupMeasure, compareCol=compareCol, dropRun=True)
	OutputReportTables(subfolder, 'hosp', measureCols, groupMeasure, compareCol=compareCol, dropRun=True)
	OutputStageReportTables(subfolder, measureCols, groupMeasure, compareCol=compareCol)
	
	ProcessAverageOverSeeds(subfolder, measureCols)
	MakeTableFive(subfolder, measureCols, table5Rows, groupMeasure)
	if doDiff:
		MakeTableFive(subfolder, measureCols, table5Rows, groupMeasure, doDiff=True)
	
	ProcessGDP(subfolder, inputDir, measureCols, groupMeasure)
	if doDiff:
		ProcessGDP(subfolder, inputDir, measureCols, groupMeasure, doDiff=True)




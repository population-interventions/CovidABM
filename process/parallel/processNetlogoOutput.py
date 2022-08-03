# -*- coding: utf-8 -*-
"""
Created on Mon Feb 15 10:22:33 2021

@author: wilsonte
"""

import math
import pandas as pd
import numpy as np
from tqdm import tqdm
import pathlib
import time
import os

#pd.options.mode.chained_assignment = 'raise'

import process.shared.utilities as util
import process.shared.globalVars as gl

WRITE_ALWAYS = False
DELETE_AFTER = True

def SplitOutTableData(
		chunk, dataMap, cohorts, days, arrayIndex, name, filePath, fileAppend,
		fillTo=False, noWrite=False, daily=True):
	columnName = name + '_listOut'
	if daily:
		df = util.SplitNetlogoNestedList(chunk, cohorts, days, columnName, name, fillTo=fillTo)
		df = df[name]
	else:
		df = util.SplitNetlogoList(chunk[[columnName]].copy(), cohorts, columnName, '')
	if dataMap is not False:
		util.OutputToDataMap(df, filePath + '_' + fileAppend + '_' + str(arrayIndex), dataMap)
		if WRITE_ALWAYS:
			util.OutputToFile(df, filePath + '_' + fileAppend + '_' + str(arrayIndex), head=False)
	elif not noWrite:
		util.OutputToFile(df, filePath + '_' + fileAppend + '_' + str(arrayIndex), head=False)
	return df


def DecorateOutDailyData(df, dataMap, arrayIndex, filePath, fileAppend):
	if dataMap is not False:
		util.OutputToDataMap(df, filePath + '_' + fileAppend + '_' + str(arrayIndex), dataMap)
		if WRITE_ALWAYS:
			util.OutputToFile(df, filePath + '_' + fileAppend + '_' + str(arrayIndex), head=False)
	else:
		util.OutputToFile(df, filePath + '_' + fileAppend + '_' + str(arrayIndex), head=False)
	return df


def ProcessAbmChunk(
		chunk: pd.DataFrame, dataMap, outputStaticData, outputDir, singleDir, arrayIndex,
		measureCols_raw, indexRename, day_override=False):
	# Drop colums that are probably never useful.
	
	filename = outputDir + '/processed'
	
	chunk = chunk[[
		'[run number]', 'draw_index',
		'stage_listOut', 'scalephase', 'cumulativeInfected',
		'infectNoVacArray_listOut', 'infectVacArray_listOut',
		'vaccine_listOut', 'vaccineArray_listOut',
		'case_listOut', 'case7_listOut',
		'case14_listOut', 'case28_listOut',
		'age_listOut']
		 + measureCols_raw
		 + ['{}Array_listOut'.format(name) for name in gl.metricListRaw.keys()]
		 + ['{}_listOut'.format(name) for name in gl.countedMetricList]
		 + ['{}_listOut'.format(name) for name in gl.cohortMetricList]
		 + ['{}_out'.format(name) for name in gl.singleMetricList]
	]
	
	cohorts = len(chunk.iloc[0].age_listOut.split(' '))
	vaccines = len(chunk.iloc[0].vaccine_listOut.split(' '))
	days = len(chunk.iloc[0].stage_listOut.split(' '))
	if day_override:
		days = day_override
	
	if outputStaticData:
		staticData = pd.DataFrame(chunk[['age_listOut']].transpose()[0])
		staticData = util.SplitNetlogoList(staticData, cohorts, 0, '').transpose()
		staticData = staticData.rename(columns={'age_listOut': 'age'})
		util.OutputToFile(staticData, filename + '_static' + '_' + str(arrayIndex), head=False) 
		
		staticData = pd.DataFrame(chunk[['vaccine_listOut']].transpose()[0])
		staticData = util.SplitNetlogoList(staticData, vaccines, 0, '').transpose()
		staticData = staticData.rename(columns={'vaccine_listOut': 'vaccine'})
		util.OutputToFile(staticData, filename + '_static_vaccine' + '_' + str(arrayIndex), head=False) 
	
	chunk = chunk.drop(['age_listOut', 'vaccine_listOut'], axis=1)
	chunk = chunk.rename(mapper={'[run number]' : 'run'}, axis=1)
	chunk = chunk.set_index(['run', 'draw_index',] + measureCols_raw)
	
	secondaryData = [
		'scalephase', 'cumulativeInfected',
	]
	
	util.OutputToFile(chunk[secondaryData], filename + '_secondary' + '_' + str(arrayIndex), head=False)
	chunk = chunk.drop(secondaryData, axis=1)
	chunk = util.DoIndexRename(chunk, indexRename)
	
	dfSingle = chunk[['{}_out'.format(metric) for metric in gl.singleMetricList]]
	dfSingle = dfSingle.rename({'{}_out'.format(metric) : metric for metric in gl.singleMetricList}, axis=1)
	util.OutputToFile(dfSingle, '{}/{}_{}'.format(singleDir, 'single', arrayIndex), head=False) 
	
		
	#SplitOutTableData(chunk, 1, days, arrayIndex, 'case', filename, 'case', fillTo=day_override)
	#SplitOutTableData(chunk, 1, days, arrayIndex, 'case7', filename, 'case7', fillTo=day_override)
	#SplitOutTableData(chunk, 1, days, arrayIndex, 'case14', filename, 'case14', fillTo=day_override)
	SplitOutTableData(chunk, dataMap, 1, days, arrayIndex, 'stage', filename, 'stage', fillTo=day_override)
	
	SplitOutTableData(
		chunk, dataMap, vaccines, days, arrayIndex, '{}Array'.format('vaccine'),
		filename, 'vaccine', fillTo=day_override)
	
	dfNoVac = SplitOutTableData(
		chunk, dataMap, cohorts, days, arrayIndex, 'infectNoVacArray',
		filename, 'infectNoVac', fillTo=day_override, noWrite=True)
	dfVac = SplitOutTableData(
		chunk, dataMap, cohorts, days, arrayIndex, 'infectVacArray',
		filename, 'infectVac', fillTo=day_override, noWrite=True)
	DecorateOutDailyData(dfNoVac.apply(pd.to_numeric) + dfVac.apply(pd.to_numeric), dataMap, arrayIndex, filename, 'infect')
	
	for rawName, metric in gl.metricListRaw.items():
		SplitOutTableData(
			chunk, dataMap, cohorts, days, arrayIndex, '{}Array'.format(rawName),
			filename, metric, fillTo=day_override)
		
	for metric in gl.cohortMetricList:
		SplitOutTableData(
			chunk, dataMap, cohorts, days, arrayIndex, metric,
			filename, metric, fillTo=day_override, daily=False)
	
	for metric in gl.countedMetricList:
		SplitOutTableData(
			chunk, dataMap, gl.countedMetricLength, days, arrayIndex, metric,
			filename, metric, fillTo=day_override)
	
	return dataMap


def ProcessAbmOutput(
		inputDir, outputDir, singleDir, arrayIndex,
		indexRename, measureCols_raw,
		day_override=False, useDataMap=True):
	filelist = [(inputDir + '/{}_table_{}').format(str(arrayIndex), str(arrayIndex))]
		
	print("Processing Files", filelist)
	chunksize = 4 ** 7
	firstProcess = True
	dataMap = {} if useDataMap else False
	# Do keep_default_na=False because empty string is a valid input for models
	# however, the index values need to be renamed via indexRename in the spec
	# file for further processing.
	for filename in filelist:
		for chunk in tqdm(pd.read_csv(
					filename + '.csv',
					chunksize=chunksize, header=6,
					keep_default_na=False),
				total=4):
			ProcessAbmChunk(
				chunk, dataMap, firstProcess, outputDir, singleDir, arrayIndex,
				measureCols_raw, indexRename,
				day_override=day_override)
			firstProcess = False
	return dataMap


def ToVisualisation(chunk, outputDir, arrayIndex, append, measureCols, divisor=False, dayStartOffset=0, outputDay=False):
	chunk.columns = chunk.columns.set_levels(chunk.columns.levels[0].astype(int), level=0)
	chunk.columns = chunk.columns.set_levels(chunk.columns.levels[1].astype(int), level=1)
	
	chunk = chunk.groupby(level=[0], axis=1).sum()
	chunk = chunk.sort_values('day', axis=1)
	if divisor:
		chunk = chunk / divisor
	
	if outputDay:
		chunk_day = chunk.copy()
		chunk_day.columns = chunk_day.columns.droplevel(level=0)
		util.OutputToFile(chunk_day, outputDir + '/processed_' + append + '_daily_' + str(arrayIndex), head=False)
		
	index = chunk.columns.to_frame()
	index['week'] = np.floor((index['day'] - dayStartOffset)/7)
	
	chunk.columns = pd.MultiIndex.from_frame(index)
	chunk = chunk.groupby(level=[0], axis=1).sum()
	util.OutputToFile(chunk, outputDir + '/processed_' + append + '_weeklyAgg_' + str(arrayIndex), head=False)


def ProcessFileToVisualisation(dataMap, inputDir, outputDir, arrayIndex, append, measureCols, divisor=False, dayStartOffset=None, outputDay=False):
	chunksize = 4 ** 7
	fileIn = (inputDir + '/processed').format(str(arrayIndex))
	if dataMap is not False:
		chunk = dataMap[fileIn + '_' + append + '_' + str(arrayIndex)].copy()
		ToVisualisation(chunk, outputDir, arrayIndex, append, measureCols, divisor=divisor, dayStartOffset=dayStartOffset, outputDay=outputDay)
	else:
		for chunk in tqdm(pd.read_csv(
					fileIn + '_' + append + '_' + str(arrayIndex) + '.csv', chunksize=chunksize,
					index_col=list(range(2 + len(measureCols))),
					header=list(range(2)),
					dtype={'day' : int, 'cohort' : int}), 
				total=4):
			ToVisualisation(chunk, outputDir, arrayIndex, append, measureCols, divisor=divisor, dayStartOffset=dayStartOffset, outputDay=outputDay)


def InfectionsAndStageVisualise(dataMap, inputDir, outputDir, arrayIndex, measureCols, dayStartOffset=0):
	#print('Processing trace infectNoVac')
	#ProcessFileToVisualisation(inputDir, outputDir, arrayIndex, 'infectNoVac', measureCols, dayStartOffset=dayStartOffset)
	#print('Processing trace infectVac')
	#ProcessFileToVisualisation(inputDir, outputDir, arrayIndex, 'infectVac', measureCols, dayStartOffset=dayStartOffset)
	
	for metric in gl.metricList + ['vaccine']:
		print('Processing trace {}'.format(metric))
		ProcessFileToVisualisation(
			dataMap, inputDir, outputDir, arrayIndex, metric,
			measureCols, dayStartOffset=dayStartOffset)
	
	#print('Processing trace stage')
	#ProcessFileToVisualisation(dataMap, inputDir, outputDir, arrayIndex, 'stage', measureCols, dayStartOffset=dayStartOffset)


def CasesVisualise(inputDir, outputDir, arrayIndex, measureCols, dayStartOffset=0):
	print('Processing cases')
	ProcessFileToVisualisation(
		inputDir, outputDir, arrayIndex, 'case', measureCols, divisor=False,
		dayStartOffset=dayStartOffset, outputDay=True)
	ProcessFileToVisualisation(
		inputDir, outputDir, arrayIndex, 'case7', measureCols, divisor=7,
		dayStartOffset=dayStartOffset, outputDay=True)
	ProcessFileToVisualisation(
		inputDir, outputDir, arrayIndex, 'case14', measureCols, divisor=14,
		dayStartOffset=dayStartOffset, outputDay=True)


############### Cohort outputs for mort/hosp ###############

def CheckForProblem(df):
	df = df.apply(lambda s: pd.to_numeric(s, errors='coerce').notnull().all())
	if not df.eq(True).all():
		print(df)


def OutputDayAgeAgg(df, outputPrefix, measureCols, arrayIndex):
	df = df.groupby(level=list(range(2 + len(measureCols))), axis=0).sum()
	util.OutputToFile(df, outputPrefix + '_daily' + '_' + str(arrayIndex), head=False)
	

def OutputWeek(df, outputPrefix, arrayIndex, aggregate=True):
	index = df.columns.to_frame()
	index['week'] = np.floor(index['day']/7)
	df.columns = pd.MultiIndex.from_frame(index)
	
	if aggregate:
		df = df.groupby(level=['week'], axis=1).sum()
	else:
		df = df.groupby(level=[1, 2], axis=1).sum()
	CheckForProblem(df)
	util.OutputToFile(df, outputPrefix + '_weeklyAgg' + '_' + str(arrayIndex), head=False)

def OutputTenday(df, outputPrefix, arrayIndex, aggregate=True):
	index = df.columns.to_frame()
	index['tenday'] = np.floor(index['day']/10)
	df.columns = pd.MultiIndex.from_frame(index)
	
	if aggregate:
		df = df.groupby(level=['tenday'], axis=1).sum()
	else:
		df = df.groupby(level=[1, 2], axis=1).sum()
	CheckForProblem(df)
	util.OutputToFile(df, outputPrefix + '_tendayAgg' + '_' + str(arrayIndex), head=False)


def OutputQuart(df, outputPrefix, arrayIndex, aggregate=True):
	index = df.columns.to_frame()
	index['quart'] = np.floor((index['day'])/91)
	df.columns = pd.MultiIndex.from_frame(index)
	
	if aggregate:
		df = df.groupby(level=['quart'], axis=1).sum()
	else:
		df = df.groupby(level=[1, 2], axis=1).sum()
	CheckForProblem(df)
	util.OutputToFile(df, outputPrefix + '_quartAgg' + '_' + str(arrayIndex), head=False)


def OutputYear(df, outputPrefix, arrayIndex, aggregate=True):
	index = df.columns.to_frame()
	index['year'] = np.floor((index['day'])/364)
	df.columns = pd.MultiIndex.from_frame(index)
	
	if aggregate:
		df = df.groupby(level=['year'], axis=1).sum()
	else:
		df = df.groupby(level=[1, 2], axis=1).sum()
	CheckForProblem(df)
	util.OutputToFile(df, outputPrefix + '_yearlyAgg' + '_' + str(arrayIndex), head=False)


def ProcessInfectChunk(df, chortDf, outputPrefix, arrayIndex, doDaily=False, doWeekly=False, doTenday=False):
	df.columns = df.columns.set_levels(df.columns.levels[0].astype(int), level=0)
	df.columns = df.columns.set_levels(df.columns.levels[1].astype(int), level=1)
	df = df.sort_values(['cohort', 'day'], axis=1)
	
	col_index = df.columns.to_frame()
	col_index = col_index.reset_index(drop=True)
	col_index = pd.merge(
		col_index, chortDf,
		on='cohort',
		how='left',
		sort=False)
	df.columns = pd.MultiIndex.from_frame(col_index)
	
	# TODO - Figure out why this crashes with dataMap.
	df = df.groupby(level=[0, 2], axis=1).sum()

	# In the ABM age range 15 represents ages 10-17 while age range 25 is
	# ages 18-30. First redestribute these cohorts so they align with 10 year
	# increments.
	# BUT NOT ANYMORE!
	#df[15], df[25] = df[15] + df[25]/5, df[25]*4/5

	# Move cohort names
	ageCols = [i*10 + 5 for i in range(10)]
	df = df.stack('day')
	for age in ageCols:
		# TODO, vectorise?
		if age in df:
			df[age - 5] = df[age]
			df = df.drop(age, axis=1)
		else:
			print("age not found", age)
			print(df)
			df[age - 5] = 0
	df = df.unstack('day')
	
	# Add extra cohorts missing from ABM
	df = df.sort_index(axis=0)
	df = df.sort_index(axis=1)
	# Not anymore! The PMSLT can deal with this (if it exist?)
	#for age in [100 + i*5 for i in range(2)]:
	#	df1 = df.loc[:, slice(80, 80)].rename(columns={80 : age}, level=0)
	#	df = df.join(df1)
	
	df = df.stack(level=['age'])
	OutputQuart(df.copy(), outputPrefix, arrayIndex)
	OutputYear(df.copy(), outputPrefix, arrayIndex)
	
	if doDaily:
		util.OutputToFile(df, outputPrefix + '_' + str(arrayIndex), head=False)
	if doWeekly:
		OutputWeek(df.copy(), outputPrefix, arrayIndex)
	if doTenday:
		OutputTenday(df.copy(), outputPrefix, arrayIndex)
	return df


def ProcessTimelessChunk(df, chortDf, outputPrefix, arrayIndex):
	df.columns = df.columns.astype(int)

	cohortAgeMap = {r['cohort'] : r['age'] for i, r in chortDf.iterrows()}
	df = df.rename(cohortAgeMap, axis=1)

	df = df.sort_index(axis=0)
	df = df.sort_index(axis=1)
	util.OutputToFile(df, outputPrefix + '_' + str(arrayIndex), head=False)


def ProcessVaccineChunk(df, chortDf, outputPrefix, arrayIndex, doDaily=False, doWeekly=False, doTenday=False):
	df.columns = df.columns.set_levels(df.columns.levels[0].astype(int), level=0)
	df.columns = df.columns.set_levels(df.columns.levels[1].astype(int), level=1)
	df = df.sort_values(['cohort', 'day'], axis=1)
	
	col_index = df.columns.to_frame()
	col_index = col_index.reset_index(drop=True)
	col_index = pd.merge(
		col_index, chortDf,
		on='cohort',
		how='left',
		sort=False)
	df.columns = pd.MultiIndex.from_frame(col_index)
	
	# TODO - Figure out why this crashes with dataMap.
	df = df.groupby(level=[0, 2], axis=1).sum()
	df = df.sort_index(axis=0)
	df = df.sort_index(axis=1)
	
	df = df.stack(level=['vaccine'])
	OutputQuart(df.copy(), outputPrefix, arrayIndex)
	OutputYear(df.copy(), outputPrefix, arrayIndex)
	
	if doDaily:
		util.OutputToFile(df, outputPrefix + '_' + str(arrayIndex), head=False)
	if doWeekly:
		OutputWeek(df.copy(), outputPrefix, arrayIndex)
	if doTenday:
		OutputTenday(df.copy(), outputPrefix, arrayIndex)
	return df


def ProcessPrevInfectionsChunk(df, outputPrefix, arrayIndex, doDaily=False, doWeekly=False, doTenday=False):
	df.columns = df.columns.set_levels(df.columns.levels[0].astype(int), level=0)
	df.columns = df.columns.set_levels(df.columns.levels[1].astype(int), level=1)
	df = df.sort_values(['cohort', 'day'], axis=1)
	
	col_index = df.columns.to_frame()
	col_index = col_index.rename(columns={'cohort' : 'prevInfects'})
	df.columns = pd.MultiIndex.from_frame(col_index)
	
	df = df.sort_index(axis=0)
	df = df.sort_index(axis=1)
	
	df = df.stack(level=['prevInfects'])
	OutputQuart(df.copy(), outputPrefix, arrayIndex)
	OutputYear(df.copy(), outputPrefix, arrayIndex)
	
	if doDaily:
		util.OutputToFile(df, outputPrefix + '_' + str(arrayIndex), head=False)
	if doWeekly:
		OutputWeek(df.copy(), outputPrefix, arrayIndex)
	if doTenday:
		OutputTenday(df.copy(), outputPrefix, arrayIndex)
	return df


def ProcessStage(dataMap, inputDir, visualOutDir, outputDir, arrayIndex, measureCols, outputTraces=False, doWeekly=False):
	cohortData = util.GetCohortData(inputDir + '/processed_static' + '_' + str(arrayIndex))
	for metric in gl.metricList:
		print('Processing ages {}'.format(metric))
		ProcessInfectCohorts(
			dataMap, measureCols,
			inputDir + '/processed_{}'.format(metric) + '_' + str(arrayIndex),
			cohortData,
			outputDir + '/{}'.format(metric), arrayIndex, doWeekly=doWeekly)
	
	for metric in gl.cohortMetricList:
		print('Processing ages {}'.format(metric))
		ProcessTimelessCohorts(
			dataMap, measureCols,
			inputDir + '/processed_{}'.format(metric) + '_' + str(arrayIndex),
			cohortData,
			outputDir + '/{}'.format(metric), arrayIndex)
		
	metric = 'vaccine'
	cohortData = util.GetCohortData(inputDir + '/processed_static_vaccine' + '_' + str(arrayIndex), dataCol='vaccine', dataInt=False)
	print('Processing ages {}'.format(metric))
	ProcessVaccineCohorts(
		dataMap, measureCols,
		inputDir + '/processed_{}'.format(metric) + '_' + str(arrayIndex),
		cohortData,
		outputDir + '/{}'.format(metric), arrayIndex, doWeekly=doWeekly)
	

def CleanupFiles(inputDir, arrayIndex):
	for metric in gl.metricList + gl.cohortMetricList + gl.countedMetricList + ['secondary', 'stage', 'vaccine']:
		os.remove(inputDir + '/step_1/processed_{}'.format(metric) + '_' + str(arrayIndex) + '.csv') 
	
	for stage in gl.stages:
		dfStage = df.applymap(lambda x: 1 if x == stage else 0)
		OutputQuart(dfStage.copy(), outputDir + '/processed_stage{}'.format(stage), arrayIndex)
		OutputYear(dfStage.copy(), outputDir + '/processed_stage{}'.format(stage), arrayIndex)


def ProcessInfectCohorts(dataMap, measureCols, filename, cohortData, outputPrefix, arrayIndex, doDaily=False, doWeekly=False):
	chunksize = 4 ** 7
	if dataMap is not False:
		chunk = dataMap[filename].copy()
		df = ProcessInfectChunk(chunk, cohortData, outputPrefix, arrayIndex, doDaily=doDaily, doWeekly=doWeekly)
		if doDaily:
			OutputDayAgeAgg(df, outputPrefix, measureCols, arrayIndex)
	else:
		for chunk in tqdm(pd.read_csv(
					filename + '.csv', 
					index_col=list(range(2 + len(measureCols))),
					header=list(range(2)),
					dtype={'day' : int, 'cohort' : int},
					chunksize=chunksize,
					keep_default_na=False),
				total=4):
			df = ProcessInfectChunk(chunk, cohortData, outputPrefix, arrayIndex, doDaily=doDaily, doWeekly=doWeekly)
			if doDaily:
				OutputDayAgeAgg(df, outputPrefix, measureCols, arrayIndex)


def ProcessTimelessCohorts(dataMap, measureCols, filename, cohortData, outputPrefix, arrayIndex):
	chunksize = 4 ** 7
	for chunk in tqdm(pd.read_csv(
				filename + '.csv', 
				index_col=list(range(2 + len(measureCols))),
				header=list(range(1)),
				chunksize=chunksize,
				keep_default_na=False),
			total=4):
		ProcessTimelessChunk(chunk, cohortData, outputPrefix, arrayIndex)


def ProcessVaccineCohorts(dataMap, measureCols, filename, cohortData, outputPrefix, arrayIndex, doDaily=False, doWeekly=False):
	chunksize = 4 ** 7
	if dataMap is not False:
		chunk = dataMap[filename].copy()
		df = ProcessInfectChunk(chunk, cohortData, outputPrefix, arrayIndex, doDaily=doDaily, doWeekly=doWeekly)
		if doDaily:
			OutputDayAgeAgg(df, outputPrefix, measureCols, arrayIndex)
	else:
		for chunk in tqdm(pd.read_csv(
					filename + '.csv', 
					index_col=list(range(2 + len(measureCols))),
					header=list(range(2)),
					dtype={'day' : int},
					chunksize=chunksize,
					keep_default_na=False),
				total=4):
			df = ProcessVaccineChunk(chunk, cohortData, outputPrefix, arrayIndex, doDaily=doDaily, doWeekly=doWeekly)
			if doDaily:
				OutputDayAgeAgg(df, outputPrefix, measureCols, arrayIndex)


def ProcessPrevInfections(dataMap, measureCols, filename, outputPrefix, arrayIndex, doDaily=False, doWeekly=False):
	chunksize = 4 ** 7
	if dataMap is not False:
		chunk = dataMap[filename].copy()
		df = ProcessInfectChunk(chunk, cohortData, outputPrefix, arrayIndex, doDaily=doDaily, doWeekly=doWeekly)
		if doDaily:
			OutputDayAgeAgg(df, outputPrefix, measureCols, arrayIndex)
	else:
		for chunk in tqdm(pd.read_csv(
					filename + '.csv', 
					index_col=list(range(2 + len(measureCols))),
					header=list(range(2)),
					dtype={'day' : int, 'cohort' : int},
					chunksize=chunksize,
					keep_default_na=False),
				total=4):
			df = ProcessPrevInfectionsChunk(chunk, outputPrefix, arrayIndex, doDaily=doDaily, doWeekly=doWeekly)
			if doDaily:
				OutputDayAgeAgg(df, outputPrefix, measureCols, arrayIndex)


def ProcessInfectionCohorts(
		dataMap, inputDir, outputDir, arrayIndex, measureCols, doWeekly=False):
	#print('Processing vaccination infection')
	#ProcessInfectCohorts(
	#	measureCols,
	#	inputDir + '/processed_infectVac' + '_' + str(arrayIndex),
	#	inputDir + '/processed_static' + '_' + str(arrayIndex),
	#	outputDir + '/infect_vac', arrayIndex)
	#print('Processing non-vaccination infection')
	#ProcessInfectCohorts(
	#	measureCols,
	#	inputDir + '/processed_infectNoVac' + '_' + str(arrayIndex),
	#	inputDir + '/processed_static' + '_' + str(arrayIndex),
	#	outputDir + '/infect_noVac', arrayIndex)
	
	cohortData = util.GetCohortData(inputDir + '/processed_static' + '_' + str(arrayIndex))
	for metric in gl.metricList:
		print('Processing ages {}'.format(metric))
		ProcessInfectCohorts(
			dataMap, measureCols,
			inputDir + '/processed_{}'.format(metric) + '_' + str(arrayIndex),
			cohortData,
			outputDir + '/{}'.format(metric), arrayIndex, doWeekly=doWeekly)
	
	for metric in gl.cohortMetricList:
		print('Processing ages {}'.format(metric))
		ProcessTimelessCohorts(
			dataMap, measureCols,
			inputDir + '/processed_{}'.format(metric) + '_' + str(arrayIndex),
			cohortData,
			outputDir + '/{}'.format(metric), arrayIndex)
		
	metric = 'vaccine'
	cohortData = util.GetCohortData(inputDir + '/processed_static_vaccine' + '_' + str(arrayIndex), dataCol='vaccine', dataInt=False)
	print('Processing ages {}'.format(metric))
	ProcessVaccineCohorts(
		dataMap, measureCols,
		inputDir + '/processed_{}'.format(metric) + '_' + str(arrayIndex),
		cohortData,
		outputDir + '/{}'.format(metric), arrayIndex, doWeekly=doWeekly)
	
	metric = 'prevInfections'
	ProcessPrevInfections(
		dataMap, measureCols,
		inputDir + '/processed_{}'.format(metric) + '_' + str(arrayIndex),
		outputDir + '/{}'.format(metric), arrayIndex, doWeekly=True)
	

def CleanupFiles(inputDir, arrayIndex):
	for metric in gl.metricList + gl.cohortMetricList + gl.countedMetricList + ['secondary', 'stage', 'vaccine']:
		os.remove(inputDir + '/step_1/processed_{}'.format(metric) + '_' + str(arrayIndex) + '.csv') 


############### Cohort outputs for mort/hosp ###############

def DoAbmProcessing(
		inputDir, outputDir, arrayIndex, indexRename, measureCols,
		measureCols_raw, day_override=False, dayStartOffset=0,
		outputTraces=False):
	
	print('Processing ABM Output', inputDir, arrayIndex)
	dataMap = ProcessAbmOutput(
		inputDir, outputDir + '/step_1', outputDir + '/single', arrayIndex, indexRename,
		measureCols_raw, day_override=day_override, useDataMap=False)
	
	if outputTraces:
		InfectionsAndStageVisualise(
			dataMap, outputDir + '/step_1', outputDir + '/visualise',
			arrayIndex, measureCols, dayStartOffset=dayStartOffset)
	
	print('ProcessInfectionCohorts', inputDir, arrayIndex)
	ProcessInfectionCohorts(
		dataMap, outputDir + '/step_1', outputDir + '/cohort',
		arrayIndex, measureCols, doWeekly=False)
	
	ProcessStage(
		dataMap, outputDir + '/step_1', outputDir + '/visualise', outputDir + '/stage',
		arrayIndex, measureCols, outputTraces=outputTraces)
	
	
	if DELETE_AFTER:
		CleanupFiles(outputDir, arrayIndex)

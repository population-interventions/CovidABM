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

import process.shared.utilities as util

metricList = ['mort', 'icu', 'hosp', 'sympt', 'infect']
metricListRaw = {'die' : 'mort', 'icu' : 'icu', 'hosp' : 'hosp', 'sympt' : 'sympt'}

def SplitOutDailyData(chunk, cohorts, days, arrayIndex, name, filePath, fileAppend, fillTo=False):
	columnName = name + '_listOut'
	df = util.SplitNetlogoNestedList(chunk, cohorts, days, columnName, name, fillTo=fillTo)
	df = df[name]
	util.OutputToFile(df, filePath + '_' + fileAppend + '_' + str(arrayIndex), head=False)
	return df


def DecorateOutDailyData(df, arrayIndex, filePath, fileAppend):
	util.OutputToFile(df, filePath + '_' + fileAppend + '_' + str(arrayIndex), head=False)
	return df


def ProcessAbmChunk(
		chunk: pd.DataFrame, outputStaticData, outputDir, arrayIndex,
		measureCols_raw, indexRename, day_override=False):
	# Drop colums that are probably never useful.
	
	filename = outputDir + '/processed'
	
	chunk = chunk[[
		'[run number]', 'draw_index',
		'stage_listOut', 'scalephase', 'cumulativeInfected',
		'infectNoVacArray_listOut', 'infectVacArray_listOut',
		'dieArray_listOut', 'icuArray_listOut', 'hospArray_listOut', 'symptArray_listOut',
		'case_listOut', 'case7_listOut',
		'case14_listOut', 'case28_listOut',
		'age_listOut'
	] + measureCols_raw]
	
	cohorts = len(chunk.iloc[0].age_listOut.split(' '))
	days = len(chunk.iloc[0].stage_listOut.split(' '))
	if day_override:
		days = day_override
	
	if outputStaticData:
		staticData = pd.DataFrame(
			chunk[['age_listOut']].transpose()[0])
		staticData = util.SplitNetlogoList(staticData, cohorts, 0, '').transpose()
		staticData = staticData.rename(
			columns={'age_listOut': 'age'})
		util.OutputToFile(staticData, filename + '_static' + '_' + str(arrayIndex), head=False) 
	
	chunk = chunk.drop(['age_listOut'], axis=1)
	chunk = chunk.rename(mapper={'[run number]' : 'run'}, axis=1)
	chunk = chunk.set_index(['run', 'draw_index',] + measureCols_raw)
	
	secondaryData = [
		'scalephase', 'cumulativeInfected',
	]
	
	util.OutputToFile(chunk[secondaryData], filename + '_secondary' + '_' + str(arrayIndex), head=False)
	chunk = chunk.drop(secondaryData, axis=1)
	chunk = util.DoIndexRename(chunk, indexRename)
	
	SplitOutDailyData(chunk, 1, days, arrayIndex, 'case', filename, 'case', fillTo=day_override)
	SplitOutDailyData(chunk, 1, days, arrayIndex, 'case7', filename, 'case7', fillTo=day_override)
	SplitOutDailyData(chunk, 1, days, arrayIndex, 'case14', filename, 'case14', fillTo=day_override)
	SplitOutDailyData(chunk, 1, days, arrayIndex, 'stage', filename, 'stage', fillTo=day_override)
	
	dfNoVac = SplitOutDailyData(
		chunk, cohorts, days, arrayIndex, 'infectNoVacArray',
		filename, 'infectNoVac', fillTo=day_override)
	dfVac = SplitOutDailyData(
		chunk, cohorts, days, arrayIndex, 'infectVacArray',
		filename, 'infectVac', fillTo=day_override)
	DecorateOutDailyData(dfNoVac + dfVac, arrayIndex, filename, 'infect')
	
	for rawName, metric in metricListRaw.items():
		SplitOutDailyData(
			chunk, cohorts, days, arrayIndex, '{}Array'.format(rawName),
			filename, metric, fillTo=day_override)


def ProcessAbmOutput(
		inputDir, outputDir, arrayIndex,
		indexRename, measureCols_raw,
		day_override=False):
	filelist = [(inputDir + '/{}_table_{}').format(str(arrayIndex), str(arrayIndex))]
		
	print("Processing Files", filelist)
	chunksize = 4 ** 7
	firstProcess = True
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
				chunk, firstProcess, outputDir, arrayIndex,
				measureCols_raw, indexRename,
				day_override=day_override)
			firstProcess = False


def ToVisualisation(chunk, outputDir, arrayIndex, append, measureCols, divisor=False, dayStartOffset=0, outputDay=False):
	chunk.columns = chunk.columns.set_levels(chunk.columns.levels[0].astype(int), level=0)
	chunk.columns = chunk.columns.set_levels(chunk.columns.levels[1].astype(int), level=1)
	print(chunk)
	chunk = chunk.groupby(level=[0], axis=1).sum()
	chunk = chunk.sort_values('day', axis=1)
	if divisor:
		chunk = chunk / divisor
	
	print(chunk)
	if outputDay:
		chunk_day = chunk.copy()
		chunk_day.columns = chunk_day.columns.droplevel(level=0)
		util.OutputToFile(chunk_day, outputDir + '/processed_' + append + '_daily_' + str(arrayIndex), head=False)
		
	index = chunk.columns.to_frame()
	index['week'] = np.floor((index['day'] - dayStartOffset)/7)
	
	print(chunk)
	chunk.columns = pd.MultiIndex.from_frame(index)
	chunk = chunk.groupby(level=[0], axis=1).sum()
	util.OutputToFile(chunk, outputDir + '/processed_' + append + '_weeklyAgg_' + str(arrayIndex), head=False)


def ProcessFileToVisualisation(inputDir, outputDir, arrayIndex, append, measureCols, divisor=False, dayStartOffset=None, outputDay=False):
	chunksize = 4 ** 7
	fileIn = (inputDir + '/processed').format(str(arrayIndex))
	for chunk in tqdm(pd.read_csv(
				fileIn + '_' + append + '_' + str(arrayIndex) + '.csv', chunksize=chunksize,
				index_col=list(range(2 + len(measureCols))),
				header=list(range(2)),
				dtype={'day' : int, 'cohort' : int}), 
			total=4):
		ToVisualisation(chunk, outputDir, arrayIndex, append, measureCols, divisor=divisor, dayStartOffset=dayStartOffset, outputDay=outputDay)


def InfectionsAndStageVisualise(inputDir, outputDir, arrayIndex, measureCols, dayStartOffset=0):
	print('Processing trace infectNoVac')
	ProcessFileToVisualisation(inputDir, outputDir, arrayIndex, 'infectNoVac', measureCols, dayStartOffset=dayStartOffset)
	print('Processing trace infectVac')
	ProcessFileToVisualisation(inputDir, outputDir, arrayIndex, 'infectVac', measureCols, dayStartOffset=dayStartOffset)
	
	for metric in metricList:
		print('Processing trace {}'.format(metric))
		ProcessFileToVisualisation(
			inputDir, outputDir, arrayIndex, metric,
			measureCols, dayStartOffset=dayStartOffset)
	
	print('Processing trace stage')
	ProcessFileToVisualisation(inputDir, outputDir, arrayIndex, 'stage', measureCols, dayStartOffset=dayStartOffset)


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
	

def OutputWeek(df, outputPrefix, arrayIndex):
	index = df.columns.to_frame()
	index['week'] = np.floor(index['day']/7)
	df.columns = pd.MultiIndex.from_frame(index)
	
	df = df.groupby(level=['week'], axis=1).sum()
	CheckForProblem(df)
	util.OutputToFile(df, outputPrefix + '_weeklyAgg' + '_' + str(arrayIndex), head=False)

def OutputTenday(df, outputPrefix, arrayIndex):
	index = df.columns.to_frame()
	index['tenday'] = np.floor(index['day']/10)
	df.columns = pd.MultiIndex.from_frame(index)
	
	df = df.groupby(level=['tenday'], axis=1).sum()
	CheckForProblem(df)
	util.OutputToFile(df, outputPrefix + '_tendayAgg' + '_' + str(arrayIndex), head=False)


def OutputYear(df, outputPrefix, arrayIndex):
	index = df.columns.to_frame()
	index['year'] = np.floor((index['day'])/365)
	df.columns = pd.MultiIndex.from_frame(index)
	
	df = df.groupby(level=['year'], axis=1).sum()
	CheckForProblem(df)
	util.OutputToFile(df, outputPrefix + '_yearlyAgg' + '_' + str(arrayIndex), head=False)


def ProcessInfectChunk(df, chortDf, outputPrefix, arrayIndex, doDaily=False, doTenday=False):
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
	
	df = df.groupby(level=[0, 2], axis=1).sum()

	# In the ABM age range 15 represents ages 10-17 while age range 25 is
	# ages 18-30. First redestribute these cohorts so they align with 10 year
	# increments.
	# BUT NOT ANYMORE!
	#df[15], df[25] = df[15] + df[25]/5, df[25]*4/5

	# Then split the 10 year cohorts in half.
	ageCols = [i*10 + 5 for i in range(10)]
	df = df.stack('day')
	for age in ageCols:
		# TODO, vectorise?
		if age in df:
			df[age - 5] = df[age]/2
			df[age] = df[age]/2
		else:
			df[age - 5] = 0
			df[age] = 0
	df = df.unstack('day')
	
	# Add extra cohorts missing from ABM
	df = df.sort_index(axis=0)
	df = df.sort_index(axis=1)
	# Not anymore! The PMSLT can deal with this (if it exist?)
	#for age in [100 + i*5 for i in range(2)]:
	#	df1 = df.loc[:, slice(80, 80)].rename(columns={80 : age}, level=0)
	#	df = df.join(df1)
	
	df = df.stack(level=['age'])
	if doDaily:
		util.OutputToFile(df, outputPrefix + '_' + str(arrayIndex), head=False)
	OutputWeek(df.copy(), outputPrefix, arrayIndex)
	if doTenday:
		OutputTenday(df.copy(), outputPrefix, arrayIndex)
	OutputYear(df.copy(), outputPrefix, arrayIndex)
	return df


def ProcessInfectCohorts(measureCols, filename, cohortFile, outputPrefix, arrayIndex):
	cohortData = util.GetCohortData(cohortFile)
	chunksize = 4 ** 7
	
	for chunk in tqdm(pd.read_csv(
				filename + '.csv', 
				index_col=list(range(2 + len(measureCols))),
				header=list(range(2)),
				dtype={'day' : int, 'cohort' : int},
				chunksize=chunksize,
				keep_default_na=False),
			total=4):
		df = ProcessInfectChunk(chunk, cohortData, outputPrefix, arrayIndex)
		OutputDayAgeAgg(df, outputPrefix, measureCols, arrayIndex)


def ProcessInfectionCohorts(inputDir, outputDir, arrayIndex, measureCols):
	print('Processing vaccination infection')
	ProcessInfectCohorts(
		measureCols,
		inputDir + '/processed_infectVac' + '_' + str(arrayIndex),
		inputDir + '/processed_static' + '_' + str(arrayIndex),
		outputDir + '/infect_vac', arrayIndex)
	print('Processing non-vaccination infection')
	ProcessInfectCohorts(
		measureCols,
		inputDir + '/processed_infectNoVac' + '_' + str(arrayIndex),
		inputDir + '/processed_static' + '_' + str(arrayIndex),
		outputDir + '/infect_noVac', arrayIndex)
	
	for metric in metricList:
		print('Processing ages {}'.format(metric))
		ProcessInfectCohorts(
			measureCols,
			inputDir + '/processed_{}'.format(metric) + '_' + str(arrayIndex),
			inputDir + '/processed_static' + '_' + str(arrayIndex),
			outputDir + '/{}'.format(metric), arrayIndex)


############### Cohort outputs for mort/hosp ###############

def DoAbmProcessing(inputDir, outputDir, arrayIndex, indexRename, measureCols, measureCols_raw, day_override=False, dayStartOffset=0):
	print('Processing ABM Output', inputDir, arrayIndex)
	#ProcessAbmOutput(inputDir, outputDir + '/step_1', arrayIndex, indexRename, measureCols_raw, day_override=day_override)
	
	#CasesVisualise(outputDir + '/step_1', outputDir + '/visualise', arrayIndex, measureCols, dayStartOffset=dayStartOffset)
	InfectionsAndStageVisualise(outputDir + '/step_1', outputDir + '/visualise', arrayIndex, measureCols, dayStartOffset=dayStartOffset)
	
	print('ProcessInfectionCohorts', inputDir, arrayIndex)
	ProcessInfectionCohorts(outputDir + '/step_1', outputDir + '/cohort', arrayIndex, measureCols)


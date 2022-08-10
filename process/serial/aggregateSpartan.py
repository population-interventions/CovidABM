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

from process.shared.utilities import SplitNetlogoList
from process.shared.utilities import SplitNetlogoNestedList
from process.shared.utilities import OutputToFile
from process.shared.utilities import AddFiles, AppendFiles
from process.shared.utilities import ToHeatmap

import process.shared.utilities as util
import process.shared.globalVars as gl


def AppendParallels(
		dataDir, rawDataDir, outDir, indexSize, outputSubdir, prefix,
		runIndexer, indexList, fileNames, header=1, indexGrouping=False,
		doAverage=False, numberKeys=True):
	for file in fileNames:
		if prefix:
			thisPrefix = prefix + '_'
		else:
			thisPrefix = ''
		print('\n' + file)
		AppendFiles(
			dataDir + outDir + thisPrefix + file,
			[rawDataDir + outputSubdir + thisPrefix + file + '_' + str(x) for x in indexList],
			runIndexer,
			doTqdm=True,
			numberKeys=numberKeys,
			indexSize=indexSize,
			header=header,
			head=False,
			indexGrouping=indexGrouping,
			doAverage=doAverage
		)


def DoSpartanAggregate(
		dataDir, rawDataDir, measureCols, runIndexer, arraySize=400,
		skip=False, processCohort=True, processStages=True,
		indexGrouping=False, doAverage=False, outputTraces=False):
	indexList = range(1, arraySize + 1)
	if skip:
		indexList = util.ListRemove(indexList, skip)
	
	util.OutputToFile(util.GetCohortData(
		rawDataDir + '/step_1/processed_static_1').drop(columns='cohort'),
		dataDir + '/shared/cohortData', head=False)
	
	processAgg = []
	processCount = []
	tracesAgg = []
	for metric in gl.metricList:
		processAgg.append('{}_quartAgg'.format(metric))
		processAgg.append('{}_yearlyAgg'.format(metric))
		tracesAgg.append('{}_weeklyAgg'.format(metric))
	for metric, conf in gl.timefullMetrics.items():
		if 'aggMean' in conf and conf['aggMean'] is True:
			processCount.append('{}_quartMean'.format(metric))
			processCount.append('{}_yearlyMean'.format(metric))
			processCount.append('{}_weeklyMean'.format(metric))
		else:
			processCount.append('{}_quartAgg'.format(metric))
			processCount.append('{}_yearlyAgg'.format(metric))
			processCount.append('{}_weeklyAgg'.format(metric))
		if 'doDaily' in conf and conf['doDaily'] is True:
			processCount.append('{}_daily'.format(metric))
	tracesAgg.append('stage_daily')
	
	stageAgg = []
	for stage in gl.stages:
		stageAgg.append('processed_stage{}_quartAgg'.format(stage))
		stageAgg.append('processed_stage{}_yearlyAgg'.format(stage))
	
	AppendParallels(
		dataDir, rawDataDir, '/timeless/', len(measureCols) + 2, '/cohort/', False,
		runIndexer, indexList, gl.cohortMetricList, indexGrouping=indexGrouping, doAverage=doAverage)
	AppendParallels(
		dataDir, rawDataDir, '/single/', len(measureCols) + 2, '/single/', False,
		runIndexer, indexList, ['single'], indexGrouping=indexGrouping, doAverage=doAverage, numberKeys=False)

	AppendParallels(
		dataDir, rawDataDir, '/timefull/', len(measureCols) + 3, '/cohort/', False,
		runIndexer, indexList, processCount, indexGrouping=indexGrouping, doAverage=doAverage)

	if processCohort:
		# Larger index because cohort data contains age
		AppendParallels(
			dataDir, rawDataDir, '/cohort/', len(measureCols) + 3, '/cohort/', False,
			runIndexer, indexList, processAgg, indexGrouping=indexGrouping, doAverage=doAverage)
	
	if processStages:
		AppendParallels(
			dataDir, rawDataDir, '/stage/', len(measureCols) + 2, '/stage/', False,
			runIndexer, indexList, stageAgg, indexGrouping=indexGrouping, doAverage=doAverage)
	
	if outputTraces:
		AppendParallels(
			dataDir, rawDataDir, '/traces/', len(measureCols) + 2, '/visualise/', 'processed',
			runIndexer, indexList, tracesAgg, indexGrouping=indexGrouping)

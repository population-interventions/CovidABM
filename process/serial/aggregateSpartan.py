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

metricList = ['mort', 'icu', 'hosp', 'sympt', 'infect']

def AppendParallels(
		dataDir, rawDataDir, outDir, indexSize, outputSubdir, prefix,
		runIndexer, indexList, fileNames, header=1, indexGrouping=False):
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
			indexSize=indexSize,
			header=header,
			head=False,
			indexGrouping=indexGrouping
		)


def DoSpartanAggregate(
		dataDir, rawDataDir, measureCols, runIndexer, arraySize=400,skip=False,
		processCohort=True, indexGrouping=False):
	indexList = range(1, arraySize + 1)
	if skip:
		indexList = util.ListRemove(indexList, skip)
	
	util.OutputToFile(util.GetCohortData(
		rawDataDir + '/step_1/processed_static_1').drop(columns='cohort'),
		dataDir + '/shared/cohortData', head=False)
	
	processAgg = []
	tracesAgg = []
	for metric in metricList:
		processAgg.append('{}_quartAgg'.format(metric))
		processAgg.append('{}_yearlyAgg'.format(metric))
		
		tracesAgg.append('{}_weeklyAgg'.format(metric))
	
	if processCohort:
		# Larger index because cohort data contains age
		AppendParallels(
			dataDir, rawDataDir, '/cohort/', len(measureCols) + 3, '/cohort/', False,
			runIndexer, indexList, processAgg, indexGrouping=indexGrouping)
	
	AppendParallels(
		dataDir, rawDataDir, '/traces/', len(measureCols) + 2, '/visualise/', 'processed',
		runIndexer, indexList, tracesAgg, indexGrouping=indexGrouping)

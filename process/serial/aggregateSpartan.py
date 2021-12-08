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

from shared.utilities import SplitNetlogoList
from shared.utilities import SplitNetlogoNestedList
from shared.utilities import OutputToFile
from shared.utilities import AddFiles, AppendFiles
from shared.utilities import ToHeatmap
import shared.utilities as util


def AppendParallels(dataDir, rawDataDir, outDir, measureCols, outputSubdir, prefix, indexList, fileNames, header=1):
	for file in fileNames:
		print('\n' + file)
		AppendFiles(
			dataDir + outDir + prefix + '_' + file,
			[rawDataDir + outputSubdir + prefix + '_' + file + '_' + str(x) for x in indexList],
			doTqdm=True,
			index=len(measureCols) + 2,
			header=header,
		)


def DoSpartanAggregate(dataDir, rawDataDir, measureCols, arraySize=100, skip=False, doTenday=False, doLong=False):
	indexList = range(1, arraySize + 1)
	if skip:
		indexList = util.ListRemove(indexList, skip)
	
	util.OutputToFile(util.GetCohortData(rawDataDir + '/step_1/processed_static_1').drop(columns='cohort'), dataDir + '/shared/cohortData')
	
	mortAgg = [
		'noVac_daily',
		'noVac_weeklyAgg',
		'noVac_yearlyAgg',
		'vac_daily',
		'vac_weeklyAgg',
		'vac_yearlyAgg',
	]
	
	if doTenday:
		mortAgg = mortAgg + [
			'noVac_tendayAgg',
			'vac_tendayAgg',
		]
	
	if doLong:
		# May not exist as these files are large.
		mortAgg = mortAgg + [
			'noVac',
			'vac',
		]
	
	AppendParallels(
		dataDir, rawDataDir, '/Mort_process/', measureCols,
		'/cohort/', 'infect', indexList, mortAgg)
	
	AppendParallels(
		dataDir, rawDataDir, '/Traces/', measureCols,
		'/step_1/', 'processed', indexList, [
			'case',
			'case7',
			'case14',
			'infectNoVac',
			'infectVac',
			'stage',
		],
		header=3,
	)
	
	AppendParallels(
		dataDir, rawDataDir, '/Traces/', measureCols,
		'/visualise/', 'processed', indexList, [
			'case_daily',
			'case_weeklyAgg',
			'case7_daily',
			'case7_weeklyAgg',
			'case14_daily',
			'case14_weeklyAgg',
			'infectNoVac_weeklyAgg',
			'infectVac_weeklyAgg',
			'stage_weeklyAgg',
		],
	)
	
	AddFiles(dataDir + '/Traces/' + 'infect_unique_weeklyAgg',
		[
			dataDir + '/Traces/' + 'processed_infectNoVac_weeklyAgg',
			dataDir + '/Traces/' + 'processed_infectVac_weeklyAgg',
		],
		index=(2 + len(measureCols))
	)


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
		if prefix:
			thisPrefix = prefix + '_'
		else:
			thisPrefix = ''
		print('\n' + file)
		AppendFiles(
			dataDir + outDir + thisPrefix + file,
			[rawDataDir + outputSubdir + thisPrefix + file + '_' + str(x) for x in indexList],
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
		'infect_noVac_daily',
		'infect_noVac_weeklyAgg',
		'infect_noVac_yearlyAgg',
		'infect_vac_daily',
		'infect_vac_weeklyAgg',
		'infect_vac_yearlyAgg',
		'mort_daily',
		'mort_weeklyAgg',
		'mort_yearlyAgg',
		'hosp_daily',
		'hosp_weeklyAgg',
		'hosp_yearlyAgg',
	]
	
	if doTenday:
		mortAgg = mortAgg + [
			'infect_noVac_tendayAgg',
			'infect_vac_tendayAgg',
			'mort_tendayAgg',
			'hosp_tendayAgg',
		]
	
	if doLong:
		# May not exist as these files are large.
		mortAgg = mortAgg + [
			'infect_noVac',
			'infect_vac',
			'mort',
			'hosp',
		]
	
	AppendParallels(
		dataDir, rawDataDir, '/Mort_process/', measureCols,
		'/cohort/', False, indexList, mortAgg)
	
	AppendParallels(
		dataDir, rawDataDir, '/Traces/', measureCols,
		'/step_1/', 'processed', indexList, [
			'case',
			'case7',
			'case14',
			'infectNoVac',
			'infectVac',
			'mort',
			'hosp',
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
			'mort_weeklyAgg',
			'hosp_weeklyAgg',
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


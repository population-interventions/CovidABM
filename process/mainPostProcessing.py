# -*- coding: utf-8 -*-
"""
Created on Wed Mar 31 12:16:11 2021

@author: wilsonte
"""
import pandas as pd
import numpy as np

from process.serial.aggregateSpartan import DoSpartanAggregate
from process.serial.processToMortHosp import MakeMortHospHeatmapRange
from process.serial.makeHeatmaps import MakeStagesHeatmap, MakeComparisionHeatmap
from process.serial.makeGraphs import MakePrettyGraphs, MakeFavouriteGraph, MakeDailyGraphs
from process.serial.processedOutputToPMSLT import DoProcessingForPMSLT
from process.serial.processedOutputToPMSLT import GetAggregates
from process.serial.processedOutputToReport import DoProcessingForReport
from process.serial.processPMSLTOutput import ProcessPMSLTResults
from process.serial.processTraceStyleGraphs import DoPreProcessChecks

import process.shared.utilities as util

table5Rows = [
	[False, False],
]

healthPerspectiveRows = [
	[False, False],
]

defaultValues = [
	{
		'R0' : 6,
		'Policy' : 'ME_TS_LS',
		'Rollout' : 'INT',
		'VacUptake' : 0.8,
		'Kids' : 'Yes',
		'IncurRate' : 5,
	},
]

# R0_range param_policy VacKids param_vacincurmult param_vac_uptake
favouriteParams = [5, 'ME_TS_LS', 'No', 5, 0.7]

def RunSeriesPost(modelData, runs, pernode):
	conf = modelData['postSeries']['processMain']
	runIndexer = modelData['runIndexer']
	params = conf['params']
	
	dryRun = params['dryRun']
	preChecks = params['preChecks']
	aggregateSpartan = params['aggregateSpartan']
	makeOutput = params['makeOutput']
	outputStages = params['outputStages']
	makeComparison = params['makeComparison']
	processCohort = params['processCohort']
	indexGrouping = params['indexGrouping']
	
	heatAges = conf['heatAges']
	heatPeriods = conf['heatPeriods']
	heatmapStructure = conf['heatmapStructure']

	measureCols_raw = list(modelData['indexParams'].keys())
	measureCols = [data['name'] for data in modelData['postSeries']['processMain']['indexRename'].values()]
	indexRename = modelData['postSeries']['processMain']['indexRename']
	
	rawDataDir = '{}/raw'.format(modelData['scratchDir'])
	postDataDir = '{}/post_parallel'.format(modelData['scratchDir'])
	workingDir = '{}/process'.format(modelData['scratchDir'])
	postInputDir = modelData['postInputDir']
	
	if preChecks:
		DoPreProcessChecks(
			workingDir, postDataDir, indexRename, measureCols, measureCols_raw,
			defaultValues, firstOnly=dryRun)

	if aggregateSpartan:
		arraySize = len(util.GetFiles(rawDataDir))
		print('arraySize', arraySize)
		DoSpartanAggregate(
			workingDir, postDataDir, measureCols, runIndexer,
			arraySize=arraySize, processCohort=processCohort,
			indexGrouping=indexGrouping)

	if makeOutput:
		for period in heatPeriods:
			MakeMortHospHeatmapRange(
				workingDir, measureCols, heatAges, heatmapStructure, 'quartAgg',
				period[0], period[1] - 1, describe=True)

	if outputStages:
		for period in heatPeriods:
			MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, period[0] * 91, period[1] * 91, stage_min=1, describe=True)
			MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, period[0] * 91, period[1] * 91, stage_min=2, describe=True)
			MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, period[0] * 91, period[1] * 91, stage_min=3, describe=True)
			MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, period[0] * 91, period[1] * 91, stage_min=4, describe=True)
			MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, period[0] * 91, period[1] * 91, stage_min=5, describe=True)

	if 'splitTableIndexName' in modelData:
		DoProcessingForReport(workingDir, postInputDir, measureCols, table5Rows, modelData['splitTableIndexName'], months=24)

	if makeComparison:
		compareHeatmap = 'weeklyAgg_infect_from_30_to_82_age_0_110_total_percentile_050'
		compareStages = 'stageAbove_2_from_210_to_574_percentile_050'
		MakeComparisionHeatmap(workingDir, heatmapStructure, compareHeatmap)
		MakeComparisionHeatmap(workingDir, heatmapStructure, compareHeatmap, divide=False)
		MakeComparisionHeatmap(workingDir, heatmapStructure, compareStages, divide=False)

	#DoProcessingForPMSLT(workingDir, inputDir, measureCols, months=24)
	filterIndex = [
		('R0', 6.5),
		('Essential', 'Extreme'),
		('Rollout', 'BAU'),
		('VacRate', 0.5),
	]

	#MakeDailyGraphs(workingDir, 'processed_case14', measureCols, 'VacRate', mean=False, filterIndex=filterIndex)
	#MakePrettyGraphs(workingDir, 'processed_case_daily', measureCols, 'Policy', mean=False, filterIndex=filterIndex)
	#MakePrettyGraphs(workingDir, 'processed_stage', measureCols, 'param_policy')
	#MakeFavouriteGraph(workingDir, 'processed_stage', measureCols, favouriteParams)
	#MakeFavouriteGraph(workingDir, 'infect_unique', measureCols, favouriteParams)

	#ProcessPMSLTResults(workingDir, measureCols, heatmapStructure, healthPerspectiveRows)
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 31 12:16:11 2021

@author: wilsonte
"""
import pandas as pd
import numpy as np

from serial.processNetlogoOutput import DoAbmProcessing
from serial.aggregateSpartan import DoSpartanAggregate
from serial.processToMortHosp import PreProcessMortHosp, FinaliseMortHosp_NoDraw, DrawMortHospDistributions
from serial.processToMortHosp import MakeMortHospHeatmapRange, MakeIcuHeatmaps
from serial.makeHeatmaps import MakeStagesHeatmap, MakeComparisionHeatmap
from serial.makeGraphs import MakePrettyGraphs, MakeFavouriteGraph, MakeDailyGraphs
from serial.processedOutputToPMSLT import DoProcessingForPMSLT
from serial.processedOutputToPMSLT import GetAggregates
from serial.processedOutputToReport import DoProcessingForReport
from serial.processPMSLTOutput import ProcessPMSLTResults
from serial.processTraceStyleGraphs import DoPreProcessChecks

import pak_conf as conf

table5Rows = [
	[False, False],
	['VacUptake', ['.csv']],
]

healthPerspectiveRows = [
	[False, False],
	['VacUptake', ['.csv']],
]

heatmapStructure = {
	'index_rows' : ['R0', 'Policy', 'VacUptake'],
	'index_cols' : ['AgeLimit', 'IncurRate'],
	'base_value' : {
	},
	'sort_rows' : [
	], 
	'sort_cols' : [
	]
}

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

heatAges = [
	#[0, 15],
	#[15, 25],
	#[25, 35],
	#[35, 45],
	#[45, 55],
	#[55, 65],
	#[65, 75],
	#[75, 85],
	#[85, 95],
	#[95, 110],
	[0, 110],
]


# R0_range param_policy VacKids param_vacincurmult param_vac_uptake
favouriteParams = [5, 'ME_TS_LS', 'No', 5, 0.7]

measureCols_raw = conf.GetMeasureColsRaw()
measureCols = conf.GetMeasureCols()
indexRenameFunc = conf.GetIndexRenameFunc()

#dataDir = '2021_05_04'
rawDataDir = '../../output_post/pak_main'
workingDir = '../../output_process/pak_main'
inputDir = 'serial_data/pak/other_input'
day_override = 574

compareHeatmap = 'weeklyAgg_infect_from_30_to_82_age_0_110_total_percentile_050'
compareStages = 'stageAbove_2_from_210_to_574_percentile_050'

dryRun = False
preChecks = False
aggregateSpartan = True
doDraws = True
doFinaliseCohortAgg = True
makeOutput = True
outputStages = True
processIcu = False
makeComparison = False

if preChecks:
	DoPreProcessChecks(
		workingDir, rawDataDir, indexRenameFunc, measureCols, measureCols_raw,
		defaultValues, firstOnly=dryRun)

if aggregateSpartan:
	DoSpartanAggregate(workingDir, rawDataDir, measureCols, arraySize=1)

#if doDraws:
#	DrawMortHospDistributions(workingDir, inputDir, measureCols, drawCount=100, padMult=1)

if doFinaliseCohortAgg:
	FinaliseMortHosp_NoDraw(workingDir, measureCols, heatAges)

DoProcessingForReport(workingDir, inputDir, measureCols, table5Rows, 'R0', months=24)

if makeOutput:
	MakeMortHospHeatmapRange(workingDir, measureCols, heatAges, heatmapStructure, 'weeklyAgg', 0, 82, aggSize=7, describe=True)
	MakeMortHospHeatmapRange(workingDir, measureCols, heatAges, heatmapStructure, 'weeklyAgg', 0, 30, aggSize=7, describe=True)
	MakeMortHospHeatmapRange(workingDir, measureCols, heatAges, heatmapStructure, 'weeklyAgg', 30, 52, aggSize=7, describe=True)

if outputStages:
	#MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, 0, 210, describe=True)
	#MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, 210, 364, describe=True)
	#MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, 0, 574, describe=True)

	#MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, 182, 28, describe=True)
	MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, 210, 364, describe=True)
	
	MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, 210, 364, stage_set=0, describe=True)
	MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, 210, 364, stage_set=1, describe=True)
	#MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, 210, 364, stage_set=2, describe=True)
	#MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, 210, 364, stage_set=3, describe=True)
	#MakeStagesHeatmap(workingDir, measureCols, heatmapStructure, 210, 364, stage_set=4, describe=True)


if processIcu:
	MakeIcuHeatmaps(workingDir, measureCols, heatmapStructure, 0, 82, describe=True)
	MakeIcuHeatmaps(workingDir, measureCols, heatmapStructure, 30, 52, describe=True)

if makeComparison:
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
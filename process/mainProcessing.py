# -*- coding: utf-8 -*-
"""
Created on Wed Mar 31 12:16:11 2021

@author: wilsonte
"""
import pandas as pd
import numpy as np

from process.serial.aggregateSpartan import DoSpartanAggregate
from process.serial.processToMortHosp import MakeMortHospHeatmapRange
from process.serial.makeGraphs import MakePrettyGraphs, MakeFavouriteGraph, MakeDailyGraphs
from process.serial.processedOutputToPMSLT import DoProcessingForPMSLT
from process.serial.processedOutputToPMSLT import GetAggregates
from process.serial.processedOutputToReport import DoProcessingForReport
from process.serial.processPMSLTOutput import ProcessPMSLTResults
from process.serial.processTraceStyleGraphs import DoPreProcessChecks

import process.serial.makeHeatmaps as makeHeatmaps
import process.serial.singleProcess as singleProcess

import process.shared.utilities as util
import process.shared.globalVars as gl

table5Rows = [
	[False, False],
]

def RunSeriesPost(modelData, runs, pernode, onHpc):
	conf = modelData['postSeries']['processMain']
	runIndexer = modelData['runIndexer']
	params = conf['params']
	
	processStages = params['processStages']
	processCohort = params['processCohort']
	indexGrouping = params['indexGrouping']
	
	aggregateProcessing = 'aggregateProcessing' in params and params['aggregateProcessing']
	doAverage = 'doAverage' in params and params['doAverage']
	describeHeatmaps = 'describeHeatmaps' in params and params['describeHeatmaps']
	outputTraces = 'outputTraces' in params and params['outputTraces']
	
	heatmapStructure = conf['heatmapStructure']

	measureCols_raw = list(modelData['indexParams'].keys())
	measureCols = [
		modelData['postSeries']['processMain']['indexRename'][metric]['name']
		if metric in modelData['postSeries']['processMain']['indexRename'] else metric for metric in measureCols_raw]
	indexRename = modelData['postSeries']['processMain']['indexRename']
	
	rawDataDir = '{}/raw'.format(modelData['scratchDir'])
	postDataDir = '{}/post_parallel'.format(modelData['scratchDir'])
	workingDir = '{}/process'.format(modelData['scratchDir'])
	postInputDir = modelData['postInputDir']

	arraySize = len(util.GetFiles(rawDataDir))
	print('arraySize', arraySize)
	if aggregateProcessing:
		DoSpartanAggregate(
			workingDir, postDataDir, measureCols, runIndexer,
			arraySize=arraySize, processCohort=processCohort,
			processStages=processStages, indexGrouping=indexGrouping,
			doAverage=doAverage, outputTraces=outputTraces)

	if 'singleProcessing' in conf:
		singleProcess.DoSingleProcess(conf['singleProcessing'], workingDir, heatmapStructure, measureCols_raw, onHpc)

	if 'singleHeatmaps' in conf:
		singleProcess.MakeSingleHeatmaps(conf['singleHeatmaps'], workingDir, heatmapStructure, measureCols_raw)
		
	if 'tornado' in conf:
		singleProcess.MakeTornadoPlots(conf['tornado'], workingDir, measureCols_raw, onHpc)
	
	if 'cohortHeatmaps' in conf:
		for period in conf['cohortHeatmaps']['heatPeriods']:
			print('Period', period[0], period[1] - 1)
			MakeMortHospHeatmapRange(
				workingDir, measureCols, conf['cohortHeatmaps']['heatAges'], heatmapStructure, 'quartAgg',
				period[0], period[1] - 1, describe=describeHeatmaps)

	if 'splitTableIndexName' in modelData:
		DoProcessingForReport(workingDir, postInputDir, measureCols, table5Rows, modelData['splitTableIndexName'], months=24)


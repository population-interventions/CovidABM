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

def RunSeriesPost(modelData, runs, pernode, onHpc, singleOnly, heatmapOnly=False):
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
	allowDaily = 'allowDaily' in params and params['allowDaily']
	
	heatmapStructure = conf['heatmapStructure']

	measureCols_raw = list(modelData['indexParams'].keys())
	measureCols = [
		modelData['postSeries']['processMain']['indexRename'][metric]['name']
		if metric in modelData['postSeries']['processMain']['indexRename'] else metric for metric in measureCols_raw]
	indexRename = modelData['postSeries']['processMain']['indexRename']
	
	postDataDir = '{}/post_parallel'.format(modelData['scratchDir'])
	workingDir = '{}/process'.format(modelData['scratchDir'])
	postInputDir = modelData['postInputDir']

	singles = util.GetFiles('{}/single'.format(postDataDir))
	arraySize = len(singles)
	if arraySize == 0:
		singles = util.GetFiles('{}/post_parallel/single'.format(modelData['scratchDir']))
		arraySize = len(singles)
		singleOnly = True
		indexList = [int(x[str.find(x, 'post_parallel/single_') + 21:]) for x in singles]
	else:
		indexList = [int(x[str.find(x, 'single/single_') + 14:]) for x in singles]
	fullArray = [x + 1 for x in range(arraySize)]
	
		
	print('Raw Index', indexList)
	print('Missing Element', util.ListRemove(fullArray, indexList, lenient=True))
	if aggregateProcessing and not singleOnly:
		DoSpartanAggregate(
			workingDir, postDataDir, measureCols, runIndexer,
			indexList=indexList, processCohort=processCohort,
			processStages=processStages, indexGrouping=indexGrouping,
			doAverage=doAverage, outputTraces=outputTraces, allowDaily=allowDaily)

	# Fix single issue
	#if (not heatmapOnly) and not onHpc:
	#	singleProcess.FixSingle(workingDir, measureCols_raw)
		
	if (not heatmapOnly) and 'singleProcessing' in conf:
		singleProcess.DoSingleProcess(conf['singleProcessing'], workingDir, heatmapStructure, measureCols_raw, onHpc)
	
	if 'singleHeatmaps' in conf:
		singleProcess.MakeSingleHeatmaps(conf['singleHeatmaps'], workingDir, heatmapStructure, measureCols_raw)

	if heatmapOnly:
		return
	
	if processCohort and 'cohortHeatmaps' in conf and not singleOnly:
		for period in conf['cohortHeatmaps']['heatPeriods']:
			print('Period', period[0], period[1] - 1)
			MakeMortHospHeatmapRange(
				workingDir, measureCols, conf['cohortHeatmaps']['heatAges'], heatmapStructure, 'quartAgg',
				period[0], period[1] - 1, describe=describeHeatmaps)

	if 'splitTableIndexName' in modelData:
		DoProcessingForReport(workingDir, postInputDir, measureCols, table5Rows, modelData['splitTableIndexName'], months=24)
	
	if 'tornado' in conf:
		singleProcess.MakeTornadoPlots(conf['tornado'], workingDir, measureCols_raw, onHpc)


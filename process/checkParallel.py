import pandas as pd
import numpy as np
import sys

from process.parallel.processNetlogoOutput import DoAbmProcessing
import process.shared.modelData as md

def DoParallelCheck(runIndex, modelName, runs, pernode):
	modelData = md.LoadModelData(modelName)
	
	if 'postSeries' in modelData:
		if 'processMain' in modelData['postSeries']:
			measureCols_raw = list(modelData['indexParams'].keys())
			measureCols = [
				modelData['postSeries']['processMain']['indexRename'][metric]['name']
				if metric in modelData['postSeries']['processMain']['indexRename'] else metric for metric in measureCols_raw]
		
			mainData = modelData['postSeries']['processMain']
		
			inputDir = '{}/raw'.format(modelData['scratchDir'])
			outputDir = '{}/post_parallel'.format(modelData['scratchDir'])
			outputTraces = mainData['params']['outputTraces'] if 'outputTraces' in mainData['params'] else False
			allowDaily = mainData['params']['allowDaily'] if 'allowDaily' in mainData['params'] else False
			retainRaw = mainData['params']['retainRaw'] if 'retainRaw' in mainData['params'] else False
			# Usually retainRaw for auto calibration, as it reads raw directly.
			
			DoAbmProcessing(
				inputDir, outputDir, runIndex,
				mainData['indexRename'],
				measureCols, measureCols_raw,
				outputTraces=outputTraces, allowDaily=allowDaily, retainRaw=retainRaw)
	


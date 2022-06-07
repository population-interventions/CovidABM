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
		
			inputDir = '{}/raw'.format(modelData['scratchDir'])
			outputDir = '{}/post_parallel'.format(modelData['scratchDir'])
			
			DoAbmProcessing(
				inputDir, outputDir, runIndex,
				modelData['postSeries']['processMain']['indexRename'],
				measureCols, measureCols_raw)
	


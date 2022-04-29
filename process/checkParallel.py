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
			measureCols = [data['name'] for data in modelData['postSeries']['processMain']['indexRename'].values()]
		
			inputDir = '{}/raw'.format(modelData['scratchDir'])
			outputDir = '{}/post_parallel'.format(modelData['scratchDir'])
			
			DoAbmProcessing(
				inputDir, outputDir, runIndex,
				modelData['postSeries']['processMain']['indexRename'],
				measureCols, measureCols_raw)
	


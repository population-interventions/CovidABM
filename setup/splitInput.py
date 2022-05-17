
from numpy import random
import random as baseRandom
import json

import pandas as pd
import numpy as np

import process.shared.utilities as util
import process.shared.modelData as md
import setup.readNetlogo as nl

def SplitFile(inFile, outFile, stackedCols=False, appendDf=False):
	if stackedCols:
		df = pd.read_csv(inFile + '.csv', 
			index_col=[0],
			header=[0,1])
		df = df.stack(0)
		df = df.reorder_levels([1, 0])
	else:
		df = pd.read_csv(inFile + '.csv', 
			index_col=[0,1],
			header=[0])
	
	df = util.SetLevelType(df, 0, int)
	df = df.sort_index()
	
	for draw in util.UniqueLevelValueList(df, 0):
		outDf = df.loc[draw, :]
		if appendDf is not False:
			outDf = outDf.join(appendDf)
		util.OutputToFile(outDf, '{}_{}'.format(outFile, draw), head=False)


def DoVicSplit():
	appendDf = pd.read_csv('abm/input/vic/preinfect_append' + '.csv', 
		index_col=[0],
		header=[0])
	
	SplitFile('abm/input/vic/preinfect_source', 'abm/input/vic/prevac/draw', stackedCols=True, appendDf=appendDf)
	SplitFile('abm/input/vic/vaccine_underlying_source', 'abm/input/vic/vaccine/draw')
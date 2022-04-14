# -*- coding: utf-8 -*-
"""
Created on Fri Jul 23 13:17:50 2021

@author: wilsonte
"""

import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
import matplotlib.ticker as ticker
import seaborn as sns
import pathlib
import process.shared.utilities as util

from process.rcalc.processRcalc import DoProcessRCalc

def ProcessResults(modelData):
	nameList = util.GetFiles(modelData['scratchDir'] + '/raw/')
	gitTime = util.GetGitTimeIdentifier()
	
	index = list(modelData['indexParams'].keys())
	notFloatCol = [
	]
	simIndex = modelData['runIndexer']
	metric = modelData['postSeries']['rcalc']['metric']
	interestingColumns = index + [simIndex, metric]
	print('interestingColumns', interestingColumns)
	
	df = pd.DataFrame(columns=interestingColumns)
	for v in nameList:
		pdf = pd.read_csv(v + '.csv', header=6)
		pdf = pdf[interestingColumns]
		df  = df.append(pdf)
	 
	for colName in interestingColumns:
		if colName not in notFloatCol:
			df[colName] = df[colName].astype(float)

	df = df.set_index(index + [simIndex])
	df = df.transpose().stack(simIndex)
	df = df.describe(percentiles=[0 + 0.01*i for i in range(100)])
	print(df)
	
	outPath = modelData['scratchDir'] + '/process'
	util.OutputToFile(df, '{}/{}_{}'.format(outPath, gitTime, 'desc'), head=False)
	DoProcessRCalc(
		nameList, metric,
		simIndex, index,
		outPath, gitTime)

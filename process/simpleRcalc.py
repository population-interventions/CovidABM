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
import shared.utilities as util

from rcalc.processRcalc import DoProcessRCalc

def ProcessResults(outputName, path):
	nameList = util.GetFiles(path + '/raw/')
	gitTime = util.GetGitTimeIdentifier()
	
	index = [
		'trans_override',
		'sympt_iso_prop',
	]
	notFloatCol = [
	]
	simIndex = 'draw_index'
	metric = 'initial_infection_R'
	interestingColumns = index + [simIndex, metric]
	
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
	
	outPath = '../../scratch/vic_rcalc/process'
	util.OutputToFile(df, '{}/{}_{}'.format(outPath, gitTime, outputName), head=False)
	DoProcessRCalc(
		nameList, metric,
		simIndex, index,
		outPath, gitTime)


ProcessResults('desc', '../../scratch/vic_rcalc')

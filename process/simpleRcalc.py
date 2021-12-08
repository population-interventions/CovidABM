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
	nameList = util.GetFiles(path)
	gitTime = util.GetGitTimeIdentifier()
	
	index = [
		'init_cases_region',
		'global_transmissibility',
		'param_policy',
	]
	notFloatCol = [
		'sensitivity',
		'param_policy',
	]
	metric = [
		'initial_infection_R',
	]
	interestingColumns = index + ['rand_seed'] + metric
	
	df = pd.DataFrame(columns=interestingColumns)
	for v in nameList:
		pdf = pd.read_csv(v + '.csv', header=6)
		pdf = pdf[interestingColumns]
		df  = df.append(pdf)
	 
	for colName in interestingColumns:
		if colName not in notFloatCol:
			df[colName] = df[colName].astype(float)

	df = df.set_index(index + ['rand_seed'])
	df = df.transpose().stack('rand_seed')
	df = df.describe(percentiles=[0 + 0.01*i for i in range(100)])
	print(df)
	util.OutputToFile(df, '../../output_rcalc/{}_{}'.format(gitTime, outputName), head=False)
	
	DoProcessRCalc(nameList, 'initial_infection_R', gitTime)


ProcessResults('desc', '../../output_raw/rcalc/')

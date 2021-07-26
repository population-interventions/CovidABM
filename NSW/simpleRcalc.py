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
import utilities as util

def ProcessResults(outputName, nameList):
	
	index = [
		'global_transmissibility'
	]
	metric = [
		'initial_infection_R',
	]
	interestingColumns = index + ['rand_seed'] + metric
	
	notFloatCol = []
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
	df = df.describe(percentiles=[0.5 + 0.05*i for i in range(10)] + [0.975, 0.99, 0.999])
	print(df)
	util.OutputToFile(df, 'output/rCalc/' + outputName, head=False)


files = util.GetFiles('output/rCalc/2021_07_23b/')
files = ['output/rCalc/trace03']
print(files)
ProcessResults('desc_03', files)
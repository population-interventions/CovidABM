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
import process.shared.helpers as helpers

from process.rcalc.processRcalc import DoProcessRCalc

def ProcessResults(modelData):
	nameList = util.GetFiles(modelData['scratchDir'] + '/raw/')
	gitTime = util.GetGitTimeIdentifier()
	
	index = list(modelData['indexParams'].keys())
	notFloatCol = [] # TODO: Fill out non-float index
	simIndex = modelData['runIndexer']
	metric = modelData['postSeries']['rcalc']['metric']
	
	gitTime = util.GetGitTimeIdentifier()
	df = helpers.AggregateAndPickOutColumn(nameList, index, simIndex, notFloatCol, metric)
	print(df)
	
	outPath = modelData['scratchDir'] + '/process'
	util.OutputToFile(df, '{}/{}_{}'.format(outPath, gitTime, 'desc'), head=False)
	DoProcessRCalc(
		nameList, metric,
		simIndex, index,
		outPath, gitTime)

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
import json

import process.shared.utilities as util
import process.shared.helpers as helpers
import process.shared.modelData as md

def ProcessResults(modelData):
	## Load the results
	nameList = util.GetFiles(modelData['scratchDir'] + '/raw/')
	gitTime = util.GetGitTimeIdentifier()
	
	index = list(modelData['indexParams'].keys())
	notFloatCol = [] # TODO: Fill out non-float index
	simIndex = modelData['runIndexer']
	metric = modelData['postSeries']['targetOptimise']['metric']
	
	gitTime = util.GetGitTimeIdentifier()
	df = helpers.AggregateAndPickOutColumn(nameList, index, simIndex, notFloatCol, metric)
	
	## Apply the results to the input-output file.
	df = df.loc['mean'].to_frame()
	print(df)
	
	outPath = modelData['handlerDir'] + '/raw'
	util.OutputToFile(df, outPath + '/targetValues', appendToExisting=True, head=False)
	
	## Read the input-output file that has been built up.
	df = pd.read_csv(outPath + '/targetValues' + '.csv', index_col=0)
	df = df[~df.index.duplicated(keep='first')]
	df = df.sort_index()
	
	## Make guesses for the next model run.
	inList = list(df['mean'].keys())
	outList = list(df['mean'].values)
	guesses = [
		util.GuessAtFunctionInverse(inList, outList, x) 
		for x in modelData['postSeries']['targetOptimise']['targets']]
	
	## Check whether the repetion limit has been reached, and output final guess.
	repetitionLimit = modelData['postSeries']['targetOptimise']['repetionLimit']
	if repetitionLimit <= 0:
		dfGuess = pd.DataFrame(
			index=modelData['postSeries']['targetOptimise']['targets'],
			data=guesses,
			columns=[metric + '_mean'])
		dfGuess.index = dfGuess.index.rename(index[0])
		util.OutputToFile(dfGuess, modelData['handlerDir'] + '/process/finalGuess', head=False)
		return
	
	## Output a new model spec file with the updated guesses
	rawModel = md.LoadRawModelDataFile(modelData['name'])
	
	repetitionLimit = repetitionLimit - 1
	rawModel['postSeries']['targetOptimise']['repetionLimit'] = repetitionLimit
	rawModel['indexParams'][index[0]] = guesses
	rawModel['baseName'] = modelData['baseName']
	
	util.StringToFile('specs/{}_{}.json'.format(modelData['baseName'], repetitionLimit), json.dumps(rawModel, indent=4))
	
	

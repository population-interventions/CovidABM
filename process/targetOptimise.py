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

import subprocess

def ProcessResults(modelData, runs, pernode):
	## Load the results
	nameList = util.GetFiles(modelData['scratchDir'] + '/raw/')
	gitTime = util.GetGitTimeIdentifier()
	
	index = list(modelData['indexParams'].keys())
	notFloatCol = [] # TODO: Fill out non-float index
	simIndex = modelData['runIndexer']
	metric = modelData['postSeries']['targetOptimise']['metric']
	positiveSlope = modelData['postSeries']['targetOptimise']['positiveSlope']
	
	gitTime = util.GetGitTimeIdentifier()
	df = helpers.AggregateAndPickOutColumn(nameList, index, simIndex, notFloatCol, metric)
	
	## Apply the results to the input-output file.
	df = df.loc['mean'].to_frame()
	firstRun = (modelData['name'] == modelData['baseName'])
	print('firstRun', firstRun)
	print(df)
	
	outPath = modelData['handlerDir'] + '/raw'
	util.OutputToFile(df, outPath + '/targetValues', appendToExisting=(not firstRun), head=False)
	
	## Read the input-output file that has been built up.
	df = pd.read_csv(outPath + '/targetValues' + '.csv', index_col=0)
	df = df[~df.index.duplicated(keep='first')]
	df = df.sort_index(ascending=positiveSlope)
	
	## Make guesses for the next model run.
	print(df)
	inList = list(df['mean'].keys())
	outList = list(df['mean'].values)
	guesses = [
		util.GuessAtFunctionInverse(inList, outList, x) 
		for x in modelData['postSeries']['targetOptimise']['targets']]
	print('========== guesses ==========')
	print('guesses', guesses)
	print('in', inList)
	print('out', outList)
	print('target', modelData['postSeries']['targetOptimise']['targets'])
	
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
	
	guesses = list(set(guesses))
	print("guesses final", guesses)
	
	repetitionLimit = repetitionLimit - 1
	rawModel['postSeries']['targetOptimise']['repetionLimit'] = repetitionLimit
	rawModel['indexParams'][index[0]] = guesses
	rawModel['baseName'] = modelData['baseName']
	
	specName = '{}_{}'.format(modelData['baseName'], repetitionLimit)
	md.WriteSpecFile(specName, rawModel)
	
	## Start the new model run.
	callList = ['sh', './../run.sh', format(specName), str(runs), str(pernode)]
	print(callList)
	subprocess.call(callList) # Requires HPC to run.

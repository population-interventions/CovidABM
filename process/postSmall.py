# -*- coding: utf-8 -*-
"""
Created on Wed Mar 31 12:16:11 2021

@author: wilsonte
"""
import pandas as pd
import numpy as np

import process.serial.tornadoPlot as tornadoPlot

import process.shared.utilities as util
import process.shared.globalVars as gl

def GetTornadoRange(df, sensitivity, metricList, percentile):
	lower = df[sensitivity].quantile(percentile)
	upper = df[sensitivity].quantile(1 - percentile)
	
	output = {}
	for metric in metricList:
		output[metric] = [
			df[df[sensitivity] <= lower][metric].mean(),
			df[df[sensitivity] >= upper][metric].mean()
		]
	return output, [lower, upper]


def MakeTornadoPlots(tornadoConf, subfolder, measureCols_raw, onHpc, percentile=0.2):
	df = pd.read_csv(
		subfolder + '/single/single.csv',
		index_col=list(range(len(measureCols_raw) + 1)))
	
	tornadoData = {}
	senValues = {}
	for senMetric in tornadoConf['senList']:
		tornadoData[senMetric], senValues[senMetric] = GetTornadoRange(
			df, senMetric, 
			tornadoConf['metrics'], percentile
		)
	tornadoData = pd.DataFrame(tornadoData).transpose().to_dict()
	for metric in tornadoConf['metrics']:
		tornadoData[metric] = {
			k : {'value' : v, 'range' : senValues[k]}
			for k, v in tornadoData[metric].items()}
	
	for metric in tornadoConf['metrics']:
		median = df[metric].quantile(0.5)
		lower = df[metric].quantile(percentile)
		upper = df[metric].quantile(1 - percentile)
		tornadoData[metric][metric] = {
			'value' : [df[df[metric] <= lower][metric].mean(), df[df[metric] >= upper][metric].mean()],
			'range' : [lower, upper]
		}
		tornadoPlot.MakePlot(
			metric, tornadoData[metric], median,
			saveDir=subfolder + '/tornado', showBrowser=not onHpc)


def RunPostSmall(modelData, runs, pernode, onHpc):
	conf = modelData['postSeries']['processMainPost']
	runIndexer = modelData['runIndexer']
	params = conf['params']
	measureCols_raw = list(modelData['indexParams'].keys())
	
	workingDir = '{}/process'.format(modelData['scratchDir'])
	
	#tornadoPlot.MakeExamplePlot()
	if 'tornado' in conf:
		MakeTornadoPlots(conf['tornado'], workingDir, measureCols_raw, onHpc)
	
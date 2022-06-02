# -*- coding: utf-8 -*-
"""
Created on Thu Feb 18 12:28:02 2021

@author: wilsonte
"""

import pandas as pd
from matplotlib import pyplot
import matplotlib.ticker as ticker
import seaborn as sns
import process.shared.utilities as util
#from tqdm import tqdm


def AddIfVaryingValue(colName, df, desiredIndex, toUnstack):
	inTest = (colName in df.columns and (len(df[colName].unique()) > 1))
	if inTest:
		desiredIndex.append(colName)
		toUnstack = toUnstack + 1
		#df['testName'] = df['testName'].str.replace('EssWork', 'Ework')
	else:
		df = df.drop(columns=[colName])
	return df, desiredIndex, toUnstack


def ProcessVariableEnd(nameList, metricName, simIndex, index):
	interestingColumns = [simIndex, metricName] + index
	df = pd.DataFrame(columns=interestingColumns)
	for v in nameList:
		pdf = pd.read_csv(v + '.csv', header=6)
		pdf = pdf[interestingColumns]
		df  = df.append(pdf)
	
	desiredIndex = [simIndex] + index
	toUnstack = len(desiredIndex) - 1
	
	#df, desiredIndex, toUnstack = AddIfVaryingValue('testName', df, desiredIndex, toUnstack)
	#df, desiredIndex, toUnstack = AddIfVaryingValue('gather_location_count', df, desiredIndex, toUnstack)
	
	if 'testName' in desiredIndex:
		df['testName'] = df['testName'].str.replace('Is0.8 Stage3', 'Is0.75 Stage3')  
	
	df = df.set_index(desiredIndex)
	
	# Sometimes the random numbers collide.
	df = df[~df.index.duplicated(keep='first')]
	
	for i in range(toUnstack):
		df = df.unstack(level=-1)
		
	return df
	

def MakePlot(
		df, varName, simIndex, index,
		topLevelFilter=False,
		yTop=False,
		yDomain=(-0.2, 9.2),
		ymajticks=False,
		yminticks=False,
		hlines=False,
		figWidth=48.5,
		figHeight= 40,
		saveID=False,
		path=''):
	
	if yTop:
		yDomain = (-0.2, yTop - 0.8)
		ymajticks = range(yTop)
		yminticks = [i/5 for i in range(int(5*yTop))]
	
	xLabel = df.columns.names[1]
	transmit_vals = list(dict.fromkeys(['_'.join([str(x) for x in v[1:]]) for v in df.columns]))
	policy_vals = list(dict.fromkeys([v[1] for v in df.columns]))

	dataCount = len(df.columns)
	
	sns.set_theme(style="ticks", palette="pastel")
	sns.set_style("ticks", {"xtick.major.size": 60})
	
	fig, ax = pyplot.subplots(figsize=(figWidth, figHeight))
	plt = sns.boxplot(data=df, fliersize=5, showmeans=True,
					  meanprops={"marker":".", 'markersize':25, "markerfacecolor":"black", "markeredgecolor":"black"})

	#plt = sns.swarmplot(data=df, color=".25")
	plt.set(xlim=(-1, dataCount + 1), ylim=yDomain)
	sns.despine(ax=ax, offset=10)
	
	plt.set_xticklabels([''] * dataCount)
	plt.xaxis.set_major_locator(ticker.FixedLocator([i*len(policy_vals) - 0.5 for i in range(len(transmit_vals))]))
	plt.xaxis.set_minor_locator(ticker.FixedLocator([(i + 0.6) - 0.5 for i in range(len(transmit_vals))]))
	plt.xaxis.set_minor_formatter(ticker.FixedFormatter(transmit_vals))
	
	for tick in ax.xaxis.get_minor_ticks():
		tick.label.set_fontsize(32) 
		tick.label.set_rotation(45)
		tick.label.set_horizontalalignment('right')
		tick.label.set_verticalalignment('top')
		tick.tick1line.set_markersize(0)
		tick.tick2line.set_markersize(0)
	
	for tick in ax.yaxis.get_major_ticks():
		tick.label.set_fontsize(32) 
	
	pyplot.xlabel(xLabel, fontsize=48)
	pyplot.ylabel(varName, fontsize=48)
	
	if ymajticks:
		ax.set_yticks(ymajticks)
	if yminticks:
		ax.set_yticks(yminticks, minor=True)
	
	if hlines:
		for v in hlines:
			ax.axhline(y=v, linewidth=2.2, zorder=0, color='r')
	
	pyplot.tight_layout()
	ax.grid(which='minor', alpha=0.4, linewidth=1.5, zorder=-1, axis="y")
	ax.grid(which='major', alpha=0.7, linewidth=2, zorder=-1)
	if saveID:
		pyplot.savefig('{}/{}_{}_plot.png'.format(path, saveID, varName))
	else:
		pyplot.show()


def ProcessToPlot(df, indexReorder=False):	  
	if indexReorder:
		df.columns = df.columns.reorder_levels(indexReorder)
		df.sort_values(['testName', 'housetotal', ],axis=1,inplace=True)
	return df


def DoProcessRCalc(nameList, metric_name, simIndex, index, path, saveID):
	dfProcessed = ProcessVariableEnd(nameList, metric_name, simIndex, index)
	MakePlot(
		ProcessToPlot(dfProcessed),
		metric_name,
		simIndex,
		index,
		yTop=18,
		hlines=[1, 6, 7.5],
		figWidth=30,
		figHeight=20,
		saveID=saveID,
		path=path,
	)

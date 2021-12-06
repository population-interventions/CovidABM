# -*- coding: utf-8 -*-
"""
Created on Thu Feb 18 12:28:02 2021

@author: wilsonte
"""

import pandas as pd
from matplotlib import pyplot
import matplotlib.ticker as ticker
import seaborn as sns
#from tqdm import tqdm

def Process(path, name):
	df = pd.read_csv(path + name + '.csv', header=6)
	df = df[['rand_seed', '[step]', 'average_R', 'global_transmissibility', 'init_cases_region']]
	lastStep = df['[step]'].max()
	df = df[df['[step]'] == lastStep]
	df = df[['rand_seed', 'average_R_all_regions', 'global_transmissibility', 'init_cases_region']]
	
	df = df.set_index(['rand_seed', 'global_transmissibility', 'init_cases_region'])
	
	df = df.unstack(level=-1)
	df.columns = df.columns.get_level_values(1)
	df.to_csv(path + name + '_process.csv')
	df.describe().to_csv(path + name + '_metric.csv')
	print(df.describe())


def AddIfVaryingValue(colName, df, desiredIndex, toUnstack):
	inTest = (colName in df.columns and (len(df[colName].unique()) > 1))
	if inTest:
		desiredIndex.append(colName)
		toUnstack = toUnstack + 1
		#df['testName'] = df['testName'].str.replace('EssWork', 'Ework')
	else:
		df = df.drop(columns=[colName])
	return df, desiredIndex, toUnstack


def ProcessVariableEnd(nameList, metricName):
	interestingColumns = [
		'rand_seed', metricName, 'param_policy', 
		'global_transmissibility', 'init_cases_region', 'testName',
		'gather_location_count',
	]
	df = pd.DataFrame(columns=interestingColumns)
	for v in nameList:
		pdf = pd.read_csv(v + '.csv', header=6)
		if 'testName' not in pdf.columns:
			interestingColumns = filter(lambda x: x != 'testName', interestingColumns)
		pdf = pdf[interestingColumns]
		df  = df.append(pdf)
	
	desiredIndex = ['rand_seed', 'param_policy', 'global_transmissibility', 'init_cases_region']
	toUnstack = 3
	
	df, desiredIndex, toUnstack = AddIfVaryingValue('testName', df, desiredIndex, toUnstack)
	df, desiredIndex, toUnstack = AddIfVaryingValue('gather_location_count', df, desiredIndex, toUnstack)
	
	if 'testName' in desiredIndex:
		df['testName'] = df['testName'].str.replace('Is0.8 Stage3', 'Is0.75 Stage3')  
	
	df = df.set_index(desiredIndex)
	
	# Sometimes the random numbers collide.
	df = df[~df.index.duplicated(keep='first')]
	
	for i in range(toUnstack):
		df = df.unstack(level=-1)
		
	return df
	

def MakePlot(
		df, varName,
		topLevelFilter=False,
		yTop=False,
		yDomain=(-0.2, 9.2),
		ymajticks=False,
		yminticks=False,
		hlines=False,
		figWidth=48.5,
		figHeight= 40,
		saveID=False):
	
	if yTop:
		yDomain = (-0.2, yTop - 0.8)
		ymajticks = range(yTop)
		yminticks = [i/5 for i in range(int(5*yTop))]
	
	xLabel = df.columns.names[1]
	transmit_vals = list(dict.fromkeys(['r{}_{}_{}'.format(v[1], v[2], v[3]) for v in df.columns]))
	policy_vals = list(dict.fromkeys([v[2] for v in df.columns]))

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
		pyplot.savefig('../../output_rcalc/{}_plot.png'.format(saveID))
	else:
		pyplot.show()


def ProcessToPlot(df, indexReorder=False):	  
	if indexReorder:
		df.columns = df.columns.reorder_levels(indexReorder)
		df.sort_values(['testName', 'housetotal', ],axis=1,inplace=True)
	return df


def DoProcessRCalc(nameList, metric_name, saveID):
	dfProcessed = ProcessVariableEnd(nameList, metric_name)
	MakePlot(
		ProcessToPlot(dfProcessed),
		metric_name,
		yTop=14,
		hlines=[1, 5.5, 6.5],
		figWidth=30,
		figHeight=20,
		saveID=saveID,
	)

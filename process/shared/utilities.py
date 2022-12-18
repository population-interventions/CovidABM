import pandas as pd
import numpy as np
import scipy
import math
import pdb
import os
import json
import tqdm

import pathlib
import importlib
import copy

from numpy import random
import random as baseRandom

from datetime import datetime, timezone
import subprocess

fileCreated = {}
HEAD_MODE = True

percMap = {
	0: 'percentile_000',
	0.05: 'percentile_005',
	0.95 : 'percentile_095',
	0.25 : 'percentile_025',
	0.75 : 'percentile_075',
	0.5 : 'percentile_050',
	1 : 'percentile_100',
}

def UniqueLevelValueList(df, level, axis=0):
	if axis == 0:
		return list(set(df.index.get_level_values(level)))
	return list(set(df.columns.get_level_values(level)))

def SetLevelType(df, level, newType):
	df.index = df.index.set_levels(df.index.levels[level].astype(newType), level=level)
	return df


def DoIndexRename(df, indexRename):
	index = df.index.to_frame()
	
	for name, data in indexRename.items():
		if 'values' in data:
			index[name] = index[name].astype(str).replace(data['values'])
	index = index.rename(columns={name : data['name'] for name, data in indexRename.items()})
		
	df.index = pd.MultiIndex.from_frame(index)	
	return df


def GuessAtFunctionInverse(indexList, valueList, target):
	if target < valueList[0]:
		return indexList[0]/2
	if target > valueList[len(valueList) - 1]:
		maxIn = indexList[len(indexList) - 1]
		if maxIn < 1:
			return 1 - (1 - maxIn) / 2
		else:
			return maxIn + (maxIn - indexList[len(indexList) - 1])
		
	for i in range(len(indexList) - 1):
		outValNext = valueList[i + 1]
		if target < outValNext:
			inVal = indexList[i]
			outVal = valueList[i]
			inValNext = indexList[i + 1]
			
			midProp = (target - outVal) / (outValNext - outVal)
			interoplate = inVal + midProp * (inValNext - inVal)
			print('interoplate', target, inVal, inValNext, outVal, outValNext)
			return interoplate


def ApplyDefaultToDict(override, default):
	out = default.copy()
	for key, value in override.items():
		out[key] = value
	return out


def ListListToDictList(data):
	out = {}
	for value in data:
		key = value.pop(0)
		out[key] = value
	return out


def SwapToPos(data, match, pos):
	for i in range(len(data)):
		if data[i][0] == match:
			data[i], data[pos] = data[pos], data[i]
			return


def GetRandomListUnique(listSize, maxIntSize=10000000):
	randList = baseRandom.sample(range(maxIntSize), listSize)
	while len(FindRepeat(randList)) > 0:
		randList = baseRandom.sample(range(maxIntSize), listSize)
	return randList


def GetGitTimeIdentifier():
	now = datetime.now()
	dateString = now.strftime('%Y-%m-%dT%H_%M_%S')
	shortHash = subprocess.check_output(['git', 'rev-parse', '--short', 'HEAD']).decode('ascii').strip()
	return '{}_g{}'.format(dateString, shortHash)


def WriteListToFile(path, data, addNewline=True):
	#print('Writing to', path)
	MakePath(path)
	with open(path + '.txt', 'w') as f:
		for line in data:
			f.write(line)
			if addNewline:
				f.write('\n')


def WriteRunIdFile(path, identifier):
	WriteListToFile(path, [identifier], addNewline=False)


def StringToFile(path, string):
	MakePath(path)
	with open(path, 'w') as outfile:
		outfile.write(string)

	
def WriteJsonFile(path, data, pretty=True):
	path = path + '.json'
	if pretty:
		StringToFile(path, json.dumps(data, indent=4))
	else:
		StringToFile(path, json.dumps(data))


def isfloat(value):
	try:
		float(value)
		return True
	except ValueError:
		return False


def DecimalLimit(f, limit):
	return format(f, '.{}f'.format(limit)).rstrip('0').rstrip('.')


def FindRepeat(listIn, threshold=1):
	repeats = {}
	for val in listIn:
		if val in repeats:
			repeats[val] = repeats.get(val) + 1
		else:
			repeats[val] = 1
	if not threshold:
		threshold = sum(list(repeats.values())) / len(list(repeats.values()))
		return [x for x in repeats.keys() if repeats.get(x) > threshold]
	return [x for x in repeats.keys() if repeats.get(x) > threshold]


def PrintDuplicateRows(df):
	df = df[df.duplicated()]
	print(df)


def PrintDuplicateIndex(df):
	print(PrintDuplicateRows(df.index.to_frame()))


def HasDuplicateIndex(df):
	df = df.index.duplicated()
	return (True in df)


def MakePath(path):
	if '/' not in path:
		return
	out_folder = os.path.dirname(path)
	if not os.path.exists(out_folder):
		MakePath(out_folder)
		os.makedirs(out_folder, exist_ok=True)


def GetFiles(subfolder, firstOnly=False):
	subfolder = subfolder + '/'
	inputPath = pathlib.Path(subfolder)
	print('Reading files from {}'.format(inputPath))
	suffix = '.csv'
	pathList = sorted(inputPath.glob('*{}'.format(suffix)))
	filelist = [] # TODO - Do better.
	for path in pathList:
		filelist.append(subfolder + str(path.name)[:-len(suffix)])
		if firstOnly:
			return filelist
	return filelist


def OutputToDataMap(df, path, dataMap):
	if path in dataMap:
		dataMap[path] = dataMap[path].append(df)
	else:
		dataMap[path] = df


def OutputToFile(df, path, index=True, head=False, appendToExisting=False):
	# Write dataframe to a file.
	# Appends dataframe when called with the same name.
	fullFilePath = path + '.csv'
	MakePath(path)
	#print('OUTPUT', path)
	#if path == '../../output_post/pak_main/cohort/infect_vac_yearlyAgg_1':
	#	print(df)
	
	if appendToExisting and os.path.exists(fullFilePath):
		fileCreated[fullFilePath] = True
	
	if fileCreated.get(fullFilePath):
		# Append
		df.to_csv(fullFilePath, mode='a', header=False, index=index)
	else:
		fileCreated[fullFilePath] = True
		df.to_csv(fullFilePath, index=index) 
		if HEAD_MODE and head:
			last = path.rfind('/')
			df.head(100).to_csv(path[:last + 1] + '_head_' + path[last + 1:] + '.csv', index=index) 


def CrossDf(df1, df2):
	return (df1
		.assign(_cross_merge_key=1)
		.merge(df2.assign(_cross_merge_key=1), on="_cross_merge_key")
		.drop("_cross_merge_key", axis=1)
	)


def CrossIndex(df, indexDf):
	indexNames = [x for x in df.index.names if x != None]
	if len(indexNames) == 0:
		df = df.reset_index(drop=True)
	else:
		df = df.reset_index()
	df = CrossDf(df, indexDf)
	df = df.set_index(list(indexDf.columns) + indexNames)
	df = df.sort_index(axis=0)
	return df


def SplitNetlogoList(chunk, cohorts, name, outputName):
	split_names = [outputName + str(i) for i in range(0, cohorts)]
	df = chunk[name].str.replace('\[', '', regex=True).str.replace('\]', '', regex=True).str.split(' ', expand=True)
	if cohorts - 1 not in df:
		for i in range(cohorts):
			if i not in df:
				df[i] = 0
	chunk[split_names] = df
	chunk = chunk.drop(name, axis=1)
	return chunk
	
  
def SplitNetlogoNestedList(chunk, cohorts, days, colName, name, fillTo=365):
	split_names = [(name, j, i) for j in range(0, days) for i in range(0, cohorts)]
	df = chunk[colName].str.replace('\[', '', regex=True).str.replace('\]', '', regex=True).str.split(' ', expand=True)
	df = df.copy() # de-fragment frame.
	if days * cohorts - 1 not in df:
		for i in range(days * cohorts):
			if i not in df:
				df[i] = 0
	if fillTo:
		for i in [fillTo - j for j in range(1, fillTo)]:
			if i in df.columns:
				break
			else:
				df[i] = 0
		df = df.replace({None : 0})
	df.columns = pd.MultiIndex.from_tuples(split_names, names=['metric', 'day', 'cohort'])
	return df


def GetCohortData(cohortFile, dataCol='age', dataInt=True):
	df = pd.read_csv(cohortFile + '.csv', 
				index_col=[0],
				header=[0])
	df.index.rename('cohort', True)
	df = df.reset_index()
	df['cohort'] = df['cohort'].astype(int)
	if dataInt:
		df[dataCol] = df[dataCol].astype(int)
	return df


def AddFiles(outputName, fileList, index=1, header=1, doTqdm=False):
	first = True
	for fileName in (tqdm.tqdm(fileList) if doTqdm else fileList):
		if first:
			first = False
			df = pd.read_csv(
				fileName + '.csv',
				index_col=list(range(index)),
				header=list(range(header)))
		else:
			df = df + pd.read_csv(
				fileName + '.csv',
				index_col=list(range(index)),
				header=list(range(header)))
	OutputToFile(df, outputName)


def AggregateDuplicateIndex(df):
	index = df.index.to_frame()
	index['row'] =  np.arange(len(index))
	df.index = pd.MultiIndex.from_frame(index)
	df = df.groupby(level=ListRemove(list(df.index.names), 'row')).mean()
	return df


def AppendFiles(
		outputName, fileList, runIndexer, indexSize=1, header=1, doTqdm=False,
		head=False, indexGrouping=False, doAverage=False, doFullDescribe=False, numberKeys=True):
	first = True
	for fileName in (tqdm.tqdm(fileList) if doTqdm else fileList):
		if first:
			first = False
			df = pd.read_csv(
				fileName + '.csv',
				index_col=list(range(indexSize)),
				header=list(range(header)))
		else:
			df = df.append(pd.read_csv(
				fileName + '.csv',
				index_col=list(range(indexSize)),
				header=list(range(header))))
	
	# Average the runs by grouping chunks of index values.
	if indexGrouping is not False:
		index = df.index.to_frame()
		index['_index_agg'] = np.floor(index[runIndexer] / indexGrouping)
		df.index = pd.MultiIndex.from_frame(index)
		df = df.groupby(level=ListRemove(list(range(indexSize + 1)), [0, 1]), axis=0).mean()
		df.index = df.index.rename(runIndexer, level='_index_agg')
		
		df.index = df.index.set_levels(df.index.levels[indexSize - 2].astype(int), level=runIndexer)
		df = df.reorder_levels([indexSize - 2] + list(range(0, indexSize - 2)))
	else:
		df = df.droplevel('run', axis=0)
	
	df = df.sort_index()
	if numberKeys:
		df.columns = pd.to_numeric(df.columns).astype(int)
	
	OutputToFile(df, outputName, head=head)
	
	groupbyLevels = ListRemove(list(range(indexSize - 1)), 0)
	if doAverage:
		dfAve = df.groupby(level=groupbyLevels, axis=0).mean()
		OutputToFile(dfAve, outputName + '_drawAve', head=head)
	
	if doFullDescribe:
		for percentile in [0, 0.05, 0.25, 0.5, 0.75, 0.95, 1]:
			OutputToFile(
				df.groupby(level=groupbyLevels, axis=0).quantile(percentile),
				'{}_{}'.format(outputName, percMap[percentile]), head=head)


def ListRemove(myList, element, lenient=False):
	if type(element) == list:
		for e in element:
			myList = ListRemove(myList, e, lenient=lenient)
		return myList
	myCopy = list(myList).copy()
	if (not lenient) or element in myCopy:
		myCopy.remove(element)
	return myCopy


def ListUnique(myList):
	return list(dict.fromkeys(myList))


def GetFigMult(x, sigFigs):
	return 10**math.floor(math.log10(abs(x)) - sigFigs + 1)


def RoundNumber(x, sigFigs=2):
	if abs(x) < 0.001:
		return '{:,.6f}'.format(x)
	if abs(x) < 1:
		return '{:,.3f}'.format(x)
	if abs(x) < 10:
		return '{:,.2f}'.format(x)
	return '{:,.0f}'.format(GetFigMult(x, sigFigs)*round(x/GetFigMult(x, sigFigs)))


def FilterOnIndex(df, indexName, minVal, maxVal):
	filterIndex = df.index.get_level_values(indexName)
	minExisting = max(filterIndex.min(), minVal)
	maxExisting = min(filterIndex.max(), maxVal - 1)
	filterIndex = ((filterIndex >= minExisting) & (filterIndex <= maxExisting))
	df = df[filterIndex]
	return df


def FilterOutIndexVal(df, indexDict):
	filterIndex = True
	for name, val in indexDict.items():
		thisFilter = df.index.get_level_values(name)
		if type(val) == list:
			valFilter = False
			for v in val:
				valFilter = ((thisFilter == v) | valFilter)
			filterIndex = (valFilter & filterIndex)
		else:
			filterIndex = ((thisFilter == val) & filterIndex)
	df = df[(~filterIndex)]
	return df


def GetMultiIndexFilter(df, targetIndex):
	filterIndex = False
	for key, value in targetIndex.items():
		keyValues = df.index.get_level_values(key)
		if type(value) is dict:
			if 'lower' in value:
				if 'upper' in value:
					minExisting = max(keyValues.min(), value['lower'])
					maxExisting = min(keyValues.max(), value['upper'] - 1)
					newFilter = ((keyValues >= minExisting) & (keyValues <= maxExisting))
				else:
					minExisting = max(keyValues.min(), value['lower'])
					newFilter = (keyValues >= minExisting)
			elif 'upper' in value:
				maxExisting = min(keyValues.max(), value['upper'] - 1)
				newFilter = (keyValues <= maxExisting)
			elif 'names' in value:
				keyValues = newFilter
				newFilter = False
				for indexVal in value['names']:
					if newFilter is False:
						newFilter = (keyValues == indexVal)
					else:
						newFilter = (newFilter | (keyValues == indexVal))
		else:
			newFilter = (keyValues == value)
		
		if filterIndex is False:
			filterIndex = newFilter
		else:
			filterIndex = (filterIndex & newFilter)
	return filterIndex


def IdentifyIndex(df, identifyIndex, quantile=False):
	if quantile is not False:
		return df.groupby(ListRemove(list(df.index.names), identifyIndex)).quantile(quantile)
	return df.groupby(ListRemove(list(df.index.names), identifyIndex)).mean()


def Opt(conf, keyList, default=False):
	# Load an optional parameter (or path of parameters) from a dict, with a default if it is not found.
	if type(keyList) is list and len(keyList) <= 1:
		keyList = keyList[0]
	
	if type(keyList) is not list:
		if keyList in conf:
			return conf[keyList]
		else:
			return default
	
	if keyList[0] not in conf:
		return default
	
	return Opt(conf[keyList[0]], keyList[1:], default)


def LoadJson(filePath):
	with open('{}.json'.format(filePath)) as json_file:
		try:
			return json.load(json_file)
		except ValueError as err:
			print("=== Json Error ===")
			print("File: '{}.json'".format(filePath))
			print(err)
			return False


def ToHeatmap(df, structure):
	if df.index.name != None:
		df = df.reset_index()
	
	df['_sort_row'] = ''
	for value in structure['sort_rows']:
		if value[0] in df.columns:
			repDict = {x : str(i).zfill(2) for i, x in enumerate(value[1])}
			df['_sort_row'] = df['_sort_row'] + df[value[0]].replace(repDict).astype(str)
	df['_sort_col'] = ''
	for value in structure['sort_cols']:
		if value[0] in df.columns:
			repDict = {x : str(i).zfill(2) for i, x in enumerate(value[1])}
			df['_sort_col'] = df['_sort_col'] + df[value[0]].replace(repDict).astype(str)
	
	df = df.set_index(['_sort_row', '_sort_col'] + structure['index_rows'] + structure['index_cols'])
	df = df.unstack(['_sort_col'] + structure['index_cols'])
	df = df.sort_index(axis=0, level=0)
	df = df.sort_index(axis=1, level=0)
	
	df.columns = df.columns.droplevel(level='_sort_col')
	if len(df.index.names) > 1:
		df.index = df.index.droplevel(level='_sort_row')
	else:
		df = df.reset_index(drop=True)
		df = df.rename(index={0 : 'value'})
	return df

def PreAddList(pre, myList):
	return [pre + x for x in myList]


def MakeDescribedHeatmapSet(
		subfolder, df, heatStruct, prefixName,
		describe=False, identifyIndex=False,
		describeList=[x*0.01 for x in range(1, 100)],
		extraDir='extra/'):
	print('Output heatmap {}'.format(prefixName))
	percentList = [0.05, 0.25, 0.5, 0.75, 0.95]
	df = df.sort_index()
	
	if identifyIndex is not False:
		df = df.groupby(ListRemove(list(df.index.names), identifyIndex)).mean()
		heatStruct = heatStruct.copy()
		heatStruct['index_rows'] = ListRemove(heatStruct['index_rows'], identifyIndex, lenient=True)
		heatStruct['index_cols'] = ListRemove(heatStruct['index_cols'], identifyIndex, lenient=True)
	
	relevantMeasureCols = heatStruct.get('index_rows') + heatStruct.get('index_cols')
	if describe:
		name = prefixName + '_describe'
		#print('Describe {} draws'.format(prefixName))
		df_describe = df.copy()
		df_describe = df_describe.unstack(relevantMeasureCols)
		df_describe = df_describe.describe(percentiles=describeList)
		OutputToFile(df_describe, subfolder + name, head=False)
	
	dfMean = df.copy()
	dfMean = dfMean.groupby(level=relevantMeasureCols, axis=0).mean().to_frame()
	dfMean = dfMean.rename(columns={dfMean.columns[0] : 'mean'})
	
	df = df.groupby(level=relevantMeasureCols, axis=0).quantile(percentList)
	df.index.names = relevantMeasureCols + ['percentile']
	df = df.reorder_levels(['percentile'] + relevantMeasureCols).sort_index()
	
	dfMean = dfMean.reset_index()
	dfMean = dfMean.rename({dfMean.columns[0] : 'mean'})
	dfHeat = ToHeatmap(dfMean, heatStruct)
	#print(dfHeat)
	
	name =  prefixName + '_mean'
	#dfHeat = dfHeat.drop_duplicates()
	OutputToFile(dfHeat, subfolder + name, head=False)
	
	for pc in percentList:
		#dfHeat = df.loc[pc, :]
		dfHeat = df[pc].to_frame().rename(columns={0 : 'pc_{}'.format(pc)})
		dfHeat = ToHeatmap(dfHeat.reset_index(), heatStruct)
		name =  prefixName + '_' + percMap.get(pc)
		#print('Output heatmap {}'.format(name))
		#dfHeat = dfHeat.drop_duplicates()
		if pc == 0.5:
			OutputToFile(dfHeat, subfolder + name, head=False)
		else:
			OutputToFile(dfHeat, subfolder + extraDir + name, head=False)
	
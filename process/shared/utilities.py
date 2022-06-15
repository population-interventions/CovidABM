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


def LoadJsonFile(path):
	path = path + '.json'
	with open(path) as json_file:
		jsonData = json.load(json_file)
	return jsonData

	
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
		os.mkdir(out_folder, exist_ok=True)


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


def OutputToFile(df, path, index=True, head=True, appendToExisting=False):
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


def AppendFiles(
		outputName, fileList, runIndexer, indexSize=1, header=1, doTqdm=False,
		head=False, indexGrouping=False, doAverage=False):
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
		df = df.groupby(level=ListRemove(list(range(indexSize + 1)), 1), axis=0).mean()
		df.index = df.index.rename(runIndexer, level='_index_agg')
		
		df.index = df.index.set_levels(df.index.levels[indexSize - 1].astype(int), level=runIndexer)
		df = df.reorder_levels([0, indexSize - 1] + list(range(1, indexSize - 1)))
		
	df = df.droplevel('run', axis=0)
	df = df.sort_index(0)
	df.columns = pd.to_numeric(df.columns).astype(int)
	
	OutputToFile(df, outputName, head=head)
	
	if doAverage:
		dfAve = df.groupby(level=ListRemove(list(range(indexSize - 1)), 0), axis=0).mean()
		OutputToFile(dfAve, outputName + '_drawAve', head=head)


def ListRemove(myList, element):
	myCopy = list(myList).copy()
	myCopy.remove(element)
	return myCopy


def ListUnique(myList):
	return list(dict.fromkeys(myList))


def FilterOnIndex(df, indexName, minVal, maxVal):
	filterIndex = df.index.get_level_values(indexName)
	minExisting = max(filterIndex.min(), minVal)
	maxExisting = min(filterIndex.max(), maxVal - 1)
	filterIndex = ((filterIndex >= minExisting) & (filterIndex <= maxExisting))
	df = df[filterIndex]
	return df

def ToHeatmap(df, structure):
	if df.index.name != None:
		df = df.reset_index()
	
	df['_sort_row'] = ''
	for value in structure['sort_rows']:
		df['_sort_row'] = df['_sort_row'] + df[value[0]].replace(value[1]).astype(str)
	df['_sort_col'] = ''
	for value in structure['sort_cols']:
		df['_sort_col'] = df['_sort_col'] + df[value[0]].replace(value[1]).astype(str)
	
	df = df.set_index(['_sort_row', '_sort_col'] + structure['index_rows'] + structure['index_cols'])
	df = df.unstack(['_sort_col'] + structure['index_cols'])
	df = df.sort_index(axis=0, level=0)
	df = df.sort_index(axis=1, level=0)
	
	df.columns = df.columns.droplevel(level='_sort_col')
	df.index = df.index.droplevel(level='_sort_row')
	return df


def MakeDescribedHeatmapSet(
		subfolder, df, heatStruct, prefixName,
		describe=False,
		describeList=[x*0.01 for x in range(1, 100)]):
	
	print('Output heatmap {}'.format(prefixName))
	percentList = [0.05, 0.5, 0.95]
	percMap = {
		0.05: 'percentile_005',
		0.95 : 'percentile_095',
		0.5 : 'percentile_050',
	}
	df = df.sort_index()
	
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
	#print(dfMean)
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
		OutputToFile(dfHeat, subfolder + name, head=False)
	
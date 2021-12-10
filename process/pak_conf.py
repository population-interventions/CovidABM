import pandas as pd
import numpy as np

measureCols_raw = [
	'in_dose1',
	'in_dose2',
]
measureCols = [
	'Scenario',
	'VacUptake',
]

def indexRenameFunc(chunk):
	index = chunk.index.to_frame()
	#index['R0'] = index['global_transmissibility_out'].apply(lambda x: 3.75 if x < 0.61333 else (4.17 if x < 0.681666 else 4.58))

	index['in_dose1'] = index['in_dose1'].replace({
		"_1" : '12+',
		"_2" : '5+',
		"_3" : '5+_boost',
		"_4" : '12+_boost',
		"_5" : '5+_boost_parallel',
		"_6" : '12+_fast_urban',
	})
	index['in_dose2'] = index['in_dose2'].replace({
		"_60" : '60%',
		"_70" : '70%',
		"_80" : '80%',
	})
	
	renameCols = {measureCols_raw[i] : measureCols[i] for i in range(len(measureCols))}
	index = index.rename(columns=renameCols)
	
	chunk.index = pd.MultiIndex.from_frame(index)
	return chunk


def GetMeasureColsRaw():
	return measureCols_raw


def GetMeasureCols():
	return measureCols


def GetIndexRenameFunc():
	return indexRenameFunc

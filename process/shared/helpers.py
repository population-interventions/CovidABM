
import pandas as pd
import process.shared.utilities as util

def AggregateAndPickOutColumn(nameList, index, runIndex, notFloatCol, columName):
	interestingColumns = index + [runIndex, columName]
	print('interestingColumns', interestingColumns)
	
	df = pd.DataFrame(columns=interestingColumns)
	for v in nameList:
		pdf = pd.read_csv(v + '.csv', header=6)
		pdf = pdf[interestingColumns]
		df  = df.append(pdf)
	 
	for colName in interestingColumns:
		if colName not in notFloatCol:
			df[colName] = df[colName].astype(float)

	df = df.set_index(index + [runIndex])
	df = df.transpose().stack(runIndex)
	df = df.describe(percentiles=[0 + 0.01*i for i in range(100)])
	return df
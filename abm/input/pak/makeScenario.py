
import pandas as pd
import numpy as np
from tqdm import tqdm

import os, sys
currentdir = os.path.dirname(os.path.realpath(__file__))
parentdir = os.path.dirname(currentdir)
sys.path.append('../../../process/')

import shared.utilities as util

def LoadTable(scenario, vac):
	print('pre/scenario{}_{}.csv'.format(scenario, vac))
	df = pd.read_csv('pre/scenario{}_{}.csv'.format(scenario, vac))
	#util.OutputToFile(df, 'pre/scenario{}_{}'.format(scenario + 1, vac), head=False, index=False)
	
	# Zero entries are often left empty, and the multiindex is not written out in full
	df = df.fillna(method='ffill').fillna(0)
	
	# Rename the human names to something more processable
	df = df.rename(columns={
		'Unnamed: 0' : 'region',
		'Mnth' : 'cohort',
	})
	df['region'] = df['region'].replace({
		"Rural" : 'R',
		"Urban" : 'U',
	})
	df['age'] = df['cohort'].replace({
		"60+ double vacc'ed" : 60,
		"18-59 double vacc'ed" : 18,
		"12-17 double vacc'ed" : 12,
		"5-11 double vacc'ed" : 5,
		"60+ booster - one shot" : 60,
		"18 to 59 booster - one shot" : 18,
		"60+ double vacc'ed" : 60,
		"18-59 double vacc'ed" : 18,
		"12-17 double vacc'ed" : 12,
		"5-11 double vacc'ed" : 5,
		"60+ booster - one shot" : 60,
		"18 to 59 booster - one shot" : 18,
	})
	df['shot'] = df['cohort'].replace({
		"60+ double vacc'ed" : '',
		"18-59 double vacc'ed" : '',
		"12-17 double vacc'ed" : '',
		"5-11 double vacc'ed" : '',
		"60+ booster - one shot" : '_3',
		"18 to 59 booster - one shot" : '_3',
		"60+ double vacc'ed" : '',
		"18-59 double vacc'ed" : '',
		"12-17 double vacc'ed" : '',
		"5-11 double vacc'ed" : '',
		"60+ booster - one shot" : '_3',
		"18 to 59 booster - one shot" : '_3',
	})
	
	setupNeedDoseTwo = [1, 2, 3, 4, 5, 6, 7, 8] # TODO, calculate
	
	# Finalise loading reasonable index.
	df = df.set_index(['shot', 'region', 'age'])
	df = df.drop(columns=['cohort'])
	df = df.sort_index()
	
	# Add shot 2 a month after the first shot.
	df = df.transpose()
	df2 = df[['']].rename(columns={'' : '_2'}).transpose()
	df2.columns = (df2.columns.astype(int) + 1).astype(str)
	df2['1'] = setupNeedDoseTwo
	df = df.join(df2.transpose())
	df = df.transpose()
	
	# Expand per-month data to be copied for each day
	df = util.CrossIndex(df, pd.DataFrame({'day' : list(range(30))}))
	df = df.unstack('day') / 30
	df = df.transpose()
	
	# Collapse month and day into a single index
	index = df.index.set_names('month',level=0).to_frame()
	index['day'] = index['day'] + (index['month'].astype(int) - 1)*30
	index = index.drop(columns=['month'])
	df.index = pd.MultiIndex.from_frame(index)
	
	# Collapse region, age and shot into a single identifier used by the ABM.
	colIndex = df.columns.to_frame()
	colIndex['id'] = colIndex['region'] + colIndex['age'].astype(str) + colIndex['shot']
	colIndex = colIndex[['id']]
	df.columns = pd.MultiIndex.from_frame(colIndex)
	
	util.OutputToFile(df, 'dose_rate_{}_{}'.format(scenario, vac), index=False, head=False)
	

for i in range(1, 7):
	for j in [60, 70, 80]:
		LoadTable(i, j)
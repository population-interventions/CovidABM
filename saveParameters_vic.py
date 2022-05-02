# -*- coding: utf-8 -*-
"""
Created on Thu Feb 11 12:11:03 2021

@author: wilsonte
"""

from numpy import random
import random as baseRandom

import process.shared.utilities as util
import setup.readNetlogo as nl


def ReadModelFileAndWriteParams(startPart, endPart, valueOverwrite, topOfFile=[]):
	parameters = nl.GetModelDefaults('abm/covidModel.nlogo', startPart, endPart)
	parameters.sort()
	
	valueOverwrite = nl.ToNetlogoStr(nl.LowerKeys(valueOverwrite))
	outputFile = open('paramFile.txt', 'w')
	
	for i in range(len(topOfFile)):
		util.SwapToPos(parameters, topOfFile[i].lower(), i)
	
	for data in parameters:
		name, value = str(data[0]), str(data[1])
		if valueOverwrite.get(name):
			value = valueOverwrite[name]
		outputFile.write('["' + name + '" ' + value + ']\n')  
		
	
	outputFile.close()
	nl.OutputCurrentNetlogoValues('abm/covidModel.nlogo', 'specs/default/currentAbm.json')
  

topOfFile = [
	'draw_index',
	'Gather_Location_Count',
	'param_policy',
	'policy_pipeline',
	'Global_Transmissibility',
	'global_trans_std',
	'R0_range',
	'param_vac_uptake',
	'param_vacincurmult',
	'stage_test_index',
	'calibrate',
]

defaultParams = {
}

paramValues_mainTest = {**defaultParams, **{
	'rand_seed' : nl.listToStr(util.GetRandomListUnique(100)),
    'total_population' : '234000000',

	'draw_index' : nl.listToStr(list(range(10))),
	'incursion_phase_speed_mult' : nl.listToStr([
		0.5,
		1,
		1.5
	]),
	'param_vac_uptake_mult' : nl.listToStr([
		0.75,
		0.85,
		0.95
	]),
	'param_policy' : '"TightSupress_No_4"',
	
	'data_suffix' : nl.listToStr([
		'".csv"',
	]),
	'policy_switch' : '"pak"',
	'end_day' : 390,
}}

paramValues_rCalcSmall = {**defaultParams, **{
	'draw_index' : nl.listToStr(list(range(1000))),
    'total_population' : '6649066',
	'first_case_calibrate' : 'true',
	'trans_override' : nl.listToStr([0.25, 0.5, 0.75]),
	'sympt_iso_prop' : nl.listToStr([0, 1]),
}}

ReadModelFileAndWriteParams('GRAPHICS-WINDOW', '@#$#@#$#@',
							paramValues_rCalcSmall,
							topOfFile=topOfFile)

# -*- coding: utf-8 -*-
"""
Created on Thu Feb 11 12:11:03 2021

@author: wilsonte
"""

from numpy import random
import random as baseRandom
import utilities as util

def listToStr(input):
	return " ".join(str(x) for x in input)


def GetRandomListUnique(listSize, maxIntSize=10000000):
	randList = baseRandom.sample(range(maxIntSize), listSize)
	while len(util.FindRepeat(randList)) > 0:
		randList = baseRandom.sample(range(maxIntSize), listSize)
	
	print(len(list(set(randList))))
	return listToStr(randList)


def MoveMatchToPos(data, match, pos):
	for i in range(len(data)):
		if data[i][0] == match:
			data[i], data[pos] = data[pos], data[i]
			return


def ToNetlogoStr(data):
	for i in data:
		if type(data[i]) is not str:
			data[i] = str(data[i]).lower()
	return data


def FindNameAndValue(file, nameLines, valueLines):
	foundName = False
	while True:
		line = file.readline().rstrip()
		if nameLines > 0:
			nameLines -= 1
			if nameLines == 0:
				foundName = line.lower()
		elif valueLines > 0:
			valueLines -= 1
			if valueLines == 0:
				return foundName, line 


def GetChooserValue(optionString, choice):
	options = optionString.split(" ")
	return options[int(choice)]


def LowerKeys(myDict):
	if not myDict:
		return False
	outdict = {}
	for k, v in myDict.items():
		outdict[k.lower()] = v
	return outdict


def ReadModelFileAndWriteParams(startPart, endPart, valueOverwrite, topOfFile=[]):
	valueOverwrite = ToNetlogoStr(LowerKeys(valueOverwrite))
	modelFile = open('COVID SIMULS VIC JAN Vaccination Model.nlogo', 'r')
	outputFile = open('paramFile.txt', 'w')
	foundPart = False
	parameters = []
	
	while True:
		# Get next line from file
		line = modelFile.readline().rstrip()
		if foundPart and line == endPart:
			break
			
		if line == startPart:
			foundPart = True
		
		if foundPart:
			if line == 'SLIDER':
				name, value = FindNameAndValue(modelFile, 5, 4)
				if value == '2.5E7':
					value = 25000000 # >_<
				parameters.append([name, value])
			elif line == 'SWITCH':
				name, value = FindNameAndValue(modelFile, 5, 2)
				if int(value) == 0:
					# Weird how netlogo stores switches packwards.
					value = 'true'
				else:
					value = 'false'
				parameters.append([name, value])
			elif line == 'INPUTBOX':
				name, value = FindNameAndValue(modelFile, 5, 1)
				parameters.append([name, value])
			elif line == 'CHOOSER':
				name, value = FindNameAndValue(modelFile, 5, 2)
				value = GetChooserValue(value, modelFile.readline().rstrip())
				parameters.append([name, value])
	
	modelFile.close()
	
	parameters.sort()
	for i in range(len(topOfFile)):
		MoveMatchToPos(parameters, topOfFile[i].lower(), i)
	
	for data in parameters:
		name, value = str(data[0]), str(data[1])
		if valueOverwrite.get(name):
			value = valueOverwrite[name]
		outputFile.write('["' + name + '" ' + value + ']\n')  
		
	
	outputFile.close()
  

topOfFile = [
	'rand_seed',
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

paramValues_stageEssential = {**defaultParams, **{
	'rand_seed' : GetRandomListUnique(100),
	'total_population' : '5000000',
	'r0_range' : listToStr([6.5]),
	'param_policy' : listToStr([ 
		'"ModerateElim"',
		'"TightSupress"',
		'"LooseSupress"',
		'"BarelySupress"',
	]),
	'data_suffix' : listToStr([
		'"_70"',
		'"_80"',
		'"_90"',
		'"_95"',
	]),
	'data_suffix_2' : listToStr([
		'"_12.csv"',
		'"_5.csv"',
	]),
	'policy_switch': '"nz"',
	'min_stage' : 2,
	'param_vac_uptake_mult' : listToStr([0]),
	'param_vacIncurMult' : listToStr([0.2, 1, 5, 10]),
	'param_final_phase' : listToStr([4]),
	'Non_Infective_Time' : listToStr([0]),
	'compound_essential' : listToStr(['"Extreme"']),
	'param_vac_rate_mult' : listToStr([0.5]),
	'input_population_table' : '"input/population_nz"', 
	'input_vaccine_table' : '"input/vaccine_rollout.csv"',
	'input_dose_rate_table' : '"input/dose_rate.csv"',
	'input_incursion_table' : '"input/incursion_nz.csv"',
	'policy_pipeline' : '"None"',
	'end_day' : 364,
}}

ReadModelFileAndWriteParams('GRAPHICS-WINDOW', '@#$#@#$#@',
							paramValues_stageEssential,
							topOfFile=topOfFile)

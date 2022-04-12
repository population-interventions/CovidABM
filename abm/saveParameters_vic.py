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


def FindNameAndValue(file, nameLines, valueLines, extra=False):
	foundName = False
	while True:
		line = file.readline().rstrip()
		if nameLines > 0:
			nameLines -= 1
			if nameLines == 0:
				foundName = line.lower()
		else:
			valueLines -= 1
			if valueLines == 0:
				retLine = line
			
			if valueLines <= 0:
				if extra:
					if extra <= -valueLines:
						return foundName, retLine, line 
				else:
					return foundName, retLine 


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
	modelFile = open('covidModel.nlogo', 'r')
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
					# Weird how netlogo stores switches backwards.
					value = 'true'
				else:
					value = 'false'
				parameters.append([name, value])
			elif line == 'INPUTBOX':
				name, value, extra = FindNameAndValue(modelFile, 5, 1, extra=3)
				if extra == 'String':
					value = '"{}"'.format(value)
				parameters.append([name, value])
			elif line == 'CHOOSER':
				name, value = FindNameAndValue(modelFile, 5, 2)
				value = GetChooserValue(value, modelFile.readline().rstrip())
				print(name, value)
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
	'rand_seed' : GetRandomListUnique(100),
    'total_population' : '234000000',

	'draw_index' : listToStr(list(range(10))),
	'incursion_phase_speed_mult' : listToStr([
		0.5,
		1,
		1.5
	]),
	'param_vac_uptake_mult' : listToStr([
		0.75,
		0.85,
		0.95
	]),
	'param_policy' : '"TightSupress_No_4"',
	
	'data_suffix' : listToStr([
		'".csv"',
	]),
	'policy_switch' : '"pak"',
	'end_day' : 390,
}}

paramValues_rCalcSmall = {**defaultParams, **{
	'draw_index' : listToStr(list(range(1000))),
    'total_population' : '6649066',
	'first_case_calibrate' : 'true',
	'trans_override' : listToStr([0.25, 0.5, 0.75]),
	'sympt_iso_prop' : listToStr([0, 1]),
}}

ReadModelFileAndWriteParams('GRAPHICS-WINDOW', '@#$#@#$#@',
							paramValues_rCalcSmall,
							topOfFile=topOfFile)


import re

import process.shared.utilities as util

def listToStr(input):
	return " ".join(str(x) for x in input)


def ToNetlogoStr(data):
	for i in data:
		if type(data[i]) is not str:
			data[i] = str(data[i]).lower()
	return data


def IsExperimentStart(line, name):
	match = re.search('  <experiment name="[^"]*', line)
	if match is None:
		return False
	return match.group()[20:] == name


def ToNetlogoType(data):
	if type(data) is dict:
		out = {}
		for key, value in data.items():
			out[key] = ToNetlogoType(value)
		return out
	if type(data) is list:
		out = []
		for item in data:
			out.append(ToNetlogoType(item))
		return out
	if data is True:
		return 'true'
	elif data is False:
		return 'false'
	elif type(data) is str:
		return '\"{}\"'.format(data)
	else: # Assume it's a number! 
		return "{}".format(data)


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


def WriteModelParamsXml(file, params):
	for key, valueList in params.items():
		file.write('    <enumeratedValueSet variable="{}">\n'.format(key))
		for value in valueList:
			value = value.replace('"', '&quot;')
			file.write('      <value value="{}"/>\n'.format(value))
		file.write('    </enumeratedValueSet>\n')


def GetModelDefaults(modelName, startPart, endPart):
	modelFile = open(modelName, 'r')
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
				parameters.append([name, value])
	modelFile.close()
	return parameters


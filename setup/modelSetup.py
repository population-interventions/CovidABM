
from numpy import random
import random as baseRandom
import json

import process.shared.utilities as util
import process.shared.modelData as md
import setup.readNetlogo as nl

GRAPHICS_START = 'GRAPHICS-WINDOW'
SEPARATOR = '<experiments>'
BEHAVIOUR_END = '</experiments>'


def OutputCurrentNetlogoValues(netlogoFileName):
	parameters = util.ListListToDictList(
		nl.GetModelDefaults(netlogoFileName, GRAPHICS_START, SEPARATOR))
	util.StringToFile('specs/default/temp.json', json.dumps(parameters, indent=4))


def MakeHeadlessWithCustomBehaviourSpace(modelData):
	modelFile = open(modelData['netlogoFileName'], 'r')
	outputFile = open(modelData['headlessFileName'], 'w')
	ignore = False
	
	inGraphicsSection = False
	inBehaviourSection = False
	inTargetExperiment = False
	while True:
		# Get next line from file
		line = modelFile.readline()
		if line == '':
			break
		line = line.rstrip()
		
		# Section transitions
		if inGraphicsSection:
			if line == SEPARATOR:
				outputFile.write(line + '\n')
				inGraphicsSection = False
				inBehaviourSection = True
			else:	
				# Strip the plots and monitors on the UI
				if line == 'MONITOR':
					ignore = True
				elif line == 'PLOT':
					ignore = True
				elif line == '':
					ignore = False
					
				if not ignore:
					outputFile.write(line + '\n')
		elif inBehaviourSection:
			if line == BEHAVIOUR_END:
				inBehaviourSection = False
				outputFile.write(line + '\n')
			elif inTargetExperiment:
				if line.find('<setup>') >= 0 or line.find('<go>') >= 0 or line.find('<metric>') >= 0:
					outputFile.write(line + '\n')
				elif line.find('</experiment>') >= 0:
					nl.WriteModelParamsXml(outputFile, modelData['modelParams'])
					outputFile.write(line + '\n')
					inTargetExperiment = False
			elif nl.IsExperimentStart(line, modelData['copyExperimentMetrics']):
				outputFile.write('  <experiment name="headless_experiment" repetitions="1" runMetricsEveryStep="false">\n')
				inTargetExperiment = True
		else:
			if line == GRAPHICS_START:
				inGraphicsSection = True
			outputFile.write(line + '\n')
	
	outputFile.close()
	modelFile.close()
	

def MakeHeadlessWithParameters(specFile, runCount):
	modelData = md.LoadModelDatWithExperimentInput(specFile, runCount)
	
	# Useful for checking validity
	OutputCurrentNetlogoValues(modelData['netlogoFileName'])
	
	MakeHeadlessWithCustomBehaviourSpace(modelData)
	
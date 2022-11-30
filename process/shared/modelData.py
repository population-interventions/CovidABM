
import os

import setup.readNetlogo as nl
import process.shared.utilities as util


def LoadRawModelDataFile(specFile):
	if os.path.exists('specs/{}.json'.format(specFile)):
		return util.LoadJson('specs/{}'.format(specFile))
	return util.LoadJsonFile('../scratch/specs/{}'.format(specFile))


def WriteSpecFile(name, data, toScratch=True):
	if toScratch:
		path = '../scratch/specs/{}'.format(name)
	else:
		path = 'specs/{}'.format(name)
	util.WriteJsonFile(path, data)


def LoadModelData(specFile):
	modelData = LoadRawModelDataFile(specFile)
	modelData['name'] = specFile
	if 'baseName' not in modelData:
		modelData['baseName'] = modelData['name']
	modelData['scratchDir'] = '../scratch/{}'.format(modelData['scratchDir'] if 'scratchDir' in modelData else specFile)
	if 'handlerName' in modelData:
		modelData['handlerDir'] = '../scratch/{}'.format(modelData['handlerName'])
	if 'postInputDir' in modelData:
		modelData['postInputDir'] = '../CovidABM/post_input/{}'.format(modelData['postInputDir'])
		
	
	return modelData


def LoadModelDatWithExperimentInput(specFile, runCount):
	modelData = LoadModelData(specFile)
	
	overrideParams = modelData['indexParams'].copy()
	overrideParams.update({k : [v] for (k, v) in modelData['paramOverrides'].items()})
	overrideParams[modelData['runIndexer']] = list(range(runCount))
	overrideParams = nl.ToNetlogoType(overrideParams)
	
	defaultParams = util.LoadJsonFile('specs/default/{}'.format(modelData['defaultParamFile']))
	
	modelData['modelParams'] = util.ApplyDefaultToDict(overrideParams, defaultParams)
	modelData['netlogoFileName'] = 'abm/{}.nlogo'.format(modelData['netlogoFile'])
	modelData['headlessFileName'] = 'abm/headless_{}.nlogo'.format(modelData['name'])
	
	return modelData
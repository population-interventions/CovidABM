
import setup.readNetlogo as nl
import process.shared.utilities as util


def LoadRawModelDataFile(specFile):
	return util.LoadJsonFile('specs/{}'.format(specFile))

def LoadModelData(specFile):
	modelData = LoadRawModelDataFile(specFile)
	modelData['name'] = specFile
	if 'baseName' not in modelData:
		modelData['baseName'] = modelData['name']
	modelData['scratchDir'] = '../scratch/{}'.format(specFile)
	if 'handlerName' in modelData:
		modelData['handlerDir'] = '../scratch/{}'.format(modelData['handlerName'])
	
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

import setup.readNetlogo as nl
import process.shared.utilities as util

def LoadModelData(specFile):
	modelData = util.LoadJsonFile('specs/{}'.format(specFile))
	modelData['name'] = specFile
	modelData['scratchDir'] = '../scratch/{}'.format(specFile)
	
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
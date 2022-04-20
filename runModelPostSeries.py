import sys
import process.shared.modelData as md
import process.simpleRcalc as rcalc
import process.targetOptimise as targetOptimise

modelName = sys.argv[1] if len(sys.argv) > 1 else 'rc_auto'

modelData = md.LoadModelData(modelName)

if 'postSeries' in modelData:
	if 'rcalc' in modelData['postSeries']:
		rcalc.ProcessResults(modelData)
	if 'targetOptimise' in modelData['postSeries']:
		targetOptimise.ProcessResults(modelData)
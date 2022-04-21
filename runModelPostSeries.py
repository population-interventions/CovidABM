import sys
import process.shared.modelData as md
import process.simpleRcalc as rcalc
import process.targetOptimise as targetOptimise

modelName = sys.argv[1] if len(sys.argv) > 1 else 'rc_auto'
runs = sys.argv[2] if len(sys.argv) > 2 else 10
pernode = sys.argv[3] if len(sys.argv) > 3 else 5

modelData = md.LoadModelData(modelName)

if 'postSeries' in modelData:
	if 'rcalc' in modelData['postSeries']:
		rcalc.ProcessResults(modelData)
	if 'targetOptimise' in modelData['postSeries']:
		targetOptimise.ProcessResults(modelData, runs, pernode)
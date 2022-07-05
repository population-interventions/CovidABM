import sys
import process.shared.modelData as md
import process.simpleRcalc as rcalc
import process.targetOptimise as targetOptimise
import process.mainProcessing as mainProcessing
import process.postSmall as postSmall

onHpc = len(sys.argv) > 1
modelName = sys.argv[1] if len(sys.argv) > 1 else 'vic_main_post'
runs = sys.argv[2] if len(sys.argv) > 2 else 10
pernode = sys.argv[3] if len(sys.argv) > 3 else 5

modelData = md.LoadModelData(modelName)

if 'postSeries' in modelData:
	if 'processMain' in modelData['postSeries']:
		mainProcessing.RunSeriesPost(modelData, runs, pernode)
	if 'processMainPost' in modelData['postSeries']:
		postSmall.RunPostSmall(modelData, runs, pernode, onHpc)
	if 'rcalc' in modelData['postSeries']:
		rcalc.ProcessResults(modelData)
	if 'targetOptimise' in modelData['postSeries']:
		targetOptimise.ProcessResults(modelData, runs, pernode)
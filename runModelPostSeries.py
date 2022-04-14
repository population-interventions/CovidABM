import sys
import process.shared.modelData as md
import process.simpleRcalc as rcalc

modelName = sys.argv[1] if len(sys.argv) > 1 else 'vic_rcalc'

modelData = md.LoadModelData(modelName)

if 'postSeries' in modelData:
	if 'rcalc' in modelData['postSeries']:
		rcalc.ProcessResults(modelData)
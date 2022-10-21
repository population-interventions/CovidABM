import sys
import setup.modelSetup as modelSetup
import setup.splitInput as splitInput

modelName = sys.argv[1] if len(sys.argv) > 1 else 'rcalc_stage'
runCount = int(sys.argv[2]) if len(sys.argv) > 2 else 1
cullUi = (len(sys.argv) > 2) or False

modelSetup.MakeHeadlessWithParameters(modelName, runCount=runCount, cullUi=cullUi)

# Run manually, not on HPC
#if len(sys.argv) < 2:
#	splitInput.DoVicSplit()

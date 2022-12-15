import sys
import setup.modelSetup as modelSetup
import setup.splitInput as splitInput

modelName = sys.argv[1] if len(sys.argv) > 1 else 'vic_mask_stage15_square'
runCount = int(sys.argv[2]) if len(sys.argv) > 2 else 10
cullUi = (len(sys.argv) > 2) or True

modelSetup.MakeHeadlessWithParameters(modelName, runCount=runCount, cullUi=cullUi)

# Run manually, not on HPC
#if len(sys.argv) < 2:
#	splitInput.DoVicSplit()

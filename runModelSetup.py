import sys
import setup.modelSetup as modelSetup
import setup.splitInput as splitInput

modelName = sys.argv[1] if len(sys.argv) > 1 else 'vic_main'
runCount = int(sys.argv[2]) if len(sys.argv) > 2 else 2

modelSetup.MakeHeadlessWithParameters(modelName, runCount=runCount)
#splitInput.DoVicSplit()


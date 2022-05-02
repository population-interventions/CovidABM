import sys
import setup.modelSetup as modelSetup

modelName = sys.argv[1] if len(sys.argv) > 1 else 'rc_auto'
runCount = int(sys.argv[2]) if len(sys.argv) > 2 else 2

modelSetup.MakeHeadlessWithParameters(modelName, runCount=runCount)
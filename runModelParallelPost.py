import sys
from process.checkParallel import DoParallelCheck

#import warnings
#warnings.simplefilter(action = "error", category = RuntimeWarning)

runIndex = int(sys.argv[1]) if len(sys.argv) > 1 else 1
modelName = sys.argv[2] if len(sys.argv) > 2 else 'vic_mask_stage2_square'
runs = int(sys.argv[3]) if len(sys.argv) > 3 else 500
pernode = int(sys.argv[4]) if len(sys.argv) > 4 else 1

print('DoParallelCheck', runIndex, modelName, runs, pernode)
DoParallelCheck(runIndex, modelName, runs, pernode)

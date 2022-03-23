import pandas as pd
import numpy as np
import sys

from parallel.processNetlogoOutput import DoAbmProcessing
import vic_conf as conf

measureCols_raw = conf.GetMeasureColsRaw()
measureCols = conf.GetMeasureCols()
indexRenameFunc = conf.GetIndexRenameFunc()

inputDir = '../../scratch/vic_main/raw'
outputDir = '../../scratch/vic_main/post_parallel'

def main(arrayIndex):
	DoAbmProcessing(inputDir, outputDir, arrayIndex, indexRenameFunc, measureCols, measureCols_raw)

if __name__== "__main__":
	# length check for testing with no arguments.
	main(sys.argv[1] if len(sys.argv) > 1 else 1)

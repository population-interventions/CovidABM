import sys
import process.shared.modelData as md

modelName = sys.argv[1] if len(sys.argv) > 1 else 'rc_auto'
paramName = sys.argv[2] if len(sys.argv) > 2 else 'threads'
default = sys.argv[3] if len(sys.argv) > 3 else '4'

modelData = md.LoadModelData(modelName)
if paramName in modelData:
	print(modelData[paramName])
else:
	print(default)
import sys

runIndex = int(sys.argv[1]) if len(sys.argv) > 1 else 1
modelName = sys.argv[2] if len(sys.argv) > 2 else 'rc_auto'
runs = int(sys.argv[3]) if len(sys.argv) > 3 else 10
pernode = int(sys.argv[4]) if len(sys.argv) > 4 else 5

print(modelName, runIndex)
import sys

modelName = sys.argv[1] if len(sys.argv) > 1 else 'vic_rcalc'
runIndex = int(sys.argv[2]) if len(sys.argv) > 2 else 0

print(modelName, runIndex)
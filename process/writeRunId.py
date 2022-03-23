import sys
import shared.utilities as util

def WriteRunId(name):
	runId = '{}_{}'.format(name, util.GetGitTimeIdentifier())
	util.WriteRunIdFile('../../scratch/{}/run_id'.format(name), runId)

modelName = sys.argv[1] if len(sys.argv) > 1 else 'unnamed'

WriteRunId(modelName)

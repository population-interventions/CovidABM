from source.main import RunModelFromJson, RunWithProfile
import sys

def WriteRunId(name)
	runId = '{}_{}'.format(name, util.GetGitTimeIdentifier())
	util.WriteRunIdFile('../../output/{}/run_id'.format(name), runId)

modelName = sys.argv[1] if len(sys.argv) > 1 else 'unnamed'

WriteRunId(modelName)

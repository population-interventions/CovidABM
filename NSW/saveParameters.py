# -*- coding: utf-8 -*-
"""
Created on Thu Feb 11 12:11:03 2021

@author: wilsonte
"""

from numpy import random

def listToStr(input):
    return " ".join(str(x) for x in input)


def MoveMatchToPos(data, match, pos):
    for i in range(len(data)):
        if data[i][0] == match:
            data[i], data[pos] = data[pos], data[i]
            return


def ToNetlogoStr(data):
    for i in data:
        if type(data[i]) is not str:
            data[i] = str(data[i]).lower()
    return data


def FindNameAndValue(file, nameLines, valueLines):
    foundName = False
    while True:
        line = file.readline().rstrip()
        if nameLines > 0:
            nameLines -= 1
            if nameLines == 0:
                foundName = line.lower()
        elif valueLines > 0:
            valueLines -= 1
            if valueLines == 0:
                return foundName, line 


def GetChooserValue(optionString, choice):
    options = optionString.split(" ")
    return options[int(choice)]


def LowerKeys(myDict):
    if not myDict:
        return False
    outdict = {}
    for k, v in myDict.items():
        outdict[k.lower()] = v
    return outdict


def ReadModelFileAndWriteParams(startPart, endPart, valueOverwrite, topOfFile=[]):
    valueOverwrite = ToNetlogoStr(LowerKeys(valueOverwrite))
    modelFile = open('COVID SIMULS VIC JAN Vaccination Model.nlogo', 'r')
    outputFile = open('paramFile.txt', 'w')
    foundPart = False
    parameters = []
    
    while True:
        # Get next line from file
        line = modelFile.readline().rstrip()
        if foundPart and line == endPart:
            break
            
        if line == startPart:
            foundPart = True
        
        if foundPart:
            if line == 'SLIDER':
                name, value = FindNameAndValue(modelFile, 5, 4)
                if value == '2.5E7':
                    value = 25000000 # >_<
                parameters.append([name, value])
            elif line == 'SWITCH':
                name, value = FindNameAndValue(modelFile, 5, 2)
                if int(value) == 0:
                    # Weird how netlogo stores switches packwards.
                    value = 'true'
                else:
                    value = 'false'
                parameters.append([name, value])
            elif line == 'INPUTBOX':
                name, value = FindNameAndValue(modelFile, 5, 1)
                parameters.append([name, value])
            elif line == 'CHOOSER':
                name, value = FindNameAndValue(modelFile, 5, 2)
                value = GetChooserValue(value, modelFile.readline().rstrip())
                parameters.append([name, value])
    
    modelFile.close()
    
    parameters.sort()
    for i in range(len(topOfFile)):
        MoveMatchToPos(parameters, topOfFile[i].lower(), i)
    
    for data in parameters:
        name, value = str(data[0]), str(data[1])
        if valueOverwrite.get(name):
            value = valueOverwrite[name]
        outputFile.write('["' + name + '" ' + value + ']\n')  
        
    
    outputFile.close()
  

topOfFile = [
    'rand_seed',
    'Gather_Location_Count',
    'param_policy',
    'policy_pipeline',
    'Global_Transmissibility',
    'global_trans_std',
    'R0_range',
    'param_vac_uptake',
    'param_vacincurmult',
    'stage_test_index',
    'calibrate',
]

defaultParams = {
}

paramValuesTestR_stageTestFull = {**defaultParams, **{
    'rand_seed' : listToStr(random.randint(10000000, size=(20000))),
    'param_policy' : listToStr([
        '"StageCal Test"',
    ]),
    'Global_Transmissibility' : listToStr([
        0.122,
    ]),
    'max_stage' : 4,
    #'stage_test_index' : listToStr([0]),
    'init_timenow_limit' : 30,
    'stage_test_index' : 0, #listToStr([0, 55, 56, 57, 58, 59]),
    #'stage_test_index' : listToStr(list(range(75))),
    'vaccine_available' : 'false',
    'total_population' : '668100000000',
    'initial_cases' : 60,
    'param_incur_phase_limit' : 0,
    'trace_calibration' : 0,
    'calibrate' : 'true',
}}

paramValuesFullValues = {
    'rand_seed' : listToStr(random.randint(10000000, size=(100))),
    'total_population' : '6681000',
    'policy_pipeline' : listToStr([ 
        '"ME_ME_TS"',
        '"ME_TS_LS"',
        '"ME_TS_BS"',
    ]),
    'param_vac_uptake' : listToStr([0.5, 0.6, 0.7, 0.8, 0.9]),
    'param_vacIncurMult' : listToStr([0.2, 1, 5, 25]),
    'R0_range' : listToStr([5, 6]),
    'param_final_phase' : listToStr([2, 3]),
    'param_policy' : '"Stage1"',
    'compound_param' : '"None"',
    'mask_efficacy_mult' : listToStr([1]),
    'global_trans_std' : 1.2,
    'init_timenow_limit' : 30,
    'incur_timenow_limit' : 4,
    'max_stage' : 4,
    'initial_cases' : 0,
    'presimdailycases' : 0,
    'Vaccine_Available' : 'true',
    'track_r' : 'false',
    'calibrate' : 'false',
    'track_slope' : 'false',
    'set_shape' : 'false',
    'stage_test_index' : 0,
    'trace_calibration' : 0,
    'end_day' : 730,
    'hetro_mult' : 1,
    'compound_mask_param' : '"Normal"',
    'param_trace_mult' : 1,
    'param_force_vaccine' : '"Disabled"',
}

paramSensitivityTest = {
    'rand_seed' : listToStr(random.randint(10000000, size=(100))),
    'total_population' : '6681000',
    'param_vac_uptake' : listToStr([0, 0.3, 0.5, 0.7, 0.9]),
    'param_final_phase' : listToStr([2, 3]),
    'policy_pipeline' : listToStr([ 
        '"ME_TS_S1"',
        '"ME_TS_BS"',
    ]),
    'param_vacIncurMult' : listToStr([1, 5, 25]),
    'R0_range' : listToStr([5, 6]),
    'compound_mask_param' : listToStr([ 
        '"NoMask"',
        '"Min50"',
        '"Min100"',
    ]),
    'param_trace_mult' : listToStr([0, 0.5, 1]),
    'param_force_vaccine' : listToStr([ 
        '"Disabled"',
        '"AZ"',
        '"Pfizer"',
    ]),
    'param_policy' : '"Stage1"',
    'compound_param' : '"None"',
    'mask_efficacy_mult' : listToStr([1]),
    'init_timenow_limit' : 30,
    'incur_timenow_limit' : 4,
    'global_trans_std' : 1.2,
    'max_stage' : 4,
    'initial_cases' : 0,
    'presimdailycases' : 0,
    'Vaccine_Available' : 'true',
    'track_r' : 'false',
    'calibrate' : 'false',
    'track_slope' : 'false',
    'set_shape' : 'false',
    'stage_test_index' : 0,
    'trace_calibration' : 0,
    'end_day' : 730,
    'hetro_mult' : 1,
}

paramIncursion = {
    'rand_seed' : listToStr(random.randint(10000000, size=(1600))),
    'total_population' : '6681000',
    'param_trace_mult' : listToStr([1]),
    'sympt_present_prop' : listToStr([0.5]),
    'isoComply_override' : listToStr([0.97]),
    'spread_deviate' : listToStr([1]),
    'move_deviate' : listToStr([1]),
    'virlce_deviate' : listToStr([1]),
    'init_timenow_limit' : 4,
    'param_policy' : '"AggressElim"',
    'max_stage' : 1,
    'Global_Transmissibility' : 0.079,
    'global_trans_std' : 0.09,
    'initial_cases' : 1,
    'trace_calibration' : 100,
    'param_incur_phase_limit' : 0,
    'calibrate' : 'true',
    'Vaccine_Available' : 'false',
    'set_shape' : 'false',
}

paramValuesStageNone = {
    'rand_seed' : listToStr(random.randint(10000000, size=(100))),
    'Global_Transmissibility' : listToStr([0.278, 0.333]),
}

paramValues_stage2Infect = {**defaultParams, **{
    'rand_seed' : listToStr(random.randint(10000000, size=(5000))),
}}

ReadModelFileAndWriteParams('GRAPHICS-WINDOW', '@#$#@#$#@', paramValuesFullValues, topOfFile=topOfFile)

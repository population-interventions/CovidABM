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
    'Global_Transmissibility',
    'stage_test_index',
    'calibrate',
]

defaultParams = {
}

paramValuesTestR_stageTestFull = {**defaultParams, **{
    'rand_seed' : listToStr(random.randint(10000000, size=(500))),
    'param_policy' : listToStr([
        '"StageCal Test"',
    ]),
    'Global_Transmissibility' : listToStr([
        0.505,
        0.585,
        0.655,
    ]),
    #'stage_test_index' : listToStr([0]),
    #'stage_test_index' : listToStr([0, 55, 56, 57, 58, 59]),
    'stage_test_index' : listToStr(list(range(75))),
    'total_population' : '668100000000',
    'initial_cases' : 60,
    'param_incur_phase_limit' : 0,
    'calibrate' : 'true',
}}
  
paramValuesFullValues = {
    'rand_seed' : listToStr(random.randint(10000000, size=(100))),
    'total_population' : '6681000',
    'param_vac_uptake' : listToStr([0.5, 0.7, 0.9]),
    'param_final_phase' : listToStr([2, 3]),
    'param_policy' : listToStr([
        '"ModerateElim"',
        '"TightSupress"',
        '"LooseSupress"',
    ]),
    'Global_Transmissibility' : listToStr([
        0.505,
        0.585,
        0.655,
    ]),
    'initial_cases' : 2,
    'secondary_cases' : 4,
    'presimdailycases' : 1,
    'track_r' : 'false',
    'calibrate' : 'false',
    'stage_test_index' : 0,
    'end_day' : 730,
}

paramValuesStageNone = {
    'rand_seed' : listToStr(random.randint(10000000, size=(100))),
    'Global_Transmissibility' : listToStr([0.278, 0.333]),
}

paramValues_stage2Infect = {**defaultParams, **{
    'rand_seed' : listToStr(random.randint(10000000, size=(5000))),
}}

ReadModelFileAndWriteParams('GRAPHICS-WINDOW', '@#$#@#$#@', paramValuesTestR_stageTestFull, topOfFile=topOfFile)
# -*- coding: utf-8 -*-
"""
Created on Thu Feb 18 12:28:02 2021

@author: wilsonte
"""

import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
import matplotlib.ticker as ticker
import seaborn as sns
#from tqdm import tqdm

def GetIndexPickStr(indexVals):
    lbl = "with"
    first = True
    for key in indexVals:
        if not first:
            lbl += ","
        lbl += " {} = {}".format(key, indexVals[key])
        first = False
    return lbl


def PickOutIndexAndMetric(df, axis, metric, index, indexVals):
    df = df.reset_index()
    for key in indexVals:
        df = df[df[key] == indexVals[key]]
    
    splitNames = [x for x in index if x not in indexVals]
    # splitNames should only have one entry.
    df = df.set_index(['rand_seed', axis] + splitNames)
    df = df[[metric]]
    return df, splitNames[0]


def PlotIntegerRange(df, axis, metric, index, indexVals,
                     bar=False, doSum=False, doCount=False, size=(9,4.5), hlines=False):
    print('PlotIntegerRange', axis, metric)
    df, splitName = PickOutIndexAndMetric(df, axis, metric, index, indexVals)
   
    if doCount:
        df = df.groupby(level=[1, 2]).count()
    elif doSum:
        df = df.groupby(level=[1, 2]).sum()
    else:
        df = df.groupby(level=[1, 2]).mean()
    df = df.unstack(1)
    neighborhoods = list(dict.fromkeys(list(df.columns.get_level_values(1))))
    
    print('Plotting')
    if bar:
        figure = df.plot.bar(figsize=size)  
    else:
        figure = df.plot(figsize=size)
        
    plt.xticks(rotation=0)
    if doCount:
        plt.ylabel("number of runs")
    else:
        plt.ylabel(metric)
    figure.set_ylim(min(figure.get_ylim()[0], 0), max(figure.get_ylim()[1], 1.05))
    figure.set_title('{} by {} {}'.format(metric, axis, GetIndexPickStr(indexVals)))
    plt.legend(neighborhoods, title=splitName)
    if hlines:
        for v in hlines:
            figure.axhline(y=v, linewidth=1, zorder=0, color='r')
    
    
def PlotPartialStackedBar(df, axis, metric, index, indexVals, size=(9,4.5), hlines=False):
    print('PlotPartialStackedBar', axis, metric)
    df, splitName = PickOutIndexAndMetric(df, axis, metric, index, indexVals)
    
    df['neg_' + metric] = 1 - df[metric]
    df = df.groupby(level=[1, 2]).sum()
    df = df.unstack(1)
    
    neighborhoods = list(dict.fromkeys(list(df.columns.get_level_values(1))))
    df = df.stack(0).reset_index()
    
    classes = list(dict.fromkeys(list(df[axis].values)))
    ind = np.arange(len(classes)) + .15
    fig, ax = plt.subplots()
    
    top_colors = ['#7EA3BC', '#FFB97C', '#9DE09D', '#E57072', '#BD98E0']
    bottom_colors = ['#1F77B4', '#FF7F0E', '#2CA02C', '#D62728', '#9467BD']
    width = 0.095
    print('Plotting')
    
    cur_width = 0
    for i, n in enumerate(neighborhoods):
        vis = df[(df.level_1 == metric)][n]
        non_vis = df[df.level_1 == 'neg_' + metric][n]
        rect1 = ax.bar(ind + cur_width, vis, float(width), color=bottom_colors[i])
        cur_width += 0.15
    
    cur_width = 0
    for i, n in enumerate(neighborhoods):
        vis = df[(df.level_1 == metric)][n]
        non_vis = df[df.level_1 == 'neg_' + metric][n]
        rect2 = ax.bar(ind + cur_width, non_vis, width, color=top_colors[i], bottom=vis)
        cur_width += 0.15
    
    extra_space = 0.205
    ax.set_xticks(ind + width + extra_space)
    ax.set_xticklabels(classes)
    
    ax.set_title('{} prop split by {} {}'.format(metric, axis, GetIndexPickStr(indexVals)))
    
    plt.xlabel(axis)
    plt.ylabel(metric)
    plt.rcParams["figure.figsize"] = size
    plt.legend(neighborhoods, title=splitName)
    if hlines:
        for v in hlines:
            ax.axhline(y=v, linewidth=1, zorder=0, color='r')
    plt.show()

def PlotResultsForIndexAndSplit(df, index, indexVals):
    PlotPartialStackedBar(df, 'any_trace', 'success', index, indexVals)
    
    PlotIntegerRange(df, 'first_trace_day', 'success', index, indexVals)
    PlotIntegerRange(df[df['first_trace_infections'] < 40], 'first_trace_infections', 'success', index, indexVals)
    
    PlotIntegerRange(df, 'IncurDiseaseTime', 'success', index, indexVals)
    PlotIntegerRange(df, 'IncurAsymptomatic', 'success', index, indexVals, bar=True)
    PlotPartialStackedBar(df, 'IncurAsymptomatic', 'success', index, indexVals)
    PlotPartialStackedBar(df, 'IncurPresentDay', 'success', index, indexVals)
    
    PlotIntegerRange(df[df['End_Day'] < 100], 'End_Day', 'success', index, indexVals, doCount=True)
    PlotIntegerRange(df[df['End_Day'] < 100], 'End_Day', 'success', index, indexVals)
    
    
def PlotRangeManyIndex(df, indexVals, axis, metric, bar=False, doSum=False, doCount=False, hlines=False):
    for preset in indexVals:
        PlotIntegerRange(df, axis, metric, preset['ind'], preset['val'],
                         bar=bar, doSum=doSum, doCount=doCount, hlines=hlines)
   
    
def PlotStackedManyIndex(df, indexVals, axis, metric, bar=False, doSum=False, doCount=False, hlines=False):
    for preset in indexVals:
        PlotPartialStackedBar(df, axis, metric, preset['ind'], preset['val'], hlines=hlines)


def ProcessResults(path, nameList):
    name = nameList[0]
    interestingColumns = [
        'param_trace_mult', 'sympt_present_prop', 'global_transmissibility',
        'rand_seed', 'isocomply_override', 'End_Day',
        'infectionsToday', 'first_trace_day', 'first_trace_infections',
        'currentInfections', 'cumulativeInfected', 'tracked_simuls',
        'finished_infections', 'finished_tracked',
        'cali_timenow', 'cali_asymptomaticFlag',
        'cali_symtomatic_present_day',
        'first_trace_occurred', 'cumulative_tracked_all',
        'cumulative_tracked_notice',
    ]
    df = pd.DataFrame(columns=interestingColumns)
    for v in nameList:
        pdf = pd.read_csv(path + v + '.csv', header=6)
        pdf = pdf[interestingColumns]
        df  = df.append(pdf)
    
    for colName in interestingColumns:
        df[colName] = df[colName].astype(float)
    
    df = df.rename(columns={
        'global_transmissibility' : 'GlobalTrans',
        'isocomply_override' : 'IsoComply',
        'cali_symtomatic_present_day' : 'IncurPresentDay',
        'cali_asymptomaticFlag' : 'IncurAsymptomatic',
        'cali_timenow' : 'IncurDiseaseTime',
        'param_trace_mult' : 'TraceMult',
        'sympt_present_prop' : 'PresentProp',
        'first_trace_occurred' : 'first_trace_day2',
        'cumulative_tracked_all' : 'culTrackAll',
        'cumulative_tracked_notice' : 'culNotice',
    })
    
    df = df.set_index(['rand_seed', 'IsoComply', 'TraceMult', 'PresentProp'])
    df['IncurPresentDay'] = df['IncurPresentDay'].replace(
        {-1 : 'None'})
    
    df['culTrace'] = df['culTrackAll'] - df['culNotice']
    df['success'] = 0
    df.loc[df['currentInfections'] == 0, 'success'] = 1
    df['any_trace'] = 0
    df.loc[df['first_trace_day'] >= 0, 'any_trace'] = 1
    df['any_trace2'] = 0
    df.loc[df['first_trace_day2'] >= 0, 'any_trace2'] = 1
    
    PlotIntegerRange(df, 'GlobalTrans', 'success', ['IsoComply', 'TraceMult', 'PresentProp'], {'TraceMult' : 1, 'PresentProp' : 0.5}, hlines=[0.75], bar=True)
    #PlotIntegerRange(df, 'TraceMult', 'success', ['IsoComply', 'PresentProp'], {'PresentProp' : 0.5}, hlines=[0.75], bar=True)
    #PlotIntegerRange(df, 'TraceMult', 'success', ['IsoComply', 'PresentProp'], {'PresentProp' : 0.65}, hlines=[0.75], bar=True)

    indexList = [
        {'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'GlobalTrans'], 
         'val' : {'TraceMult' : 1, 'PresentProp' : 0.5, 'GlobalTrans' : 0.685}},
        {'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'GlobalTrans'], 
         'val' : {'TraceMult' : 1, 'PresentProp' : 0.5, 'IsoComply' : 0.97}},
        #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp'], 
        # 'val' : {'IsoComply' : 0.97, 'TraceMult' : 1}},
        #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp'], 
        # 'val' : {'IsoComply' : 0.97, 'PresentProp' : 0.5}},
        #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp'], 
        # 'val' : {'TraceMult' : 2, 'PresentProp' : 0.65}},
    ]
    
    PlotStackedManyIndex(df, indexList, 'any_trace', 'success')
    
    PlotRangeManyIndex(df, indexList, 'first_trace_day', 'success')
    PlotRangeManyIndex(df[df['first_trace_infections'] < 40], indexList,'first_trace_infections', 'success')
    
    PlotRangeManyIndex(df, indexList,'IncurDiseaseTime', 'success')
    PlotRangeManyIndex(df, indexList,'IncurAsymptomatic', 'success', bar=True)
    PlotStackedManyIndex(df, indexList, 'IncurAsymptomatic', 'success')
    PlotStackedManyIndex(df, indexList, 'IncurPresentDay', 'success')
    
    PlotRangeManyIndex(df[df['End_Day'] < 100], indexList, 'End_Day', 'success', doCount=True)
    PlotRangeManyIndex(df[df['End_Day'] < 100], indexList, 'End_Day', 'success')


nameStr = 'run007'
namePath = 'output/trace/'

#ProcessResults(namePath, ['run002', 'run003', 'run004'])
#ProcessResults(namePath, ['run005'])
ProcessResults(namePath, ['run006', nameStr])


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


def PickOutIndex(df, indexVals):
    df = df.reset_index()
    for key in indexVals:
        df = df[df[key] == indexVals[key]]
    return df
        
def PickOutIndexAndMetric(df, axis, metric, index, indexVals):
    df = PickOutIndex(df, indexVals)
    
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
        plt.grid(which='both')
        
    plt.xticks(rotation=0)
    if doCount:
        plt.ylabel("number of runs")
    else:
        plt.ylabel(metric)
    figure.set_ylim(min(figure.get_ylim()[0], 0), max(figure.get_ylim()[1], 1.05))
    
    if doCount:
        figure.set_title('runs by {} {}'.format(axis, GetIndexPickStr(indexVals)))
    else:
        figure.set_title('{} by {} {}'.format(metric, axis, GetIndexPickStr(indexVals)))
    
    plt.legend(neighborhoods, title=splitName)
    if hlines:
        for v in hlines:
            figure.axhline(y=v, linewidth=1, zorder=0, color='r')
    plt.show()
    
    
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
    
    extra_space = 0.205 - 0.225 * (5 - len(neighborhoods))/3
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


def PlotRangeManyIndex(df, indexVals, axis, metric, bar=False, doSum=False, doCount=False, hlines=False):
    for preset in indexVals:
        PlotIntegerRange(df, axis, metric, preset['ind'], preset['val'],
                         bar=bar, doSum=doSum, doCount=doCount, hlines=hlines)


def PlotStackedManyIndex(df, indexVals, axis, metric, bar=False, doSum=False, doCount=False, hlines=False):
    for preset in indexVals:
        PlotPartialStackedBar(df, axis, metric, preset['ind'], preset['val'], hlines=hlines)


def PrintSomeStats(df, indexVals):
    df = PickOutIndex(df, indexVals)
    
    totalInfections = df['incurR'].sum()
    totalRuns = len(df['any_transmit'])
    noTransmitProp = len(df[df['any_transmit'] == 0]) / totalRuns
    
    print('=== Stats {} ==='.format(GetIndexPickStr(indexVals)))
    print("Runs with no transmission", noTransmitProp)
    print("Total Infections: {}, Total runs: {}".format(totalInfections, totalRuns))
    for i in range(1,16):
        filterDf = df[df['incurR'] >= i]
        print(("Transmission >={}, #infections: {:.0f}, #runs {:.0f}, " + 
              "%infections: {:.01f}%, %runs: {:.01f}%").format(
            i, filterDf['incurR'].sum(), filterDf['incurR'].count(),
            100 * filterDf['incurR'].sum() / totalInfections,
            100 * filterDf['incurR'].count() / totalRuns))
    
    

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
        'cumulative_tracked_notice', 'initial_infection_R',
        'spread_deviate', 'move_deviate', 'virlce_deviate',
    ]
    df = pd.DataFrame(columns=interestingColumns)
    for v in nameList:
        pdf = pd.read_csv(path + v + '.csv', header=6)
        pdf = pdf[interestingColumns]
        df  = df.append(pdf)
    
    for colName in interestingColumns:
        df[colName] = df[colName].astype(float)
    
    df = df.rename(columns={
        'first_trace_day' : 'first_report_day',
        'first_trace_occurred' : 'first_trace_occur',
        'global_transmissibility' : 'GlobalTrans',
        'isocomply_override' : 'IsoComply',
        'cali_symtomatic_present_day' : 'IncurPresentDay',
        'cali_asymptomaticFlag' : 'IncurAsymptomatic',
        'cali_timenow' : 'IncurDiseaseTime',
        'param_trace_mult' : 'TraceMult',
        'sympt_present_prop' : 'PresentProp',
        'cumulative_tracked_all' : 'culTrackAll',
        'cumulative_tracked_notice' : 'culNotice',
        'initial_infection_R' : 'incurR',
    })
    
    df = df.set_index(['rand_seed', 'IsoComply', 'TraceMult', 'PresentProp'])
    df['IncurPresentDay'] = df['IncurPresentDay'].replace(
        {-1 : 'None'})
    
    df['culTrace'] = df['culTrackAll'] - df['culNotice']
    df['success'] = 0
    df.loc[df['currentInfections'] == 0, 'success'] = 1
    df['any_trace'] = 0
    df.loc[df['first_trace_occur'] >= 0, 'any_trace'] = 1
    df['any_transmit'] = 0
    df.loc[df['cumulativeInfected'] > 1, 'any_transmit'] = 1
    
    df['R0'] = df['GlobalTrans'].replace({0.0663 : 2.5, 0.135 : 5.0})
    # Reset plot parameters
    plt.rcParams.update(plt.rcParamsDefault)
    
    if False:
        PlotIntegerRange(df, 'R0', 'success',
                         ['IsoComply', 'TraceMult', 'PresentProp'],
                         {'TraceMult' : 1, 'IsoComply' : 0.95},
                         hlines=[0.75, 0.9], bar=True)
        PlotIntegerRange(df, 'R0', 'success',
                         ['IsoComply', 'TraceMult', 'PresentProp'],
                         {'TraceMult' : 1, 'PresentProp' : 0.5},
                         hlines=[0.75, 0.9], bar=True)
        PlotIntegerRange(df, 'R0', 'success',
                         ['IsoComply', 'TraceMult', 'PresentProp'],
                         {'PresentProp' : 0.5, 'IsoComply' : 0.95},
                         hlines=[0.75, 0.9], bar=True)
        indexList = [
            #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
            # 'val' : {'TraceMult' : 1, 'PresentProp' : 0.5, 'R0' : 5}},
            {'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
             'val' : {'IsoComply' : 0.95, 'TraceMult' : 1, 'PresentProp' : 0.5}},
            {'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
             'val' : {'R0' : 2.5, 'TraceMult' : 1, 'PresentProp' : 0.5}},
            {'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
             'val' : {'R0' : 5.0, 'TraceMult' : 1, 'PresentProp' : 0.5}},
            {'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
             'val' : {'R0' : 2.5, 'IsoComply' : 0.95, 'PresentProp' : 0.5}},
            {'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
             'val' : {'R0' : 5.0, 'IsoComply' : 0.95, 'PresentProp' : 0.5}},
            {'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
             'val' : {'R0' : 2.5, 'IsoComply' : 0.95, 'TraceMult' : 1}},
            {'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
             'val' : {'R0' : 5.0, 'IsoComply' : 0.95, 'TraceMult' : 1}},
            #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
            # 'val' : {'IsoComply' : 0.97, 'TraceMult' : 1, 'R0' : 2.5}},
            #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
            # 'val' : {'IsoComply' : 0.97, 'TraceMult' : 1, 'R0' : 4.75}},
            #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
            # 'val' : {'IsoComply' : 0.97, 'PresentProp' : 0.5, 'R0' : 2.5}},
            #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
            # 'val' : {'IsoComply' : 0.97, 'PresentProp' : 0.5, 'R0' : 4.75}},
            #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
            # 'val' : {'TraceMult' : 1, 'PresentProp' : 0.5, 'R0' : 2.5}},
            #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
            # 'val' : {'TraceMult' : 1, 'PresentProp' : 0.5, 'R0' : 4.75}},
            #{'ind' : ['spread_deviate', 'move_deviate', 'virlce_deviate'], 
            # 'val' : {'move_deviate' : 1, 'virlce_deviate' : 1}},
            #{'ind' : ['spread_deviate', 'move_deviate', 'virlce_deviate'], 
            # 'val' : {'spread_deviate' : 1, 'move_deviate' : 1}},
            #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp', 'R0'], 
            # 'val' : {'TraceMult' : 1, 'PresentProp' : 0.5, 'IsoComply' : 0.97}},
            #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp'], 
            # 'val' : {'IsoComply' : 0.97, 'TraceMult' : 1}},
            #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp'], 
            # 'val' : {'IsoComply' : 0.97, 'PresentProp' : 0.5}},
            #{'ind' : ['IsoComply', 'TraceMult', 'PresentProp'], 
            # 'val' : {'TraceMult' : 2, 'PresentProp' : 0.65}},
        ]
        
        PlotStackedManyIndex(df, indexList, 'any_trace', 'success')
        PlotStackedManyIndex(df, indexList, 'any_transmit', 'success')
        PlotRangeManyIndex(df, indexList, 'incurR', 'success', doCount=True)
        
        PlotRangeManyIndex(df[df['first_trace_occur'] >= 0], indexList, 'first_trace_occur', 'success')
        PlotRangeManyIndex(df[(df['first_trace_infections'] < 40) & (df['first_trace_infections'] > 0)],
                           indexList,'first_trace_infections', 'success')
        
        PlotStackedManyIndex(df, indexList,'IncurDiseaseTime', 'success')
        PlotStackedManyIndex(df, indexList, 'IncurAsymptomatic', 'success')
        PlotStackedManyIndex(df, indexList, 'IncurPresentDay', 'success')
        
        PlotRangeManyIndex(df[df['End_Day'] < 100], indexList, 'End_Day', 'success', doCount=True)
        PlotRangeManyIndex(df[df['End_Day'] < 100], indexList, 'End_Day', 'success')
    
    print('Total runs {}'.format(df['End_Day'].count()))
    PrintSomeStats(df, {'IsoComply' : 0.93, 'TraceMult' : 1, 'PresentProp' : 0.5, 'R0' : 2.5})


nameStr = 'run048'
namePath = 'output/trace/'

#ProcessResults(namePath, ['run002', 'run003', 'run004'])
#ProcessResults(namePath, ['run005'])
#ProcessResults(namePath, ['run006', 'run007'])
#ProcessResults(namePath, [nameStr, 'run047', 'run048'])
#ProcessResults(namePath, ['run049'])
#ProcessResultsOne(namePath, [nameStr, 'run047', 'run048'])
ProcessResults(namePath, ['run062'])


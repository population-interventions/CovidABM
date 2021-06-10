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


def PlotIntegerRange(df, axis, metric, bar=False, doSum=False, doCount=False, size=(8,4)):
    df = df.reset_index().set_index(['IsoComply', 'rand_seed', axis])
    df = df[[metric]]
    if doCount:
        df = df.groupby(level=[0,2]).count()
    elif doSum:
        df = df.groupby(level=[0,2]).sum()
    else:
        df = df.groupby(level=[0,2]).mean()
    df = df.unstack(0)
    
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
    
    
def PlotPartialStackedBar(df, axis, metric, size=(8,4)):
    df = df.reset_index().set_index(['IsoComply', 'rand_seed', axis])
    df = df[[metric]]
    df['neg_' + metric] = 1 - df[metric]
    df = df.groupby(level=[0,2]).sum()
    df = df.unstack(0)
    neighborhoods = list(dict.fromkeys(list(df.columns.get_level_values(1))))
    df = df.stack(0).reset_index()
    
    classes = list(dict.fromkeys(list(df[axis].values)))
    ind = np.arange(len(classes)) + .15
    fig, ax = plt.subplots()
    
    top_colors = ['#7EA3BC', '#FFB97C', '#9DE09D', '#E57072', '#BD98E0']
    bottom_colors = ['#1F77B4', '#FF7F0E', '#2CA02C', '#D62728', '#9467BD']
    width = 0.095
    
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
    
    ax.set_title('{} proportion split by Iso Compliance'.format(metric, axis))
    
    plt.xlabel(axis)
    plt.ylabel(metric)
    plt.rcParams["figure.figsize"] = size
    plt.legend(neighborhoods)
    plt.show()


def ProcessResults(path, nameList):
    name = nameList[0]
    interestingColumns = [
        'param_trace_mult', 'sympt_present_prop',
        'rand_seed', 'isocomply_override', 'End_Day',
        'infectionsToday', 'first_trace_day', 'first_trace_infections',
        'currentInfections', 'cumulativeInfected', 'tracked_simuls',
        'finished_infections', 'finished_tracked',
        'cali_timenow', 'cali_asymptomaticFlag',
        'cali_symtomatic_present_day',
    ]
    df = pd.DataFrame(columns=interestingColumns)
    for v in nameList:
        pdf = pd.read_csv(path + v + '.csv', header=6)
        pdf = pdf[interestingColumns]
        df  = df.append(pdf)
    
    for colName in interestingColumns:
        df[colName] = df[colName].astype(float)
    
    df = df.rename(columns={
        'isocomply_override' : 'IsoComply',
        'cali_symtomatic_present_day' : 'IncurPresentDay',
        'cali_asymptomaticFlag' : 'IncurAsymptomatic',
        'cali_timenow' : 'IncurDiseaseTime',
    })
    
    df = df.set_index(['IsoComply', 'rand_seed'])
    df['IncurPresentDay'] = df['IncurPresentDay'].replace(
        {-1 : 'None'})
    
    df['success'] = 0
    df.loc[df['currentInfections'] == 0, 'success'] = 1
    df['any_trace'] = 0
    df.loc[df['first_trace_day'] >= 0, 'any_trace'] = 1
    
    
    PlotIntegerRange(df, 'first_trace_day', 'success')
    PlotIntegerRange(df, 'IncurDiseaseTime', 'success')
    PlotIntegerRange(df, 'IncurAsymptomatic', 'success', bar=True)
    PlotPartialStackedBar(df, 'IncurAsymptomatic', 'success')
    PlotPartialStackedBar(df, 'IncurPresentDay', 'success')
    PlotIntegerRange(df[df['first_trace_infections'] < 30], 'first_trace_infections', 'success')
    PlotIntegerRange(df[df['End_Day'] < 100], 'End_Day', 'success', doCount=True)
    PlotIntegerRange(df[df['End_Day'] < 100], 'End_Day', 'success')
    PlotPartialStackedBar(df, 'any_trace', 'success')


nameStr = 'run002'
namePath = 'output/trace/'

#ProcessResults(namePath, [nameStr, 'run003', 'run004'])
ProcessResults(namePath, [nameStr, 'run005'])


# -*- coding: utf-8 -*-
"""
Created on Thu Feb 11 12:11:03 2021

@author: wilsonte
"""

from numpy import random
import random as baseRandom

import process.shared.utilities as util
import setup.makeSingleOutputStupidly as single
import process.shared.globalVars as gl

single.MakeExtraSingleVariables(
	'abm', gl.singleList,
	{x + '_out' : v for x, v in gl.singleAverages.items()},
	[x + '_out' for x in gl.singleMetricNoDiff])

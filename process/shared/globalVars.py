
metricList = ['mort', 'icu', 'hosp', 'hospTime', 'sympt', 'infect']
metricListRaw = {'die' : 'mort', 'icu' : 'icu', 'hosp' : 'hosp', 'hospTime' : 'hospTime', 'sympt' : 'sympt'}

cohortMetricList = ['halyAcute', 'halyDeath', 'halyLong']
timefullMetrics = {
	'prevInfections' : {
		'length' : 9,
		'colName' : 'prevInfects',
	},
	'aggOutcome' : {
		'length' : 5,
		'colName' : 'outcome',
		'doDaily' : True, # only if model spec allows daily
		'rename' : [
			'1_infections',
			'2_sympts',
			'3_hosps',
			'4_icus',
			'5_deaths',
		],
	},
	'hospUsage' : {
		'length' : 3,
		'colName' : 'hospUsage',
		'doDaily' : True, # only if model spec allows daily[
		'rename' : [
			'1_hospUsage',
			'2_hospAbove750',
			'3_hospAbove1500',
		],
	},
	'aveImmuneVac' : {
		'length' : 6,
		'colName' : 'outcome',
		'aggMean' : True,
		'rename' : [
			'0_infectivity',
			'1_risk',
			'2_sympt',
			'3_hosp',
			'4_icu',
			'5_mortality',
		],
	},
	'aveImmuneNat' : {
		'length' : 6,
		'colName' : 'outcome',
		'aggMean' : True,
		'rename' : [
			'0_infectivity',
			'1_risk',
			'2_sympt',
			'3_hosp',
			'4_icu',
			'5_mortality',
		],
	
	},
	'aveImmuneAll' : {
		'length' : 6,
		'colName' : 'outcome',
		'aggMean' : True,
		'rename' : [
			'0_infectivity',
			'1_risk',
			'2_sympt',
			'3_hosp',
			'4_icu',
			'5_mortality',
		],
	}
}

# Outputs that are one culmulator divided by another.
# The cumulators should appear before the avearge in the list.
singleAverages = {
	'generationTime' : ['totInfecterTime', 'totInfect'],
	'reff' : ['reffInfectees', 'reffInfecters'],
}

singleList = [
	[0, 182],
	[0, 364],
	[182, 364],
	[182, 546],
	[364, 546],
	[0, 60],
	[60, 182],
	[0, 91],
	[91, 182],
]

singleMetricList = [
	'costDeathAverted',
	'costAcute',
	'costLong',
	'costTesting',
	'costVaccine',
	'costVacDeliver',
	'costVaccineFixed',
	'costMask',
	'costMaskFixed',
	'costGdp',
	'costTotalHealth',
	'costTotalTotal',
	'nmbLow',
	'nmbMed',
	'nmbHigh',
	'nmbLowNoGdp',
	'nmbMedNoGdp',
	'nmbHighNoGdp',
	'halyTotalAcute',
	'halyTotalDeath',
	'halyTotalLong',
	'halyTotalTotal',
	'totStage2',
	'totStage3',
	'totStage4',
	'totStage5',
	'totInfect',
	'totSympt',
	'totHosp',
	'totIcu',
	'totDeath',
	'totHospTime',
	'totIcuTime',
	'hospDaysAbove500',
	'hospDaysAbove750',
	'hospDaysAbove1000',
	'hospDaysAbove1250',
	'hospDaysAbove1500',
	'hospDaysAbove1750',
	'hospDaysAbove2000',
	'costDeathAverted_uk',
	'halyTotalDeath_uk',
	'costTotalHealth_uk',
	'costTotalTotal_uk',
	'halyTotalTotal_uk',
	'nmbLow_uk',
	'nmbMed_uk',
	'nmbHigh_uk',
	'nmbLowNoGdp_uk',
	'nmbMedNoGdp_uk',
	'nmbHighNoGdp_uk',
	'prevInfect0',
	'prevInfect1',
	'prevInfect2',
	'prevInfect3',
	'prevInfect4',
	'prevInfect5',
	'prevInfect6',
	'prevInfect7',
	'prevInfect8',
	'totInfecterTime',
	'generationTime',
	'reffInfecters',
	'reffInfectees',
	'reff',
	
	'halyTotalDeath_alt',
	'halyTotalTotal_alt',
	'nmbLowNoGdp_alt',
	'nmbMedNoGdp_alt',
	'nmbHighNoGdp_alt',
	'nmbLow_alt',
	'nmbMed_alt',
	'nmbHigh_alt_out',

]

senMetricList = [
	'sen_vacInfectReduct',
	'sen_vacWaneInfect',
	'sen_vacWaneHosp',
	'sen_recoverInfectReduct',
	'sen_recoverWane',
	'sen_maskEff',
	'sen_asymptTransmit',
	'sen_isoProp',
	'sen_ifr',
	'sen_icu',
	'sen_hosp',
	'sen_sympt',
	'sen_hospTime',
	'sen_icuTime',
	'sen_vacCur',
	'sen_vacTarget',
	'sen_vacMulti',
	'sen_vacPromote',
	'sen_vacOverhead',
	'sen_maskPerson',
	'sen_maskStorage',
	'sen_maskPromote',
	'sen_vacUptake',
	'sen_transmissDraw',
	'sen_isoComply',
	'sen_halyAcute',
	'sen_halyLong',
	'sen_halyDeath',
	'sen_costGdp',
	'sen_costTest',
	'sen_costLong',
	'sen_costDeath',
	'sen_costDoctor',
	'sen_costParacetamol',
	'sen_costVisitEr',
	'sen_costHospBed',
	'sen_costIcuBed',
	'sen_countTest',
]
stages = [1, 2, 3, 4, 5]

def FullSingleMetricList():
	retList = singleMetricList + senMetricList
	for singleRange in singleList:
		for var in singleMetricList:
			retList.append('mid_{}_{}_{}'.format(singleRange[0], singleRange[1], var))
	return retList

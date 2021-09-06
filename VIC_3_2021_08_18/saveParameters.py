# -*- coding: utf-8 -*-
"""
Created on Thu Feb 11 12:11:03 2021

@author: wilsonte
"""

from numpy import random
import random as baseRandom
import utilities as util

def listToStr(input):
	return " ".join(str(x) for x in input)


def GetRandomListUnique(listSize, maxIntSize=10000000):
	randList = baseRandom.sample(range(maxIntSize), listSize)
	while len(util.FindRepeat(randList)) > 0:
		randList = baseRandom.sample(range(maxIntSize), listSize)
	
	print(len(list(set(randList))))
	return listToStr(randList)


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
	'rand_seed' : GetRandomListUnique(2000),
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
	'rand_seed' : GetRandomListUnique(100),
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
	'rand_seed' : GetRandomListUnique(100),
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
	'rand_seed' : GetRandomListUnique(1600),
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
	'rand_seed' : GetRandomListUnique(10000),
	'global_transmissibility' : listToStr([0.118, 0.148, 0.18, 0.22, 0.27]),
	
	'data_suffix' : listToStr([
		'"_bau.csv"',
	]),
	'input_population_table' : '"input/pop_essential_2007"', 
	'input_vaccine_table' : '"input/vaccine_rollout"',     
	'input_dose_rate_table' : '"input/dose_rate.csv"',  
}


paramValues_rCalibrate = {**defaultParams, **{
	'rand_seed' : GetRandomListUnique(10000),
	'global_transmissibility' : listToStr([
		0.098394749,
		0.119370711,
		0.1335,
		0.1579,
		0.1701,
		0.1945,
	]),
	'recreate_bug' : listToStr([
		'true',
		'false',
	]),

	'gather_location_count' : 200,
	'global_trans_std' : 0.12,
	'end_day' : 40,
	
	'input_dose_rate_table' : '"input/dose_rate.csv"',
	'input_population_table' : '"input/population"',
	'input_vaccine_table' : '"input/vaccine_rollout"',
	'data_suffix' : '"_bau.csv"',
	
	'param_policy' : '"None"',
	'policy_pipeline' : '"None"',
	'compound_essential' : '"Normal"',
	'compound_input' : '"None"',
	'compound_mask_param' : '"Normal"',
	'compound_param' : '"None"',
	
	'r0_range' : -1,
	'complacency_bound' : 0,
	'param_vacincurmult' : 0.1,
	'stage_test_index' : 0,
	'calibrate' : 'false',
	'complacency_loss' : 1,
	'daily_infect_binom' : 5,
	'end_r_reported' : -1,
	'ess_radius_anchor' : 0,
	'ess_spread_anchor' : 0,
	'ess_w_risk_reduction' : 0.5,
	'essential_workers' : 100,
	'age_isolation' : 0,
	'avoid_essential' : 'true',
	'asymptomatic_trans' : 0.74095293324329,
	'hetro_mult' : 1,
	'house_resample_red_group' : 0.95,
	'house_resample_scale_up' : 0.7,
	'household_iso_factor' : 1,
	'illness_period' : 21.2,
	'incubation_period' : 4.4,
	'incur_timenow_limit' : 4,
	'incursion_phase_speed_mult' : 1,
	'infect_iso_factor' : 1,
	'init_timenow_limit' : 0,
	'init_trace_prop' : 0,
	'initial_cases' : 1,
	'initial_primary_prop' : 0.66,
	'initial_variant_2_prop' : 0,
	'isocomply_override' : 0.93,
	'isolate_on_inf_notice' : 'false',
	'isolation_transmission' : 0.33,
	'mask_efficacy_mult' : 1,
	'mask_wearing' : 0,
	'maskpolicy' : 'false',
	'max_stage' : 4,
	'minmaskwearing' : 0,
	'non_infective_time' : 0,
	'param_final_phase' : 3,
	'param_force_vaccine' : '"Disabled"',
	'param_incur_phase_limit' : 0,
	'asymptom_prop' : 0.34493636991391824,
	'param_policy_force_days' : 0,
	'param_policy_force_preset' : 0,
	'param_policy_force_stage' : -1,
	'param_recovered_prop' : 0,
	'param_stage1_time' : -1,
	'param_trace_mult' : 1,
	'param_trigger_loosen' : 'false',
	'param_vac_rate_mult' : 1,
	'param_vac_uptake_mult' : 0.7,
	'param_vac_wane' : 0,
	'calibrate_stage_switch' : 0,
	'policy_pipe_time' : 182.5,
	'asymptom_trace_mult' : 0.66,
	'population' : 2500,
	'prepeak_vir_boost' : 0.1,
	'presimdailycases' : 0,
	'prev_var_area' : 0,
	'prev_var_risk' : 0,
	'profile_on' : 'false',
	'proportion_people_avoid' : 0,
	'proportion_time_avoid' : 0,
	'first_case_calibrate' : 'true',
	'accept_isolation_prop' : 0,
	'recov_var_match_rate' : 0,
	'recovered_match_rate' : 0.08,
	'reinfect_area' : 0.5183237641599878,
	'reinfect_delay' : 21,
	'reinfect_risk' : 0.5537842958067682,
	'report_proportion' : 1,
	'scale' : 'false',
	'scale_factor' : 4,
	'scale_threshold' : 240,
	'schoolsopen' : 'true',
	'se_illnesspd' : 4,
	'se_incubation' : 2.25,
	'self_iso_at_peak' : 'true',
	'set_shape' : 'false',
	'span' : 10,
	'case_reporting_delay' : 1,
	'success_14day_cases' : -1,
	'superspreaders' : 0.1,
	'sympt_present_max' : 9,
	'sympt_present_min' : 6,
	'sympt_present_prop' : 0.5,
	'total_population' : 81660000000000,
	'trace_attempt_limit' : 3,
	'trace_calibration' : 0,
	'track_iso_factor' : 1,
	'track_r' : 'true',
	'track_slope' : 'false',
	'tracking' :' true',
	'trans_draw_max' : 0.27,
	'trans_draw_min' : 0.22,
	'vac_variant_eff_prop' : 0.86,
	'vaccine_available' : 'false',
	'variant_transmiss_growth' : 1.5,
	'visit_frequency' : 0.1428,
	'visit_radius' : 8.8,
	'yearly_recover_prop_loss' : 0,
}}

paramValues_stageEssential = {**defaultParams, **{
	'rand_seed' : GetRandomListUnique(100),
	'total_population' : '6681000',
	'r0_range' : listToStr([5, 6.5, 8]),
	'policy_pipeline' : listToStr([ 
		'"ME_ME_TS"',
		'"ME_TS_LS"',
		'"ME_TS_BS"',
	]),
	'compound_trace' : listToStr([ 
		#'"ass50_70at5"',
		'"ass100_90at5"',
		#'"ass100_90at5_iso"',
		#'"ass200_90at5"',
	]),
	'min_stage' : listToStr([0, 2]),
	'param_vac_uptake_mult' : listToStr([1]),
	'param_vacIncurMult' : listToStr([0.2, 1, 5]),
	'param_final_phase' : listToStr([3, 4]),
	'Non_Infective_Time' : listToStr([0]),
	'compound_essential' : listToStr(['"Extreme"']),
	'param_vac_rate_mult' : listToStr([0.5]),
	'data_suffix' : listToStr([
		'"_az_25_95.csv"',
		'"_az_25_90.csv"',
		'"_az_25_80.csv"',
		'"_az_25_70.csv"',
	]),
	'sensitivity' : listToStr([
		'"None"',
	]),
	'input_population_table' : '"input/population"', 
	'input_vaccine_table' : '"input/vaccine_rollout_az_25.csv"',
	'input_dose_rate_table' : '"input/dose_rate.csv"',
	'input_incursion_table' : '"input/incursion.csv"',
	'policy_switch' : '"tony"',
	'data_suffix_2' : '"None"',
	'suffix_rollout' : 'false',
	'end_day' : 574,
}}

paramValues_stageEssential_single = {**defaultParams, **{
	'rand_seed' : GetRandomListUnique(100),
	'total_population' : '6681000',
	'r0_range' : listToStr([6.5]),
	'policy_pipeline' : listToStr([ 
		'"ME_TS_LS"',
	]),
	'compound_trace' : listToStr([ 
		#'"ass50_70at5"',
		'"ass100_90at5"',
		#'"ass100_90at5_iso"',
		#'"ass200_90at5"',
	]),
	'param_vac_uptake_mult' : listToStr([1]),
	'param_vacIncurMult' : listToStr([5]),
	'param_final_phase' : listToStr([4]),
	'Non_Infective_Time' : listToStr([0]),
	'compound_essential' : listToStr(['"Extreme"']),
	'param_vac_rate_mult' : listToStr([0.5]),
	'data_suffix' : listToStr([
		#'"_az_25_95.csv"',
		#'"_az_25_90.csv"',
		'"_az_25_80.csv"',
		#'"_az_25_70.csv"',
	]),
	'sensitivity' : listToStr([
		'"None"',
	]),
	'input_population_table' : '"input/population"', 
	'input_vaccine_table' : '"input/vaccine_rollout_az_25.csv"',
	'input_dose_rate_table' : '"input/dose_rate.csv"',
	'input_incursion_table' : '"input/incursion.csv"',
	'policy_switch' : '"tony"',
	'data_suffix_2' : '"None"',
	'suffix_rollout' : 'false',
	'end_day' : 574,
}}

paramValues_stageEssentialSensitive = {**defaultParams, **{
	'rand_seed' : GetRandomListUnique(100),
	'total_population' : '6681000',
	'r0_range' : listToStr([6.5]),
	'policy_pipeline' : listToStr([ 
		'"ME_ME_TS"',
		'"ME_TS_LS"',
		'"ME_TS_BS"',
	]),
	'min_stage' : listToStr([0, 2]),
	'param_final_phase' : listToStr([3, 4]),
	'data_suffix' : listToStr([
		'"_az_25_90.csv"',
		'"_az_25_80.csv"',
	]),
	'sensitivity' : listToStr([
		'"None"',
		'"LetItRip"',
		'"TraceLow"',
		'"TraceHigh"',
		'"Asmpyt_66"',
		'"RAT_15"',
		'"RAT_33"',
		'"AllPF"',
		'"GatherVent_33"',
		'"GatherVent_80"',
		'"NoInfect_1"',
		'"BoostMask_25"',
		'"StageMax_3b"',
		'"StageMax_3"',
		'"LetItRipStage1"',
		'"LetItRipStage2"',
		'"ScaleBoost_20"',
		'"ScaleSet_70"',
		'"SetVacArea50"',
		'"NoRecoverImmune"',
		'"DistMult_2"',
        '"PresentPropMult_050"',
        '"PPM_050_Stage3"',
        '"PPM_050_Stage3b"',
	]),
	'compound_trace' : '"ass100_90at5"',
	'param_vac_uptake_mult' : listToStr([1]),
	'param_vacIncurMult' : listToStr([1]),
	'Non_Infective_Time' : listToStr([0]),
	'compound_essential' : listToStr(['"Extreme"']),
	'param_vac_rate_mult' : listToStr([0.5]),
	'input_population_table' : '"input/population"', 
	'input_vaccine_table' : '"input/vaccine_rollout_az_25.csv"',
	'input_dose_rate_table' : '"input/dose_rate.csv"',
	'input_incursion_table' : '"input/incursion.csv"',
	'policy_switch' : '"tony"',
	'data_suffix_2' : '"None"',
	'suffix_rollout' : 'false',
	'end_day' : 574,
}}

ReadModelFileAndWriteParams('GRAPHICS-WINDOW', '@#$#@#$#@',
							paramValues_stageEssentialSensitive,
							topOfFile=topOfFile)

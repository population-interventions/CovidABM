;; This version of the model has been speifically designed to estimate issues associated with Victoria's second wave of infections, beginning in early July
;; The intent of the model is for it to be used as a guide for considering differences in potential patterns of infection under various policy futures
;; As with any model, it's results should be interpreted with caution and placed alongside other evidence when interpreting results

__includes[
  "globals.nls"
  "housing.nls"
  "main.nls"
  "simul.nls"
  "setup.nls"
  "parameters.nls"
  "scale.nls"
  "stages.nls"
  "stages_tony.nls"
  "stages_nz.nls"
  "stages_pak.nls"
  "stages_continuous.nls"
  "policy.nls"
  "policy_tony.nls"
  "policy_nz.nls"
  "policy_pak.nls"
  "trace.nls"
  "count.nls"
  "vaccine.nls"
  "variant.nls"
  "incursion.nls"
  "debug.nls"
  "dataOut.nls"
  "ageVarParams.nls"
  "util.nls"
  "mask.nls"
]
@#$#@#$#@
GRAPHICS-WINDOW
388
63
1012
688
-1
-1
8.68
1
10
1
1
1
0
1
1
1
0
70
0
70
1
1
1
ticks
30.0

BUTTON
255
68
319
102
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
218
108
282
142
Go
ifelse (count simuls ) = (count simuls with [ color = blue ])  [ stop ] [ Go ]
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
2799
870
2901
905
Trace_Patterns
ask n-of 1 simuls with [ color != black ] [ pen-down ]
NIL
1
T
OBSERVER
NIL
T
NIL
NIL
1

BUTTON
2913
870
3013
904
UnTrace
ask turtles [ pen-up ]
NIL
1
T
OBSERVER
NIL
U
NIL
NIL
1

SLIDER
3354
187
3467
220
Population
Population
0
2500
2500.0
2500
1
NIL
HORIZONTAL

SLIDER
1479
54
1612
87
Span
Span
0
30
10.0
1
1
NIL
HORIZONTAL


BUTTON
283
108
347
142
Go Once
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1




SLIDER
1627
219
1806
252
superspreaders
superspreaders
0
1
0.1
0.01
1
NIL
HORIZONTAL




SLIDER
1625
54
1807
87
Proportion_People_Avoid
Proportion_People_Avoid
0
100
5.0
.5
1
NIL
HORIZONTAL

SLIDER
1625
89
1808
122
Proportion_Time_Avoid
Proportion_Time_Avoid
0
100
5.0
.5
1
NIL
HORIZONTAL




INPUTBOX
239
200
373
263
initial_cases
3000.0
1
0
Number

INPUTBOX
228
375
335
437
total_population
6649066.0
1
0
Number













SLIDER
1627
179
1805
212
Essential_Workers
Essential_Workers
0
100
100.0
1
1
NIL
HORIZONTAL

SLIDER
2349
902
2532
935
Ess_W_Risk_Reduction
Ess_W_Risk_Reduction
0
1
0.0
0.1
1
NIL
HORIZONTAL

SWITCH
1477
412
1612
445
tracking
tracking
1
1
-1000

SLIDER
1480
92
1614
125
Mask_Wearing
Mask_Wearing
0
100
15.0
1
1
NIL
HORIZONTAL

SWITCH
1484
280
1619
313
schoolsOpen
schoolsOpen
0
1
-1000





SWITCH
1484
320
1618
353
MaskPolicy
MaskPolicy
0
1
-1000

SLIDER
808
1027
1008
1060
Case_Reporting_Delay
Case_Reporting_Delay
0
5
1.0
1
1
NIL
HORIZONTAL

SLIDER
1625
263
1807
296
Visit_Frequency
Visit_Frequency
0
1
0.1428
0.01
1
NIL
HORIZONTAL

SLIDER
1625
299
1808
332
Visit_Radius
Visit_Radius
0
16
8.8
1
1
NIL
HORIZONTAL







SLIDER
3415
634
3599
667
Mask_Efficacy_Mult
Mask_Efficacy_Mult
0
3
1.0
.01
1
NIL
HORIZONTAL

SWITCH
463
704
655
737
Vaccine_Enabled
Vaccine_Enabled
0
1
-1000












TEXTBOX
1493
27
1617
60
Stage Policy Settings
12
0.0
1

CHOOSER
10
330
178
375
param_policy
param_policy
"AggressElim" "ModerateElim" "TightSupress" "LooseSupress" "BarelySupress" "TightSupress_No_4" "LooseSupress_No_4" "Stage2infect" "None" "Stage1" "Stage1b" "Stage2" "Stage2b" "Stage3" "Stage3b" "Stage4" "StageCal_None" "StageCal_Test" "StageCal_1" "StageCal_1b" "StageCal_2" "StageCal_3" "StageCal_4" "continuous"
5




SLIDER
807
944
1006
977
Asymptom_Trace_Mult
Asymptom_Trace_Mult
0
1
0.66
0.01
1
NIL
HORIZONTAL




SLIDER
3023
900
3231
933
Gather_Location_Count
Gather_Location_Count
0
1000
200.0
10
1
NIL
HORIZONTAL

SLIDER
1625
135
1807
168
Complacency_Bound
Complacency_Bound
0
100
5.0
1
1
NIL
HORIZONTAL



BUTTON
3357
97
3462
131
Profile Stop
profiler:stop \nprint profiler:report
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
3408
59
3515
92
profile_on
profile_on
1
1
-1000

BUTTON
3243
97
3347
132
Profile Start
profiler:start
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
1039
18
1212
51
End_Day
End_Day
-1
730
390.0
1
1
NIL
HORIZONTAL

SLIDER
2748
394
2946
427
Isolation_Transmission
Isolation_Transmission
0
1
0.33
0.01
1
NIL
HORIZONTAL



SWITCH
1474
763
1578
796
track_R
track_R
0
1
-1000




SLIDER
818
869
1020
902
Recovered_Match_Rate
Recovered_Match_Rate
0
1
0.33
0.01
1
NIL
HORIZONTAL

SWITCH
3044
315
3211
348
param_trigger_loosen
param_trigger_loosen
1
1
-1000




SLIDER
18
967
208
1000
calibrate_stage_switch
calibrate_stage_switch
0
500
300.0
100
1
NIL
HORIZONTAL

SLIDER
22
1007
322
1040
stage_test_index
stage_test_index
0
70
0.0
1
1
NIL
HORIZONTAL

SWITCH
1627
338
1810
371
isolate_on_inf_notice
isolate_on_inf_notice
0
1
-1000

SLIDER
2748
434
2948
467
Household_Iso_Factor
Household_Iso_Factor
0
1
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
2748
508
2945
541
Infect_Iso_Factor
Infect_Iso_Factor
0
1
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
2748
473
2946
506
Track_Iso_Factor
Track_Iso_Factor
0
1
1.0
0.05
1
NIL
HORIZONTAL

SWITCH
1727
819
1842
852
track_slope
track_slope
0
1
-1000

INPUTBOX
224
455
301
515
preSimDailyCases
0.0
1
0
Number




SLIDER
813
908
1011
941
Recov_Var_Match_Rate
Recov_Var_Match_Rate
0
1
0.58
0.01
1
NIL
HORIZONTAL

SWITCH
570
17
680
50
set_shape
set_shape
1
1
-1000



SLIDER
2814
914
3014
947
complacency_loss
complacency_loss
0
1
1.0
0.1
1
NIL
HORIZONTAL


SLIDER
3572
65
3747
98
param_incur_phase_limit
param_incur_phase_limit
-1
10
-1.0
1
1
NIL
HORIZONTAL

SLIDER
1265
1027
1438
1060
report_proportion
report_proportion
0
1
1.0
0.01
1
NIL
HORIZONTAL


SLIDER
2748
544
2941
577
accept_isolation_prop
accept_isolation_prop
0
1
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
10
133
209
166
incursion_phase_speed_mult
incursion_phase_speed_mult
0
2
0.5
0.01
1
NIL
HORIZONTAL

SWITCH
217
967
321
1000
calibrate
calibrate
1
1
-1000


SLIDER
228
335
377
368
initial_primary_prop
initial_primary_prop
0
1
0.26
0.01
1
NIL
HORIZONTAL

SLIDER
9
457
202
490
param_policy_force_days
param_policy_force_days
0
28
0.0
1
1
NIL
HORIZONTAL

SLIDER
7
493
201
526
param_policy_force_stage
param_policy_force_stage
-1
4
-1.0
1
1
NIL
HORIZONTAL

SLIDER
9
419
202
452
param_policy_force_preset
param_policy_force_preset
0
3
0.0
1
1
NIL
HORIZONTAL

SLIDER
3570
107
3744
140
param_vacIncurMult
param_vacIncurMult
0
2
0.0
0.1
1
NIL
HORIZONTAL

SLIDER
2558
540
2731
573
param_trace_mult
param_trace_mult
0
1
1.0
0.05
1
NIL
HORIZONTAL

SLIDER
2558
610
2731
643
trace_attempt_limit
trace_attempt_limit
-1
10
3.0
1
1
NIL
HORIZONTAL

SLIDER
220
564
329
597
max_stage
max_stage
0
4
3.0
1
1
NIL
HORIZONTAL

SLIDER
3130
794
3333
827
trace_calibration
trace_calibration
0
100000
0.0
10
1
NIL
HORIZONTAL

SLIDER
2748
358
2952
391
isoComply_override
isoComply_override
-0.01
1
0.93
0.01
1
NIL
HORIZONTAL

SLIDER
1042
990
1206
1023
init_timenow_limit
init_timenow_limit
0
26
0.0
1
1
NIL
HORIZONTAL

CHOOSER
8
568
201
613
policy_pipeline
policy_pipeline
"None" "ME_TS_S1" "ME_ME_ME" "ME_ME_TS" "ME_ME_LS" "ME_TS_LS" "ME_TS_BS" "ME_TS_NONE"
0

SLIDER
9
617
198
650
policy_pipe_time
policy_pipe_time
0
200
105.0
0.5
1
NIL
HORIZONTAL

SLIDER
1043
1027
1206
1060
incur_timenow_limit
incur_timenow_limit
0
30
4.0
1
1
NIL
HORIZONTAL

SLIDER
3230
240
3442
273
hetro_mult
hetro_mult
0
3
1.0
0.1
1
NIL
HORIZONTAL

SLIDER
3230
278
3439
311
Daily_Infect_Binom
Daily_Infect_Binom
1
20
5.0
1
1
NIL
HORIZONTAL

CHOOSER
203
767
351
812
compound_param
compound_param
"None" "Hetro_Test"
0

CHOOSER
3415
552
3603
597
compound_mask_param
compound_mask_param
"Normal" "NoMask" "Min100" "Min50" "None"
0

SLIDER
3415
599
3602
632
MinMaskWearing
MinMaskWearing
0
100
0.0
1
1
NIL
HORIZONTAL

SLIDER
3129
758
3336
791
success_14day_cases
success_14day_cases
-1
40
-1.0
1
1
NIL
HORIZONTAL

SLIDER
8
529
202
562
param_stage1_time
param_stage1_time
-1
20
-1.0
1
1
NIL
HORIZONTAL

SLIDER
464
789
654
822
init_trace_prop
init_trace_prop
0
1
1.0
0.05
1
NIL
HORIZONTAL

INPUTBOX
2132
425
2347
485
input_population_table
input/vic/pop
1
0
String

CHOOSER
203
717
350
762
compound_input
compound_input
"None" "baseline"
0

SLIDER
464
744
654
777
param_vac_uptake_mult
param_vac_uptake_mult
0
1
0.85
0.05
1
NIL
HORIZONTAL

CHOOSER
2349
852
2532
897
compound_essential
compound_essential
"None" "Normal" "Extreme"
2

SWITCH
2349
1019
2529
1052
avoid_essential
avoid_essential
1
1
-1000

SLIDER
2349
939
2532
972
ess_radius_anchor
ess_radius_anchor
0
20
8.8
0.1
1
NIL
HORIZONTAL

SLIDER
2349
979
2532
1012
ess_spread_anchor
ess_spread_anchor
0
0.15
0.08
0.1
1
NIL
HORIZONTAL



SWITCH
664
704
838
737
first_case_calibrate
first_case_calibrate
1
1
-1000

SLIDER
2815
957
3015
990
prepeak_vir_boost
prepeak_vir_boost
0
1
0.1
0.05
1
NIL
HORIZONTAL

CHOOSER
2208
555
2353
600
data_suffix
data_suffix
"_bau.csv" "_int.csv" "_az_25.csv" "_az_50.csv" "_az_25_95.csv" "_az_25_90.csv" "_az_25_80.csv" "_az_25_70.csv" "_70" "_80" "_90" "_95" ".csv"
12

SLIDER
808
987
1007
1020
pre_present_iso
pre_present_iso
0
10
1.0
1
1
NIL
HORIZONTAL

SWITCH
3243
138
3418
171
self_iso_at_peak
self_iso_at_peak
0
1
-1000

SWITCH
219
657
338
690
print_phase
print_phase
1
1
-1000

SWITCH
219
619
337
652
print_vac
print_vac
1
1
-1000

SLIDER
1257
990
1459
1023
house_init_group
house_init_group
0
1
0.15
0.05
1
NIL
HORIZONTAL

CHOOSER
214
150
382
195
sensitivity
sensitivity
"None" "HouseResample+" "HouseResample-" "HouseResampleUp+" "HouseResampleUp-" "NoInfect_1" "NoInfect_2" "UniformContact_054" "UniformContact_033" "ReduceVacTrans_050" "TraceLow" "TraceHigh" "Asmpyt_66" "RAT_33" "RAT_15" "AllPF" "GatherVent_33" "GatherVent_80" "BoostMask_25" "StageMax_3b" "StageMax_3" "LetItRip" "LetItRipStage1" "LetItRipStage2" "ScaleBoost_20" "ScaleSet_70" "SetVacArea50" "SetVacArea65" "NoRecoverImmune" "DistMult_2" "PresentPropMult_050" "IsoTransmit_05" "IsoTransmit_1" "PPM_050_Stage3" "PPM_050_Stage3b" "TestVic" "OverrideAsympt"
0

SLIDER
2558
575
2731
608
trace_eff_override
trace_eff_override
-1
1
-1.0
0.05
1
NIL
HORIZONTAL

SLIDER
2747
583
2920
616
vac_trans_mult
vac_trans_mult
0
1
1.0
0.05
1
NIL
HORIZONTAL

SLIDER
2558
469
2731
502
trace_at_5
trace_at_5
0
1
0.9
0.05
1
NIL
HORIZONTAL

SLIDER
2558
505
2731
538
trace_assymtote
trace_assymtote
0
500
100.0
1
1
NIL
HORIZONTAL

CHOOSER
2560
385
2733
430
compound_trace
compound_trace
"None" "ass50_70at5" "ass100_90at5" "ass100_90at5_iso" "ass200_90at5"
2

SLIDER
2748
619
2921
652
site_iso_prop
site_iso_prop
0
1
0.0
0.01
1
NIL
HORIZONTAL

SLIDER
2747
658
2920
691
site_iso_max_day
site_iso_max_day
0
14
0.0
1
1
NIL
HORIZONTAL

SLIDER
2558
434
2731
467
trace_at_1
trace_at_1
0
1
0.98
0.05
1
NIL
HORIZONTAL

SWITCH
2562
349
2676
382
trace_print
trace_print
1
1
-1000

CHOOSER
2203
604
2341
649
data_suffix_2
data_suffix_2
"None" "_5.csv" "_12.csv"
0

CHOOSER
12
175
150
220
policy_switch
policy_switch
"tony" "nz" "pak" "continuous"
2

SWITCH
2210
657
2338
690
suffix_rollout
suffix_rollout
0
1
-1000

SWITCH
3497
304
3635
337
count_incursion
count_incursion
1
1
-1000

SLIDER
3024
940
3232
973
transmit_skew
transmit_skew
0.2
20
1.0
0.05
1
NIL
HORIZONTAL

SLIDER
3024
979
3231
1012
duration_skew
duration_skew
1
20
1.0
0.5
1
NIL
HORIZONTAL

SLIDER
2758
708
2931
741
global_distance_mult
global_distance_mult
1
20
1.0
1
1
NIL
HORIZONTAL

SLIDER
2758
750
2933
783
recover_immunity_mult
recover_immunity_mult
0
1
1.0
1
1
NIL
HORIZONTAL

SWITCH
2950
747
3089
780
always_spread
always_spread
1
1
-1000

SLIDER
2757
793
2930
826
param_override_ve
param_override_ve
-1
1
-1.0
0.1
1
NIL
HORIZONTAL

SWITCH
2759
834
2931
867
print_contact_events
print_contact_events
1
1
-1000

SLIDER
1602
820
1712
853
cont_stage
cont_stage
0
4
3.25
0.05
1
NIL
HORIZONTAL

SLIDER
220
529
333
562
min_stage
min_stage
0
4
0.0
1
1
NIL
HORIZONTAL

CHOOSER
3033
47
3172
92
pipe_end_override
pipe_end_override
"off" "None" "Stage1" "Stage2"
0

SLIDER
3033
98
3206
131
rat_prop
rat_prop
0
1
0.0
0.01
1
NIL
HORIZONTAL

SLIDER
3033
137
3206
170
rat_day_max
rat_day_max
0
20
7.0
1
1
NIL
HORIZONTAL

CHOOSER
3034
185
3173
230
vacType_override
vacType_override
"off" "Pfizer"
0

SLIDER
3037
233
3212
266
gather_loc_trans_red
gather_loc_trans_red
0
1
0.0
0.01
1
NIL
HORIZONTAL

SLIDER
3043
275
3216
308
Mask_Wear_Boost
Mask_Wear_Boost
0
100
0.0
1
1
NIL
HORIZONTAL

SWITCH
3182
187
3337
220
reducedStageFour
reducedStageFour
1
1
-1000

INPUTBOX
2132
359
2347
419
input_incursion_table
input/vic/incursion.csv
1
0
String

SLIDER
2936
793
3119
826
param_override_ve_area
param_override_ve_area
-1
1
-1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1597
863
1752
896
Scale_Up_Threshold
Scale_Up_Threshold
0
200
150.0
1
1
NIL
HORIZONTAL

SLIDER
1597
900
1751
933
Scale_Down_Threshold
Scale_Down_Threshold
0
200
130.0
1
1
NIL
HORIZONTAL

SLIDER
1595
938
1749
971
scale_cont_buffer
scale_cont_buffer
0
100
10.0
1
1
NIL
HORIZONTAL


SLIDER
1615
605
1788
638
slope_track_start
slope_track_start
0
100
23.0
1
1
NIL
HORIZONTAL

SLIDER
1615
642
1788
675
slope_track_end
slope_track_end
0
5000
0.0
5
1
NIL
HORIZONTAL

SWITCH
3202
52
3382
85
override_asympt_table
override_asympt_table
1
1
-1000

SLIDER
1039
95
1219
128
init_metric_threshold
init_metric_threshold
-10
1200
390.0
10
1
NIL
HORIZONTAL

SLIDER
1040
132
1213
165
init_stage
init_stage
0
4
0.0
0.1
1
NIL
HORIZONTAL



SLIDER
305
15
563
48
SIM_SEED
SIM_SEED
-1
10000000
-1.0
1
1
NIL
HORIZONTAL

SWITCH
1040
169
1213
202
realNotCaseThres
realNotCaseThres
0
1
-1000


SLIDER
834
788
1018
821
mid_report_day
mid_report_day
0
100
42.0
1
1
NIL
HORIZONTAL


SLIDER
3570
143
3719
176
param_incurMult
param_incurMult
0
1
0.0
0.05
1
NIL
HORIZONTAL

INPUTBOX
2383
344
2558
404
input_region
input/vic/region.csv
1
0
String

INPUTBOX
2384
399
2558
459
input_vac_params
input/vic/vaccine_params
1
0
String

INPUTBOX
239
265
372
325
init_cases_region
-1.0
1
0
Number

INPUTBOX
305
454
383
514
preSimDailyHosp
0.0
1
0
Number

SWITCH
1477
453
1612
486
policyUseHosp
policyUseHosp
0
1
-1000

INPUTBOX
2349
783
2403
843
in_dose1
_1
1
0
String

INPUTBOX
2410
784
2463
844
in_dose2
_60
1
0
String


INPUTBOX
2390
459
2549
519
input_variant
input/vic/variant.csv
1
0
String

INPUTBOX
2392
520
2534
580
input_draws
input/vic
1
0
String

SLIDER
12
13
285
46
draw_index
draw_index
0
4000
0.0
1
1
NIL
HORIZONTAL

INPUTBOX
2204
493
2381
553
input_vaccine_schedule
input/vic/rollout_both.csv
1
0
String



CHOOSER
1598
985
1731
1030
param_force_vaccine
param_force_vaccine
"Disabled" "AZ" "Pfizer"
0



SLIDER
469
867
642
900
trans_override
trans_override
0
0.999
0.0
0.01
1
NIL
HORIZONTAL

SLIDER
625
1027
798
1060
sympt_iso_prop
sympt_iso_prop
0
1
0.0
0.01
1
NIL
HORIZONTAL

INPUTBOX
2350
652
2534
712
input_pre_vacinfect
input/vic/prevacinfect.csv
1
0
String

SLIDER
2592
873
2787
906
yearly_recover_prop_loss
yearly_recover_prop_loss
0
100
0.0
1
1
NIL
HORIZONTAL

INPUTBOX
2362
587
2541
647
input_maskFile
input/vic/mask_params.csv
1
0
String

SLIDER
468
925
641
958
mask_upgradeProp
mask_upgradeProp
0
1
0.8
0.1
1
NIL
HORIZONTAL

SLIDER
469
965
642
998
mask_upgradeStage
mask_upgradeStage
0
5
2.0
1
1
NIL
HORIZONTAL

INPUTBOX
2350
715
2537
775
input_vaccine_base
input/vic/vaccine_underlying_params
1
0
String

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

bed
false
15
Polygon -1 true true 45 150 45 150 90 210 240 105 195 75 45 150
Rectangle -1 true true 227 105 239 150
Rectangle -1 true true 90 195 106 250
Rectangle -1 true true 45 150 60 195
Polygon -1 true true 106 211 106 211 232 125 228 108 98 193 102 213

bog roll
true
0
Circle -1 true false 13 13 272
Circle -16777216 false false 75 75 150
Circle -16777216 true false 103 103 95
Circle -16777216 false false 59 59 182
Circle -16777216 false false 44 44 212
Circle -16777216 false false 29 29 242

bog roll2
true
0
Circle -1 true false 74 30 146
Rectangle -1 true false 75 102 220 204
Circle -1 true false 74 121 146
Circle -16777216 true false 125 75 44
Circle -16777216 false false 75 28 144

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

box 2
false
0
Polygon -7500403 true true 150 285 270 225 270 90 150 150
Polygon -13791810 true false 150 150 30 90 150 30 270 90
Polygon -13345367 true false 30 90 30 225 150 285 150 150

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

health care
false
15
Circle -1 true true 2 -2 302
Rectangle -2674135 true false 69 122 236 176
Rectangle -2674135 true false 127 66 181 233

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

worker1
true
15
Circle -16777216 true false 96 96 108
Circle -1 true true 108 108 85
Polygon -16777216 true false 120 180 135 195 121 245 107 246 125 190 125 190
Polygon -16777216 true false 181 182 166 197 180 247 194 248 176 192 176 192

worker2
true
15
Circle -16777216 true false 95 94 110
Circle -1 true true 108 107 85
Polygon -16777216 true false 130 197 148 197 149 258 129 258
Polygon -16777216 true false 155 258 174 258 169 191 152 196

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="headless_experiment" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>average_R_all_regions</metric>
    <metric>trans_override</metric>
    <metric>days</metric>
    <metric>totalEndCount</metric>
    <metric>scalephase</metric>
    <metric>infectionsToday</metric>
    <metric>End_Day</metric>
    <metric>first_trace_day</metric>
    <metric>first_trace_infections</metric>
    <metric>currentInfections</metric>
    <metric>cumulativeInfected</metric>
    <metric>tracked_simuls</metric>
    <metric>finished_infections</metric>
    <metric>finished_tracked</metric>
    <metric>cali_timenow</metric>
    <metric>cali_asymptomaticFlag</metric>
    <metric>cali_symtomatic_present_day</metric>
    <metric>first_trace_occurred</metric>
    <metric>cumulative_tracked_all</metric>
    <metric>cumulative_tracked_notice</metric>
    <metric>initial_infection_R</metric>
    <metric>casesinperiod7_max</metric>
    <metric>casesReportedToday_max</metric>
    <metric>stage4time</metric>
    <metric>stage3time</metric>
    <metric>stage2time</metric>
    <metric>stage1btime</metric>
    <metric>stage1time</metric>
    <metric>stage_listOut</metric>
    <metric>infectNoVacArray_listOut</metric>
    <metric>infectVacArray_listOut</metric>
    <metric>case_listOut</metric>
    <metric>case7_listOut</metric>
    <metric>case14_listOut</metric>
    <metric>case28_listOut</metric>
    <metric>age_listOut</metric>
    <metric>casesinperiod7_min</metric>
    <metric>pre_stop_day</metric>
    <metric>casesinperiod7_switchTime</metric>
    <metric>cumulativeInfected_switchTime</metric>
    <metric>cumulativeInfected_minusInit</metric>
    <metric>dieArray_listOut</metric>
    <metric>icuArray_listOut</metric>
    <metric>hospArray_listOut</metric>
    <enumeratedValueSet variable="population">
      <value value="2500.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="10.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="5.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="5.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="63000.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="total_population">
      <value value="6649066.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="100.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tracking">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="15.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="schoolsopen">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="8.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_enabled">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;TightSupress&quot;"/>
      <value value="&quot;LooseSupress&quot;"/>
      <value value="&quot;BarelySupress&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.66"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="160.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="5.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="390.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_r">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_iso_factor">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_slope">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailycases">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.58"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set_shape">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incur_phase_limit">
      <value value="-1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incursion_phase_speed_mult">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_primary_prop">
      <value value="0.26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_days">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_stage">
      <value value="-1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_preset">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vacincurmult">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trace_mult">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_attempt_limit">
      <value value="3.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max_stage">
      <value value="3.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_calibration">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isocomply_override">
      <value value="0.93"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_timenow_limit">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_pipeline">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_pipe_time">
      <value value="105.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incur_timenow_limit">
      <value value="4.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hetro_mult">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="daily_infect_binom">
      <value value="5.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_param">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_mask_param">
      <value value="&quot;Normal&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="minmaskwearing">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="success_14day_cases">
      <value value="-1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_stage1_time">
      <value value="-1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_trace_prop">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_population_table">
      <value value="&quot;input/vic/pop&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_input">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake_mult">
      <value value="0.6"/>
      <value value="0.8"/>
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_essential">
      <value value="&quot;Extreme&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avoid_essential">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_radius_anchor">
      <value value="8.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_spread_anchor">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="first_case_calibrate">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prepeak_vir_boost">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="data_suffix">
      <value value="&quot;.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="pre_present_iso">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="self_iso_at_peak">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="print_phase">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="print_vac">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="house_init_group">
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sensitivity">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_eff_override">
      <value value="-1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_trans_mult">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_at_5">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_assymtote">
      <value value="100.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_trace">
      <value value="&quot;ass100_90at5&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="site_iso_prop">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="site_iso_max_day">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_at_1">
      <value value="0.98"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_print">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="data_suffix_2">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_switch">
      <value value="&quot;pak&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="suffix_rollout">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="count_incursion">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transmit_skew">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="duration_skew">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_distance_mult">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recover_immunity_mult">
      <value value="1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="always_spread">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_override_ve">
      <value value="-1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="print_contact_events">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cont_stage">
      <value value="3.25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="min_stage">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="pipe_end_override">
      <value value="&quot;off&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rat_prop">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rat_day_max">
      <value value="7.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vactype_override">
      <value value="&quot;off&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_loc_trans_red">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wear_boost">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reducedstagefour">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_incursion_table">
      <value value="&quot;input/vic/incursion.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_override_ve_area">
      <value value="-1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_up_threshold">
      <value value="150.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_down_threshold">
      <value value="130.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_cont_buffer">
      <value value="10.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="slope_track_start">
      <value value="23.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="slope_track_end">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="override_asympt_table">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_metric_threshold">
      <value value="390.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_stage">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sim_seed">
      <value value="-1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="realnotcasethres">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mid_report_day">
      <value value="42.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incurmult">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_region">
      <value value="&quot;input/vic/region.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_vac_params">
      <value value="&quot;input/vic/vaccine_params&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_cases_region">
      <value value="-1.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailyhosp">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policyusehosp">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="in_dose1">
      <value value="&quot;_1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="in_dose2">
      <value value="&quot;_60&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_variant">
      <value value="&quot;input/vic/variant.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_draws">
      <value value="&quot;input/vic&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="draw_index">
      <value value="0"/>
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_vaccine_schedule">
      <value value="&quot;input/vic/rollout_both.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_force_vaccine">
      <value value="&quot;Disabled&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trans_override">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_iso_prop">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_pre_vacinfect">
      <value value="&quot;input/vic/prevacinfect.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="yearly_recover_prop_loss">
      <value value="0.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_maskfile">
      <value value="&quot;input/vic/mask_params.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_upgradeprop">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_upgradestage">
      <value value="2.0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_vaccine_base">
      <value value="&quot;input/vic/vaccine_underlying_params&quot;"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@

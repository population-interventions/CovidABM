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
  "costs.nls"
  "util.nls"
  "mask.nls"
  "avoidResponse.nls"
]
@#$#@#$#@
GRAPHICS-WINDOW
404
62
874
533
-1
-1
6.08
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
75
0
75
1
1
1
ticks
30.0

BUTTON
257
69
321
103
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
2837
903
2939
938
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
2949
903
3049
937
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
3914
147
4027
180
Population
Population
0
10000
5000.0
2500
1
NIL
HORIZONTAL

SLIDER
2584
40
2717
73
Span
Span
0
30
12.780000000000001
1
1
NIL
HORIZONTAL

PLOT
3704
872
4099
1047
Susceptible, Infected and Recovered - 000's
Days from March 10th
Numbers of people
0.0
10.0
0.0
100.0
true
true
"" ""
PENS
"Infected Proportion" 1.0 0 -2674135 true "" "plot count simuls with [ color = red ] * (Total_Population / 100 / max (list count Simuls 1)) "
"Susceptible" 1.0 0 -14070903 true "" "plot count simuls with [ color = 85 ] * (Total_Population / 100 / max (list count Simuls 1)) "
"Recovered" 1.0 0 -987046 true "" "plot count simuls with [ color = yellow ] * (Total_Population / 100 / max (list count Simuls 1)) "

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

MONITOR
3812
750
3961
807
Deaths
Deathcount
0
1
14

MONITOR
3542
915
3697
972
# simuls
count simuls * (Total_Population / population)
0
1
14

MONITOR
3715
110
3884
167
Total # Infected
cumulativeInfected
0
1
14

SLIDER
2732
205
2911
238
superspreaders
superspreaders
0
1
0.0535
0.01
1
NIL
HORIZONTAL

MONITOR
15
835
164
892
% Total Infections
cumulativeInfected / Total_Population * 100
2
1
14

MONITOR
3847
492
3977
537
Case Fatality Rate %
caseFatalityRate * 100
2
1
11

PLOT
4042
355
4270
485
Case Fatality Rate %
NIL
NIL
0.0
10.0
0.0
0.05
true
false
"" ""
PENS
"default" 1.0 0 -5298144 true "" "plot caseFatalityRate * 100"

SLIDER
2729
40
2924
73
Proportion_People_Avoid
Proportion_People_Avoid
0
1
0.28
0.01
1
NIL
HORIZONTAL

SLIDER
2729
75
2912
108
Proportion_Time_Avoid
Proportion_Time_Avoid
0
1
0.38
0.01
1
NIL
HORIZONTAL

PLOT
2552
932
2819
1052
Estimated count of deceased across age ranges (not scaled)
NIL
NIL
0.0
100.0
0.0
50.0
true
false
"" ""
PENS
"default" 1.0 1 -2674135 true "" "Histogram [ agerange ] of simuls with [ color = black ] "

PLOT
2148
194
2417
336
Infection Proportional Growth Rate
Time
Growth rate
0.0
300.0
0.0
2.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "if ticks > 1 [ plot ( InfectionChange ) * 10 ]"

MONITOR
3432
680
3564
725
Infection Growth %
infectionchange
2
1
11

INPUTBOX
287
197
377
257
initial_cases
250000.0
1
0
Number

INPUTBOX
229
390
336
452
total_population
6649066.0
1
0
Number

MONITOR
1728
808
1860
853
Close contacts per day
AverageContacts
2
1
11

PLOT
1838
32
2131
180
Age (black), Vaccinated (green)
NIL
NIL
0.0
100.0
0.0
0.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "" "histogram [ agerange ] of simuls"
"pen-2" 1.0 0 -2674135 true "" "histogram [ agerange ] of simuls with [ recoverVaccine != 0 ]"
"pen-3" 1.0 0 -15040220 true "" "histogram [ agerange ] of simuls with [ currentVaccine != 0 ]"
"pen-4" 1.0 0 -13791810 true "" "histogram [ agerange ] of simuls with [ prevVaccine != 0 ]"
"pen-5" 1.0 0 -5825686 true "" "histogram [ agerange ] of simuls with [ color = red ]"

PLOT
1040
747
1463
986
Active (red) and Total (blue) Infections ICU Beds (black)
NIL
NIL
0.0
10.0
0.0
200.0
true
false
"" "\n"
PENS
"Current Cases" 1.0 1 -7858858 true "" "plot currentInfections_minusInit"
"Total Infected" 1.0 0 -13345367 true "" "plot cumulativeInfected_minusInit"
"ICU Beds Required" 1.0 0 -16777216 true "" "plot ICUBedsRequired "
"Raw cum" 1.0 0 -7500403 true "" "plot cumulativeInfected_raw"

MONITOR
1478
554
1603
603
New Infections
(globalPopPerSimul * (count simuls with [ color = red and timenow = 1 ]))
0
1
12

PLOT
3240
379
3414
512
Ln(1 + New Infections Per Day)
NIL
NIL
0.0
10.0
0.0
2.0
true
false
"" ""
PENS
"LN New Cases" 1.0 1 -5298144 true "" "plot Log (1 + (globalPopPerSimul * (count simuls with [ color = red and timenow = 1]))) 2.618"
"pen-1" 1.0 0 -16777216 true "" "plot Log (1 + init_metric_threshold) 2.618"

MONITOR
1759
920
1861
965
Red (raw)
count simuls with [ color = red ]
0
1
11

MONITOR
768
15
846
60
NIL
Days
17
1
11

MONITOR
1473
838
1581
887
Scale Exponent
scalePhase
17
1
12

MONITOR
4072
687
4152
732
NIL
count simuls
17
1
11

MONITOR
4067
582
4181
627
Potential contacts
PotentialContacts
0
1
11

PLOT
2148
27
2437
189
Distribution of Illness pd
NIL
NIL
10.0
40.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "" "histogram [ ownIllnessPeriod ] of simuls "

SLIDER
2732
165
2910
198
Essential_Workers
Essential_Workers
0
1
0.73
0.01
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
2582
364
2717
397
tracking
tracking
0
1
-1000

SWITCH
2589
230
2724
263
schoolsOpen
schoolsOpen
0
1
-1000

MONITOR
685
14
763
59
Households
houseTotal
1
1
11

PLOT
3247
192
3466
341
Infections by age range
NIL
NIL
0.0
100.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "" "Histogram [ agerange ] of simuls with [ color != 85  ]"

MONITOR
3847
444
3979
489
EW Infection %
EWInfections / Population
1
1
11

MONITOR
4027
497
4160
542
Student Infections %
studentInfections / Population
1
1
11

SWITCH
2589
270
2723
303
MaskPolicy
MaskPolicy
0
1
-1000

SLIDER
835
1027
1035
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
2729
249
2911
282
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
2729
285
2912
318
Visit_Radius
Visit_Radius
0
16
8.715
1
1
NIL
HORIZONTAL

MONITOR
1472
662
1576
707
NIL
currentinfections
17
1
11

PLOT
1840
484
2214
604
Ln(1 + New cases in last 7, 14, 28 days)
NIL
NIL
0.0
10.0
0.0
2.0
true
true
"" ""
PENS
"7" 1.0 0 -16777216 true "" "plot Log (1 + casesinperiod7 / 7) 2.618"
"14" 1.0 0 -14454117 true "" "plot Log (1 + casesinperiod14 / 14) 2.618"
"28" 1.0 0 -2674135 true "" "plot Log (1 + casesinperiod28 / 28) 2.618"
"1" 1.0 0 -14439633 true "" "plot Log (1 + casesReportedToday) 2.618"
"pS" 1.0 0 -6459832 true "" "plot Log (1 + preSimDailyCases) 2.618"

PLOT
1040
620
1464
745
Stage (red) and Scale (blue)
NIL
NIL
0.0
10.0
0.0
4.0
true
false
"" ""
PENS
"Stage" 1.0 0 -5298144 true "" "plot stage"
"LS" 1.0 0 -8990512 true "" "plot Log ((max (list (scaledPopulation / Population) 1)) * (max (list Scale_Factor 1))) 2"
"Scale" 1.0 0 -14454117 true "" "plot scalePhase"

MONITOR
1760
967
1860
1012
Yellow (raw)
count simuls with [ color = yellow ]
0
1
11

MONITOR
3852
345
3925
390
Time = 1
count simuls with [ timenow = 2 ]
0
1
11

MONITOR
4067
632
4132
677
Students
count simuls with [ isStudent ]
0
1
11

SLIDER
3854
634
4038
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
405
699
563
732
Vaccine_Enabled
Vaccine_Enabled
0
1
-1000

MONITOR
1384
13
1453
58
Vac1 %
100 * count simuls with [currentVaccine = \"cur_2\"] / population
2
1
11

MONITOR
1565
13
1638
58
Vaccinated
6
17
1
11

PLOT
3435
352
3792
490
Vaccination Rates
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"OLD2" 1.0 0 -16777216 true "" "plot 100 * count simuls with [currentVaccine = \"OLD_2\"] / population"
"OLD3" 1.0 0 -2674135 true "" "plot 100 * count simuls with [currentVaccine = \"OLD_3\"] / population"
"TARGET" 1.0 0 -13791810 true "" "plot 100 * count simuls with [currentVaccine = \"TARGET\"] / population"
"MULTI" 1.0 0 -11085214 true "" "plot 100 * count simuls with [currentVaccine = \"MULTI\"] / population"

MONITOR
2584
80
2721
125
NIL
spatial_distance
17
1
11

MONITOR
2584
130
2718
175
NIL
case_isolation
17
1
11

MONITOR
2589
180
2722
225
NIL
quarantine
17
1
11

MONITOR
2978
288
3150
333
NIL
Track_and_Trace_Efficiency
17
1
11

MONITOR
1470
714
1527
759
NIL
stage
17
1
11

MONITOR
3992
790
4089
835
Interaction Infectivity
transmission_average
6
1
11

MONITOR
4107
740
4187
785
Virulent Interactions
transmission_count_metric
17
1
11

PLOT
3645
509
3828
663
Potential transmission interactions per day (scaled)
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot transmission_count_metric"

TEXTBOX
2598
13
2722
46
Stage Policy Settings
12
0.0
1

CHOOSER
13
463
208
508
param_policy
param_policy
"AggressElim" "ModerateElim" "TightSupress" "LooseSupress" "BarelySupress" "Fix2_1_LooseSupress" "Fix2_1_BarelySupress" "Fix2_1_Stage2" "Fix2_1_Stage15" "TightSupress_No_5" "LooseSupress_No_5" "Stage2infect" "None" "Stage1" "Stage1b" "Stage2" "Stage2b" "Stage3" "Stage3b" "Stage4" "StageCal_None" "StageCal_Test" "StageCal_1" "StageCal_2" "StageCal_3" "StageCal_4" "StageCal_5" "StageFixed" "continuous"
8

MONITOR
1473
892
1581
937
Person per Simul
scaledPopulation * extraScaleFactor / Population
2
1
11

MONITOR
1473
942
1583
987
People in Model
scaledPopulation * extraScaleFactor
0
1
11

PLOT
1869
727
2341
885
Case Tracking (scaled)
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Tracked" 1.0 0 -16777216 true "" "plot count simuls with [ color = red and tracked = 1 ] * globalPopPerSimul"
"Total" 1.0 0 -7500403 true "" "plot count simuls with [ color = red ] * globalPopPerSimul"
"Reported" 1.0 0 -2674135 true "" "plot count simuls with [ color = red and tracked = 1 and caseReportTime <= ticks and report_case_draw < report_proportion] * globalPopPerSimul"
"KnowContact" 1.0 0 -13840069 true "" "plot count simuls with [hasKnownContact and color = red] * globalPopPerSimul"

SLIDER
834
944
1033
977
Asymptom_Trace_Mult
Asymptom_Trace_Mult
0
1
0.67
0.01
1
NIL
HORIZONTAL

PLOT
3440
507
3633
660
Average Interaction Infectivity
NIL
NIL
0.0
10.0
0.0
0.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot transmission_average"

MONITOR
4097
787
4190
832
Expected New Cases
transmission_count_metric * transmission_average
6
1
11

PLOT
1869
888
2339
1051
States (scaled)
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Isolating" 1.0 0 -12345184 true "" "plot count simuls with [color = cyan and isolating = 1] * globalPopPerSimul "
"Infected" 1.0 0 -2674135 true "" "plot count simuls with [color = red] * globalPopPerSimul "
"Tracked" 1.0 0 -5825686 true "" "plot count simuls with [color = red and tracked = 1] * globalPopPerSimul "
"Comply" 1.0 0 -13840069 true "" "plot count simuls with [color = cyan and isolateCompliant = 1] * globalPopPerSimul "
"Recovered" 1.0 0 -1184463 true "" "plot count simuls with [color = yellow] * globalPopPerSimul "
"KnownContact" 1.0 0 -13297659 true "" "plot count simuls with [hasKnownContact and color = red] * globalPopPerSimul "

SLIDER
419
915
621
948
Gather_Location_Count
Gather_Location_Count
0
350
80.0
5
1
NIL
HORIZONTAL

SLIDER
2729
120
2911
153
Complacency_Bound
Complacency_Bound
0
1
1.0
0.01
1
NIL
HORIZONTAL

PLOT
3223
48
3502
168
Distribution of currentVirulence
NIL
NIL
0.0
1.2
0.0
1.0
true
false
"" ""
PENS
"default" 0.05 1 -16777216 true "" "histogram [ currentVirulence ] of simuls with [ color = red ]"

MONITOR
4100
837
4189
882
Real New Cases
new_case_real
17
1
11

BUTTON
3827
72
3932
106
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
3877
34
3984
67
profile_on
profile_on
1
1
-1000

BUTTON
3712
72
3816
107
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
546
546.0
1
1
NIL
HORIZONTAL

SLIDER
590
588
750
621
Isolation_Transmission
Isolation_Transmission
0
1
0.33
0.01
1
NIL
HORIZONTAL

MONITOR
2582
314
2722
359
NIL
floor (policymetric7 / 7)
17
1
11

PLOT
4037
180
4310
300
OverseasIncursions
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Incursions" 1.0 0 -16777216 true "" "plot totalOverseasIncursions"
"People" 1.0 0 -7500403 true "" "plot global_incursionArrivals"
"% Chance" 1.0 0 -2674135 true "" "plot global_incursionRisk * 100"

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

PLOT
3063
374
3223
517
Cohorts and infections
NIL
NIL
0.0
37.0
0.0
50.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "" "histogram [ cohortIndex ] of simuls"
"pen-1" 1.0 0 -5298144 true "" "histogram [ cohortIndex ] of simuls with [ color = red ]"

MONITOR
13
653
163
710
Total Infected
cumulativeInfected / 1000000
6
1
14

MONITOR
13
897
168
954
% Living Recovered
recoverProportion * 100
2
1
14

SLIDER
624
984
826
1017
Recovered_Match_Rate
Recovered_Match_Rate
0
1
0.9
0.01
1
NIL
HORIZONTAL

SWITCH
3512
307
3679
340
param_trigger_loosen
param_trigger_loosen
1
1
-1000

MONITOR
1495
504
1600
549
NIL
policyTriggerScale
17
1
11

MONITOR
1714
372
1817
417
slopeAverage %
slopeAverage * 100
3
1
11

PLOT
3244
910
3476
1030
slope %
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot slopeAverage * 100"
"pen-1" 1.0 0 -7500403 true "" "plot slope * 100"

SLIDER
12
968
171
1001
stage_test_index
stage_test_index
-1
25
-1.0
1
1
NIL
HORIZONTAL

SWITCH
2732
324
2915
357
isolate_on_inf_notice
isolate_on_inf_notice
0
1
-1000

SLIDER
2553
457
2753
490
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
539
2945
572
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
2553
495
2751
528
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
3372
1037
3487
1070
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

MONITOR
298
884
407
929
% Rec Second
100 * (count simuls with [recoverVariant = \"omlike_escape\"]) / Population
2
1
11

MONITOR
183
839
285
884
% Red First
100 * (count simuls with [color = red and infectVariant = \"base\"]) / Population
2
1
11

MONITOR
184
888
286
933
% Red Second
100 * (count simuls with [color = red and infectVariant = \"omlike_escape\"]) / Population
2
1
11

SLIDER
619
1023
817
1056
Recov_Var_Match_Rate
Recov_Var_Match_Rate
0
1
0.9
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

MONITOR
4012
740
4102
785
Incursion Var
incursionPhaseEndDay
17
1
11

MONITOR
295
838
397
883
% Rec First
100 * (count simuls with [recoverVariant = \"base\"]) / Population
17
1
11

SLIDER
2838
943
3036
976
complacency_loss
complacency_loss
0
0.01
0.01
0.001
1
NIL
HORIZONTAL

MONITOR
2727
404
2870
449
NIL
average_R_all_regions
4
1
11

SLIDER
4039
57
4214
90
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

MONITOR
2978
242
3151
287
Case report %
100 * (count simuls with [ color = red and tracked = 1 and caseReportTime <= ticks and report_case_draw < report_proportion]) / (max (list (count simuls with [ color = red ]) 1))
2
1
11

SLIDER
2748
575
2941
608
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
3824
690
4023
723
incursion_phase_speed_mult
incursion_phase_speed_mult
0
2
1.0
0.01
1
NIL
HORIZONTAL

SWITCH
130
1029
230
1062
calibrate
calibrate
1
1
-1000

MONITOR
1758
872
1860
917
NIL
extraScaleFactor
3
1
11

SLIDER
407
543
556
576
initial_primary_prop
initial_primary_prop
0
1
0.25
0.01
1
NIL
HORIZONTAL

SLIDER
4204
772
4397
805
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
4202
807
4396
840
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
4204
732
4397
765
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
4037
99
4211
132
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
2983
194
3156
227
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
2559
888
2732
921
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
270
564
382
597
max_stage
max_stage
0
5
5.0
1
1
NIL
HORIZONTAL

SLIDER
3597
787
3800
820
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
2759
459
2963
492
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
1
0.86
0.02
1
NIL
HORIZONTAL

CHOOSER
2222
468
2365
513
policy_pipeline
policy_pipeline
"None" "ME_TS_S1" "ME_ME_ME" "ME_ME_TS" "ME_ME_LS" "ME_TS_LS" "ME_TS_BS" "ME_TS_NONE"
0

SLIDER
2220
515
2365
548
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
3712
247
3924
280
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
3712
287
3921
320
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
205
788
353
833
compound_param
compound_param
"None" "Hetro_Test"
0

CHOOSER
3882
544
4070
589
compound_mask_param
compound_mask_param
"Normal" "NoMask" "Min100" "Min50" "None"
0

SLIDER
3597
750
3804
783
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
4204
842
4398
875
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
419
994
609
1027
init_trace_prop
init_trace_prop
0
1
0.2
0.05
1
NIL
HORIZONTAL

INPUTBOX
2559
653
2728
713
input_population_table
input/vic/pop
1
0
String

CHOOSER
205
743
352
788
compound_input
compound_input
"None" "baseline"
0

SLIDER
419
787
609
820
param_vac_uptake_mult
param_vac_uptake_mult
0
1
0.65
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

MONITOR
1472
614
1604
659
NIL
casesReportedToday
17
1
11

MONITOR
1714
325
1823
370
NIL
initial_infection_R
17
1
11

SWITCH
405
619
579
652
first_case_calibrate
first_case_calibrate
1
1
-1000

SLIDER
2838
984
3038
1017
prepeak_vir_boost
prepeak_vir_boost
0
1
0.0
0.05
1
NIL
HORIZONTAL

CHOOSER
2225
555
2370
600
data_suffix
data_suffix
"_bau.csv" "_int.csv" "_az_25.csv" "_az_50.csv" "_az_25_95.csv" "_az_25_90.csv" "_az_25_80.csv" "_az_25_70.csv" "_70" "_80" "_90" "_95" ".csv"
12

SLIDER
835
987
1034
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
419
955
612
988
self_iso_at_peak
self_iso_at_peak
0
1
-1000

SWITCH
4207
584
4326
617
print_phase
print_phase
1
1
-1000

SWITCH
4207
544
4325
577
print_vac
print_vac
1
1
-1000

SLIDER
1238
992
1440
1025
house_init_group
house_init_group
0
1
0.85
0.05
1
NIL
HORIZONTAL

CHOOSER
215
148
383
193
sensitivity
sensitivity
"None" "HouseResample+" "HouseResample-" "HouseResampleUp+" "HouseResampleUp-" "NoInfect_1" "NoInfect_2" "UniformContact_054" "UniformContact_033" "ReduceVacTrans_050" "TraceLow" "TraceHigh" "Asmpyt_66" "RAT_33" "RAT_15" "AllPF" "GatherVent_33" "GatherVent_80" "BoostMask_25" "StageMax_3b" "StageMax_3" "LetItRip" "LetItRipStage1" "LetItRipStage2" "ScaleBoost_20" "ScaleSet_70" "SetVacArea50" "SetVacArea65" "NoRecoverImmune" "DistMult_2" "PresentPropMult_050" "IsoTransmit_05" "IsoTransmit_1" "PPM_050_Stage3" "PPM_050_Stage3b" "TestVic" "OverrideAsympt"
0

SLIDER
2559
853
2732
886
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
614
2920
647
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
2983
124
3156
157
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
2983
159
3156
192
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
2987
39
3160
84
compound_trace
compound_trace
"None" "ass50_70at5" "ass100_90at5" "ass100_90at5_iso" "ass200_90at5"
2

SLIDER
2748
650
2921
683
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
689
2920
722
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
2983
89
3156
122
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
3524
270
3638
303
trace_print
trace_print
1
1
-1000

CHOOSER
2220
605
2358
650
data_suffix_2
data_suffix_2
"None" "_5.csv" "_12.csv"
0

CHOOSER
12
508
125
553
policy_switch
policy_switch
"tony" "nz" "pak" "continuous"
0

SWITCH
2227
658
2355
691
suffix_rollout
suffix_rollout
0
1
-1000

SWITCH
4069
305
4207
338
count_incursion
count_incursion
1
1
-1000

SLIDER
3527
977
3696
1010
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
3527
1017
3696
1050
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
739
2931
772
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
780
2933
813
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
3417
739
3556
772
always_spread
always_spread
1
1
-1000

SLIDER
2757
824
2930
857
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
865
2931
898
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
270
527
383
560
min_stage
min_stage
0
5
1.0
1
1
NIL
HORIZONTAL

CHOOSER
3500
39
3639
84
pipe_end_override
pipe_end_override
"off" "None" "Stage1" "Stage2"
0

SLIDER
3500
90
3673
123
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
3500
129
3673
162
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
3502
177
3641
222
vacType_override
vacType_override
"off" "Pfizer"
0

SLIDER
3504
225
3679
258
gather_loc_trans_red
gather_loc_trans_red
0
1
0.0
0.01
1
NIL
HORIZONTAL

SWITCH
3652
187
3807
220
reducedStageFour
reducedStageFour
1
1
-1000

INPUTBOX
14
327
342
387
input_incursion_table
input/vic/incur_base45_only.csv
1
0
String

SLIDER
3403
785
3586
818
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
300
290.0
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
300
260.0
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

MONITOR
1472
994
1560
1039
% in Model
extraScaleFactor * 100 * scaledPopulation / total_population
2
1
11

SLIDER
3253
834
3426
867
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
3253
872
3426
905
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
3672
27
3852
60
override_asympt_table
override_asympt_table
1
1
-1000

SLIDER
1640
694
1827
727
init_metric_threshold
init_metric_threshold
-1000
30000
18000.0
1000
1
NIL
HORIZONTAL

SLIDER
1643
513
1816
546
init_stage
init_stage
0
5
2.0
0.01
1
NIL
HORIZONTAL

MONITOR
848
14
916
59
NIL
start_day
17
1
11

MONITOR
1464
13
1532
58
Vac2 %
100 * count simuls with [currentVaccine = \"cur_3\"] / population
2
1
11

SLIDER
305
15
563
48
SIM_SEED
SIM_SEED
-1
10000000
26066.76358
1
1
NIL
HORIZONTAL

MONITOR
15
772
166
829
Total Cases
totalCasesReported
0
1
14

SLIDER
640
943
824
976
midreport_day
midreport_day
0
100
64.0
1
1
NIL
HORIZONTAL

SLIDER
4037
135
4186
168
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
2368
342
2543
402
input_region
input/vic/region.csv
1
0
String

INPUTBOX
2368
404
2542
464
input_vac_params
input/vic/vaccine_params
1
0
String

INPUTBOX
184
198
282
258
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
2582
405
2717
438
policyUseHosp
policyUseHosp
0
1
-1000

INPUTBOX
3597
674
3651
734
in_dose1
_1
1
0
String

INPUTBOX
3657
675
3710
735
in_dose2
_60
1
0
String

MONITOR
12
709
190
766
NIL
recoverCount
0
1
14

INPUTBOX
2368
467
2527
527
input_variant
input/vic/variant_revised.csv
1
0
String

INPUTBOX
2368
529
2510
589
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
2000
108.0
1
1
NIL
HORIZONTAL

INPUTBOX
17
263
335
323
input_vaccine_schedule
input/vic/rollout_target_later_30_high.csv
1
0
String

PLOT
1843
185
2135
354
Vaccine Eff vs. Infection
NIL
NIL
0.0
1.0
0.0
1.0
true
true
"" ""
PENS
"base" 0.02 1 -1184463 true "" "histogram [ 1 - (vaccine_getWanedParameter \"riskReduct\" \"base\" currentVaccine vaccineDay prevVaccine prevVaccineDay) ] of simuls"
"incur" 0.02 1 -13840069 true "" "histogram [ 1 - (vaccine_getWanedParameter \"riskReduct\" (word incur_name_part_1 incur_name_part_2 incur_name_part_3) currentVaccine vaccineDay prevVaccine prevVaccineDay) ] of simuls"
"baseRec" 0.02 1 -2674135 true "" "histogram [ 1 - (simul_getRecoverVacHistogram \"base\" 2659) ] of simuls"
"incurRec" 0.02 1 -13345367 true "" "histogram [ 1 - (simul_getRecoverVacHistogram (word incur_name_part_1 incur_name_part_2 incur_name_part_3) 2659) ] of simuls"

PLOT
1840
363
2204
483
Days Since Vac
NIL
NIL
0.0
250.0
0.0
10.0
true
false
"" ""
PENS
"default" 5.0 1 -16777216 true "" "histogram [ days - vaccineDay ] of simuls with [currentVaccine != 0]"
"pen-1" 10.0 1 -5298144 true "" "histogram [ days - recoverDay ] of simuls with [recoverVaccine != 0]"

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
405
659
578
692
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
419
1030
613
1063
sympt_iso_prop
sympt_iso_prop
0
1
1.0
0.01
1
NIL
HORIZONTAL

INPUTBOX
2365
654
2549
714
input_pre_vacinfect
input/vic/prevac/draw_
1
0
String

SLIDER
2835
1022
3030
1055
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
2368
590
2547
650
input_maskFile
input/vic/mask_params.csv
1
0
String

INPUTBOX
2364
717
2551
777
input_vaccine_base
input/vic/vaccine/draw_
1
0
String

SWITCH
17
389
187
422
policy_mask_n95
policy_mask_n95
1
1
-1000

SLIDER
3834
195
4007
228
incur_day
incur_day
0
364
91.0
91
1
NIL
HORIZONTAL

SLIDER
1233
317
1466
350
incur_replace_chance
incur_replace_chance
-0.01
1
0.2
0.01
1
NIL
HORIZONTAL

SLIDER
427
825
615
858
param_vac_uptake_std
param_vac_uptake_std
0
0.4
0.1
0.01
1
NIL
HORIZONTAL

INPUTBOX
2362
780
2682
840
input_matchup_uncertainty
input/vic/vaccine_params_or_uncertainty.csv
1
0
String

SLIDER
3525
832
3698
865
in_prevac_count
in_prevac_count
0
1000
1000.0
1
1
NIL
HORIZONTAL

SLIDER
3525
872
3698
905
in_vaccine_count
in_vaccine_count
0
1000
100.0
1
1
NIL
HORIZONTAL

MONITOR
1484
455
1607
500
NIL
policymetric7
17
1
11

INPUTBOX
2558
589
2627
649
base_name
base
1
0
String

CHOOSER
14
110
153
155
incur_name_part_1
incur_name_part_1
"omlike" "novel"
1

CHOOSER
14
160
153
205
incur_name_part_2
incur_name_part_2
"" "_escape"
1

CHOOSER
13
207
152
252
incur_name_part_3
incur_name_part_3
"" "_high"
1

MONITOR
1640
549
1822
594
NIL
infectionsToday
0
1
11

MONITOR
184
937
289
982
% Red Third
100 * (count simuls with [color = red and infectVariant = item 6 table:get incursionTable 2]) / Population
2
1
11

PLOT
1043
360
1465
480
New infections / expected hosp
NIL
NIL
3.0
10.0
0.0
0.03
true
false
"" ""
PENS
"default" 1.0 1 -2674135 true "" "plot  policymetric7 / ( 3 + infectionsToday)"
"pen-1" 1.0 0 -16777216 true "" "plot 0.0125"

PLOT
1044
483
1471
613
New infections
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -2674135 true "" "plot infectionsToday"
"pen-1" 1.0 0 -16777216 true "" "plot init_metric_threshold"
"pen-2" 1.0 0 -955883 true "" "plot infectionsinperiod7 / 7"
"pen-3" 1.0 0 -15040220 true "" "plot 20000"

SLIDER
405
739
578
772
init_vacrecover_day
init_vacrecover_day
0
250
0.0
1
1
NIL
HORIZONTAL

SLIDER
1640
653
1780
686
start_day_min
start_day_min
0
100
25.0
1
1
NIL
HORIZONTAL

SWITCH
135
515
254
548
stages_cont
stages_cont
0
1
-1000

MONITOR
298
938
407
983
% Rec Third
100 * (count simuls with [recoverVariant = item 6 table:get incursionTable 2]) / Population
2
1
11

PLOT
2959
612
3184
756
expected hosp
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot policymetric7"

INPUTBOX
2559
717
2744
777
input_draw_static
input/vic/draw_static.csv
1
0
String

PLOT
2957
765
3187
895
Deaths
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "if ticks > 0 [plot sum (array:to-list item 0 dieArray)]"

SLIDER
588
624
752
657
avoidAttemptIntMult
avoidAttemptIntMult
0
1
0.33
0.01
1
NIL
HORIZONTAL

SLIDER
405
582
578
615
init_infectivityMult
init_infectivityMult
0
2
1.0
0.1
1
NIL
HORIZONTAL

SLIDER
189
989
407
1022
recover_prop
recover_prop
0
1
0.56
0.01
1
NIL
HORIZONTAL

SWITCH
234
1029
406
1062
override_recover_prop
override_recover_prop
1
1
-1000

SLIDER
780
579
903
612
fear_max
fear_max
0
40000
32000.0
1000
1
NIL
HORIZONTAL

SLIDER
780
619
903
652
fear_min
fear_min
0
10000
5000.0
1000
1
NIL
HORIZONTAL

SLIDER
908
578
1035
611
fear_ppa_limit
fear_ppa_limit
0
1
0.15
0.01
1
NIL
HORIZONTAL

SLIDER
908
619
1032
652
fear_pta_limit
fear_pta_limit
0
1
0.1
0.01
1
NIL
HORIZONTAL

MONITOR
658
894
778
939
%fearPpaChange
fearPpaChange * 100
2
1
11

MONITOR
914
894
1027
939
%fearPtaChange
fearPtaChange * 100
2
1
11

MONITOR
784
895
912
940
NIL
infectionsinperiod7 / 7
0
1
11

MONITOR
14
1013
122
1058
NIL
totalHosp
17
1
11

MONITOR
1757
1023
1859
1068
NIL
totalHospUsage
17
1
11

INPUTBOX
2519
532
2734
592
input_vac_extra
input/vic/vaccine_extra_params.csv
1
0
String

PLOT
1839
610
2213
730
MaskOr
NIL
NIL
0.0
1.05
0.0
2500.0
false
false
"" ""
PENS
"default" 0.05 1 -16777216 true "" "histogram [wornMaskOr] of simuls"

PLOT
622
665
1032
887
Average immunity
NIL
NIL
0.0
10.0
0.0
0.5
true
true
"" ""
PENS
"incur Rec" 1.0 0 -2674135 true "" "plot sum [ 1 - (simul_getRecoverVacHistogram (word incur_name_part_1 incur_name_part_2 incur_name_part_3) 2659) ] of simuls / population"
"base Rec" 1.0 0 -955883 true "" "plot sum [ 1 - (simul_getRecoverVacHistogram \"base\" 2659) ] of simuls / population"
"incur Vac" 1.0 0 -13840069 true "" "plot sum [ 1 - (vaccine_getWanedParameter \"riskReduct\" (word incur_name_part_1 incur_name_part_2 incur_name_part_3) currentVaccine vaccineDay prevVaccine prevVaccineDay) ] of simuls / population"
"base Vac" 1.0 0 -13345367 true "" "plot sum [ 1 - (vaccine_getWanedParameter \"riskReduct\" \"base\" currentVaccine vaccineDay prevVaccine prevVaccineDay) ] of simuls / population"
"incur Tot" 1.0 0 -16777216 true "" "plot sum [ 1 - (simul_getRecoverVacHistogram (word incur_name_part_1 incur_name_part_2 incur_name_part_3) 2659) * (vaccine_getWanedParameter \"riskReduct\" (word incur_name_part_1 incur_name_part_2 incur_name_part_3) currentVaccine vaccineDay prevVaccine prevVaccineDay) ] of simuls / population"
"base Tot" 1.0 0 -7500403 true "" "plot sum [ 1 - (simul_getRecoverVacHistogram \"base\" 2659) * (vaccine_getWanedParameter \"riskReduct\" \"base\" currentVaccine vaccineDay prevVaccine prevVaccineDay) ] of simuls / population"

SLIDER
15
72
187
105
maskWearMod
maskWearMod
-100
100
0.0
10
1
NIL
HORIZONTAL

SLIDER
2218
384
2366
417
prevInfectTrackMax
prevInfectTrackMax
0
9
9.0
1
1
NIL
HORIZONTAL

CHOOSER
12
555
125
600
compoundScenario
compoundScenario
"none" "josh" "middle" "worst"
0

SLIDER
9
603
182
636
param_wane_mult
param_wane_mult
0
1
1.0
0.05
1
NIL
HORIZONTAL

CHOOSER
133
556
272
601
compoundVaccine
compoundVaccine
"none"
0

CHOOSER
210
650
349
695
compoundMask
compoundMask
"none" "NoMask" "20Mask" "25Mask" "35Mask" "50Mask" "75Mask" "75N95" "AllN95"
0

CHOOSER
208
697
347
742
compoundMaskOld
compoundMaskOld
"none" "NoMask" "20Mask" "25Mask" "35Mask" "50Mask" "75Mask" "75N95" "AllN95"
0

SLIDER
3912
110
4031
143
filePop
filePop
0
2500
2500.0
100
1
NIL
HORIZONTAL

SWITCH
2733
365
2865
398
traceContacts
traceContacts
1
1
-1000

SLIDER
4209
639
4363
672
test_moveMult
test_moveMult
0
2
1.0
0.1
1
NIL
HORIZONTAL

SLIDER
4202
682
4377
715
test_spreadMult
test_spreadMult
0
2
1.0
0.1
1
NIL
HORIZONTAL

MONITOR
1642
599
1802
644
NIL
infectivityMult
3
1
11

SLIDER
3812
397
3985
430
init_reff_calc_time
init_reff_calc_time
0
100
15.0
1
1
NIL
HORIZONTAL

MONITOR
1495
342
1614
387
Generation Time
totInfecterTime_out / totInfect_out
3
1
11

SLIDER
2760
498
2960
531
vap_topup_days
vap_topup_days
0
100
91.0
1
1
NIL
HORIZONTAL

SLIDER
4037
14
4210
47
mask_int_start
mask_int_start
0
300
152.0
1
1
NIL
HORIZONTAL

SWITCH
18
425
187
458
policy_more_mask
policy_more_mask
1
1
-1000

PLOT
1040
118
1415
310
Infected Simuls
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"Base" 1.0 0 -2674135 true "" "plot (count simuls with [color = red and infectVariant = \"base\"])"
"Josh" 1.0 0 -13840069 true "" "plot (count simuls with [color = red and infectVariant = \"base45\"])"
"Incur" 1.0 0 -13345367 true "" "plot (count simuls with [color = red and infectVariant = item 6 table:get incursionTable 2])"

PLOT
1430
115
1827
304
Recovered Percentage
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"Base" 1.0 0 -2674135 true "" "plot 100 * (count simuls with [recoverVariant = \"base\"]) / Population"
"Josh" 1.0 0 -13840069 true "" "plot 100 * (count simuls with [recoverVariant = \"base45\"]) / Population"
"Incur" 1.0 0 -13345367 true "" "plot 100 * (count simuls with [recoverVariant = item 6 table:get incursionTable 2]) / Population"

MONITOR
1497
393
1612
438
Early Reff
reffInfectees_out / reffInfecters_out
3
1
11

SLIDER
202
613
375
646
policy_phase_days
policy_phase_days
0
100
91.0
1
1
NIL
HORIZONTAL

SLIDER
1043
58
1216
91
start_day_abort
start_day_abort
0
200
200.0
1
1
NIL
HORIZONTAL

MONITOR
1640
419
1759
464
NIL
totDeath_out
1
1
11

MONITOR
1640
467
1749
512
NIL
totHospTime_out
1
1
11

SWITCH
420
877
614
911
param_mask_redraw
param_mask_redraw
0
1
-1000

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
@#$#@#$#@
NetLogo 6.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="vic_rcalc" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
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
    <metric>totalHospUsage</metric>
    <metric>totalHosp</metric>
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
    <metric>stage5time</metric>
    <metric>stage4time</metric>
    <metric>stage3time</metric>
    <metric>stage2time</metric>
    <metric>stage1time</metric>
    <metric>casesinperiod7_min</metric>
    <metric>pre_stop_day</metric>
    <metric>casesinperiod7_switchTime</metric>
    <metric>cumulativeInfected_switchTime</metric>
    <metric>cumulativeInfected_minusInit</metric>
    <enumeratedValueSet variable="draw_index">
      <value value="0"/>
      <value value="1"/>
      <value value="2"/>
      <value value="3"/>
      <value value="4"/>
      <value value="5"/>
      <value value="6"/>
      <value value="7"/>
      <value value="8"/>
      <value value="9"/>
      <value value="10"/>
      <value value="11"/>
      <value value="12"/>
      <value value="13"/>
      <value value="14"/>
      <value value="15"/>
      <value value="16"/>
      <value value="17"/>
      <value value="18"/>
      <value value="19"/>
      <value value="20"/>
      <value value="21"/>
      <value value="22"/>
      <value value="23"/>
      <value value="24"/>
      <value value="25"/>
      <value value="26"/>
      <value value="27"/>
      <value value="28"/>
      <value value="29"/>
      <value value="30"/>
      <value value="31"/>
      <value value="32"/>
      <value value="33"/>
      <value value="34"/>
      <value value="35"/>
      <value value="36"/>
      <value value="37"/>
      <value value="38"/>
      <value value="39"/>
      <value value="40"/>
      <value value="41"/>
      <value value="42"/>
      <value value="43"/>
      <value value="44"/>
      <value value="45"/>
      <value value="46"/>
      <value value="47"/>
      <value value="48"/>
      <value value="49"/>
      <value value="50"/>
      <value value="51"/>
      <value value="52"/>
      <value value="53"/>
      <value value="54"/>
      <value value="55"/>
      <value value="56"/>
      <value value="57"/>
      <value value="58"/>
      <value value="59"/>
      <value value="60"/>
      <value value="61"/>
      <value value="62"/>
      <value value="63"/>
      <value value="64"/>
      <value value="65"/>
      <value value="66"/>
      <value value="67"/>
      <value value="68"/>
      <value value="69"/>
      <value value="70"/>
      <value value="71"/>
      <value value="72"/>
      <value value="73"/>
      <value value="74"/>
      <value value="75"/>
      <value value="76"/>
      <value value="77"/>
      <value value="78"/>
      <value value="79"/>
      <value value="80"/>
      <value value="81"/>
      <value value="82"/>
      <value value="83"/>
      <value value="84"/>
      <value value="85"/>
      <value value="86"/>
      <value value="87"/>
      <value value="88"/>
      <value value="89"/>
      <value value="90"/>
      <value value="91"/>
      <value value="92"/>
      <value value="93"/>
      <value value="94"/>
      <value value="95"/>
      <value value="96"/>
      <value value="97"/>
      <value value="98"/>
      <value value="99"/>
      <value value="100"/>
      <value value="101"/>
      <value value="102"/>
      <value value="103"/>
      <value value="104"/>
      <value value="105"/>
      <value value="106"/>
      <value value="107"/>
      <value value="108"/>
      <value value="109"/>
      <value value="110"/>
      <value value="111"/>
      <value value="112"/>
      <value value="113"/>
      <value value="114"/>
      <value value="115"/>
      <value value="116"/>
      <value value="117"/>
      <value value="118"/>
      <value value="119"/>
      <value value="120"/>
      <value value="121"/>
      <value value="122"/>
      <value value="123"/>
      <value value="124"/>
      <value value="125"/>
      <value value="126"/>
      <value value="127"/>
      <value value="128"/>
      <value value="129"/>
      <value value="130"/>
      <value value="131"/>
      <value value="132"/>
      <value value="133"/>
      <value value="134"/>
      <value value="135"/>
      <value value="136"/>
      <value value="137"/>
      <value value="138"/>
      <value value="139"/>
      <value value="140"/>
      <value value="141"/>
      <value value="142"/>
      <value value="143"/>
      <value value="144"/>
      <value value="145"/>
      <value value="146"/>
      <value value="147"/>
      <value value="148"/>
      <value value="149"/>
      <value value="150"/>
      <value value="151"/>
      <value value="152"/>
      <value value="153"/>
      <value value="154"/>
      <value value="155"/>
      <value value="156"/>
      <value value="157"/>
      <value value="158"/>
      <value value="159"/>
      <value value="160"/>
      <value value="161"/>
      <value value="162"/>
      <value value="163"/>
      <value value="164"/>
      <value value="165"/>
      <value value="166"/>
      <value value="167"/>
      <value value="168"/>
      <value value="169"/>
      <value value="170"/>
      <value value="171"/>
      <value value="172"/>
      <value value="173"/>
      <value value="174"/>
      <value value="175"/>
      <value value="176"/>
      <value value="177"/>
      <value value="178"/>
      <value value="179"/>
      <value value="180"/>
      <value value="181"/>
      <value value="182"/>
      <value value="183"/>
      <value value="184"/>
      <value value="185"/>
      <value value="186"/>
      <value value="187"/>
      <value value="188"/>
      <value value="189"/>
      <value value="190"/>
      <value value="191"/>
      <value value="192"/>
      <value value="193"/>
      <value value="194"/>
      <value value="195"/>
      <value value="196"/>
      <value value="197"/>
      <value value="198"/>
      <value value="199"/>
      <value value="200"/>
      <value value="201"/>
      <value value="202"/>
      <value value="203"/>
      <value value="204"/>
      <value value="205"/>
      <value value="206"/>
      <value value="207"/>
      <value value="208"/>
      <value value="209"/>
      <value value="210"/>
      <value value="211"/>
      <value value="212"/>
      <value value="213"/>
      <value value="214"/>
      <value value="215"/>
      <value value="216"/>
      <value value="217"/>
      <value value="218"/>
      <value value="219"/>
      <value value="220"/>
      <value value="221"/>
      <value value="222"/>
      <value value="223"/>
      <value value="224"/>
      <value value="225"/>
      <value value="226"/>
      <value value="227"/>
      <value value="228"/>
      <value value="229"/>
      <value value="230"/>
      <value value="231"/>
      <value value="232"/>
      <value value="233"/>
      <value value="234"/>
      <value value="235"/>
      <value value="236"/>
      <value value="237"/>
      <value value="238"/>
      <value value="239"/>
      <value value="240"/>
      <value value="241"/>
      <value value="242"/>
      <value value="243"/>
      <value value="244"/>
      <value value="245"/>
      <value value="246"/>
      <value value="247"/>
      <value value="248"/>
      <value value="249"/>
      <value value="250"/>
      <value value="251"/>
      <value value="252"/>
      <value value="253"/>
      <value value="254"/>
      <value value="255"/>
      <value value="256"/>
      <value value="257"/>
      <value value="258"/>
      <value value="259"/>
      <value value="260"/>
      <value value="261"/>
      <value value="262"/>
      <value value="263"/>
      <value value="264"/>
      <value value="265"/>
      <value value="266"/>
      <value value="267"/>
      <value value="268"/>
      <value value="269"/>
      <value value="270"/>
      <value value="271"/>
      <value value="272"/>
      <value value="273"/>
      <value value="274"/>
      <value value="275"/>
      <value value="276"/>
      <value value="277"/>
      <value value="278"/>
      <value value="279"/>
      <value value="280"/>
      <value value="281"/>
      <value value="282"/>
      <value value="283"/>
      <value value="284"/>
      <value value="285"/>
      <value value="286"/>
      <value value="287"/>
      <value value="288"/>
      <value value="289"/>
      <value value="290"/>
      <value value="291"/>
      <value value="292"/>
      <value value="293"/>
      <value value="294"/>
      <value value="295"/>
      <value value="296"/>
      <value value="297"/>
      <value value="298"/>
      <value value="299"/>
      <value value="300"/>
      <value value="301"/>
      <value value="302"/>
      <value value="303"/>
      <value value="304"/>
      <value value="305"/>
      <value value="306"/>
      <value value="307"/>
      <value value="308"/>
      <value value="309"/>
      <value value="310"/>
      <value value="311"/>
      <value value="312"/>
      <value value="313"/>
      <value value="314"/>
      <value value="315"/>
      <value value="316"/>
      <value value="317"/>
      <value value="318"/>
      <value value="319"/>
      <value value="320"/>
      <value value="321"/>
      <value value="322"/>
      <value value="323"/>
      <value value="324"/>
      <value value="325"/>
      <value value="326"/>
      <value value="327"/>
      <value value="328"/>
      <value value="329"/>
      <value value="330"/>
      <value value="331"/>
      <value value="332"/>
      <value value="333"/>
      <value value="334"/>
      <value value="335"/>
      <value value="336"/>
      <value value="337"/>
      <value value="338"/>
      <value value="339"/>
      <value value="340"/>
      <value value="341"/>
      <value value="342"/>
      <value value="343"/>
      <value value="344"/>
      <value value="345"/>
      <value value="346"/>
      <value value="347"/>
      <value value="348"/>
      <value value="349"/>
      <value value="350"/>
      <value value="351"/>
      <value value="352"/>
      <value value="353"/>
      <value value="354"/>
      <value value="355"/>
      <value value="356"/>
      <value value="357"/>
      <value value="358"/>
      <value value="359"/>
      <value value="360"/>
      <value value="361"/>
      <value value="362"/>
      <value value="363"/>
      <value value="364"/>
      <value value="365"/>
      <value value="366"/>
      <value value="367"/>
      <value value="368"/>
      <value value="369"/>
      <value value="370"/>
      <value value="371"/>
      <value value="372"/>
      <value value="373"/>
      <value value="374"/>
      <value value="375"/>
      <value value="376"/>
      <value value="377"/>
      <value value="378"/>
      <value value="379"/>
      <value value="380"/>
      <value value="381"/>
      <value value="382"/>
      <value value="383"/>
      <value value="384"/>
      <value value="385"/>
      <value value="386"/>
      <value value="387"/>
      <value value="388"/>
      <value value="389"/>
      <value value="390"/>
      <value value="391"/>
      <value value="392"/>
      <value value="393"/>
      <value value="394"/>
      <value value="395"/>
      <value value="396"/>
      <value value="397"/>
      <value value="398"/>
      <value value="399"/>
      <value value="400"/>
      <value value="401"/>
      <value value="402"/>
      <value value="403"/>
      <value value="404"/>
      <value value="405"/>
      <value value="406"/>
      <value value="407"/>
      <value value="408"/>
      <value value="409"/>
      <value value="410"/>
      <value value="411"/>
      <value value="412"/>
      <value value="413"/>
      <value value="414"/>
      <value value="415"/>
      <value value="416"/>
      <value value="417"/>
      <value value="418"/>
      <value value="419"/>
      <value value="420"/>
      <value value="421"/>
      <value value="422"/>
      <value value="423"/>
      <value value="424"/>
      <value value="425"/>
      <value value="426"/>
      <value value="427"/>
      <value value="428"/>
      <value value="429"/>
      <value value="430"/>
      <value value="431"/>
      <value value="432"/>
      <value value="433"/>
      <value value="434"/>
      <value value="435"/>
      <value value="436"/>
      <value value="437"/>
      <value value="438"/>
      <value value="439"/>
      <value value="440"/>
      <value value="441"/>
      <value value="442"/>
      <value value="443"/>
      <value value="444"/>
      <value value="445"/>
      <value value="446"/>
      <value value="447"/>
      <value value="448"/>
      <value value="449"/>
      <value value="450"/>
      <value value="451"/>
      <value value="452"/>
      <value value="453"/>
      <value value="454"/>
      <value value="455"/>
      <value value="456"/>
      <value value="457"/>
      <value value="458"/>
      <value value="459"/>
      <value value="460"/>
      <value value="461"/>
      <value value="462"/>
      <value value="463"/>
      <value value="464"/>
      <value value="465"/>
      <value value="466"/>
      <value value="467"/>
      <value value="468"/>
      <value value="469"/>
      <value value="470"/>
      <value value="471"/>
      <value value="472"/>
      <value value="473"/>
      <value value="474"/>
      <value value="475"/>
      <value value="476"/>
      <value value="477"/>
      <value value="478"/>
      <value value="479"/>
      <value value="480"/>
      <value value="481"/>
      <value value="482"/>
      <value value="483"/>
      <value value="484"/>
      <value value="485"/>
      <value value="486"/>
      <value value="487"/>
      <value value="488"/>
      <value value="489"/>
      <value value="490"/>
      <value value="491"/>
      <value value="492"/>
      <value value="493"/>
      <value value="494"/>
      <value value="495"/>
      <value value="496"/>
      <value value="497"/>
      <value value="498"/>
      <value value="499"/>
      <value value="500"/>
      <value value="501"/>
      <value value="502"/>
      <value value="503"/>
      <value value="504"/>
      <value value="505"/>
      <value value="506"/>
      <value value="507"/>
      <value value="508"/>
      <value value="509"/>
      <value value="510"/>
      <value value="511"/>
      <value value="512"/>
      <value value="513"/>
      <value value="514"/>
      <value value="515"/>
      <value value="516"/>
      <value value="517"/>
      <value value="518"/>
      <value value="519"/>
      <value value="520"/>
      <value value="521"/>
      <value value="522"/>
      <value value="523"/>
      <value value="524"/>
      <value value="525"/>
      <value value="526"/>
      <value value="527"/>
      <value value="528"/>
      <value value="529"/>
      <value value="530"/>
      <value value="531"/>
      <value value="532"/>
      <value value="533"/>
      <value value="534"/>
      <value value="535"/>
      <value value="536"/>
      <value value="537"/>
      <value value="538"/>
      <value value="539"/>
      <value value="540"/>
      <value value="541"/>
      <value value="542"/>
      <value value="543"/>
      <value value="544"/>
      <value value="545"/>
      <value value="546"/>
      <value value="547"/>
      <value value="548"/>
      <value value="549"/>
      <value value="550"/>
      <value value="551"/>
      <value value="552"/>
      <value value="553"/>
      <value value="554"/>
      <value value="555"/>
      <value value="556"/>
      <value value="557"/>
      <value value="558"/>
      <value value="559"/>
      <value value="560"/>
      <value value="561"/>
      <value value="562"/>
      <value value="563"/>
      <value value="564"/>
      <value value="565"/>
      <value value="566"/>
      <value value="567"/>
      <value value="568"/>
      <value value="569"/>
      <value value="570"/>
      <value value="571"/>
      <value value="572"/>
      <value value="573"/>
      <value value="574"/>
      <value value="575"/>
      <value value="576"/>
      <value value="577"/>
      <value value="578"/>
      <value value="579"/>
      <value value="580"/>
      <value value="581"/>
      <value value="582"/>
      <value value="583"/>
      <value value="584"/>
      <value value="585"/>
      <value value="586"/>
      <value value="587"/>
      <value value="588"/>
      <value value="589"/>
      <value value="590"/>
      <value value="591"/>
      <value value="592"/>
      <value value="593"/>
      <value value="594"/>
      <value value="595"/>
      <value value="596"/>
      <value value="597"/>
      <value value="598"/>
      <value value="599"/>
      <value value="600"/>
      <value value="601"/>
      <value value="602"/>
      <value value="603"/>
      <value value="604"/>
      <value value="605"/>
      <value value="606"/>
      <value value="607"/>
      <value value="608"/>
      <value value="609"/>
      <value value="610"/>
      <value value="611"/>
      <value value="612"/>
      <value value="613"/>
      <value value="614"/>
      <value value="615"/>
      <value value="616"/>
      <value value="617"/>
      <value value="618"/>
      <value value="619"/>
      <value value="620"/>
      <value value="621"/>
      <value value="622"/>
      <value value="623"/>
      <value value="624"/>
      <value value="625"/>
      <value value="626"/>
      <value value="627"/>
      <value value="628"/>
      <value value="629"/>
      <value value="630"/>
      <value value="631"/>
      <value value="632"/>
      <value value="633"/>
      <value value="634"/>
      <value value="635"/>
      <value value="636"/>
      <value value="637"/>
      <value value="638"/>
      <value value="639"/>
      <value value="640"/>
      <value value="641"/>
      <value value="642"/>
      <value value="643"/>
      <value value="644"/>
      <value value="645"/>
      <value value="646"/>
      <value value="647"/>
      <value value="648"/>
      <value value="649"/>
      <value value="650"/>
      <value value="651"/>
      <value value="652"/>
      <value value="653"/>
      <value value="654"/>
      <value value="655"/>
      <value value="656"/>
      <value value="657"/>
      <value value="658"/>
      <value value="659"/>
      <value value="660"/>
      <value value="661"/>
      <value value="662"/>
      <value value="663"/>
      <value value="664"/>
      <value value="665"/>
      <value value="666"/>
      <value value="667"/>
      <value value="668"/>
      <value value="669"/>
      <value value="670"/>
      <value value="671"/>
      <value value="672"/>
      <value value="673"/>
      <value value="674"/>
      <value value="675"/>
      <value value="676"/>
      <value value="677"/>
      <value value="678"/>
      <value value="679"/>
      <value value="680"/>
      <value value="681"/>
      <value value="682"/>
      <value value="683"/>
      <value value="684"/>
      <value value="685"/>
      <value value="686"/>
      <value value="687"/>
      <value value="688"/>
      <value value="689"/>
      <value value="690"/>
      <value value="691"/>
      <value value="692"/>
      <value value="693"/>
      <value value="694"/>
      <value value="695"/>
      <value value="696"/>
      <value value="697"/>
      <value value="698"/>
      <value value="699"/>
      <value value="700"/>
      <value value="701"/>
      <value value="702"/>
      <value value="703"/>
      <value value="704"/>
      <value value="705"/>
      <value value="706"/>
      <value value="707"/>
      <value value="708"/>
      <value value="709"/>
      <value value="710"/>
      <value value="711"/>
      <value value="712"/>
      <value value="713"/>
      <value value="714"/>
      <value value="715"/>
      <value value="716"/>
      <value value="717"/>
      <value value="718"/>
      <value value="719"/>
      <value value="720"/>
      <value value="721"/>
      <value value="722"/>
      <value value="723"/>
      <value value="724"/>
      <value value="725"/>
      <value value="726"/>
      <value value="727"/>
      <value value="728"/>
      <value value="729"/>
      <value value="730"/>
      <value value="731"/>
      <value value="732"/>
      <value value="733"/>
      <value value="734"/>
      <value value="735"/>
      <value value="736"/>
      <value value="737"/>
      <value value="738"/>
      <value value="739"/>
      <value value="740"/>
      <value value="741"/>
      <value value="742"/>
      <value value="743"/>
      <value value="744"/>
      <value value="745"/>
      <value value="746"/>
      <value value="747"/>
      <value value="748"/>
      <value value="749"/>
      <value value="750"/>
      <value value="751"/>
      <value value="752"/>
      <value value="753"/>
      <value value="754"/>
      <value value="755"/>
      <value value="756"/>
      <value value="757"/>
      <value value="758"/>
      <value value="759"/>
      <value value="760"/>
      <value value="761"/>
      <value value="762"/>
      <value value="763"/>
      <value value="764"/>
      <value value="765"/>
      <value value="766"/>
      <value value="767"/>
      <value value="768"/>
      <value value="769"/>
      <value value="770"/>
      <value value="771"/>
      <value value="772"/>
      <value value="773"/>
      <value value="774"/>
      <value value="775"/>
      <value value="776"/>
      <value value="777"/>
      <value value="778"/>
      <value value="779"/>
      <value value="780"/>
      <value value="781"/>
      <value value="782"/>
      <value value="783"/>
      <value value="784"/>
      <value value="785"/>
      <value value="786"/>
      <value value="787"/>
      <value value="788"/>
      <value value="789"/>
      <value value="790"/>
      <value value="791"/>
      <value value="792"/>
      <value value="793"/>
      <value value="794"/>
      <value value="795"/>
      <value value="796"/>
      <value value="797"/>
      <value value="798"/>
      <value value="799"/>
      <value value="800"/>
      <value value="801"/>
      <value value="802"/>
      <value value="803"/>
      <value value="804"/>
      <value value="805"/>
      <value value="806"/>
      <value value="807"/>
      <value value="808"/>
      <value value="809"/>
      <value value="810"/>
      <value value="811"/>
      <value value="812"/>
      <value value="813"/>
      <value value="814"/>
      <value value="815"/>
      <value value="816"/>
      <value value="817"/>
      <value value="818"/>
      <value value="819"/>
      <value value="820"/>
      <value value="821"/>
      <value value="822"/>
      <value value="823"/>
      <value value="824"/>
      <value value="825"/>
      <value value="826"/>
      <value value="827"/>
      <value value="828"/>
      <value value="829"/>
      <value value="830"/>
      <value value="831"/>
      <value value="832"/>
      <value value="833"/>
      <value value="834"/>
      <value value="835"/>
      <value value="836"/>
      <value value="837"/>
      <value value="838"/>
      <value value="839"/>
      <value value="840"/>
      <value value="841"/>
      <value value="842"/>
      <value value="843"/>
      <value value="844"/>
      <value value="845"/>
      <value value="846"/>
      <value value="847"/>
      <value value="848"/>
      <value value="849"/>
      <value value="850"/>
      <value value="851"/>
      <value value="852"/>
      <value value="853"/>
      <value value="854"/>
      <value value="855"/>
      <value value="856"/>
      <value value="857"/>
      <value value="858"/>
      <value value="859"/>
      <value value="860"/>
      <value value="861"/>
      <value value="862"/>
      <value value="863"/>
      <value value="864"/>
      <value value="865"/>
      <value value="866"/>
      <value value="867"/>
      <value value="868"/>
      <value value="869"/>
      <value value="870"/>
      <value value="871"/>
      <value value="872"/>
      <value value="873"/>
      <value value="874"/>
      <value value="875"/>
      <value value="876"/>
      <value value="877"/>
      <value value="878"/>
      <value value="879"/>
      <value value="880"/>
      <value value="881"/>
      <value value="882"/>
      <value value="883"/>
      <value value="884"/>
      <value value="885"/>
      <value value="886"/>
      <value value="887"/>
      <value value="888"/>
      <value value="889"/>
      <value value="890"/>
      <value value="891"/>
      <value value="892"/>
      <value value="893"/>
      <value value="894"/>
      <value value="895"/>
      <value value="896"/>
      <value value="897"/>
      <value value="898"/>
      <value value="899"/>
      <value value="900"/>
      <value value="901"/>
      <value value="902"/>
      <value value="903"/>
      <value value="904"/>
      <value value="905"/>
      <value value="906"/>
      <value value="907"/>
      <value value="908"/>
      <value value="909"/>
      <value value="910"/>
      <value value="911"/>
      <value value="912"/>
      <value value="913"/>
      <value value="914"/>
      <value value="915"/>
      <value value="916"/>
      <value value="917"/>
      <value value="918"/>
      <value value="919"/>
      <value value="920"/>
      <value value="921"/>
      <value value="922"/>
      <value value="923"/>
      <value value="924"/>
      <value value="925"/>
      <value value="926"/>
      <value value="927"/>
      <value value="928"/>
      <value value="929"/>
      <value value="930"/>
      <value value="931"/>
      <value value="932"/>
      <value value="933"/>
      <value value="934"/>
      <value value="935"/>
      <value value="936"/>
      <value value="937"/>
      <value value="938"/>
      <value value="939"/>
      <value value="940"/>
      <value value="941"/>
      <value value="942"/>
      <value value="943"/>
      <value value="944"/>
      <value value="945"/>
      <value value="946"/>
      <value value="947"/>
      <value value="948"/>
      <value value="949"/>
      <value value="950"/>
      <value value="951"/>
      <value value="952"/>
      <value value="953"/>
      <value value="954"/>
      <value value="955"/>
      <value value="956"/>
      <value value="957"/>
      <value value="958"/>
      <value value="959"/>
      <value value="960"/>
      <value value="961"/>
      <value value="962"/>
      <value value="963"/>
      <value value="964"/>
      <value value="965"/>
      <value value="966"/>
      <value value="967"/>
      <value value="968"/>
      <value value="969"/>
      <value value="970"/>
      <value value="971"/>
      <value value="972"/>
      <value value="973"/>
      <value value="974"/>
      <value value="975"/>
      <value value="976"/>
      <value value="977"/>
      <value value="978"/>
      <value value="979"/>
      <value value="980"/>
      <value value="981"/>
      <value value="982"/>
      <value value="983"/>
      <value value="984"/>
      <value value="985"/>
      <value value="986"/>
      <value value="987"/>
      <value value="988"/>
      <value value="989"/>
      <value value="990"/>
      <value value="991"/>
      <value value="992"/>
      <value value="993"/>
      <value value="994"/>
      <value value="995"/>
      <value value="996"/>
      <value value="997"/>
      <value value="998"/>
      <value value="999"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;BarelySupress&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_pipeline">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_input">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vacincurmult">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_mask_param">
      <value value="&quot;Normal&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_param">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_trace">
      <value value="&quot;ass100_90at5&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cont_stage">
      <value value="3.25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="count_incursion">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="daily_infect_binom">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="data_suffix">
      <value value="&quot;.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="data_suffix_2">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="duration_skew">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="390"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_radius_anchor">
      <value value="8.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_spread_anchor">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="first_case_calibrate">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_loc_trans_red">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="always_spread">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_distance_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hetro_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="house_init_group">
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="in_dose1">
      <value value="&quot;_1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="in_dose2">
      <value value="&quot;_60&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incur_timenow_limit">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incursion_phase_speed_mult">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_cases_region">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_metric_threshold">
      <value value="390"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_stage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_timenow_limit">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_trace_prop">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="20000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_primary_prop">
      <value value="0.26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_draws">
      <value value="&quot;input/vic&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_incursion_table">
      <value value="&quot;input/vic/incursion.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_population_table">
      <value value="&quot;input/vic/pop&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_region">
      <value value="&quot;input/vic/region.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_vac_params">
      <value value="&quot;input/vic/vaccine_params&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_vaccine_schedule">
      <value value="&quot;input/vic/rollout_both.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_variant">
      <value value="&quot;input/vic/variant.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isocomply_override">
      <value value="0.93"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wear_boost">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max_stage">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="midreport_day">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="min_stage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="minmaskwearing">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="override_asympt_table">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_force_vaccine">
      <value value="&quot;Disabled&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incur_phase_limit">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incurmult">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_override_ve">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_override_ve_area">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.66"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_days">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_preset">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_stage">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_stage1_time">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trace_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake_mult">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="pipe_end_override">
      <value value="&quot;off&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_pipe_time">
      <value value="105"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avoid_essential">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_switch">
      <value value="&quot;pak&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policyusehosp">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="pre_present_iso">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prepeak_vir_boost">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailycases">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailyhosp">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="print_contact_events">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="print_phase">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="print_vac">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rat_day_max">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rat_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="realnotcasethres">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.57"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recover_immunity_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reducedstagefour">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_cont_buffer">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_down_threshold">
      <value value="130"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_up_threshold">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="schoolsopen">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="self_iso_at_peak">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sensitivity">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set_shape">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sim_seed">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="site_iso_max_day">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="site_iso_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="slope_track_end">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="slope_track_start">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_essential">
      <value value="&quot;Extreme&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="success_14day_cases">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="suffix_rollout">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_iso_prop">
      <value value="0"/>
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="total_population">
      <value value="6649066"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_assymtote">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_at_1">
      <value value="0.98"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_at_5">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_attempt_limit">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_calibration">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_eff_override">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_print">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_r">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_slope">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tracking">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trans_override">
      <value value="0.25"/>
      <value value="0.5"/>
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transmit_skew">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_trans_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_enabled">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vactype_override">
      <value value="&quot;off&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="8.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="yearly_recover_prop_loss">
      <value value="0"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="vic_main" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>average_R_all_regions</metric>
    <metric>trans_override</metric>
    <metric>days</metric>
    <metric>aggIndex</metric>
    <metric>totalEndCount</metric>
    <metric>scalephase</metric>
    <metric>infectionsToday</metric>
    <metric>End_Day</metric>
    <metric>first_trace_day</metric>
    <metric>first_trace_infections</metric>
    <metric>currentInfections</metric>
    <metric>cumulativeInfected</metric>
    <metric>totalHospUsage</metric>
    <metric>totalHosp</metric>
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
    <metric>stage5time</metric>
    <metric>stage4time</metric>
    <metric>stage3time</metric>
    <metric>stage2time</metric>
    <metric>stage1time</metric>
    <metric>halyAcute_listOut</metric>
    <metric>halyDeath_listOut</metric>
    <metric>halyLong_listOut</metric>
    <metric>stage_listOut</metric>
    <metric>infectNoVacArray_listOut</metric>
    <metric>infectVacArray_listOut</metric>
    <metric>prevInfections_listOut</metric>
    <metric>aggOutcome_listOut</metric>
    <metric>hospUsage_listOut</metric>
    <metric>aveImmuneVac_listOut</metric>
    <metric>aveImmuneNat_listOut</metric>
    <metric>aveImmuneAll_listOut</metric>
    <metric>case_listOut</metric>
    <metric>case7_listOut</metric>
    <metric>case14_listOut</metric>
    <metric>case28_listOut</metric>
    <metric>age_listOut</metric>
    <metric>vaccine_listOut</metric>
    <metric>casesinperiod7_min</metric>
    <metric>pre_stop_day</metric>
    <metric>casesinperiod7_switchTime</metric>
    <metric>cumulativeInfected_switchTime</metric>
    <metric>cumulativeInfected_minusInit</metric>
    <metric>dieArray_listOut</metric>
    <metric>icuArray_listOut</metric>
    <metric>hospTimeArray_listOut</metric>
    <metric>hospArray_listOut</metric>
    <metric>symptArray_listOut</metric>
    <metric>vaccineArray_listOut</metric>
    <metric>costDeathAverted_out</metric>
    <metric>costDeathAverted_uk_out</metric>
    <metric>costAcute_out</metric>
    <metric>costLong_out</metric>
    <metric>costTesting_out</metric>
    <metric>costVaccine_out</metric>
    <metric>costVacDeliver_out</metric>
    <metric>costVaccineFixed_out</metric>
    <metric>costMask_out</metric>
    <metric>costMaskFixed_out</metric>
    <metric>costGdp_out</metric>
    <metric>costTotalHealth_out</metric>
    <metric>costTotalHealth_uk_out</metric>
    <metric>costTotalTotal_out</metric>
    <metric>costTotalTotal_uk_out</metric>
    <metric>nmbLow_out</metric>
    <metric>nmbMed_out</metric>
    <metric>nmbHigh_out</metric>
    <metric>nmbLow_uk_out</metric>
    <metric>nmbMed_uk_out</metric>
    <metric>nmbHigh_uk_out</metric>
    <metric>nmbLowNoGdp_out</metric>
    <metric>nmbMedNoGdp_out</metric>
    <metric>nmbHighNoGdp_out</metric>
    <metric>nmbLowNoGdp_uk_out</metric>
    <metric>nmbMedNoGdp_uk_out</metric>
    <metric>nmbHighNoGdp_uk_out</metric>
    <metric>halyTotalAcute_out</metric>
    <metric>halyTotalDeath_out</metric>
    <metric>halyTotalDeath_uk_out</metric>
    <metric>halyTotalLong_out</metric>
    <metric>halyTotalTotal_out</metric>
    <metric>halyTotalTotal_uk_out</metric>
    <metric>totStage2_out</metric>
    <metric>totStage3_out</metric>
    <metric>totStage4_out</metric>
    <metric>totStage5_out</metric>
    <metric>totInfect_out</metric>
    <metric>totSympt_out</metric>
    <metric>totHosp_out</metric>
    <metric>totIcu_out</metric>
    <metric>totDeath_out</metric>
    <metric>totHospTime_out</metric>
    <metric>totIcuTime_out</metric>
    <metric>hospDaysAbove500_out</metric>
    <metric>hospDaysAbove750_out</metric>
    <metric>hospDaysAbove1000_out</metric>
    <metric>hospDaysAbove1250_out</metric>
    <metric>hospDaysAbove1500_out</metric>
    <metric>hospDaysAbove1750_out</metric>
    <metric>hospDaysAbove2000_out</metric>
    <metric>prevInfect0_out</metric>
    <metric>prevInfect1_out</metric>
    <metric>prevInfect2_out</metric>
    <metric>prevInfect3_out</metric>
    <metric>prevInfect4_out</metric>
    <metric>prevInfect5_out</metric>
    <metric>prevInfect6_out</metric>
    <metric>prevInfect7_out</metric>
    <metric>prevInfect8_out</metric>
    <metric>totInfecterTime_out</metric>
    <metric>generationTime_out</metric>
    <metric>reffInfecters_out</metric>
    <metric>reffInfectees_out</metric>
    <metric>reff_out</metric>
    <metric>halyTotalDeath_alt_out</metric>
    <metric>halyTotalTotal_alt_out</metric>
    <metric>nmbLowNoGdp_alt_out</metric>
    <metric>nmbMedNoGdp_alt_out</metric>
    <metric>nmbHighNoGdp_alt_out</metric>
    <metric>nmbLow_alt_out</metric>
    <metric>nmbMed_alt_out</metric>
    <metric>nmbHigh_alt_out</metric>
    <metric>sen_vacInfectReduct_out</metric>
    <metric>sen_vacWaneInfect_out</metric>
    <metric>sen_vacWaneHosp_out</metric>
    <metric>sen_recoverInfectReduct_out</metric>
    <metric>sen_recoverWane_out</metric>
    <metric>sen_maskEff_out</metric>
    <metric>sen_asymptTransmit_out</metric>
    <metric>sen_isoProp_out</metric>
    <metric>sen_ifr_out</metric>
    <metric>sen_icu_out</metric>
    <metric>sen_hosp_out</metric>
    <metric>sen_sympt_out</metric>
    <metric>sen_hospTime_out</metric>
    <metric>sen_icuTime_out</metric>
    <metric>sen_vacCur_out</metric>
    <metric>sen_vacTarget_out</metric>
    <metric>sen_vacMulti_out</metric>
    <metric>sen_vacPromote_out</metric>
    <metric>sen_vacOverhead_out</metric>
    <metric>sen_maskPerson_out</metric>
    <metric>sen_maskStorage_out</metric>
    <metric>sen_maskPromote_out</metric>
    <metric>sen_vacUptake_out</metric>
    <metric>sen_transmissDraw_out</metric>
    <metric>sen_isoComply_out</metric>
    <metric>sen_halyAcute_out</metric>
    <metric>sen_halyLong_out</metric>
    <metric>sen_halyDeath_out</metric>
    <metric>sen_costGdp_out</metric>
    <metric>sen_costTest_out</metric>
    <metric>sen_costLong_out</metric>
    <metric>sen_costDeath_out</metric>
    <metric>sen_costDoctor_out</metric>
    <metric>sen_costParacetamol_out</metric>
    <metric>sen_costVisitEr_out</metric>
    <metric>sen_costHospBed_out</metric>
    <metric>sen_costIcuBed_out</metric>
    <metric>sen_countTest_out</metric>
    <metric>mid_0_182_costDeathAverted_out</metric>
    <metric>mid_0_182_costDeathAverted_uk_out</metric>
    <metric>mid_0_182_costAcute_out</metric>
    <metric>mid_0_182_costLong_out</metric>
    <metric>mid_0_182_costTesting_out</metric>
    <metric>mid_0_182_costVaccine_out</metric>
    <metric>mid_0_182_costVacDeliver_out</metric>
    <metric>mid_0_182_costVaccineFixed_out</metric>
    <metric>mid_0_182_costMask_out</metric>
    <metric>mid_0_182_costMaskFixed_out</metric>
    <metric>mid_0_182_costGdp_out</metric>
    <metric>mid_0_182_costTotalHealth_out</metric>
    <metric>mid_0_182_costTotalHealth_uk_out</metric>
    <metric>mid_0_182_costTotalTotal_out</metric>
    <metric>mid_0_182_costTotalTotal_uk_out</metric>
    <metric>mid_0_182_nmbLow_out</metric>
    <metric>mid_0_182_nmbMed_out</metric>
    <metric>mid_0_182_nmbHigh_out</metric>
    <metric>mid_0_182_nmbLow_uk_out</metric>
    <metric>mid_0_182_nmbMed_uk_out</metric>
    <metric>mid_0_182_nmbHigh_uk_out</metric>
    <metric>mid_0_182_nmbLowNoGdp_out</metric>
    <metric>mid_0_182_nmbMedNoGdp_out</metric>
    <metric>mid_0_182_nmbHighNoGdp_out</metric>
    <metric>mid_0_182_nmbLowNoGdp_uk_out</metric>
    <metric>mid_0_182_nmbMedNoGdp_uk_out</metric>
    <metric>mid_0_182_nmbHighNoGdp_uk_out</metric>
    <metric>mid_0_182_halyTotalAcute_out</metric>
    <metric>mid_0_182_halyTotalDeath_out</metric>
    <metric>mid_0_182_halyTotalDeath_uk_out</metric>
    <metric>mid_0_182_halyTotalLong_out</metric>
    <metric>mid_0_182_halyTotalTotal_out</metric>
    <metric>mid_0_182_halyTotalTotal_uk_out</metric>
    <metric>mid_0_182_totStage2_out</metric>
    <metric>mid_0_182_totStage3_out</metric>
    <metric>mid_0_182_totStage4_out</metric>
    <metric>mid_0_182_totStage5_out</metric>
    <metric>mid_0_182_totInfect_out</metric>
    <metric>mid_0_182_totSympt_out</metric>
    <metric>mid_0_182_totHosp_out</metric>
    <metric>mid_0_182_totIcu_out</metric>
    <metric>mid_0_182_totDeath_out</metric>
    <metric>mid_0_182_totHospTime_out</metric>
    <metric>mid_0_182_totIcuTime_out</metric>
    <metric>mid_0_182_hospDaysAbove500_out</metric>
    <metric>mid_0_182_hospDaysAbove750_out</metric>
    <metric>mid_0_182_hospDaysAbove1000_out</metric>
    <metric>mid_0_182_hospDaysAbove1250_out</metric>
    <metric>mid_0_182_hospDaysAbove1500_out</metric>
    <metric>mid_0_182_hospDaysAbove1750_out</metric>
    <metric>mid_0_182_hospDaysAbove2000_out</metric>
    <metric>mid_0_182_prevInfect0_out</metric>
    <metric>mid_0_182_prevInfect1_out</metric>
    <metric>mid_0_182_prevInfect2_out</metric>
    <metric>mid_0_182_prevInfect3_out</metric>
    <metric>mid_0_182_prevInfect4_out</metric>
    <metric>mid_0_182_prevInfect5_out</metric>
    <metric>mid_0_182_prevInfect6_out</metric>
    <metric>mid_0_182_prevInfect7_out</metric>
    <metric>mid_0_182_prevInfect8_out</metric>
    <metric>mid_0_182_totInfecterTime_out</metric>
    <metric>mid_0_182_generationTime_out</metric>
    <metric>mid_0_182_reffInfecters_out</metric>
    <metric>mid_0_182_reffInfectees_out</metric>
    <metric>mid_0_182_reff_out</metric>
    <metric>mid_0_182_halyTotalDeath_alt_out</metric>
    <metric>mid_0_182_halyTotalTotal_alt_out</metric>
    <metric>mid_0_182_nmbLowNoGdp_alt_out</metric>
    <metric>mid_0_182_nmbMedNoGdp_alt_out</metric>
    <metric>mid_0_182_nmbHighNoGdp_alt_out</metric>
    <metric>mid_0_182_nmbLow_alt_out</metric>
    <metric>mid_0_182_nmbMed_alt_out</metric>
    <metric>mid_0_182_nmbHigh_alt_out</metric>
    <metric>mid_0_364_costDeathAverted_out</metric>
    <metric>mid_0_364_costDeathAverted_uk_out</metric>
    <metric>mid_0_364_costAcute_out</metric>
    <metric>mid_0_364_costLong_out</metric>
    <metric>mid_0_364_costTesting_out</metric>
    <metric>mid_0_364_costVaccine_out</metric>
    <metric>mid_0_364_costVacDeliver_out</metric>
    <metric>mid_0_364_costVaccineFixed_out</metric>
    <metric>mid_0_364_costMask_out</metric>
    <metric>mid_0_364_costMaskFixed_out</metric>
    <metric>mid_0_364_costGdp_out</metric>
    <metric>mid_0_364_costTotalHealth_out</metric>
    <metric>mid_0_364_costTotalHealth_uk_out</metric>
    <metric>mid_0_364_costTotalTotal_out</metric>
    <metric>mid_0_364_costTotalTotal_uk_out</metric>
    <metric>mid_0_364_nmbLow_out</metric>
    <metric>mid_0_364_nmbMed_out</metric>
    <metric>mid_0_364_nmbHigh_out</metric>
    <metric>mid_0_364_nmbLow_uk_out</metric>
    <metric>mid_0_364_nmbMed_uk_out</metric>
    <metric>mid_0_364_nmbHigh_uk_out</metric>
    <metric>mid_0_364_nmbLowNoGdp_out</metric>
    <metric>mid_0_364_nmbMedNoGdp_out</metric>
    <metric>mid_0_364_nmbHighNoGdp_out</metric>
    <metric>mid_0_364_nmbLowNoGdp_uk_out</metric>
    <metric>mid_0_364_nmbMedNoGdp_uk_out</metric>
    <metric>mid_0_364_nmbHighNoGdp_uk_out</metric>
    <metric>mid_0_364_halyTotalAcute_out</metric>
    <metric>mid_0_364_halyTotalDeath_out</metric>
    <metric>mid_0_364_halyTotalDeath_uk_out</metric>
    <metric>mid_0_364_halyTotalLong_out</metric>
    <metric>mid_0_364_halyTotalTotal_out</metric>
    <metric>mid_0_364_halyTotalTotal_uk_out</metric>
    <metric>mid_0_364_totStage2_out</metric>
    <metric>mid_0_364_totStage3_out</metric>
    <metric>mid_0_364_totStage4_out</metric>
    <metric>mid_0_364_totStage5_out</metric>
    <metric>mid_0_364_totInfect_out</metric>
    <metric>mid_0_364_totSympt_out</metric>
    <metric>mid_0_364_totHosp_out</metric>
    <metric>mid_0_364_totIcu_out</metric>
    <metric>mid_0_364_totDeath_out</metric>
    <metric>mid_0_364_totHospTime_out</metric>
    <metric>mid_0_364_totIcuTime_out</metric>
    <metric>mid_0_364_hospDaysAbove500_out</metric>
    <metric>mid_0_364_hospDaysAbove750_out</metric>
    <metric>mid_0_364_hospDaysAbove1000_out</metric>
    <metric>mid_0_364_hospDaysAbove1250_out</metric>
    <metric>mid_0_364_hospDaysAbove1500_out</metric>
    <metric>mid_0_364_hospDaysAbove1750_out</metric>
    <metric>mid_0_364_hospDaysAbove2000_out</metric>
    <metric>mid_0_364_prevInfect0_out</metric>
    <metric>mid_0_364_prevInfect1_out</metric>
    <metric>mid_0_364_prevInfect2_out</metric>
    <metric>mid_0_364_prevInfect3_out</metric>
    <metric>mid_0_364_prevInfect4_out</metric>
    <metric>mid_0_364_prevInfect5_out</metric>
    <metric>mid_0_364_prevInfect6_out</metric>
    <metric>mid_0_364_prevInfect7_out</metric>
    <metric>mid_0_364_prevInfect8_out</metric>
    <metric>mid_0_364_totInfecterTime_out</metric>
    <metric>mid_0_364_generationTime_out</metric>
    <metric>mid_0_364_reffInfecters_out</metric>
    <metric>mid_0_364_reffInfectees_out</metric>
    <metric>mid_0_364_reff_out</metric>
    <metric>mid_0_364_halyTotalDeath_alt_out</metric>
    <metric>mid_0_364_halyTotalTotal_alt_out</metric>
    <metric>mid_0_364_nmbLowNoGdp_alt_out</metric>
    <metric>mid_0_364_nmbMedNoGdp_alt_out</metric>
    <metric>mid_0_364_nmbHighNoGdp_alt_out</metric>
    <metric>mid_0_364_nmbLow_alt_out</metric>
    <metric>mid_0_364_nmbMed_alt_out</metric>
    <metric>mid_0_364_nmbHigh_alt_out</metric>
    <metric>mid_182_364_costDeathAverted_out</metric>
    <metric>mid_182_364_costDeathAverted_uk_out</metric>
    <metric>mid_182_364_costAcute_out</metric>
    <metric>mid_182_364_costLong_out</metric>
    <metric>mid_182_364_costTesting_out</metric>
    <metric>mid_182_364_costVaccine_out</metric>
    <metric>mid_182_364_costVacDeliver_out</metric>
    <metric>mid_182_364_costVaccineFixed_out</metric>
    <metric>mid_182_364_costMask_out</metric>
    <metric>mid_182_364_costMaskFixed_out</metric>
    <metric>mid_182_364_costGdp_out</metric>
    <metric>mid_182_364_costTotalHealth_out</metric>
    <metric>mid_182_364_costTotalHealth_uk_out</metric>
    <metric>mid_182_364_costTotalTotal_out</metric>
    <metric>mid_182_364_costTotalTotal_uk_out</metric>
    <metric>mid_182_364_nmbLow_out</metric>
    <metric>mid_182_364_nmbMed_out</metric>
    <metric>mid_182_364_nmbHigh_out</metric>
    <metric>mid_182_364_nmbLow_uk_out</metric>
    <metric>mid_182_364_nmbMed_uk_out</metric>
    <metric>mid_182_364_nmbHigh_uk_out</metric>
    <metric>mid_182_364_nmbLowNoGdp_out</metric>
    <metric>mid_182_364_nmbMedNoGdp_out</metric>
    <metric>mid_182_364_nmbHighNoGdp_out</metric>
    <metric>mid_182_364_nmbLowNoGdp_uk_out</metric>
    <metric>mid_182_364_nmbMedNoGdp_uk_out</metric>
    <metric>mid_182_364_nmbHighNoGdp_uk_out</metric>
    <metric>mid_182_364_halyTotalAcute_out</metric>
    <metric>mid_182_364_halyTotalDeath_out</metric>
    <metric>mid_182_364_halyTotalDeath_uk_out</metric>
    <metric>mid_182_364_halyTotalLong_out</metric>
    <metric>mid_182_364_halyTotalTotal_out</metric>
    <metric>mid_182_364_halyTotalTotal_uk_out</metric>
    <metric>mid_182_364_totStage2_out</metric>
    <metric>mid_182_364_totStage3_out</metric>
    <metric>mid_182_364_totStage4_out</metric>
    <metric>mid_182_364_totStage5_out</metric>
    <metric>mid_182_364_totInfect_out</metric>
    <metric>mid_182_364_totSympt_out</metric>
    <metric>mid_182_364_totHosp_out</metric>
    <metric>mid_182_364_totIcu_out</metric>
    <metric>mid_182_364_totDeath_out</metric>
    <metric>mid_182_364_totHospTime_out</metric>
    <metric>mid_182_364_totIcuTime_out</metric>
    <metric>mid_182_364_hospDaysAbove500_out</metric>
    <metric>mid_182_364_hospDaysAbove750_out</metric>
    <metric>mid_182_364_hospDaysAbove1000_out</metric>
    <metric>mid_182_364_hospDaysAbove1250_out</metric>
    <metric>mid_182_364_hospDaysAbove1500_out</metric>
    <metric>mid_182_364_hospDaysAbove1750_out</metric>
    <metric>mid_182_364_hospDaysAbove2000_out</metric>
    <metric>mid_182_364_prevInfect0_out</metric>
    <metric>mid_182_364_prevInfect1_out</metric>
    <metric>mid_182_364_prevInfect2_out</metric>
    <metric>mid_182_364_prevInfect3_out</metric>
    <metric>mid_182_364_prevInfect4_out</metric>
    <metric>mid_182_364_prevInfect5_out</metric>
    <metric>mid_182_364_prevInfect6_out</metric>
    <metric>mid_182_364_prevInfect7_out</metric>
    <metric>mid_182_364_prevInfect8_out</metric>
    <metric>mid_182_364_totInfecterTime_out</metric>
    <metric>mid_182_364_generationTime_out</metric>
    <metric>mid_182_364_reffInfecters_out</metric>
    <metric>mid_182_364_reffInfectees_out</metric>
    <metric>mid_182_364_reff_out</metric>
    <metric>mid_182_364_halyTotalDeath_alt_out</metric>
    <metric>mid_182_364_halyTotalTotal_alt_out</metric>
    <metric>mid_182_364_nmbLowNoGdp_alt_out</metric>
    <metric>mid_182_364_nmbMedNoGdp_alt_out</metric>
    <metric>mid_182_364_nmbHighNoGdp_alt_out</metric>
    <metric>mid_182_364_nmbLow_alt_out</metric>
    <metric>mid_182_364_nmbMed_alt_out</metric>
    <metric>mid_182_364_nmbHigh_alt_out</metric>
    <metric>mid_182_546_costDeathAverted_out</metric>
    <metric>mid_182_546_costDeathAverted_uk_out</metric>
    <metric>mid_182_546_costAcute_out</metric>
    <metric>mid_182_546_costLong_out</metric>
    <metric>mid_182_546_costTesting_out</metric>
    <metric>mid_182_546_costVaccine_out</metric>
    <metric>mid_182_546_costVacDeliver_out</metric>
    <metric>mid_182_546_costVaccineFixed_out</metric>
    <metric>mid_182_546_costMask_out</metric>
    <metric>mid_182_546_costMaskFixed_out</metric>
    <metric>mid_182_546_costGdp_out</metric>
    <metric>mid_182_546_costTotalHealth_out</metric>
    <metric>mid_182_546_costTotalHealth_uk_out</metric>
    <metric>mid_182_546_costTotalTotal_out</metric>
    <metric>mid_182_546_costTotalTotal_uk_out</metric>
    <metric>mid_182_546_nmbLow_out</metric>
    <metric>mid_182_546_nmbMed_out</metric>
    <metric>mid_182_546_nmbHigh_out</metric>
    <metric>mid_182_546_nmbLow_uk_out</metric>
    <metric>mid_182_546_nmbMed_uk_out</metric>
    <metric>mid_182_546_nmbHigh_uk_out</metric>
    <metric>mid_182_546_nmbLowNoGdp_out</metric>
    <metric>mid_182_546_nmbMedNoGdp_out</metric>
    <metric>mid_182_546_nmbHighNoGdp_out</metric>
    <metric>mid_182_546_nmbLowNoGdp_uk_out</metric>
    <metric>mid_182_546_nmbMedNoGdp_uk_out</metric>
    <metric>mid_182_546_nmbHighNoGdp_uk_out</metric>
    <metric>mid_182_546_halyTotalAcute_out</metric>
    <metric>mid_182_546_halyTotalDeath_out</metric>
    <metric>mid_182_546_halyTotalDeath_uk_out</metric>
    <metric>mid_182_546_halyTotalLong_out</metric>
    <metric>mid_182_546_halyTotalTotal_out</metric>
    <metric>mid_182_546_halyTotalTotal_uk_out</metric>
    <metric>mid_182_546_totStage2_out</metric>
    <metric>mid_182_546_totStage3_out</metric>
    <metric>mid_182_546_totStage4_out</metric>
    <metric>mid_182_546_totStage5_out</metric>
    <metric>mid_182_546_totInfect_out</metric>
    <metric>mid_182_546_totSympt_out</metric>
    <metric>mid_182_546_totHosp_out</metric>
    <metric>mid_182_546_totIcu_out</metric>
    <metric>mid_182_546_totDeath_out</metric>
    <metric>mid_182_546_totHospTime_out</metric>
    <metric>mid_182_546_totIcuTime_out</metric>
    <metric>mid_182_546_hospDaysAbove500_out</metric>
    <metric>mid_182_546_hospDaysAbove750_out</metric>
    <metric>mid_182_546_hospDaysAbove1000_out</metric>
    <metric>mid_182_546_hospDaysAbove1250_out</metric>
    <metric>mid_182_546_hospDaysAbove1500_out</metric>
    <metric>mid_182_546_hospDaysAbove1750_out</metric>
    <metric>mid_182_546_hospDaysAbove2000_out</metric>
    <metric>mid_182_546_prevInfect0_out</metric>
    <metric>mid_182_546_prevInfect1_out</metric>
    <metric>mid_182_546_prevInfect2_out</metric>
    <metric>mid_182_546_prevInfect3_out</metric>
    <metric>mid_182_546_prevInfect4_out</metric>
    <metric>mid_182_546_prevInfect5_out</metric>
    <metric>mid_182_546_prevInfect6_out</metric>
    <metric>mid_182_546_prevInfect7_out</metric>
    <metric>mid_182_546_prevInfect8_out</metric>
    <metric>mid_182_546_totInfecterTime_out</metric>
    <metric>mid_182_546_generationTime_out</metric>
    <metric>mid_182_546_reffInfecters_out</metric>
    <metric>mid_182_546_reffInfectees_out</metric>
    <metric>mid_182_546_reff_out</metric>
    <metric>mid_182_546_halyTotalDeath_alt_out</metric>
    <metric>mid_182_546_halyTotalTotal_alt_out</metric>
    <metric>mid_182_546_nmbLowNoGdp_alt_out</metric>
    <metric>mid_182_546_nmbMedNoGdp_alt_out</metric>
    <metric>mid_182_546_nmbHighNoGdp_alt_out</metric>
    <metric>mid_182_546_nmbLow_alt_out</metric>
    <metric>mid_182_546_nmbMed_alt_out</metric>
    <metric>mid_182_546_nmbHigh_alt_out</metric>
    <metric>mid_364_546_costDeathAverted_out</metric>
    <metric>mid_364_546_costDeathAverted_uk_out</metric>
    <metric>mid_364_546_costAcute_out</metric>
    <metric>mid_364_546_costLong_out</metric>
    <metric>mid_364_546_costTesting_out</metric>
    <metric>mid_364_546_costVaccine_out</metric>
    <metric>mid_364_546_costVacDeliver_out</metric>
    <metric>mid_364_546_costVaccineFixed_out</metric>
    <metric>mid_364_546_costMask_out</metric>
    <metric>mid_364_546_costMaskFixed_out</metric>
    <metric>mid_364_546_costGdp_out</metric>
    <metric>mid_364_546_costTotalHealth_out</metric>
    <metric>mid_364_546_costTotalHealth_uk_out</metric>
    <metric>mid_364_546_costTotalTotal_out</metric>
    <metric>mid_364_546_costTotalTotal_uk_out</metric>
    <metric>mid_364_546_nmbLow_out</metric>
    <metric>mid_364_546_nmbMed_out</metric>
    <metric>mid_364_546_nmbHigh_out</metric>
    <metric>mid_364_546_nmbLow_uk_out</metric>
    <metric>mid_364_546_nmbMed_uk_out</metric>
    <metric>mid_364_546_nmbHigh_uk_out</metric>
    <metric>mid_364_546_nmbLowNoGdp_out</metric>
    <metric>mid_364_546_nmbMedNoGdp_out</metric>
    <metric>mid_364_546_nmbHighNoGdp_out</metric>
    <metric>mid_364_546_nmbLowNoGdp_uk_out</metric>
    <metric>mid_364_546_nmbMedNoGdp_uk_out</metric>
    <metric>mid_364_546_nmbHighNoGdp_uk_out</metric>
    <metric>mid_364_546_halyTotalAcute_out</metric>
    <metric>mid_364_546_halyTotalDeath_out</metric>
    <metric>mid_364_546_halyTotalDeath_uk_out</metric>
    <metric>mid_364_546_halyTotalLong_out</metric>
    <metric>mid_364_546_halyTotalTotal_out</metric>
    <metric>mid_364_546_halyTotalTotal_uk_out</metric>
    <metric>mid_364_546_totStage2_out</metric>
    <metric>mid_364_546_totStage3_out</metric>
    <metric>mid_364_546_totStage4_out</metric>
    <metric>mid_364_546_totStage5_out</metric>
    <metric>mid_364_546_totInfect_out</metric>
    <metric>mid_364_546_totSympt_out</metric>
    <metric>mid_364_546_totHosp_out</metric>
    <metric>mid_364_546_totIcu_out</metric>
    <metric>mid_364_546_totDeath_out</metric>
    <metric>mid_364_546_totHospTime_out</metric>
    <metric>mid_364_546_totIcuTime_out</metric>
    <metric>mid_364_546_hospDaysAbove500_out</metric>
    <metric>mid_364_546_hospDaysAbove750_out</metric>
    <metric>mid_364_546_hospDaysAbove1000_out</metric>
    <metric>mid_364_546_hospDaysAbove1250_out</metric>
    <metric>mid_364_546_hospDaysAbove1500_out</metric>
    <metric>mid_364_546_hospDaysAbove1750_out</metric>
    <metric>mid_364_546_hospDaysAbove2000_out</metric>
    <metric>mid_364_546_prevInfect0_out</metric>
    <metric>mid_364_546_prevInfect1_out</metric>
    <metric>mid_364_546_prevInfect2_out</metric>
    <metric>mid_364_546_prevInfect3_out</metric>
    <metric>mid_364_546_prevInfect4_out</metric>
    <metric>mid_364_546_prevInfect5_out</metric>
    <metric>mid_364_546_prevInfect6_out</metric>
    <metric>mid_364_546_prevInfect7_out</metric>
    <metric>mid_364_546_prevInfect8_out</metric>
    <metric>mid_364_546_totInfecterTime_out</metric>
    <metric>mid_364_546_generationTime_out</metric>
    <metric>mid_364_546_reffInfecters_out</metric>
    <metric>mid_364_546_reffInfectees_out</metric>
    <metric>mid_364_546_reff_out</metric>
    <metric>mid_364_546_halyTotalDeath_alt_out</metric>
    <metric>mid_364_546_halyTotalTotal_alt_out</metric>
    <metric>mid_364_546_nmbLowNoGdp_alt_out</metric>
    <metric>mid_364_546_nmbMedNoGdp_alt_out</metric>
    <metric>mid_364_546_nmbHighNoGdp_alt_out</metric>
    <metric>mid_364_546_nmbLow_alt_out</metric>
    <metric>mid_364_546_nmbMed_alt_out</metric>
    <metric>mid_364_546_nmbHigh_alt_out</metric>
    <metric>mid_0_60_costDeathAverted_out</metric>
    <metric>mid_0_60_costDeathAverted_uk_out</metric>
    <metric>mid_0_60_costAcute_out</metric>
    <metric>mid_0_60_costLong_out</metric>
    <metric>mid_0_60_costTesting_out</metric>
    <metric>mid_0_60_costVaccine_out</metric>
    <metric>mid_0_60_costVacDeliver_out</metric>
    <metric>mid_0_60_costVaccineFixed_out</metric>
    <metric>mid_0_60_costMask_out</metric>
    <metric>mid_0_60_costMaskFixed_out</metric>
    <metric>mid_0_60_costGdp_out</metric>
    <metric>mid_0_60_costTotalHealth_out</metric>
    <metric>mid_0_60_costTotalHealth_uk_out</metric>
    <metric>mid_0_60_costTotalTotal_out</metric>
    <metric>mid_0_60_costTotalTotal_uk_out</metric>
    <metric>mid_0_60_nmbLow_out</metric>
    <metric>mid_0_60_nmbMed_out</metric>
    <metric>mid_0_60_nmbHigh_out</metric>
    <metric>mid_0_60_nmbLow_uk_out</metric>
    <metric>mid_0_60_nmbMed_uk_out</metric>
    <metric>mid_0_60_nmbHigh_uk_out</metric>
    <metric>mid_0_60_nmbLowNoGdp_out</metric>
    <metric>mid_0_60_nmbMedNoGdp_out</metric>
    <metric>mid_0_60_nmbHighNoGdp_out</metric>
    <metric>mid_0_60_nmbLowNoGdp_uk_out</metric>
    <metric>mid_0_60_nmbMedNoGdp_uk_out</metric>
    <metric>mid_0_60_nmbHighNoGdp_uk_out</metric>
    <metric>mid_0_60_halyTotalAcute_out</metric>
    <metric>mid_0_60_halyTotalDeath_out</metric>
    <metric>mid_0_60_halyTotalDeath_uk_out</metric>
    <metric>mid_0_60_halyTotalLong_out</metric>
    <metric>mid_0_60_halyTotalTotal_out</metric>
    <metric>mid_0_60_halyTotalTotal_uk_out</metric>
    <metric>mid_0_60_totStage2_out</metric>
    <metric>mid_0_60_totStage3_out</metric>
    <metric>mid_0_60_totStage4_out</metric>
    <metric>mid_0_60_totStage5_out</metric>
    <metric>mid_0_60_totInfect_out</metric>
    <metric>mid_0_60_totSympt_out</metric>
    <metric>mid_0_60_totHosp_out</metric>
    <metric>mid_0_60_totIcu_out</metric>
    <metric>mid_0_60_totDeath_out</metric>
    <metric>mid_0_60_totHospTime_out</metric>
    <metric>mid_0_60_totIcuTime_out</metric>
    <metric>mid_0_60_hospDaysAbove500_out</metric>
    <metric>mid_0_60_hospDaysAbove750_out</metric>
    <metric>mid_0_60_hospDaysAbove1000_out</metric>
    <metric>mid_0_60_hospDaysAbove1250_out</metric>
    <metric>mid_0_60_hospDaysAbove1500_out</metric>
    <metric>mid_0_60_hospDaysAbove1750_out</metric>
    <metric>mid_0_60_hospDaysAbove2000_out</metric>
    <metric>mid_0_60_prevInfect0_out</metric>
    <metric>mid_0_60_prevInfect1_out</metric>
    <metric>mid_0_60_prevInfect2_out</metric>
    <metric>mid_0_60_prevInfect3_out</metric>
    <metric>mid_0_60_prevInfect4_out</metric>
    <metric>mid_0_60_prevInfect5_out</metric>
    <metric>mid_0_60_prevInfect6_out</metric>
    <metric>mid_0_60_prevInfect7_out</metric>
    <metric>mid_0_60_prevInfect8_out</metric>
    <metric>mid_0_60_totInfecterTime_out</metric>
    <metric>mid_0_60_generationTime_out</metric>
    <metric>mid_0_60_reffInfecters_out</metric>
    <metric>mid_0_60_reffInfectees_out</metric>
    <metric>mid_0_60_reff_out</metric>
    <metric>mid_0_60_halyTotalDeath_alt_out</metric>
    <metric>mid_0_60_halyTotalTotal_alt_out</metric>
    <metric>mid_0_60_nmbLowNoGdp_alt_out</metric>
    <metric>mid_0_60_nmbMedNoGdp_alt_out</metric>
    <metric>mid_0_60_nmbHighNoGdp_alt_out</metric>
    <metric>mid_0_60_nmbLow_alt_out</metric>
    <metric>mid_0_60_nmbMed_alt_out</metric>
    <metric>mid_0_60_nmbHigh_alt_out</metric>
    <metric>mid_60_182_costDeathAverted_out</metric>
    <metric>mid_60_182_costDeathAverted_uk_out</metric>
    <metric>mid_60_182_costAcute_out</metric>
    <metric>mid_60_182_costLong_out</metric>
    <metric>mid_60_182_costTesting_out</metric>
    <metric>mid_60_182_costVaccine_out</metric>
    <metric>mid_60_182_costVacDeliver_out</metric>
    <metric>mid_60_182_costVaccineFixed_out</metric>
    <metric>mid_60_182_costMask_out</metric>
    <metric>mid_60_182_costMaskFixed_out</metric>
    <metric>mid_60_182_costGdp_out</metric>
    <metric>mid_60_182_costTotalHealth_out</metric>
    <metric>mid_60_182_costTotalHealth_uk_out</metric>
    <metric>mid_60_182_costTotalTotal_out</metric>
    <metric>mid_60_182_costTotalTotal_uk_out</metric>
    <metric>mid_60_182_nmbLow_out</metric>
    <metric>mid_60_182_nmbMed_out</metric>
    <metric>mid_60_182_nmbHigh_out</metric>
    <metric>mid_60_182_nmbLow_uk_out</metric>
    <metric>mid_60_182_nmbMed_uk_out</metric>
    <metric>mid_60_182_nmbHigh_uk_out</metric>
    <metric>mid_60_182_nmbLowNoGdp_out</metric>
    <metric>mid_60_182_nmbMedNoGdp_out</metric>
    <metric>mid_60_182_nmbHighNoGdp_out</metric>
    <metric>mid_60_182_nmbLowNoGdp_uk_out</metric>
    <metric>mid_60_182_nmbMedNoGdp_uk_out</metric>
    <metric>mid_60_182_nmbHighNoGdp_uk_out</metric>
    <metric>mid_60_182_halyTotalAcute_out</metric>
    <metric>mid_60_182_halyTotalDeath_out</metric>
    <metric>mid_60_182_halyTotalDeath_uk_out</metric>
    <metric>mid_60_182_halyTotalLong_out</metric>
    <metric>mid_60_182_halyTotalTotal_out</metric>
    <metric>mid_60_182_halyTotalTotal_uk_out</metric>
    <metric>mid_60_182_totStage2_out</metric>
    <metric>mid_60_182_totStage3_out</metric>
    <metric>mid_60_182_totStage4_out</metric>
    <metric>mid_60_182_totStage5_out</metric>
    <metric>mid_60_182_totInfect_out</metric>
    <metric>mid_60_182_totSympt_out</metric>
    <metric>mid_60_182_totHosp_out</metric>
    <metric>mid_60_182_totIcu_out</metric>
    <metric>mid_60_182_totDeath_out</metric>
    <metric>mid_60_182_totHospTime_out</metric>
    <metric>mid_60_182_totIcuTime_out</metric>
    <metric>mid_60_182_hospDaysAbove500_out</metric>
    <metric>mid_60_182_hospDaysAbove750_out</metric>
    <metric>mid_60_182_hospDaysAbove1000_out</metric>
    <metric>mid_60_182_hospDaysAbove1250_out</metric>
    <metric>mid_60_182_hospDaysAbove1500_out</metric>
    <metric>mid_60_182_hospDaysAbove1750_out</metric>
    <metric>mid_60_182_hospDaysAbove2000_out</metric>
    <metric>mid_60_182_prevInfect0_out</metric>
    <metric>mid_60_182_prevInfect1_out</metric>
    <metric>mid_60_182_prevInfect2_out</metric>
    <metric>mid_60_182_prevInfect3_out</metric>
    <metric>mid_60_182_prevInfect4_out</metric>
    <metric>mid_60_182_prevInfect5_out</metric>
    <metric>mid_60_182_prevInfect6_out</metric>
    <metric>mid_60_182_prevInfect7_out</metric>
    <metric>mid_60_182_prevInfect8_out</metric>
    <metric>mid_60_182_totInfecterTime_out</metric>
    <metric>mid_60_182_generationTime_out</metric>
    <metric>mid_60_182_reffInfecters_out</metric>
    <metric>mid_60_182_reffInfectees_out</metric>
    <metric>mid_60_182_reff_out</metric>
    <metric>mid_60_182_halyTotalDeath_alt_out</metric>
    <metric>mid_60_182_halyTotalTotal_alt_out</metric>
    <metric>mid_60_182_nmbLowNoGdp_alt_out</metric>
    <metric>mid_60_182_nmbMedNoGdp_alt_out</metric>
    <metric>mid_60_182_nmbHighNoGdp_alt_out</metric>
    <metric>mid_60_182_nmbLow_alt_out</metric>
    <metric>mid_60_182_nmbMed_alt_out</metric>
    <metric>mid_60_182_nmbHigh_alt_out</metric>
    <metric>mid_0_91_costDeathAverted_out</metric>
    <metric>mid_0_91_costDeathAverted_uk_out</metric>
    <metric>mid_0_91_costAcute_out</metric>
    <metric>mid_0_91_costLong_out</metric>
    <metric>mid_0_91_costTesting_out</metric>
    <metric>mid_0_91_costVaccine_out</metric>
    <metric>mid_0_91_costVacDeliver_out</metric>
    <metric>mid_0_91_costVaccineFixed_out</metric>
    <metric>mid_0_91_costMask_out</metric>
    <metric>mid_0_91_costMaskFixed_out</metric>
    <metric>mid_0_91_costGdp_out</metric>
    <metric>mid_0_91_costTotalHealth_out</metric>
    <metric>mid_0_91_costTotalHealth_uk_out</metric>
    <metric>mid_0_91_costTotalTotal_out</metric>
    <metric>mid_0_91_costTotalTotal_uk_out</metric>
    <metric>mid_0_91_nmbLow_out</metric>
    <metric>mid_0_91_nmbMed_out</metric>
    <metric>mid_0_91_nmbHigh_out</metric>
    <metric>mid_0_91_nmbLow_uk_out</metric>
    <metric>mid_0_91_nmbMed_uk_out</metric>
    <metric>mid_0_91_nmbHigh_uk_out</metric>
    <metric>mid_0_91_nmbLowNoGdp_out</metric>
    <metric>mid_0_91_nmbMedNoGdp_out</metric>
    <metric>mid_0_91_nmbHighNoGdp_out</metric>
    <metric>mid_0_91_nmbLowNoGdp_uk_out</metric>
    <metric>mid_0_91_nmbMedNoGdp_uk_out</metric>
    <metric>mid_0_91_nmbHighNoGdp_uk_out</metric>
    <metric>mid_0_91_halyTotalAcute_out</metric>
    <metric>mid_0_91_halyTotalDeath_out</metric>
    <metric>mid_0_91_halyTotalDeath_uk_out</metric>
    <metric>mid_0_91_halyTotalLong_out</metric>
    <metric>mid_0_91_halyTotalTotal_out</metric>
    <metric>mid_0_91_halyTotalTotal_uk_out</metric>
    <metric>mid_0_91_totStage2_out</metric>
    <metric>mid_0_91_totStage3_out</metric>
    <metric>mid_0_91_totStage4_out</metric>
    <metric>mid_0_91_totStage5_out</metric>
    <metric>mid_0_91_totInfect_out</metric>
    <metric>mid_0_91_totSympt_out</metric>
    <metric>mid_0_91_totHosp_out</metric>
    <metric>mid_0_91_totIcu_out</metric>
    <metric>mid_0_91_totDeath_out</metric>
    <metric>mid_0_91_totHospTime_out</metric>
    <metric>mid_0_91_totIcuTime_out</metric>
    <metric>mid_0_91_hospDaysAbove500_out</metric>
    <metric>mid_0_91_hospDaysAbove750_out</metric>
    <metric>mid_0_91_hospDaysAbove1000_out</metric>
    <metric>mid_0_91_hospDaysAbove1250_out</metric>
    <metric>mid_0_91_hospDaysAbove1500_out</metric>
    <metric>mid_0_91_hospDaysAbove1750_out</metric>
    <metric>mid_0_91_hospDaysAbove2000_out</metric>
    <metric>mid_0_91_prevInfect0_out</metric>
    <metric>mid_0_91_prevInfect1_out</metric>
    <metric>mid_0_91_prevInfect2_out</metric>
    <metric>mid_0_91_prevInfect3_out</metric>
    <metric>mid_0_91_prevInfect4_out</metric>
    <metric>mid_0_91_prevInfect5_out</metric>
    <metric>mid_0_91_prevInfect6_out</metric>
    <metric>mid_0_91_prevInfect7_out</metric>
    <metric>mid_0_91_prevInfect8_out</metric>
    <metric>mid_0_91_totInfecterTime_out</metric>
    <metric>mid_0_91_generationTime_out</metric>
    <metric>mid_0_91_reffInfecters_out</metric>
    <metric>mid_0_91_reffInfectees_out</metric>
    <metric>mid_0_91_reff_out</metric>
    <metric>mid_0_91_halyTotalDeath_alt_out</metric>
    <metric>mid_0_91_halyTotalTotal_alt_out</metric>
    <metric>mid_0_91_nmbLowNoGdp_alt_out</metric>
    <metric>mid_0_91_nmbMedNoGdp_alt_out</metric>
    <metric>mid_0_91_nmbHighNoGdp_alt_out</metric>
    <metric>mid_0_91_nmbLow_alt_out</metric>
    <metric>mid_0_91_nmbMed_alt_out</metric>
    <metric>mid_0_91_nmbHigh_alt_out</metric>
    <metric>mid_91_182_costDeathAverted_out</metric>
    <metric>mid_91_182_costDeathAverted_uk_out</metric>
    <metric>mid_91_182_costAcute_out</metric>
    <metric>mid_91_182_costLong_out</metric>
    <metric>mid_91_182_costTesting_out</metric>
    <metric>mid_91_182_costVaccine_out</metric>
    <metric>mid_91_182_costVacDeliver_out</metric>
    <metric>mid_91_182_costVaccineFixed_out</metric>
    <metric>mid_91_182_costMask_out</metric>
    <metric>mid_91_182_costMaskFixed_out</metric>
    <metric>mid_91_182_costGdp_out</metric>
    <metric>mid_91_182_costTotalHealth_out</metric>
    <metric>mid_91_182_costTotalHealth_uk_out</metric>
    <metric>mid_91_182_costTotalTotal_out</metric>
    <metric>mid_91_182_costTotalTotal_uk_out</metric>
    <metric>mid_91_182_nmbLow_out</metric>
    <metric>mid_91_182_nmbMed_out</metric>
    <metric>mid_91_182_nmbHigh_out</metric>
    <metric>mid_91_182_nmbLow_uk_out</metric>
    <metric>mid_91_182_nmbMed_uk_out</metric>
    <metric>mid_91_182_nmbHigh_uk_out</metric>
    <metric>mid_91_182_nmbLowNoGdp_out</metric>
    <metric>mid_91_182_nmbMedNoGdp_out</metric>
    <metric>mid_91_182_nmbHighNoGdp_out</metric>
    <metric>mid_91_182_nmbLowNoGdp_uk_out</metric>
    <metric>mid_91_182_nmbMedNoGdp_uk_out</metric>
    <metric>mid_91_182_nmbHighNoGdp_uk_out</metric>
    <metric>mid_91_182_halyTotalAcute_out</metric>
    <metric>mid_91_182_halyTotalDeath_out</metric>
    <metric>mid_91_182_halyTotalDeath_uk_out</metric>
    <metric>mid_91_182_halyTotalLong_out</metric>
    <metric>mid_91_182_halyTotalTotal_out</metric>
    <metric>mid_91_182_halyTotalTotal_uk_out</metric>
    <metric>mid_91_182_totStage2_out</metric>
    <metric>mid_91_182_totStage3_out</metric>
    <metric>mid_91_182_totStage4_out</metric>
    <metric>mid_91_182_totStage5_out</metric>
    <metric>mid_91_182_totInfect_out</metric>
    <metric>mid_91_182_totSympt_out</metric>
    <metric>mid_91_182_totHosp_out</metric>
    <metric>mid_91_182_totIcu_out</metric>
    <metric>mid_91_182_totDeath_out</metric>
    <metric>mid_91_182_totHospTime_out</metric>
    <metric>mid_91_182_totIcuTime_out</metric>
    <metric>mid_91_182_hospDaysAbove500_out</metric>
    <metric>mid_91_182_hospDaysAbove750_out</metric>
    <metric>mid_91_182_hospDaysAbove1000_out</metric>
    <metric>mid_91_182_hospDaysAbove1250_out</metric>
    <metric>mid_91_182_hospDaysAbove1500_out</metric>
    <metric>mid_91_182_hospDaysAbove1750_out</metric>
    <metric>mid_91_182_hospDaysAbove2000_out</metric>
    <metric>mid_91_182_prevInfect0_out</metric>
    <metric>mid_91_182_prevInfect1_out</metric>
    <metric>mid_91_182_prevInfect2_out</metric>
    <metric>mid_91_182_prevInfect3_out</metric>
    <metric>mid_91_182_prevInfect4_out</metric>
    <metric>mid_91_182_prevInfect5_out</metric>
    <metric>mid_91_182_prevInfect6_out</metric>
    <metric>mid_91_182_prevInfect7_out</metric>
    <metric>mid_91_182_prevInfect8_out</metric>
    <metric>mid_91_182_totInfecterTime_out</metric>
    <metric>mid_91_182_generationTime_out</metric>
    <metric>mid_91_182_reffInfecters_out</metric>
    <metric>mid_91_182_reffInfectees_out</metric>
    <metric>mid_91_182_reff_out</metric>
    <metric>mid_91_182_halyTotalDeath_alt_out</metric>
    <metric>mid_91_182_halyTotalTotal_alt_out</metric>
    <metric>mid_91_182_nmbLowNoGdp_alt_out</metric>
    <metric>mid_91_182_nmbMedNoGdp_alt_out</metric>
    <metric>mid_91_182_nmbHighNoGdp_alt_out</metric>
    <metric>mid_91_182_nmbLow_alt_out</metric>
    <metric>mid_91_182_nmbMed_alt_out</metric>
    <metric>mid_91_182_nmbHigh_alt_out</metric>
    <enumeratedValueSet variable="draw_index">
      <value value="0"/>
      <value value="1"/>
      <value value="2"/>
      <value value="3"/>
      <value value="4"/>
      <value value="5"/>
      <value value="6"/>
      <value value="7"/>
      <value value="8"/>
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;TightSupress_No_4&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_pipeline">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avoid_essential">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_essential">
      <value value="&quot;Extreme&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vacincurmult">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_input">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_mask_param">
      <value value="&quot;Normal&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_param">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_trace">
      <value value="&quot;ass100_90at5&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cont_stage">
      <value value="3.25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="count_incursion">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="daily_infect_binom">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="data_suffix">
      <value value="&quot;.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="data_suffix_2">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="duration_skew">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="390"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_radius_anchor">
      <value value="8.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_spread_anchor">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="first_case_calibrate">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_loc_trans_red">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_distance_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hetro_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="house_init_group">
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="in_dose1">
      <value value="&quot;_1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="in_dose2">
      <value value="&quot;_60&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incur_timenow_limit">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incursion_phase_speed_mult">
      <value value="0.5"/>
      <value value="1"/>
      <value value="1.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_cases_region">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_metric_threshold">
      <value value="390"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_stage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_timenow_limit">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_trace_prop">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="3000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_primary_prop">
      <value value="0.26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_draws">
      <value value="&quot;input/vic&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_incursion_table">
      <value value="&quot;input/vic/incursion.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_population_table">
      <value value="&quot;input/vic/pop&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_region">
      <value value="&quot;input/vic/region.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_vac_params">
      <value value="&quot;input/vic/vaccine_params&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_vaccine_schedule">
      <value value="&quot;input/vic/rollout_both.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_variant">
      <value value="&quot;input/vic/variant.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isocomply_override">
      <value value="0.93"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wear_boost">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max_stage">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="midreport_day">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="min_stage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="minmaskwearing">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="override_asympt_table">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_force_vaccine">
      <value value="&quot;Disabled&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incur_phase_limit">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incurmult">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_override_ve">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_override_ve_area">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="always_spread">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_days">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_preset">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_stage">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_stage1_time">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trace_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake_mult">
      <value value="0.75"/>
      <value value="0.85"/>
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="pipe_end_override">
      <value value="&quot;off&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_pipe_time">
      <value value="105"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.66"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_switch">
      <value value="&quot;pak&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policyusehosp">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="pre_present_iso">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prepeak_vir_boost">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailycases">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailyhosp">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="print_contact_events">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="print_phase">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="print_vac">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rat_day_max">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rat_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="realnotcasethres">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.58"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recover_immunity_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reducedstagefour">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_cont_buffer">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_down_threshold">
      <value value="130"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_up_threshold">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="schoolsopen">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="self_iso_at_peak">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sensitivity">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set_shape">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sim_seed">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="site_iso_max_day">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="site_iso_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="slope_track_end">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="slope_track_start">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="success_14day_cases">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="suffix_rollout">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_assymtote">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_at_1">
      <value value="0.98"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_at_5">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_attempt_limit">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_calibration">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_eff_override">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_print">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_r">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_slope">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tracking">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transmit_skew">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_trans_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_enabled">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vactype_override">
      <value value="&quot;off&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="8.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="yearly_recover_prop_loss">
      <value value="0"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="vic_no_report" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <enumeratedValueSet variable="draw_index">
      <value value="0"/>
      <value value="1"/>
      <value value="2"/>
      <value value="3"/>
      <value value="4"/>
      <value value="5"/>
      <value value="6"/>
      <value value="7"/>
      <value value="8"/>
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;TightSupress_No_4&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_pipeline">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avoid_essential">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_essential">
      <value value="&quot;Extreme&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vacincurmult">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_input">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_mask_param">
      <value value="&quot;Normal&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_param">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_trace">
      <value value="&quot;ass100_90at5&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cont_stage">
      <value value="3.25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="count_incursion">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="daily_infect_binom">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="data_suffix">
      <value value="&quot;.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="data_suffix_2">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="duration_skew">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="390"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_radius_anchor">
      <value value="8.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_spread_anchor">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="first_case_calibrate">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_loc_trans_red">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_distance_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hetro_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="house_init_group">
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="in_dose1">
      <value value="&quot;_1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="in_dose2">
      <value value="&quot;_60&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incur_timenow_limit">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incursion_phase_speed_mult">
      <value value="0.5"/>
      <value value="1"/>
      <value value="1.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_cases_region">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_metric_threshold">
      <value value="390"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_stage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_timenow_limit">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_trace_prop">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="3000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_primary_prop">
      <value value="0.26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_draws">
      <value value="&quot;input/vic&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_incursion_table">
      <value value="&quot;input/vic/incursion.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_population_table">
      <value value="&quot;input/vic/pop&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_region">
      <value value="&quot;input/vic/region.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_vac_params">
      <value value="&quot;input/vic/vaccine_params&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_vaccine_schedule">
      <value value="&quot;input/vic/rollout_both.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_variant">
      <value value="&quot;input/vic/variant.csv&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isocomply_override">
      <value value="0.93"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wear_boost">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max_stage">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="midreport_day">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="min_stage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="minmaskwearing">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="override_asympt_table">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_force_vaccine">
      <value value="&quot;Disabled&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incur_phase_limit">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incurmult">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_override_ve">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_override_ve_area">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="always_spread">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_days">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_preset">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_stage">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_stage1_time">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trace_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake_mult">
      <value value="0.75"/>
      <value value="0.85"/>
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="pipe_end_override">
      <value value="&quot;off&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_pipe_time">
      <value value="105"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.66"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_switch">
      <value value="&quot;pak&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policyusehosp">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="pre_present_iso">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prepeak_vir_boost">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailycases">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailyhosp">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="print_contact_events">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="print_phase">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="print_vac">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rat_day_max">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rat_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="realnotcasethres">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.58"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recover_immunity_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reducedstagefour">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_cont_buffer">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_down_threshold">
      <value value="130"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_up_threshold">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="schoolsopen">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="self_iso_at_peak">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sensitivity">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set_shape">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sim_seed">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="site_iso_max_day">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="site_iso_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="slope_track_end">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="slope_track_start">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="success_14day_cases">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="suffix_rollout">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_assymtote">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_at_1">
      <value value="0.98"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_at_5">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_attempt_limit">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_calibration">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_eff_override">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trace_print">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_r">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_slope">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tracking">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transmit_skew">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_trans_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_enabled">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vactype_override">
      <value value="&quot;off&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="8.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="yearly_recover_prop_loss">
      <value value="0"/>
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

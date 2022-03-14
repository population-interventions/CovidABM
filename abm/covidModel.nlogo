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
  "hacks.nls"
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
2867
875
2969
910
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
2974
875
3074
909
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

PLOT
3112
917
3524
1091
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
3324
838
3473
895
Deaths
Deathcount
0
1
14

MONITOR
2743
352
2898
409
# simuls
count simuls * (Total_Population / population)
0
1
14

MONITOR
2742
183
2911
240
Total # Infected
cumulativeInfected
0
1
14

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

MONITOR
17
830
166
887
% Total Infections
cumulativeInfected / Total_Population * 100
2
1
14

MONITOR
3379
500
3509
545
Case Fatality Rate %
caseFatalityRate * 100
2
1
11

PLOT
3277
694
3505
824
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

MONITOR
2638
722
2697
767
R0
mean [ R ] of simuls with [ color = red and timenow = int Illness_Period ]
2
1
11

PLOT
2345
718
2752
840
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
2149
195
2417
344
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
2964
688
3096
733
Infection Growth %
infectionchange
2
1
11

INPUTBOX
239
200
373
263
initial_cases
1000.0
1
0
Number

INPUTBOX
228
375
335
437
total_population
2.34E8
1
0
Number

MONITOR
1039
309
1211
354
Close contacts per day
AverageContacts
2
1
11

PLOT
1833
27
2098
194
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
"pen-1" 1.0 0 -13840069 true "" "histogram [ agerange ] of simuls with [ selfVaccEff_raw_infect > 0 ]"
"pen-2" 1.0 0 -2674135 true "" "histogram [ agerange ] of simuls with [ color = red ]"

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

MONITOR
1480
550
1605
599
New Infections
(globalPopPerSimul * (count simuls with [ color = red and timenow = 1 ]))
0
1
12

PLOT
1039
489
1456
609
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

SLIDER
1672
17
1806
50
Age_Isolation
Age_Isolation
0
100
0.0
1
1
NIL
HORIZONTAL

MONITOR
1753
993
1855
1038
Red (raw)
count simuls with [ color = red ]
0
1
11

SWITCH
1477
800
1580
833
scale
scale
0
1
-1000

MONITOR
773
14
838
59
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
3573
682
3653
727
NIL
count simuls
17
1
11

MONITOR
3623
562
3737
607
Potential contacts
PotentialContacts
0
1
11

PLOT
2150
28
2439
190
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

PLOT
2442
42
2682
167
Dist_Incubation_Pd
NIL
NIL
0.0
15.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "" "histogram [ ownIncubationPeriod ] of simuls"

MONITOR
1535
715
1600
760
Virulence
mean [ personalvirulence] of simuls
1
1
11

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
2445
185
2725
333
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
3379
452
3511
497
EW Infection %
EWInfections / Population
1
1
11

MONITOR
3514
503
3647
548
Student Infections %
studentInfections / Population
1
1
11

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
568
998
768
1031
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

MONITOR
3034
917
3089
962
Average Illness time
mean [ timenow ] of simuls with [ color = red ]
1
1
11

PLOT
1039
355
1459
487
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
614
1459
739
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
1754
1040
1854
1085
Yellow (raw)
count simuls with [ color = yellow ]
0
1
11

MONITOR
3384
353
3457
398
Time = 1 
count simuls with [ timenow = 2 ]
0
1
11

MONITOR
3623
612
3688
657
Students
count simuls with [ isStudent ]
0
1
11

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
12
382
181
415
Vaccine_Available
Vaccine_Available
1
1
-1000

MONITOR
1223
13
1292
58
Vac1 %
( count simuls with [ agerange > 15 and selfVaccEff_raw_risk > 0 or vacEffectCountdown > 0 ]) / (count simuls with [agerange > 15] + 0.25 * count simuls with [agerange = 15]) * 100
2
1
11

SLIDER
13
15
296
48
RAND_SEED
RAND_SEED
0
10000000
6462264.0
1
1
NIL
HORIZONTAL

MONITOR
1404
13
1477
58
Vaccinated
count simuls with [ selfVaccEff_raw_risk > 0 ]
17
1
11

PLOT
1218
63
1477
201
Vaccinated AZ
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
"1st Administered" 1.0 0 -16777216 true "" "plot count simuls with [doseCount > 0] / 25"
"1st Effective" 1.0 0 -14439633 true "" "plot count simuls with [doseCount > 1] / 25"
"2nd Administered" 1.0 0 -2674135 true "" "plot count simuls with [doseCount > 2] / 25"

MONITOR
1480
130
1617
175
NIL
spatial_distance
17
1
11

MONITOR
1480
178
1614
223
NIL
case_isolation
17
1
11

MONITOR
1484
228
1617
273
NIL
quarantine
17
1
11

MONITOR
1040
260
1212
305
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
3525
798
3622
843
Interaction Infectivity
transmission_average
6
1
11

MONITOR
3640
748
3720
793
Virulent Interactions
transmission_count_metric
17
1
11

PLOT
2964
504
3371
678
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
1859
697
2331
877
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
568
920
767
953
Asymptom_Trace_Mult
Asymptom_Trace_Mult
0
1
0.66
0.01
1
NIL
HORIZONTAL

PLOT
2964
352
3372
502
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
3630
794
3723
839
Expected New Cases
transmission_count_metric * transmission_average
6
1
11

PLOT
1865
887
2334
1081
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
2722
590
2930
623
Gather_Location_Count
Gather_Location_Count
0
1000
200.0
50
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

PLOT
2698
48
2977
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
3633
844
3722
889
Real New Cases
new_case_real
17
1
11

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
3473
97
3580
130
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
2533
395
2731
428
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
1477
362
1617
407
NIL
floor (policymetric7 / 7)
17
1
11

PLOT
1832
200
2105
320
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
2738
180
3017
340
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
12
652
162
709
Total Infected
cumulativeInfected
0
1
14

MONITOR
17
890
172
947
% Living Recovered
recoverProportion * 100
2
1
14

SLIDER
568
882
770
915
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

MONITOR
1497
499
1602
544
NIL
policyTriggerScale
17
1
11

SLIDER
1039
57
1212
90
End_R_Reported
End_R_Reported
-1
100
-1.0
1
1
NIL
HORIZONTAL

MONITOR
1628
529
1731
574
slopeAverage %
slopeAverage * 100
3
1
11

PLOT
1620
658
1827
778
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

MONITOR
3523
844
3626
889
Tracked Infection %
100 * (count simuls with [color = red and tracked = 1]) / (count simuls with [color = red])
2
1
11

SLIDER
15
1010
205
1043
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
18
1050
318
1083
stage_test_index
stage_test_index
0
70
0.0
1
1
NIL
HORIZONTAL

SLIDER
567
772
740
805
sympt_present_prop
sympt_present_prop
0
1
0.6125933763356122
0.01
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
2533
435
2733
468
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
2533
508
2730
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
2533
473
2731
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
1734
622
1849
655
track_slope
track_slope
0
1
-1000

SLIDER
10
290
185
323
param_vac_rate_mult
param_vac_rate_mult
0
3
1.0
0.05
1
NIL
HORIZONTAL

SLIDER
1998
654
2201
687
param_recovered_prop
param_recovered_prop
0
1
0.45
0.05
1
NIL
HORIZONTAL

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
2597
932
2806
965
yearly_recover_prop_loss
yearly_recover_prop_loss
0
0.999
0.0
0.01
1
NIL
HORIZONTAL

MONITOR
177
818
277
863
% Yellow
100 * (count simuls with [color = yellow]) / Population
2
1
11

MONITOR
177
865
279
910
% Red First
100 * (count simuls with [color = red and infectVariant = \"alpha\"]) / Population
2
1
11

MONITOR
175
912
277
957
% Red Second
100 * (count simuls with [color = red and infectVariant = \"beta\"]) / Population
2
1
11

SLIDER
3454
279
3652
312
Recov_Var_Match_Rate
Recov_Var_Match_Rate
0
1
0.0
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
3545
748
3635
793
Incursion Var
incursionPhaseEndDay
17
1
11

MONITOR
175
962
277
1007
% Yellow Third
100 * (count simuls with [color = yellow and recoveryVariant = 3]) / Population
17
1
11

SLIDER
2598
974
2798
1007
complacency_loss
complacency_loss
0
1
1.0
0.1
1
NIL
HORIZONTAL

MONITOR
1650
379
1793
424
NIL
average_R_all_regions
4
1
11

SLIDER
10
168
187
201
param_final_phase
param_final_phase
-1
10
3.0
1
1
NIL
HORIZONTAL

SLIDER
14
54
189
87
param_incur_phase_limit
param_incur_phase_limit
-1
10
0.0
1
1
NIL
HORIZONTAL

SLIDER
1268
1029
1441
1062
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
1043
213
1216
258
Case report %
100 * (count simuls with [ color = red and tracked = 1 and caseReportTime <= ticks and report_case_draw < report_proportion]) / (count simuls with [ color = red ])
2
1
11

SLIDER
2533
545
2726
578
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
568
845
767
878
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
213
1010
317
1043
calibrate
calibrate
1
1
-1000

MONITOR
1752
944
1854
989
NIL
extraScaleFactor
3
1
11

SLIDER
228
335
377
368
initial_primary_prop
initial_primary_prop
0
1
0.66
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
13
93
187
126
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
2339
560
2512
593
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
2339
630
2512
663
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
364
695
549
728
R0_range
R0_range
-1
10
6.5
0.5
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
3112
875
3315
908
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
2522
357
2729
390
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

CHOOSER
1468
1042
1601
1087
param_force_vaccine
param_force_vaccine
"Disabled" "AZ" "Pfizer"
0

SLIDER
3109
838
3316
871
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
565
735
755
768
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
1856
406
2071
466
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
8
253
198
286
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

INPUTBOX
1856
537
2048
597
input_dose_rate_table
input/vic/dose_rate
1
0
String

PLOT
1224
208
1479
352
Vaccinated Pfizer
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
"default" 1.0 0 -16777216 true "" "plot count simuls with [ (selfVaccEff_raw_risk > 0 or vacEffectCountdown > 0) and vaccBranch = \"P\"] / 25"
"pen-1" 1.0 0 -14439633 true "" "plot count simuls with [ selfVaccEff_raw_risk > 0 and vaccBranch = \"P\" and doseCount >= 2] / 25"
"pen-3" 1.0 0 -2674135 true "" "plot count simuls with [ selfVaccEff_raw_risk > 0 and vaccBranch = \"P\" and doseCount >= 2 and vacEffectCountdown = 0] / 25"
"pen-4" 1.0 0 -14070903 true "" "plot count simuls with [ (selfVaccEff_raw_risk > 0) and vaccBranch = \"P\"] / 25"

MONITOR
1742
530
1851
575
NIL
initial_infection_R
17
1
11

SWITCH
203
680
356
713
first_case_calibrate
first_case_calibrate
1
1
-1000

SLIDER
2742
413
2942
446
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
1857
601
2029
646
data_suffix
data_suffix
"_bau.csv" "_int.csv" "_az_25.csv" "_az_50.csv" "_az_25_95.csv" "_az_25_90.csv" "_az_25_80.csv" "_az_25_70.csv" "_70" "_80" "_90" "_95" ".csv"
12

SLIDER
568
958
767
991
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
230
642
349
675
print_phase
print_phase
1
1
-1000

SWITCH
230
604
348
637
print_vac
print_vac
1
1
-1000

SLIDER
1259
993
1461
1026
house_init_group
house_init_group
0
1
0.0
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
2339
595
2512
628
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
2532
583
2705
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
2340
488
2513
521
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
2340
525
2513
558
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
2342
405
2515
450
compound_trace
compound_trace
"None" "ass50_70at5" "ass100_90at5" "ass100_90at5_iso" "ass200_90at5"
2

SLIDER
2533
620
2706
653
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
2532
658
2705
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
2340
453
2513
486
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
2343
368
2457
401
trace_print
trace_print
1
1
-1000

CHOOSER
1856
648
1994
693
data_suffix_2
data_suffix_2
"None" "_5.csv" "_12.csv"
0

CHOOSER
10
205
148
250
policy_switch
policy_switch
"tony" "nz" "pak" "continuous"
2

SWITCH
2033
603
2161
636
suffix_rollout
suffix_rollout
0
1
-1000

SWITCH
1707
583
1845
616
count_incursion
count_incursion
1
1
-1000

SLIDER
2723
630
2931
663
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
2723
668
2930
701
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
2827
837
2999
870
print_contact_events
print_contact_events
1
1
-1000

SLIDER
1622
623
1732
656
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
1855
340
2070
400
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
567
808
740
841
sympt_present_mult
sympt_present_mult
0
1
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
1597
863
1776
896
Scale_Up_Threshold
Scale_Up_Threshold
0
200
120.0
1
1
NIL
HORIZONTAL

SLIDER
1597
900
1776
933
Scale_Down_Threshold
Scale_Down_Threshold
0
200
90.0
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
1595
975
1749
1008
scale_up_limit
scale_up_limit
0
1
0.9
0.01
1
NIL
HORIZONTAL

SLIDER
1620
783
1793
816
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
1620
820
1793
853
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
12000
240.0
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
1.0
0.1
1
NIL
HORIZONTAL

MONITOR
963
14
1031
59
NIL
start_day
17
1
11

SWITCH
563
697
673
730
precise_R0
precise_R0
0
1
-1000

MONITOR
1303
13
1371
58
Vac2 %
( count simuls with [ agerange > 15 and doseCount >= 2 ] / ((count simuls with [agerange > 15] + 0.25 * count simuls with [agerange = 15]) )) * 100
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
1
1
-1000

SLIDER
838
750
1021
783
vac_restrict_ease_day
vac_restrict_ease_day
-1
200
77.0
1
1
NIL
HORIZONTAL

SLIDER
834
825
1017
858
vac_ease_avoid
vac_ease_avoid
0
100
30.0
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
834
900
1021
933
vac_ease_span
vac_ease_span
0
20
10.0
1
1
NIL
HORIZONTAL

SLIDER
834
938
1022
971
vac_ease_visit_rad
vac_ease_visit_rad
0
20
8.8
0.1
1
NIL
HORIZONTAL

SLIDER
834
975
1021
1008
vac_ease_spread
vac_ease_spread
0
0.5
0.08
0.01
1
NIL
HORIZONTAL

SWITCH
834
1047
1022
1080
vac_ease_schools_open
vac_ease_schools_open
0
1
-1000

SLIDER
818
863
1028
896
vac_ease_avoid_compBound
vac_ease_avoid_compBound
0
100
15.0
5
1
NIL
HORIZONTAL

MONITOR
850
13
957
58
NIL
Days - start_day
17
1
11

CHOOSER
890
699
1022
744
vac_ease_stage
vac_ease_stage
"off" "None" "1b" "2a_mask3a" "1b_mask2a"
2

SLIDER
834
1010
1023
1043
vac_ease_mask_wear
vac_ease_mask_wear
0
100
35.0
10
1
NIL
HORIZONTAL

SWITCH
720
697
884
730
vac_ease_everyone
vac_ease_everyone
0
1
-1000

SLIDER
13
130
162
163
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
2143
363
2336
423
input_region
input/vic/region.csv
1
0
String

INPUTBOX
2143
428
2337
488
input_vac_params
input/vic/vaccine_params.csv
1
0
String

MONITOR
1650
429
1790
474
NIL
table:get average_R 1
4
1
11

MONITOR
1650
475
1790
520
NIL
table:get average_R 2
4
1
11

INPUTBOX
1858
473
2073
533
input_vac_branch
input/vic/vac_branch
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

SLIDER
2342
668
2515
701
exposureSymptMult
exposureSymptMult
0
1
0.6486482613794431
0.1
1
NIL
HORIZONTAL

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

SLIDER
363
887
553
920
reinfect_delay_base
reinfect_delay_base
0
28
0.0
1
1
NIL
HORIZONTAL

INPUTBOX
2052
538
2106
598
in_dose1
_1
1
0
String

INPUTBOX
2110
538
2163
598
in_dose2
_60
1
0
String

MONITOR
12
709
200
766
NIL
recoverCount
0
1
14

INPUTBOX
2177
492
2336
552
input_variant
input/vic/variant.csv
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
  <experiment name="vic_rcalc" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>average_R_all_regions</metric>
    <metric>global_transmissibility</metric>
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
    <metric>atsi_listOut</metric>
    <metric>morbid_listOut</metric>
    <metric>casesinperiod7_min</metric>
    <metric>pre_stop_day</metric>
    <metric>casesinperiod7_switchTime</metric>
    <metric>cumulativeInfected_switchTime</metric>
    <metric>cumulativeInfected_minusInit</metric>
    <enumeratedValueSet variable="rand_seed">
      <value value="3977066"/>
      <value value="9928349"/>
      <value value="3256359"/>
      <value value="8720661"/>
      <value value="7550227"/>
      <value value="3640192"/>
      <value value="4848914"/>
      <value value="7065218"/>
      <value value="2541564"/>
      <value value="3852283"/>
      <value value="3852733"/>
      <value value="6469388"/>
      <value value="2320827"/>
      <value value="5079808"/>
      <value value="2091411"/>
      <value value="6711599"/>
      <value value="6426687"/>
      <value value="3966566"/>
      <value value="8635168"/>
      <value value="3479526"/>
      <value value="3678647"/>
      <value value="2079922"/>
      <value value="1066628"/>
      <value value="4341097"/>
      <value value="317595"/>
      <value value="8379190"/>
      <value value="5285031"/>
      <value value="3831389"/>
      <value value="5842060"/>
      <value value="7351418"/>
      <value value="7787219"/>
      <value value="2043750"/>
      <value value="9399408"/>
      <value value="1829671"/>
      <value value="8246308"/>
      <value value="9855903"/>
      <value value="1044748"/>
      <value value="3289065"/>
      <value value="9557834"/>
      <value value="8620590"/>
      <value value="9206069"/>
      <value value="1733550"/>
      <value value="2759494"/>
      <value value="210967"/>
      <value value="9680785"/>
      <value value="9393125"/>
      <value value="2693532"/>
      <value value="740512"/>
      <value value="5750426"/>
      <value value="9319928"/>
      <value value="1807150"/>
      <value value="3057297"/>
      <value value="4190158"/>
      <value value="6388119"/>
      <value value="2107179"/>
      <value value="4848401"/>
      <value value="3485688"/>
      <value value="6255006"/>
      <value value="3661414"/>
      <value value="9732522"/>
      <value value="9928773"/>
      <value value="3934019"/>
      <value value="5796408"/>
      <value value="8164200"/>
      <value value="4943673"/>
      <value value="8772343"/>
      <value value="1711005"/>
      <value value="9281346"/>
      <value value="656411"/>
      <value value="7970321"/>
      <value value="7886719"/>
      <value value="8149116"/>
      <value value="7815734"/>
      <value value="417995"/>
      <value value="2423433"/>
      <value value="6533126"/>
      <value value="1963805"/>
      <value value="4599362"/>
      <value value="544767"/>
      <value value="4530920"/>
      <value value="6665494"/>
      <value value="9601273"/>
      <value value="6301204"/>
      <value value="3763938"/>
      <value value="4181275"/>
      <value value="4739262"/>
      <value value="1978843"/>
      <value value="23805"/>
      <value value="2346756"/>
      <value value="8512095"/>
      <value value="6756271"/>
      <value value="9748257"/>
      <value value="9405997"/>
      <value value="707841"/>
      <value value="1865598"/>
      <value value="4906833"/>
      <value value="4057604"/>
      <value value="8134314"/>
      <value value="3478586"/>
      <value value="994852"/>
      <value value="821037"/>
      <value value="1600746"/>
      <value value="9415554"/>
      <value value="956713"/>
      <value value="1784228"/>
      <value value="7182622"/>
      <value value="2413483"/>
      <value value="7802174"/>
      <value value="6386506"/>
      <value value="9295089"/>
      <value value="4199743"/>
      <value value="8889315"/>
      <value value="2732733"/>
      <value value="2223075"/>
      <value value="2412841"/>
      <value value="2079390"/>
      <value value="9321556"/>
      <value value="5099043"/>
      <value value="9546432"/>
      <value value="5354423"/>
      <value value="8370479"/>
      <value value="5863616"/>
      <value value="9816500"/>
      <value value="519033"/>
      <value value="2913945"/>
      <value value="7965469"/>
      <value value="2241682"/>
      <value value="7801520"/>
      <value value="4633249"/>
      <value value="5380073"/>
      <value value="7915492"/>
      <value value="2053340"/>
      <value value="157424"/>
      <value value="8749000"/>
      <value value="9064329"/>
      <value value="1778234"/>
      <value value="2214673"/>
      <value value="8923695"/>
      <value value="7432268"/>
      <value value="7100589"/>
      <value value="5798326"/>
      <value value="9022767"/>
      <value value="7047478"/>
      <value value="6665737"/>
      <value value="834745"/>
      <value value="6628545"/>
      <value value="2398619"/>
      <value value="8496233"/>
      <value value="9644237"/>
      <value value="1890904"/>
      <value value="4565551"/>
      <value value="2132755"/>
      <value value="7131754"/>
      <value value="7531523"/>
      <value value="4887340"/>
      <value value="619419"/>
      <value value="1973296"/>
      <value value="4934717"/>
      <value value="313268"/>
      <value value="5765134"/>
      <value value="659719"/>
      <value value="9252155"/>
      <value value="6222021"/>
      <value value="5874750"/>
      <value value="5486903"/>
      <value value="4221531"/>
      <value value="2820444"/>
      <value value="7893376"/>
      <value value="6600034"/>
      <value value="4864079"/>
      <value value="354788"/>
      <value value="3240923"/>
      <value value="1902262"/>
      <value value="77612"/>
      <value value="326269"/>
      <value value="9980302"/>
      <value value="2939851"/>
      <value value="102070"/>
      <value value="8300906"/>
      <value value="6570837"/>
      <value value="4995017"/>
      <value value="5513140"/>
      <value value="5460665"/>
      <value value="7005416"/>
      <value value="1209623"/>
      <value value="9743030"/>
      <value value="3939504"/>
      <value value="8142490"/>
      <value value="7986681"/>
      <value value="5076303"/>
      <value value="1778676"/>
      <value value="901138"/>
      <value value="9644841"/>
      <value value="987462"/>
      <value value="4591905"/>
      <value value="8852561"/>
      <value value="8537862"/>
      <value value="5358335"/>
      <value value="9738575"/>
      <value value="8954056"/>
      <value value="4013015"/>
      <value value="541908"/>
      <value value="4757455"/>
      <value value="3162936"/>
      <value value="8112076"/>
      <value value="3722099"/>
      <value value="3493087"/>
      <value value="4345080"/>
      <value value="5597527"/>
      <value value="3144688"/>
      <value value="3000361"/>
      <value value="6561967"/>
      <value value="2690884"/>
      <value value="7176534"/>
      <value value="4425288"/>
      <value value="3050815"/>
      <value value="7255389"/>
      <value value="1000193"/>
      <value value="1714089"/>
      <value value="8409102"/>
      <value value="7901962"/>
      <value value="1962637"/>
      <value value="1286010"/>
      <value value="2649301"/>
      <value value="4956462"/>
      <value value="5821352"/>
      <value value="4767985"/>
      <value value="8325408"/>
      <value value="2315281"/>
      <value value="4341029"/>
      <value value="336959"/>
      <value value="5857006"/>
      <value value="9682216"/>
      <value value="8326459"/>
      <value value="70156"/>
      <value value="8703293"/>
      <value value="3610453"/>
      <value value="8572112"/>
      <value value="4368726"/>
      <value value="2326544"/>
      <value value="9429134"/>
      <value value="142128"/>
      <value value="6761655"/>
      <value value="4827347"/>
      <value value="6704401"/>
      <value value="1774054"/>
      <value value="6673721"/>
      <value value="771495"/>
      <value value="7266626"/>
      <value value="8278425"/>
      <value value="6714854"/>
      <value value="2138024"/>
      <value value="3442941"/>
      <value value="8957254"/>
      <value value="4728992"/>
      <value value="9610864"/>
      <value value="6662393"/>
      <value value="7076403"/>
      <value value="6690574"/>
      <value value="714599"/>
      <value value="7838378"/>
      <value value="4604279"/>
      <value value="1706669"/>
      <value value="3479657"/>
      <value value="6928512"/>
      <value value="5923409"/>
      <value value="240836"/>
      <value value="3414462"/>
      <value value="6064109"/>
      <value value="3598041"/>
      <value value="312133"/>
      <value value="7154483"/>
      <value value="6223538"/>
      <value value="6010661"/>
      <value value="7276179"/>
      <value value="6933956"/>
      <value value="6558826"/>
      <value value="4154563"/>
      <value value="2660350"/>
      <value value="1351066"/>
      <value value="3586726"/>
      <value value="2623703"/>
      <value value="6564440"/>
      <value value="3971417"/>
      <value value="7352544"/>
      <value value="5933378"/>
      <value value="1583556"/>
      <value value="435426"/>
      <value value="3834070"/>
      <value value="4510800"/>
      <value value="8108773"/>
      <value value="8353540"/>
      <value value="1074598"/>
      <value value="5046285"/>
      <value value="5487895"/>
      <value value="7729071"/>
      <value value="7992174"/>
      <value value="5673950"/>
      <value value="8932016"/>
      <value value="5687086"/>
      <value value="6312747"/>
      <value value="608416"/>
      <value value="644153"/>
      <value value="5180170"/>
      <value value="2037363"/>
      <value value="8892433"/>
      <value value="873526"/>
      <value value="3649463"/>
      <value value="8894108"/>
      <value value="837712"/>
      <value value="246792"/>
      <value value="7454736"/>
      <value value="7974590"/>
      <value value="2162152"/>
      <value value="4582729"/>
      <value value="7489021"/>
      <value value="8968261"/>
      <value value="9442293"/>
      <value value="5689228"/>
      <value value="6097459"/>
      <value value="7000902"/>
      <value value="8329092"/>
      <value value="6346434"/>
      <value value="1412382"/>
      <value value="3390081"/>
      <value value="4388823"/>
      <value value="9320896"/>
      <value value="3079366"/>
      <value value="834088"/>
      <value value="8363457"/>
      <value value="3085793"/>
      <value value="5107544"/>
      <value value="4347549"/>
      <value value="8091571"/>
      <value value="9514898"/>
      <value value="3810556"/>
      <value value="1089871"/>
      <value value="5365325"/>
      <value value="7801762"/>
      <value value="8754336"/>
      <value value="1265725"/>
      <value value="5781610"/>
      <value value="902157"/>
      <value value="8674328"/>
      <value value="687704"/>
      <value value="4694329"/>
      <value value="131429"/>
      <value value="2164411"/>
      <value value="4982168"/>
      <value value="4405188"/>
      <value value="7100934"/>
      <value value="7113223"/>
      <value value="6101295"/>
      <value value="2175848"/>
      <value value="6741177"/>
      <value value="4874540"/>
      <value value="6765461"/>
      <value value="6067085"/>
      <value value="2067823"/>
      <value value="5735081"/>
      <value value="9037942"/>
      <value value="3077921"/>
      <value value="6460992"/>
      <value value="6548891"/>
      <value value="4891397"/>
      <value value="5997307"/>
      <value value="327291"/>
      <value value="9965395"/>
      <value value="1817693"/>
      <value value="421156"/>
      <value value="6667694"/>
      <value value="6636256"/>
      <value value="1773192"/>
      <value value="1757716"/>
      <value value="5459410"/>
      <value value="2433030"/>
      <value value="3606124"/>
      <value value="678980"/>
      <value value="6185071"/>
      <value value="1637691"/>
      <value value="7098551"/>
      <value value="2597943"/>
      <value value="5105400"/>
      <value value="2379999"/>
      <value value="3201478"/>
      <value value="5594007"/>
      <value value="502535"/>
      <value value="908103"/>
      <value value="183575"/>
      <value value="7673874"/>
      <value value="6672836"/>
      <value value="373002"/>
      <value value="605795"/>
      <value value="4184546"/>
      <value value="8498833"/>
      <value value="7112089"/>
      <value value="1461335"/>
      <value value="4067441"/>
      <value value="3635773"/>
      <value value="2376718"/>
      <value value="6822060"/>
      <value value="173640"/>
      <value value="196582"/>
      <value value="9426723"/>
      <value value="8401888"/>
      <value value="6215021"/>
      <value value="6955918"/>
      <value value="5681776"/>
      <value value="2825972"/>
      <value value="1978804"/>
      <value value="4895762"/>
      <value value="6308551"/>
      <value value="2935981"/>
      <value value="4279786"/>
      <value value="1808774"/>
      <value value="3240954"/>
      <value value="6044747"/>
      <value value="7588844"/>
      <value value="9569097"/>
      <value value="4105816"/>
      <value value="4382240"/>
      <value value="2134111"/>
      <value value="115567"/>
      <value value="6968882"/>
      <value value="4637050"/>
      <value value="2597607"/>
      <value value="8698346"/>
      <value value="7359710"/>
      <value value="6877479"/>
      <value value="140860"/>
      <value value="7377489"/>
      <value value="7388312"/>
      <value value="87220"/>
      <value value="8535998"/>
      <value value="993946"/>
      <value value="7798606"/>
      <value value="5382829"/>
      <value value="6531483"/>
      <value value="6660874"/>
      <value value="3029401"/>
      <value value="3593040"/>
      <value value="4329223"/>
      <value value="278501"/>
      <value value="72824"/>
      <value value="1912915"/>
      <value value="8175225"/>
      <value value="3074012"/>
      <value value="5007770"/>
      <value value="4900158"/>
      <value value="1076218"/>
      <value value="6061559"/>
      <value value="3493011"/>
      <value value="3517217"/>
      <value value="4415652"/>
      <value value="6523240"/>
      <value value="6054185"/>
      <value value="4139678"/>
      <value value="192885"/>
      <value value="5309954"/>
      <value value="7345220"/>
      <value value="8629011"/>
      <value value="9950521"/>
      <value value="6587026"/>
      <value value="7441064"/>
      <value value="235498"/>
      <value value="8448925"/>
      <value value="539998"/>
      <value value="8516067"/>
      <value value="1510076"/>
      <value value="6117559"/>
      <value value="5992440"/>
      <value value="2095387"/>
      <value value="2544297"/>
      <value value="2584674"/>
      <value value="8673114"/>
      <value value="1948886"/>
      <value value="6157833"/>
      <value value="5179777"/>
      <value value="6564508"/>
      <value value="2570765"/>
      <value value="441032"/>
      <value value="1897327"/>
      <value value="8785215"/>
      <value value="6907225"/>
      <value value="729043"/>
      <value value="6865808"/>
      <value value="8712438"/>
      <value value="2472184"/>
      <value value="9460404"/>
      <value value="5996585"/>
      <value value="9928110"/>
      <value value="4292948"/>
      <value value="2310922"/>
      <value value="6111553"/>
      <value value="3521645"/>
      <value value="4205312"/>
      <value value="9483771"/>
      <value value="8785162"/>
      <value value="3067524"/>
      <value value="7499734"/>
      <value value="6008362"/>
      <value value="4139875"/>
      <value value="3242669"/>
      <value value="1346124"/>
      <value value="4980191"/>
      <value value="7321910"/>
      <value value="1642007"/>
      <value value="4918687"/>
      <value value="5238351"/>
      <value value="6983450"/>
      <value value="9000955"/>
      <value value="5825032"/>
      <value value="2340359"/>
      <value value="6246013"/>
      <value value="2257413"/>
      <value value="8127635"/>
      <value value="9291377"/>
      <value value="3045838"/>
      <value value="297503"/>
      <value value="641937"/>
      <value value="3326803"/>
      <value value="4700194"/>
      <value value="5079882"/>
      <value value="1106115"/>
      <value value="3889048"/>
      <value value="3066952"/>
      <value value="2515663"/>
      <value value="3932361"/>
      <value value="8539908"/>
      <value value="4650547"/>
      <value value="9185909"/>
      <value value="9432140"/>
      <value value="3674195"/>
      <value value="4826556"/>
      <value value="9698091"/>
      <value value="9613186"/>
      <value value="5261700"/>
      <value value="4426970"/>
      <value value="3437739"/>
      <value value="8764565"/>
      <value value="7540782"/>
      <value value="950097"/>
      <value value="5002780"/>
      <value value="3079817"/>
      <value value="3132975"/>
      <value value="1487746"/>
      <value value="755064"/>
      <value value="4712675"/>
      <value value="2654024"/>
      <value value="6692160"/>
      <value value="952227"/>
      <value value="9329359"/>
      <value value="4130988"/>
      <value value="5142440"/>
      <value value="9545959"/>
      <value value="6008476"/>
      <value value="9710555"/>
      <value value="3844998"/>
      <value value="4772447"/>
      <value value="1583383"/>
      <value value="6127089"/>
      <value value="3343413"/>
      <value value="5786028"/>
      <value value="1817734"/>
      <value value="3727519"/>
      <value value="2301348"/>
      <value value="7960164"/>
      <value value="2479504"/>
      <value value="8434717"/>
      <value value="3724264"/>
      <value value="695122"/>
      <value value="1659724"/>
      <value value="9114881"/>
      <value value="2458638"/>
      <value value="3741219"/>
      <value value="3132383"/>
      <value value="3090383"/>
      <value value="6091111"/>
      <value value="7522313"/>
      <value value="9389498"/>
      <value value="6900472"/>
      <value value="4946276"/>
      <value value="2485081"/>
      <value value="9987249"/>
      <value value="770207"/>
      <value value="3358957"/>
      <value value="4456766"/>
      <value value="5691070"/>
      <value value="5238447"/>
      <value value="9548783"/>
      <value value="3548630"/>
      <value value="4202992"/>
      <value value="2731838"/>
      <value value="6938797"/>
      <value value="5133742"/>
      <value value="1299027"/>
      <value value="53517"/>
      <value value="7735565"/>
      <value value="9317528"/>
      <value value="6859177"/>
      <value value="1849265"/>
      <value value="8552333"/>
      <value value="4223834"/>
      <value value="5080387"/>
      <value value="1240018"/>
      <value value="3423297"/>
      <value value="9433271"/>
      <value value="6583438"/>
      <value value="7841312"/>
      <value value="502162"/>
      <value value="1268218"/>
      <value value="9951914"/>
      <value value="7802810"/>
      <value value="301814"/>
      <value value="6001526"/>
      <value value="7344284"/>
      <value value="9499037"/>
      <value value="1769954"/>
      <value value="6659911"/>
      <value value="9470516"/>
      <value value="3195943"/>
      <value value="2081457"/>
      <value value="8317019"/>
      <value value="1868201"/>
      <value value="1888063"/>
      <value value="8885335"/>
      <value value="6141588"/>
      <value value="9912992"/>
      <value value="642423"/>
      <value value="3562001"/>
      <value value="9561961"/>
      <value value="6302745"/>
      <value value="800432"/>
      <value value="4702375"/>
      <value value="5846463"/>
      <value value="3001994"/>
      <value value="4692906"/>
      <value value="1378776"/>
      <value value="8961828"/>
      <value value="5945214"/>
      <value value="3170997"/>
      <value value="8031514"/>
      <value value="5684304"/>
      <value value="8029219"/>
      <value value="6863136"/>
      <value value="1164357"/>
      <value value="2832527"/>
      <value value="8403968"/>
      <value value="2388591"/>
      <value value="3179908"/>
      <value value="2086682"/>
      <value value="2203739"/>
      <value value="5197349"/>
      <value value="746109"/>
      <value value="7704443"/>
      <value value="8515066"/>
      <value value="4350941"/>
      <value value="6622897"/>
      <value value="1552303"/>
      <value value="34282"/>
      <value value="8070240"/>
      <value value="6639502"/>
      <value value="7887457"/>
      <value value="3742036"/>
      <value value="6120812"/>
      <value value="3150479"/>
      <value value="6033472"/>
      <value value="1893122"/>
      <value value="6616298"/>
      <value value="293543"/>
      <value value="1796646"/>
      <value value="6777501"/>
      <value value="7973505"/>
      <value value="2014881"/>
      <value value="8031711"/>
      <value value="3572038"/>
      <value value="8435699"/>
      <value value="8349864"/>
      <value value="8227901"/>
      <value value="3364694"/>
      <value value="8597103"/>
      <value value="3404514"/>
      <value value="6363791"/>
      <value value="9011192"/>
      <value value="6437560"/>
      <value value="3322490"/>
      <value value="9015734"/>
      <value value="5348294"/>
      <value value="4680166"/>
      <value value="5665688"/>
      <value value="8255289"/>
      <value value="3711951"/>
      <value value="9065737"/>
      <value value="9389906"/>
      <value value="1085446"/>
      <value value="5785542"/>
      <value value="2718023"/>
      <value value="1366069"/>
      <value value="229868"/>
      <value value="7075470"/>
      <value value="5841427"/>
      <value value="3575995"/>
      <value value="199393"/>
      <value value="9139925"/>
      <value value="7072805"/>
      <value value="1651183"/>
      <value value="3956381"/>
      <value value="683845"/>
      <value value="4080783"/>
      <value value="7699141"/>
      <value value="8893018"/>
      <value value="5181228"/>
      <value value="6328338"/>
      <value value="395499"/>
      <value value="8132323"/>
      <value value="2927577"/>
      <value value="6195345"/>
      <value value="4449698"/>
      <value value="5728583"/>
      <value value="2452406"/>
      <value value="958833"/>
      <value value="7924653"/>
      <value value="3170588"/>
      <value value="5897934"/>
      <value value="2344960"/>
      <value value="2876735"/>
      <value value="5943950"/>
      <value value="252365"/>
      <value value="7269233"/>
      <value value="6781650"/>
      <value value="7711322"/>
      <value value="2578581"/>
      <value value="7041772"/>
      <value value="9720949"/>
      <value value="7420698"/>
      <value value="4313130"/>
      <value value="8968247"/>
      <value value="4801977"/>
      <value value="3032864"/>
      <value value="4915416"/>
      <value value="2472206"/>
      <value value="8553871"/>
      <value value="8676050"/>
      <value value="5445328"/>
      <value value="4210853"/>
      <value value="4727231"/>
      <value value="510003"/>
      <value value="6514825"/>
      <value value="5036623"/>
      <value value="4909962"/>
      <value value="8503286"/>
      <value value="2861692"/>
      <value value="4346080"/>
      <value value="3927091"/>
      <value value="1004970"/>
      <value value="2101001"/>
      <value value="638937"/>
      <value value="4183855"/>
      <value value="9596208"/>
      <value value="4004844"/>
      <value value="4490670"/>
      <value value="941827"/>
      <value value="3446551"/>
      <value value="7633526"/>
      <value value="1945892"/>
      <value value="2602492"/>
      <value value="2077352"/>
      <value value="9762609"/>
      <value value="5730601"/>
      <value value="2578674"/>
      <value value="1509157"/>
      <value value="9288585"/>
      <value value="1273009"/>
      <value value="7776964"/>
      <value value="8104955"/>
      <value value="6162238"/>
      <value value="7519619"/>
      <value value="7638739"/>
      <value value="9773306"/>
      <value value="3005058"/>
      <value value="663344"/>
      <value value="7362494"/>
      <value value="9307922"/>
      <value value="5329177"/>
      <value value="36483"/>
      <value value="6141171"/>
      <value value="9413731"/>
      <value value="7447539"/>
      <value value="7266633"/>
      <value value="4479695"/>
      <value value="4970464"/>
      <value value="3058690"/>
      <value value="6851819"/>
      <value value="9688596"/>
      <value value="8345451"/>
      <value value="9929357"/>
      <value value="5667630"/>
      <value value="3012950"/>
      <value value="6195373"/>
      <value value="1340186"/>
      <value value="2217028"/>
      <value value="9485902"/>
      <value value="1267317"/>
      <value value="4950041"/>
      <value value="1560515"/>
      <value value="3292843"/>
      <value value="924213"/>
      <value value="7981396"/>
      <value value="3573490"/>
      <value value="3458742"/>
      <value value="2552569"/>
      <value value="2892854"/>
      <value value="1313314"/>
      <value value="3780435"/>
      <value value="6483049"/>
      <value value="6980238"/>
      <value value="1658596"/>
      <value value="1159203"/>
      <value value="3871326"/>
      <value value="4447719"/>
      <value value="5672573"/>
      <value value="9599218"/>
      <value value="257897"/>
      <value value="3764550"/>
      <value value="2005309"/>
      <value value="8463264"/>
      <value value="3439477"/>
      <value value="4112767"/>
      <value value="6717931"/>
      <value value="8706031"/>
      <value value="8485263"/>
      <value value="3551958"/>
      <value value="2224973"/>
      <value value="8535894"/>
      <value value="8701868"/>
      <value value="8363649"/>
      <value value="6924133"/>
      <value value="9941567"/>
      <value value="8384845"/>
      <value value="1227956"/>
      <value value="3235995"/>
      <value value="6600169"/>
      <value value="7187063"/>
      <value value="2799000"/>
      <value value="1719024"/>
      <value value="4403571"/>
      <value value="1417105"/>
      <value value="5546611"/>
      <value value="1477198"/>
      <value value="9948444"/>
      <value value="8728274"/>
      <value value="3843092"/>
      <value value="6554871"/>
      <value value="1179033"/>
      <value value="4512856"/>
      <value value="8293148"/>
      <value value="8244099"/>
      <value value="368528"/>
      <value value="1176405"/>
      <value value="6305712"/>
      <value value="1172879"/>
      <value value="2078185"/>
      <value value="1996628"/>
      <value value="22995"/>
      <value value="75428"/>
      <value value="803432"/>
      <value value="6445162"/>
      <value value="9541600"/>
      <value value="1064651"/>
      <value value="8967712"/>
      <value value="2682447"/>
      <value value="7971112"/>
      <value value="5024144"/>
      <value value="5427021"/>
      <value value="5982656"/>
      <value value="1502134"/>
      <value value="5803855"/>
      <value value="1369752"/>
      <value value="4419202"/>
      <value value="7710005"/>
      <value value="9541582"/>
      <value value="728730"/>
      <value value="2928233"/>
      <value value="607906"/>
      <value value="8685614"/>
      <value value="6903153"/>
      <value value="3441528"/>
      <value value="4112950"/>
      <value value="3803429"/>
      <value value="3993838"/>
      <value value="870384"/>
      <value value="7149189"/>
      <value value="814492"/>
      <value value="7803816"/>
      <value value="3152822"/>
      <value value="7944496"/>
      <value value="753239"/>
      <value value="6858093"/>
      <value value="8041840"/>
      <value value="6773824"/>
      <value value="9926295"/>
      <value value="50930"/>
      <value value="808415"/>
      <value value="9152084"/>
      <value value="7226284"/>
      <value value="9721301"/>
      <value value="8578769"/>
      <value value="8050046"/>
      <value value="6922448"/>
      <value value="6132491"/>
      <value value="585252"/>
      <value value="3347175"/>
      <value value="2762984"/>
      <value value="5175808"/>
      <value value="3381823"/>
      <value value="1860431"/>
      <value value="7220507"/>
      <value value="1734852"/>
      <value value="8542688"/>
      <value value="1026335"/>
      <value value="3359119"/>
      <value value="3267301"/>
      <value value="7265953"/>
      <value value="4911274"/>
      <value value="4220619"/>
      <value value="7174799"/>
      <value value="9583444"/>
      <value value="5564805"/>
      <value value="6359799"/>
      <value value="3842948"/>
      <value value="4392310"/>
      <value value="3003108"/>
      <value value="5121149"/>
      <value value="4263559"/>
      <value value="7283168"/>
      <value value="5411119"/>
      <value value="6579719"/>
      <value value="9112567"/>
      <value value="6007026"/>
      <value value="6530384"/>
      <value value="4157420"/>
      <value value="2741703"/>
      <value value="4147383"/>
      <value value="4811384"/>
      <value value="2227932"/>
      <value value="9519810"/>
      <value value="9805622"/>
      <value value="8369220"/>
      <value value="5495794"/>
      <value value="8048901"/>
      <value value="5901321"/>
      <value value="1253725"/>
      <value value="4627734"/>
      <value value="691577"/>
      <value value="1909286"/>
      <value value="8677256"/>
      <value value="382852"/>
      <value value="7569377"/>
      <value value="3820793"/>
      <value value="7548797"/>
      <value value="4050849"/>
      <value value="7511874"/>
      <value value="8918113"/>
      <value value="3924767"/>
      <value value="6027080"/>
      <value value="9845331"/>
      <value value="8448313"/>
      <value value="4638695"/>
      <value value="8505395"/>
      <value value="6681212"/>
      <value value="5792001"/>
      <value value="4660353"/>
      <value value="8834385"/>
      <value value="7407245"/>
      <value value="8275294"/>
      <value value="5878547"/>
      <value value="7004101"/>
      <value value="5214670"/>
      <value value="2991882"/>
      <value value="3180047"/>
      <value value="8571989"/>
      <value value="3198401"/>
      <value value="7645471"/>
      <value value="829036"/>
      <value value="6576533"/>
      <value value="2569714"/>
      <value value="2996300"/>
      <value value="6800046"/>
      <value value="6078768"/>
      <value value="8240290"/>
      <value value="8640547"/>
      <value value="1223979"/>
      <value value="3254357"/>
      <value value="191146"/>
      <value value="3330773"/>
      <value value="5212559"/>
      <value value="4032065"/>
      <value value="9341425"/>
      <value value="8666282"/>
      <value value="7081079"/>
      <value value="9049209"/>
      <value value="1246486"/>
      <value value="9475854"/>
      <value value="4808578"/>
      <value value="1978371"/>
      <value value="2433013"/>
      <value value="2126262"/>
      <value value="5749269"/>
      <value value="9138839"/>
      <value value="5769104"/>
      <value value="7889493"/>
      <value value="7747493"/>
      <value value="1364061"/>
      <value value="8692017"/>
      <value value="9145965"/>
      <value value="5578981"/>
      <value value="8973117"/>
      <value value="8271540"/>
      <value value="1315605"/>
      <value value="2272337"/>
      <value value="919520"/>
      <value value="1436105"/>
      <value value="7716749"/>
      <value value="8920449"/>
      <value value="1109632"/>
      <value value="1109299"/>
      <value value="4690584"/>
      <value value="1744629"/>
      <value value="8514424"/>
      <value value="3868257"/>
      <value value="1512107"/>
      <value value="4536473"/>
      <value value="5943299"/>
      <value value="7864218"/>
      <value value="4707696"/>
      <value value="3366734"/>
      <value value="7137714"/>
      <value value="3340483"/>
      <value value="132918"/>
      <value value="5282990"/>
      <value value="9446739"/>
      <value value="5697925"/>
      <value value="4321201"/>
      <value value="7368245"/>
      <value value="7422888"/>
      <value value="93138"/>
      <value value="9607206"/>
      <value value="6681781"/>
      <value value="8189860"/>
      <value value="5188617"/>
      <value value="1565272"/>
      <value value="9340013"/>
      <value value="1331151"/>
      <value value="3547728"/>
      <value value="1888228"/>
      <value value="2441213"/>
      <value value="93097"/>
      <value value="8733419"/>
      <value value="9230226"/>
      <value value="4932969"/>
      <value value="6284904"/>
      <value value="9940812"/>
      <value value="6123758"/>
      <value value="4740156"/>
      <value value="3382974"/>
      <value value="7593326"/>
      <value value="5818840"/>
      <value value="8925513"/>
      <value value="3439376"/>
      <value value="2100957"/>
      <value value="8210886"/>
      <value value="7607584"/>
      <value value="5827608"/>
      <value value="3123896"/>
      <value value="3518202"/>
      <value value="6290483"/>
      <value value="5892334"/>
      <value value="810263"/>
      <value value="8348160"/>
      <value value="2865344"/>
      <value value="4461901"/>
      <value value="8936650"/>
      <value value="8094677"/>
      <value value="7651753"/>
      <value value="1163593"/>
      <value value="3629022"/>
      <value value="5832300"/>
      <value value="3925893"/>
      <value value="5691042"/>
      <value value="9206188"/>
      <value value="6606000"/>
      <value value="2655709"/>
      <value value="3118383"/>
      <value value="7033540"/>
      <value value="1340076"/>
      <value value="6470309"/>
      <value value="9284704"/>
      <value value="6273670"/>
      <value value="4758804"/>
      <value value="3429478"/>
      <value value="648515"/>
      <value value="3612468"/>
      <value value="6151421"/>
      <value value="421750"/>
      <value value="7211841"/>
      <value value="267601"/>
      <value value="8624998"/>
      <value value="8896177"/>
      <value value="6006905"/>
      <value value="4662074"/>
      <value value="7699574"/>
      <value value="1809385"/>
      <value value="3472868"/>
      <value value="754798"/>
      <value value="5756428"/>
      <value value="1477060"/>
      <value value="4248250"/>
      <value value="9389222"/>
      <value value="6304284"/>
      <value value="5965115"/>
      <value value="6494821"/>
      <value value="7575142"/>
      <value value="4670490"/>
      <value value="3347809"/>
      <value value="7663975"/>
      <value value="1979785"/>
      <value value="9195655"/>
      <value value="668764"/>
      <value value="750442"/>
      <value value="3447369"/>
      <value value="2031108"/>
      <value value="4486516"/>
      <value value="8189787"/>
      <value value="859017"/>
      <value value="6008095"/>
      <value value="1132441"/>
      <value value="7077782"/>
      <value value="2091827"/>
      <value value="7329615"/>
      <value value="3308778"/>
      <value value="8838692"/>
      <value value="6562571"/>
      <value value="5621377"/>
      <value value="3098509"/>
      <value value="6793893"/>
      <value value="4080693"/>
      <value value="3758001"/>
      <value value="130840"/>
      <value value="5524182"/>
      <value value="7889926"/>
      <value value="3224570"/>
      <value value="5172192"/>
      <value value="3657709"/>
      <value value="6210279"/>
      <value value="5085292"/>
      <value value="8963545"/>
      <value value="3751547"/>
      <value value="7357319"/>
      <value value="7633493"/>
      <value value="5821669"/>
      <value value="841728"/>
      <value value="9955939"/>
      <value value="5218460"/>
      <value value="2843146"/>
      <value value="6529102"/>
      <value value="6970195"/>
      <value value="4317603"/>
      <value value="457080"/>
      <value value="3543409"/>
      <value value="1307863"/>
      <value value="1198037"/>
      <value value="1710208"/>
      <value value="5713637"/>
      <value value="8167457"/>
      <value value="3913764"/>
      <value value="7613077"/>
      <value value="4555691"/>
      <value value="3761732"/>
      <value value="6839470"/>
      <value value="9490361"/>
      <value value="5959016"/>
      <value value="1076809"/>
      <value value="2468770"/>
      <value value="6341356"/>
      <value value="1300269"/>
      <value value="8379070"/>
      <value value="2080832"/>
      <value value="3342723"/>
      <value value="3552051"/>
      <value value="2814299"/>
      <value value="6384935"/>
      <value value="7309303"/>
      <value value="9623667"/>
      <value value="6382250"/>
      <value value="988727"/>
      <value value="771188"/>
      <value value="8836671"/>
      <value value="7277209"/>
      <value value="5127023"/>
      <value value="1239092"/>
      <value value="7721280"/>
      <value value="8451483"/>
      <value value="4393242"/>
      <value value="3505087"/>
      <value value="8246517"/>
      <value value="1345071"/>
      <value value="1705023"/>
      <value value="5236080"/>
      <value value="2701959"/>
      <value value="4332673"/>
      <value value="6178426"/>
      <value value="9532022"/>
      <value value="717810"/>
      <value value="3398540"/>
      <value value="6720816"/>
      <value value="3474278"/>
      <value value="4323500"/>
      <value value="7371247"/>
      <value value="1355499"/>
      <value value="2152691"/>
      <value value="8715089"/>
      <value value="1773279"/>
      <value value="4649101"/>
      <value value="4343697"/>
      <value value="2134229"/>
      <value value="8376025"/>
      <value value="6882829"/>
      <value value="2241753"/>
      <value value="8887356"/>
      <value value="4504715"/>
      <value value="2054388"/>
      <value value="5412790"/>
      <value value="3407203"/>
      <value value="5494242"/>
      <value value="2400659"/>
      <value value="143794"/>
      <value value="9328514"/>
      <value value="2891601"/>
      <value value="8448769"/>
      <value value="7789556"/>
      <value value="589882"/>
      <value value="1257664"/>
      <value value="5393115"/>
      <value value="8182697"/>
      <value value="8703254"/>
      <value value="7921524"/>
      <value value="2537528"/>
      <value value="8321870"/>
      <value value="1492754"/>
      <value value="1204299"/>
      <value value="8429017"/>
      <value value="8644574"/>
      <value value="3971846"/>
      <value value="6644045"/>
      <value value="9755646"/>
      <value value="1531466"/>
      <value value="4446195"/>
      <value value="9439542"/>
      <value value="4308788"/>
      <value value="5963722"/>
      <value value="116326"/>
      <value value="8230919"/>
      <value value="4380096"/>
      <value value="7669048"/>
      <value value="5047278"/>
      <value value="2532791"/>
      <value value="4930422"/>
      <value value="3965479"/>
      <value value="6502218"/>
      <value value="7488100"/>
      <value value="6686926"/>
      <value value="1893347"/>
      <value value="8455067"/>
      <value value="8849006"/>
      <value value="9463657"/>
      <value value="1219431"/>
      <value value="4350178"/>
      <value value="802679"/>
      <value value="7909523"/>
      <value value="9195794"/>
      <value value="8929333"/>
      <value value="4051094"/>
      <value value="858276"/>
      <value value="2050366"/>
      <value value="3724897"/>
      <value value="9717079"/>
      <value value="4592574"/>
      <value value="6190474"/>
      <value value="892337"/>
      <value value="7222360"/>
      <value value="2687368"/>
      <value value="3134657"/>
      <value value="4448308"/>
      <value value="287771"/>
      <value value="6943615"/>
      <value value="6697099"/>
      <value value="9490769"/>
      <value value="8633624"/>
      <value value="5425621"/>
      <value value="7459343"/>
      <value value="5628491"/>
      <value value="3756526"/>
      <value value="99556"/>
      <value value="7699451"/>
      <value value="8865001"/>
      <value value="2252747"/>
      <value value="4573016"/>
      <value value="8523607"/>
      <value value="7112326"/>
      <value value="3888901"/>
      <value value="7593672"/>
      <value value="2619071"/>
      <value value="6936135"/>
      <value value="4752053"/>
      <value value="7730303"/>
      <value value="761778"/>
      <value value="4415922"/>
      <value value="9270500"/>
      <value value="9630493"/>
      <value value="9984033"/>
      <value value="7555949"/>
      <value value="8883520"/>
      <value value="2164641"/>
      <value value="3666039"/>
      <value value="4231002"/>
      <value value="423521"/>
      <value value="8991540"/>
      <value value="68407"/>
      <value value="9371727"/>
      <value value="1274697"/>
      <value value="1449260"/>
      <value value="7611259"/>
      <value value="9965555"/>
      <value value="6212745"/>
      <value value="8052530"/>
      <value value="1639143"/>
      <value value="1016302"/>
      <value value="9471340"/>
      <value value="5835248"/>
      <value value="8616159"/>
      <value value="4659064"/>
      <value value="892636"/>
      <value value="4703826"/>
      <value value="6120657"/>
      <value value="359288"/>
      <value value="680485"/>
      <value value="5617315"/>
      <value value="1350936"/>
      <value value="8419509"/>
      <value value="9517190"/>
      <value value="4330375"/>
      <value value="8046022"/>
      <value value="503718"/>
      <value value="369167"/>
      <value value="9237809"/>
      <value value="1151118"/>
      <value value="6606964"/>
      <value value="5174337"/>
      <value value="6138543"/>
      <value value="1905583"/>
      <value value="4694943"/>
      <value value="5725654"/>
      <value value="233717"/>
      <value value="6587813"/>
      <value value="9825106"/>
      <value value="2134435"/>
      <value value="1793089"/>
      <value value="5520623"/>
      <value value="6602419"/>
      <value value="7713155"/>
      <value value="9452174"/>
      <value value="319291"/>
      <value value="4345311"/>
      <value value="7191743"/>
      <value value="466731"/>
      <value value="9905211"/>
      <value value="8841046"/>
      <value value="4723096"/>
      <value value="3370066"/>
      <value value="4757929"/>
      <value value="8006427"/>
      <value value="1323168"/>
      <value value="6372953"/>
      <value value="4724411"/>
      <value value="707949"/>
      <value value="1737394"/>
      <value value="5436571"/>
      <value value="9988166"/>
      <value value="2549755"/>
      <value value="7095591"/>
      <value value="2885855"/>
      <value value="7972665"/>
      <value value="4763296"/>
      <value value="1706266"/>
      <value value="4399033"/>
      <value value="7934409"/>
      <value value="694465"/>
      <value value="2076622"/>
      <value value="2524210"/>
      <value value="3715647"/>
      <value value="5773961"/>
      <value value="3310891"/>
      <value value="2321227"/>
      <value value="1994186"/>
      <value value="2827030"/>
      <value value="8205836"/>
      <value value="4855657"/>
      <value value="219703"/>
      <value value="8294314"/>
      <value value="8554316"/>
      <value value="4895689"/>
      <value value="6773910"/>
      <value value="9877908"/>
      <value value="2721002"/>
      <value value="5050397"/>
      <value value="3505889"/>
      <value value="7264010"/>
      <value value="5798273"/>
      <value value="9326154"/>
      <value value="7650974"/>
      <value value="8369975"/>
      <value value="7425169"/>
      <value value="1564345"/>
      <value value="7732878"/>
      <value value="7250160"/>
      <value value="252059"/>
      <value value="5461921"/>
      <value value="5481080"/>
      <value value="9524557"/>
      <value value="6308022"/>
      <value value="7206383"/>
      <value value="1734401"/>
      <value value="1337328"/>
      <value value="8014037"/>
      <value value="7586005"/>
      <value value="6522891"/>
      <value value="896899"/>
      <value value="2737279"/>
      <value value="2022154"/>
      <value value="2719194"/>
      <value value="5746776"/>
      <value value="3536667"/>
      <value value="1122048"/>
      <value value="3385624"/>
      <value value="1143666"/>
      <value value="4488634"/>
      <value value="2572270"/>
      <value value="2949300"/>
      <value value="6838157"/>
      <value value="197978"/>
      <value value="7170175"/>
      <value value="2715530"/>
      <value value="9437548"/>
      <value value="9240037"/>
      <value value="4908475"/>
      <value value="1523019"/>
      <value value="9273580"/>
      <value value="5088353"/>
      <value value="7691131"/>
      <value value="5511985"/>
      <value value="9165545"/>
      <value value="6985962"/>
      <value value="8634345"/>
      <value value="3292108"/>
      <value value="1096482"/>
      <value value="7933853"/>
      <value value="3893513"/>
      <value value="5755898"/>
      <value value="2889722"/>
      <value value="9356067"/>
      <value value="751390"/>
      <value value="7562903"/>
      <value value="8031718"/>
      <value value="5106524"/>
      <value value="4877999"/>
      <value value="7395409"/>
      <value value="9248844"/>
      <value value="4928913"/>
      <value value="9612091"/>
      <value value="869698"/>
      <value value="6488225"/>
      <value value="533244"/>
      <value value="1448617"/>
      <value value="2405437"/>
      <value value="1004328"/>
      <value value="7318946"/>
      <value value="1670469"/>
      <value value="1793617"/>
      <value value="8136423"/>
      <value value="8932391"/>
      <value value="4102752"/>
      <value value="125468"/>
      <value value="3661864"/>
      <value value="7116946"/>
      <value value="4209717"/>
      <value value="2847528"/>
      <value value="6573208"/>
      <value value="9342495"/>
      <value value="8808291"/>
      <value value="9088633"/>
      <value value="1122831"/>
      <value value="9730844"/>
      <value value="5413670"/>
      <value value="1156536"/>
      <value value="8639736"/>
      <value value="5992357"/>
      <value value="3237483"/>
      <value value="8130331"/>
      <value value="328130"/>
      <value value="4044490"/>
      <value value="5542312"/>
      <value value="8866585"/>
      <value value="225700"/>
      <value value="1814953"/>
      <value value="4817189"/>
      <value value="9817565"/>
      <value value="4236130"/>
      <value value="1053711"/>
      <value value="7323970"/>
      <value value="4218735"/>
      <value value="2529545"/>
      <value value="7339989"/>
      <value value="6399364"/>
      <value value="7893593"/>
      <value value="7820397"/>
      <value value="3851998"/>
      <value value="5911731"/>
      <value value="7695489"/>
      <value value="7519678"/>
      <value value="4463665"/>
      <value value="6073739"/>
      <value value="529363"/>
      <value value="8780407"/>
      <value value="2297047"/>
      <value value="1104954"/>
      <value value="3923165"/>
      <value value="2446316"/>
      <value value="257605"/>
      <value value="6965677"/>
      <value value="8512542"/>
      <value value="2558558"/>
      <value value="2518064"/>
      <value value="4599191"/>
      <value value="5171300"/>
      <value value="5090506"/>
      <value value="60157"/>
      <value value="7720685"/>
      <value value="6540053"/>
      <value value="9604174"/>
      <value value="5345229"/>
      <value value="6300109"/>
      <value value="3220332"/>
      <value value="6199323"/>
      <value value="7878537"/>
      <value value="8148571"/>
      <value value="190751"/>
      <value value="4520882"/>
      <value value="3109766"/>
      <value value="2495"/>
      <value value="4367973"/>
      <value value="7961985"/>
      <value value="2720053"/>
      <value value="1527102"/>
      <value value="3136264"/>
      <value value="1484936"/>
      <value value="1574264"/>
      <value value="7878088"/>
      <value value="1543485"/>
      <value value="880471"/>
      <value value="4623355"/>
      <value value="6117539"/>
      <value value="7435553"/>
      <value value="7871111"/>
      <value value="2407694"/>
      <value value="7749631"/>
      <value value="7660937"/>
      <value value="12911"/>
      <value value="6363775"/>
      <value value="1804086"/>
      <value value="6028890"/>
      <value value="6142693"/>
      <value value="4163093"/>
      <value value="3700254"/>
      <value value="8834929"/>
      <value value="7107895"/>
      <value value="4897610"/>
      <value value="6765643"/>
      <value value="3788996"/>
      <value value="2458517"/>
      <value value="1711834"/>
      <value value="2721373"/>
      <value value="9558616"/>
      <value value="2590637"/>
      <value value="3844982"/>
      <value value="5404927"/>
      <value value="6315075"/>
      <value value="2228576"/>
      <value value="2265547"/>
      <value value="6780355"/>
      <value value="7413952"/>
      <value value="8719654"/>
      <value value="7339563"/>
      <value value="3962170"/>
      <value value="9694898"/>
      <value value="101453"/>
      <value value="738476"/>
      <value value="6897218"/>
      <value value="9780286"/>
      <value value="5090392"/>
      <value value="9057516"/>
      <value value="4105323"/>
      <value value="2250956"/>
      <value value="7676417"/>
      <value value="2047180"/>
      <value value="6464787"/>
      <value value="9287115"/>
      <value value="3564168"/>
      <value value="171305"/>
      <value value="4072070"/>
      <value value="7476707"/>
      <value value="6376852"/>
      <value value="9033069"/>
      <value value="5403406"/>
      <value value="2103017"/>
      <value value="6427536"/>
      <value value="871733"/>
      <value value="9635657"/>
      <value value="6295448"/>
      <value value="3567233"/>
      <value value="5106312"/>
      <value value="9900394"/>
      <value value="772434"/>
      <value value="5045708"/>
      <value value="1785753"/>
      <value value="4171359"/>
      <value value="1681196"/>
      <value value="1763944"/>
      <value value="2645128"/>
      <value value="2465087"/>
      <value value="126233"/>
      <value value="5279768"/>
      <value value="587329"/>
      <value value="3262104"/>
      <value value="1739101"/>
      <value value="7999821"/>
      <value value="4318153"/>
      <value value="4389363"/>
      <value value="6290559"/>
      <value value="4426271"/>
      <value value="2347124"/>
      <value value="8955227"/>
      <value value="8427520"/>
      <value value="4252482"/>
      <value value="2234207"/>
      <value value="7886505"/>
      <value value="9349974"/>
      <value value="5987722"/>
      <value value="4935237"/>
      <value value="5832485"/>
      <value value="202139"/>
      <value value="3921760"/>
      <value value="9104484"/>
      <value value="8840815"/>
      <value value="9374025"/>
      <value value="5002023"/>
      <value value="2867365"/>
      <value value="2103746"/>
      <value value="7069329"/>
      <value value="7206884"/>
      <value value="7254656"/>
      <value value="5865801"/>
      <value value="7945751"/>
      <value value="7828813"/>
      <value value="1760011"/>
      <value value="2588861"/>
      <value value="1654850"/>
      <value value="2398356"/>
      <value value="1748086"/>
      <value value="3520085"/>
      <value value="4405360"/>
      <value value="6191717"/>
      <value value="4809934"/>
      <value value="5842496"/>
      <value value="7363118"/>
      <value value="5622529"/>
      <value value="1748824"/>
      <value value="8893385"/>
      <value value="3569677"/>
      <value value="1576783"/>
      <value value="9505208"/>
      <value value="1720728"/>
      <value value="3839841"/>
      <value value="2480225"/>
      <value value="2089324"/>
      <value value="1296944"/>
      <value value="9571464"/>
      <value value="7481511"/>
      <value value="7076952"/>
      <value value="6462993"/>
      <value value="4887043"/>
      <value value="5451542"/>
      <value value="5750936"/>
      <value value="2766046"/>
      <value value="1313359"/>
      <value value="593792"/>
      <value value="4449173"/>
      <value value="7323356"/>
      <value value="7133571"/>
      <value value="8682058"/>
      <value value="8951743"/>
      <value value="1327609"/>
      <value value="2440497"/>
      <value value="7824187"/>
      <value value="6302405"/>
      <value value="5035895"/>
      <value value="2042410"/>
      <value value="5000049"/>
      <value value="2609373"/>
      <value value="169467"/>
      <value value="2955776"/>
      <value value="5482209"/>
      <value value="1710737"/>
      <value value="1846189"/>
      <value value="394473"/>
      <value value="2757525"/>
      <value value="1939855"/>
      <value value="1154133"/>
      <value value="9168920"/>
      <value value="913162"/>
      <value value="8681811"/>
      <value value="9765216"/>
      <value value="3689572"/>
      <value value="2161987"/>
      <value value="9457136"/>
      <value value="9463090"/>
      <value value="9808057"/>
      <value value="1914224"/>
      <value value="788136"/>
      <value value="3642160"/>
      <value value="6201270"/>
      <value value="2051314"/>
      <value value="3974029"/>
      <value value="4831145"/>
      <value value="1156417"/>
      <value value="5215136"/>
      <value value="3084124"/>
      <value value="6549120"/>
      <value value="6101503"/>
      <value value="3520804"/>
      <value value="7248732"/>
      <value value="1627975"/>
      <value value="6806075"/>
      <value value="1497162"/>
      <value value="137949"/>
      <value value="5714741"/>
      <value value="1112517"/>
      <value value="1263753"/>
      <value value="4168619"/>
      <value value="3664147"/>
      <value value="1968667"/>
      <value value="5134811"/>
      <value value="6886017"/>
      <value value="4601602"/>
      <value value="9512394"/>
      <value value="7304848"/>
      <value value="3563928"/>
      <value value="1222517"/>
      <value value="2300361"/>
      <value value="9612141"/>
      <value value="2313290"/>
      <value value="8324679"/>
      <value value="8384606"/>
      <value value="8933405"/>
      <value value="5777433"/>
      <value value="9697852"/>
      <value value="3063636"/>
      <value value="799825"/>
      <value value="7897824"/>
      <value value="3288264"/>
      <value value="442615"/>
      <value value="7972804"/>
      <value value="4096478"/>
      <value value="9599272"/>
      <value value="6274840"/>
      <value value="3005593"/>
      <value value="6804929"/>
      <value value="3577862"/>
      <value value="1262220"/>
      <value value="2898280"/>
      <value value="161765"/>
      <value value="6425855"/>
      <value value="9973399"/>
      <value value="4857716"/>
      <value value="8826624"/>
      <value value="5840543"/>
      <value value="6937772"/>
      <value value="6847474"/>
      <value value="6449296"/>
      <value value="5223510"/>
      <value value="3607697"/>
      <value value="1189020"/>
      <value value="6898048"/>
      <value value="7233752"/>
      <value value="1528514"/>
      <value value="6075042"/>
      <value value="1442202"/>
      <value value="4866130"/>
      <value value="6800672"/>
      <value value="2419617"/>
      <value value="5450597"/>
      <value value="8690119"/>
      <value value="8700324"/>
      <value value="7767769"/>
      <value value="203499"/>
      <value value="8833182"/>
      <value value="1098839"/>
      <value value="362109"/>
      <value value="9292548"/>
      <value value="5938971"/>
      <value value="56132"/>
      <value value="6921726"/>
      <value value="6935616"/>
      <value value="998195"/>
      <value value="4116776"/>
      <value value="1747207"/>
      <value value="9712461"/>
      <value value="89970"/>
      <value value="6061079"/>
      <value value="9894801"/>
      <value value="113659"/>
      <value value="3927388"/>
      <value value="8499627"/>
      <value value="3292407"/>
      <value value="6103760"/>
      <value value="36919"/>
      <value value="6230489"/>
      <value value="2012426"/>
      <value value="3311994"/>
      <value value="4890534"/>
      <value value="6324097"/>
      <value value="7215559"/>
      <value value="3524194"/>
      <value value="1714595"/>
      <value value="5338715"/>
      <value value="8279805"/>
      <value value="2454917"/>
      <value value="3621966"/>
      <value value="7107210"/>
      <value value="9660532"/>
      <value value="2552234"/>
      <value value="9848806"/>
      <value value="8428178"/>
      <value value="7796517"/>
      <value value="949081"/>
      <value value="717440"/>
      <value value="9194651"/>
      <value value="7457435"/>
      <value value="3626350"/>
      <value value="1446779"/>
      <value value="3367459"/>
      <value value="2860199"/>
      <value value="9843962"/>
      <value value="6928443"/>
      <value value="9648941"/>
      <value value="716517"/>
      <value value="3352335"/>
      <value value="4886461"/>
      <value value="5447666"/>
      <value value="3120874"/>
      <value value="9950543"/>
      <value value="1590785"/>
      <value value="73600"/>
      <value value="4737822"/>
      <value value="8294652"/>
      <value value="8908156"/>
      <value value="6809887"/>
      <value value="1164999"/>
      <value value="2107784"/>
      <value value="5594722"/>
      <value value="6399049"/>
      <value value="5986525"/>
      <value value="2912217"/>
      <value value="5743310"/>
      <value value="1337446"/>
      <value value="9958703"/>
      <value value="490741"/>
      <value value="1738317"/>
      <value value="6414032"/>
      <value value="4052406"/>
      <value value="1408554"/>
      <value value="904987"/>
      <value value="9858475"/>
      <value value="3309536"/>
      <value value="9704753"/>
      <value value="6500060"/>
      <value value="4124370"/>
      <value value="5164845"/>
      <value value="7114327"/>
      <value value="6090018"/>
      <value value="3678008"/>
      <value value="100463"/>
      <value value="6984721"/>
      <value value="1582216"/>
      <value value="3194437"/>
      <value value="3805165"/>
      <value value="1981868"/>
      <value value="9948612"/>
      <value value="7787122"/>
      <value value="1121367"/>
      <value value="4883827"/>
      <value value="1774268"/>
      <value value="4827506"/>
      <value value="6330858"/>
      <value value="6909057"/>
      <value value="3831851"/>
      <value value="1663292"/>
      <value value="5536786"/>
      <value value="899438"/>
      <value value="104378"/>
      <value value="9494280"/>
      <value value="575071"/>
      <value value="5497007"/>
      <value value="5414420"/>
      <value value="1672875"/>
      <value value="2151241"/>
      <value value="4880908"/>
      <value value="4332704"/>
      <value value="4109541"/>
      <value value="1414888"/>
      <value value="2696379"/>
      <value value="6281724"/>
      <value value="5426798"/>
      <value value="6561255"/>
      <value value="1922254"/>
      <value value="4055064"/>
      <value value="7365026"/>
      <value value="2658992"/>
      <value value="1381389"/>
      <value value="6749653"/>
      <value value="1675865"/>
      <value value="6533420"/>
      <value value="1136351"/>
      <value value="3400307"/>
      <value value="8409382"/>
      <value value="4938230"/>
      <value value="1299116"/>
      <value value="61934"/>
      <value value="3937159"/>
      <value value="6027736"/>
      <value value="8729901"/>
      <value value="7130266"/>
      <value value="1186784"/>
      <value value="7741716"/>
      <value value="244128"/>
      <value value="4939763"/>
      <value value="5857222"/>
      <value value="9997368"/>
      <value value="9498819"/>
      <value value="2378024"/>
      <value value="9323373"/>
      <value value="7485321"/>
      <value value="7730058"/>
      <value value="6361741"/>
      <value value="1721280"/>
      <value value="2643022"/>
      <value value="1619192"/>
      <value value="1919888"/>
      <value value="6187973"/>
      <value value="1422032"/>
      <value value="9000185"/>
      <value value="1853791"/>
      <value value="5504531"/>
      <value value="4892250"/>
      <value value="9717887"/>
      <value value="1146301"/>
      <value value="2941910"/>
      <value value="8063792"/>
      <value value="3427999"/>
      <value value="796432"/>
      <value value="4234613"/>
      <value value="4781915"/>
      <value value="1962294"/>
      <value value="6947701"/>
      <value value="7543384"/>
      <value value="2646584"/>
      <value value="9458641"/>
      <value value="5178068"/>
      <value value="1853572"/>
      <value value="8492696"/>
      <value value="4943904"/>
      <value value="96509"/>
      <value value="5788320"/>
      <value value="829255"/>
      <value value="3143737"/>
      <value value="7029756"/>
      <value value="9464963"/>
      <value value="5968985"/>
      <value value="4277315"/>
      <value value="4812795"/>
      <value value="7379859"/>
      <value value="112096"/>
      <value value="2514220"/>
      <value value="5057806"/>
      <value value="2205290"/>
      <value value="8455409"/>
      <value value="4397944"/>
      <value value="9036862"/>
      <value value="5818910"/>
      <value value="4644143"/>
      <value value="4840078"/>
      <value value="6246176"/>
      <value value="1599751"/>
      <value value="5638096"/>
      <value value="7381520"/>
      <value value="7476595"/>
      <value value="4971943"/>
      <value value="4309914"/>
      <value value="6122363"/>
      <value value="7588274"/>
      <value value="6036651"/>
      <value value="1256133"/>
      <value value="9775603"/>
      <value value="7107364"/>
      <value value="8005393"/>
      <value value="5162605"/>
      <value value="3216798"/>
      <value value="6209585"/>
      <value value="6207165"/>
      <value value="6133718"/>
      <value value="1597473"/>
      <value value="5486339"/>
      <value value="5618401"/>
      <value value="331299"/>
      <value value="3050350"/>
      <value value="7299259"/>
      <value value="1736212"/>
      <value value="7482216"/>
      <value value="1395969"/>
      <value value="8908153"/>
      <value value="7802195"/>
      <value value="1991084"/>
      <value value="7438132"/>
      <value value="5825315"/>
      <value value="253493"/>
      <value value="2773812"/>
      <value value="3746628"/>
      <value value="343754"/>
      <value value="5133048"/>
      <value value="9947010"/>
      <value value="1851291"/>
      <value value="5440349"/>
      <value value="9064398"/>
      <value value="6385988"/>
      <value value="8909617"/>
      <value value="4054488"/>
      <value value="7269852"/>
      <value value="652756"/>
      <value value="5944885"/>
      <value value="9105336"/>
      <value value="4361173"/>
      <value value="4576909"/>
      <value value="9853528"/>
      <value value="1455402"/>
      <value value="6034179"/>
      <value value="192812"/>
      <value value="1020527"/>
      <value value="6275481"/>
      <value value="4256950"/>
      <value value="5832601"/>
      <value value="5096032"/>
      <value value="3080086"/>
      <value value="7863426"/>
      <value value="9152775"/>
      <value value="4628674"/>
      <value value="8082046"/>
      <value value="3894789"/>
      <value value="3466086"/>
      <value value="2499722"/>
      <value value="9858283"/>
      <value value="3856768"/>
      <value value="5575913"/>
      <value value="1933006"/>
      <value value="2926235"/>
      <value value="8757866"/>
      <value value="4104397"/>
      <value value="8250274"/>
      <value value="1998840"/>
      <value value="8898472"/>
      <value value="101012"/>
      <value value="6271960"/>
      <value value="2889384"/>
      <value value="3212115"/>
      <value value="2976154"/>
      <value value="9733876"/>
      <value value="7348598"/>
      <value value="4028471"/>
      <value value="3421096"/>
      <value value="5745249"/>
      <value value="7449146"/>
      <value value="9784557"/>
      <value value="1504082"/>
      <value value="5167444"/>
      <value value="14026"/>
      <value value="8079308"/>
      <value value="2871859"/>
      <value value="5273396"/>
      <value value="4084821"/>
      <value value="40511"/>
      <value value="5424336"/>
      <value value="9075899"/>
      <value value="4623888"/>
      <value value="9494774"/>
      <value value="6002969"/>
      <value value="727648"/>
      <value value="4739203"/>
      <value value="5610085"/>
      <value value="7461775"/>
      <value value="1510517"/>
      <value value="6916548"/>
      <value value="5411437"/>
      <value value="899115"/>
      <value value="4690243"/>
      <value value="8595620"/>
      <value value="8209942"/>
      <value value="3067998"/>
      <value value="4159250"/>
      <value value="5103361"/>
      <value value="6325658"/>
      <value value="7103463"/>
      <value value="9766210"/>
      <value value="9865424"/>
      <value value="885446"/>
      <value value="1408172"/>
      <value value="5580112"/>
      <value value="1016072"/>
      <value value="6056252"/>
      <value value="8253141"/>
      <value value="7109604"/>
      <value value="8860548"/>
      <value value="4339431"/>
      <value value="8978028"/>
      <value value="4168487"/>
      <value value="116727"/>
      <value value="7291781"/>
      <value value="4029222"/>
      <value value="5461528"/>
      <value value="7639057"/>
      <value value="5538468"/>
      <value value="7476395"/>
      <value value="3233624"/>
      <value value="5936632"/>
      <value value="533568"/>
      <value value="4504089"/>
      <value value="4722450"/>
      <value value="4455229"/>
      <value value="3850411"/>
      <value value="3686580"/>
      <value value="1461258"/>
      <value value="8901042"/>
      <value value="6229568"/>
      <value value="3285589"/>
      <value value="618935"/>
      <value value="4853262"/>
      <value value="3465235"/>
      <value value="577642"/>
      <value value="6270292"/>
      <value value="716312"/>
      <value value="3429844"/>
      <value value="8238313"/>
      <value value="6531863"/>
      <value value="9169238"/>
      <value value="7351045"/>
      <value value="3249798"/>
      <value value="9150174"/>
      <value value="6318083"/>
      <value value="4823223"/>
      <value value="7117943"/>
      <value value="1561241"/>
      <value value="8830255"/>
      <value value="8575190"/>
      <value value="5848576"/>
      <value value="6593463"/>
      <value value="6828955"/>
      <value value="5009754"/>
      <value value="5060993"/>
      <value value="9953646"/>
      <value value="2278488"/>
      <value value="7823684"/>
      <value value="2119070"/>
      <value value="1604217"/>
      <value value="7002214"/>
      <value value="6793364"/>
      <value value="3761848"/>
      <value value="8863531"/>
      <value value="842368"/>
      <value value="4365815"/>
      <value value="3270111"/>
      <value value="567525"/>
      <value value="1036326"/>
      <value value="910330"/>
      <value value="2727429"/>
      <value value="8513098"/>
      <value value="816750"/>
      <value value="4382472"/>
      <value value="9601667"/>
      <value value="9474519"/>
      <value value="5039511"/>
      <value value="6979497"/>
      <value value="5482172"/>
      <value value="7506402"/>
      <value value="1208108"/>
      <value value="6885749"/>
      <value value="7092093"/>
      <value value="1454599"/>
      <value value="9307933"/>
      <value value="2452398"/>
      <value value="1975589"/>
      <value value="292200"/>
      <value value="194364"/>
      <value value="3212404"/>
      <value value="6115236"/>
      <value value="5841123"/>
      <value value="782129"/>
      <value value="9399103"/>
      <value value="7916237"/>
      <value value="4821468"/>
      <value value="7552851"/>
      <value value="9096661"/>
      <value value="3668560"/>
      <value value="1933926"/>
      <value value="7884666"/>
      <value value="8915946"/>
      <value value="1261726"/>
      <value value="2170918"/>
      <value value="1373509"/>
      <value value="9076661"/>
      <value value="6198947"/>
      <value value="9105390"/>
      <value value="2123392"/>
      <value value="2387349"/>
      <value value="2287504"/>
      <value value="2336949"/>
      <value value="7918162"/>
      <value value="580033"/>
      <value value="8572840"/>
      <value value="8715085"/>
      <value value="7319523"/>
      <value value="5993883"/>
      <value value="1442886"/>
      <value value="6945379"/>
      <value value="3483804"/>
      <value value="1806691"/>
      <value value="7597903"/>
      <value value="5302123"/>
      <value value="4617812"/>
      <value value="878800"/>
      <value value="7134532"/>
      <value value="2653183"/>
      <value value="8591988"/>
      <value value="178194"/>
      <value value="1979042"/>
      <value value="2735078"/>
      <value value="5699308"/>
      <value value="4296491"/>
      <value value="2775655"/>
      <value value="5136152"/>
      <value value="7256974"/>
      <value value="5123104"/>
      <value value="8239251"/>
      <value value="179561"/>
      <value value="3868748"/>
      <value value="1094233"/>
      <value value="1167535"/>
      <value value="9003031"/>
      <value value="2847926"/>
      <value value="1364852"/>
      <value value="1951638"/>
      <value value="1564668"/>
      <value value="2965051"/>
      <value value="9831727"/>
      <value value="611533"/>
      <value value="1706418"/>
      <value value="8644170"/>
      <value value="1789101"/>
      <value value="656433"/>
      <value value="6345041"/>
      <value value="8002527"/>
      <value value="5898761"/>
      <value value="155748"/>
      <value value="6506040"/>
      <value value="1843150"/>
      <value value="8614579"/>
      <value value="8501593"/>
      <value value="4408799"/>
      <value value="8689865"/>
      <value value="2417610"/>
      <value value="5600156"/>
      <value value="3163886"/>
      <value value="2678594"/>
      <value value="8654268"/>
      <value value="9894961"/>
      <value value="3213427"/>
      <value value="4959430"/>
      <value value="6970414"/>
      <value value="7669295"/>
      <value value="5655858"/>
      <value value="2849323"/>
      <value value="2733474"/>
      <value value="2785694"/>
      <value value="1349394"/>
      <value value="5316562"/>
      <value value="216812"/>
      <value value="6790301"/>
      <value value="1510857"/>
      <value value="3757655"/>
      <value value="6198809"/>
      <value value="5850443"/>
      <value value="9616155"/>
      <value value="8108888"/>
      <value value="362202"/>
      <value value="8885069"/>
      <value value="33834"/>
      <value value="5693250"/>
      <value value="37408"/>
      <value value="383073"/>
      <value value="5359224"/>
      <value value="3315976"/>
      <value value="3695362"/>
      <value value="30062"/>
      <value value="4020839"/>
      <value value="7029383"/>
      <value value="3071320"/>
      <value value="6200132"/>
      <value value="6862298"/>
      <value value="1045459"/>
      <value value="3539703"/>
      <value value="8181955"/>
      <value value="9489358"/>
      <value value="9486661"/>
      <value value="7847376"/>
      <value value="6864244"/>
      <value value="9908131"/>
      <value value="3759772"/>
      <value value="7886448"/>
      <value value="6814414"/>
      <value value="8253221"/>
      <value value="455048"/>
      <value value="1715261"/>
      <value value="452794"/>
      <value value="6327860"/>
      <value value="9372992"/>
      <value value="8729982"/>
      <value value="2057558"/>
      <value value="2120862"/>
      <value value="6845529"/>
      <value value="6848086"/>
      <value value="2319133"/>
      <value value="2077069"/>
      <value value="5563995"/>
      <value value="3857533"/>
      <value value="9649706"/>
      <value value="9528375"/>
      <value value="4421477"/>
      <value value="9424140"/>
      <value value="1199454"/>
      <value value="7707367"/>
      <value value="4138034"/>
      <value value="3840612"/>
      <value value="530376"/>
      <value value="5793438"/>
      <value value="3418477"/>
      <value value="9322811"/>
      <value value="9267881"/>
      <value value="7196493"/>
      <value value="4217312"/>
      <value value="6497475"/>
      <value value="3136424"/>
      <value value="6970384"/>
      <value value="4034830"/>
      <value value="919372"/>
      <value value="4476336"/>
      <value value="1039998"/>
      <value value="7752924"/>
      <value value="4221283"/>
      <value value="5409868"/>
      <value value="4190439"/>
      <value value="572430"/>
      <value value="6793979"/>
      <value value="1161088"/>
      <value value="5028295"/>
      <value value="6797731"/>
      <value value="9085970"/>
      <value value="5161288"/>
      <value value="4650851"/>
      <value value="5561968"/>
      <value value="2385741"/>
      <value value="7846017"/>
      <value value="6128659"/>
      <value value="8214786"/>
      <value value="2110660"/>
      <value value="5032555"/>
      <value value="6379202"/>
      <value value="6377356"/>
      <value value="1127381"/>
      <value value="3345947"/>
      <value value="4312888"/>
      <value value="2935384"/>
      <value value="4477699"/>
      <value value="2637236"/>
      <value value="4250065"/>
      <value value="2343059"/>
      <value value="1208123"/>
      <value value="6229122"/>
      <value value="7652218"/>
      <value value="7256318"/>
      <value value="7426088"/>
      <value value="3137002"/>
      <value value="8784341"/>
      <value value="8505093"/>
      <value value="7663829"/>
      <value value="7000195"/>
      <value value="9173415"/>
      <value value="5924770"/>
      <value value="3076024"/>
      <value value="8606114"/>
      <value value="1479563"/>
      <value value="1578402"/>
      <value value="3794652"/>
      <value value="5895794"/>
      <value value="3785756"/>
      <value value="8099982"/>
      <value value="3669830"/>
      <value value="8740151"/>
      <value value="1068446"/>
      <value value="3025295"/>
      <value value="6154648"/>
      <value value="7775345"/>
      <value value="43294"/>
      <value value="6515056"/>
      <value value="6276762"/>
      <value value="471266"/>
      <value value="3813297"/>
      <value value="4881445"/>
      <value value="6910317"/>
      <value value="9073816"/>
      <value value="9718772"/>
      <value value="7850643"/>
      <value value="5589188"/>
      <value value="7062329"/>
      <value value="1233058"/>
      <value value="3584279"/>
      <value value="2305255"/>
      <value value="8902507"/>
      <value value="4583903"/>
      <value value="8253525"/>
      <value value="8131471"/>
      <value value="1326279"/>
      <value value="7264687"/>
      <value value="6759132"/>
      <value value="4164630"/>
      <value value="4145539"/>
      <value value="8665617"/>
      <value value="3732889"/>
      <value value="9108288"/>
      <value value="683576"/>
      <value value="3160265"/>
      <value value="8264802"/>
      <value value="9780217"/>
      <value value="1291856"/>
      <value value="805551"/>
      <value value="1625588"/>
      <value value="2726078"/>
      <value value="3198558"/>
      <value value="7041199"/>
      <value value="7729753"/>
      <value value="7982375"/>
      <value value="9821536"/>
      <value value="9049890"/>
      <value value="6789000"/>
      <value value="1440985"/>
      <value value="561422"/>
      <value value="1660878"/>
      <value value="7009375"/>
      <value value="1796484"/>
      <value value="9194295"/>
      <value value="5018082"/>
      <value value="5458334"/>
      <value value="7696277"/>
      <value value="7856944"/>
      <value value="1538062"/>
      <value value="5373107"/>
      <value value="6076211"/>
      <value value="6901205"/>
      <value value="2344867"/>
      <value value="854624"/>
      <value value="66818"/>
      <value value="365134"/>
      <value value="1919676"/>
      <value value="8255994"/>
      <value value="4268606"/>
      <value value="9881728"/>
      <value value="9359796"/>
      <value value="8676813"/>
      <value value="543688"/>
      <value value="2504225"/>
      <value value="9945853"/>
      <value value="1201657"/>
      <value value="3080415"/>
      <value value="3771677"/>
      <value value="1639881"/>
      <value value="4520412"/>
      <value value="7293977"/>
      <value value="1325061"/>
      <value value="4606536"/>
      <value value="8032282"/>
      <value value="5759222"/>
      <value value="403542"/>
      <value value="9577176"/>
      <value value="9666048"/>
      <value value="60904"/>
      <value value="1844441"/>
      <value value="9417898"/>
      <value value="2179082"/>
      <value value="4177815"/>
      <value value="2628641"/>
      <value value="4814935"/>
      <value value="207625"/>
      <value value="5221894"/>
      <value value="6859037"/>
      <value value="816850"/>
      <value value="6232637"/>
      <value value="4639402"/>
      <value value="3577603"/>
      <value value="705506"/>
      <value value="931083"/>
      <value value="1717409"/>
      <value value="9518662"/>
      <value value="2115038"/>
      <value value="9752799"/>
      <value value="1531191"/>
      <value value="1680587"/>
      <value value="8174557"/>
      <value value="4908839"/>
      <value value="829416"/>
      <value value="1549198"/>
      <value value="2959223"/>
      <value value="8566292"/>
      <value value="4164063"/>
      <value value="3291985"/>
      <value value="5155581"/>
      <value value="6414371"/>
      <value value="2809547"/>
      <value value="2285555"/>
      <value value="4263407"/>
      <value value="1133113"/>
      <value value="4490332"/>
      <value value="7822775"/>
      <value value="78252"/>
      <value value="5695228"/>
      <value value="4788363"/>
      <value value="4320269"/>
      <value value="5625980"/>
      <value value="5671128"/>
      <value value="517270"/>
      <value value="7878357"/>
      <value value="7831826"/>
      <value value="954658"/>
      <value value="2764365"/>
      <value value="7908316"/>
      <value value="2176925"/>
      <value value="7977232"/>
      <value value="1925994"/>
      <value value="2282919"/>
      <value value="5754056"/>
      <value value="7265334"/>
      <value value="7846618"/>
      <value value="1546594"/>
      <value value="5071945"/>
      <value value="8941915"/>
      <value value="3966394"/>
      <value value="1004760"/>
      <value value="9100142"/>
      <value value="6781641"/>
      <value value="3856441"/>
      <value value="5953253"/>
      <value value="4380825"/>
      <value value="7497786"/>
      <value value="4195361"/>
      <value value="4239208"/>
      <value value="5642938"/>
      <value value="310379"/>
      <value value="5667452"/>
      <value value="9781432"/>
      <value value="2681125"/>
      <value value="4033324"/>
      <value value="2335385"/>
      <value value="7194163"/>
      <value value="4938996"/>
      <value value="6541909"/>
      <value value="5506755"/>
      <value value="6198058"/>
      <value value="8943970"/>
      <value value="9178224"/>
      <value value="4448055"/>
      <value value="6940142"/>
      <value value="5850111"/>
      <value value="6876237"/>
      <value value="2960556"/>
      <value value="396097"/>
      <value value="8467235"/>
      <value value="916833"/>
      <value value="7983580"/>
      <value value="8632521"/>
      <value value="7026962"/>
      <value value="6080740"/>
      <value value="7091568"/>
      <value value="6088800"/>
      <value value="5783129"/>
      <value value="5062334"/>
      <value value="8353317"/>
      <value value="9532452"/>
      <value value="7786343"/>
      <value value="7431629"/>
      <value value="9102698"/>
      <value value="6963442"/>
      <value value="1202815"/>
      <value value="9524581"/>
      <value value="9884865"/>
      <value value="6460189"/>
      <value value="5434948"/>
      <value value="9602596"/>
      <value value="1914120"/>
      <value value="9653202"/>
      <value value="7570650"/>
      <value value="9093701"/>
      <value value="3183157"/>
      <value value="1357076"/>
      <value value="5545420"/>
      <value value="2259489"/>
      <value value="7367032"/>
      <value value="8761957"/>
      <value value="6556251"/>
      <value value="9069892"/>
      <value value="13184"/>
      <value value="5703526"/>
      <value value="4918257"/>
      <value value="6513047"/>
      <value value="9649691"/>
      <value value="565341"/>
      <value value="2983151"/>
      <value value="4971119"/>
      <value value="1831578"/>
      <value value="8615485"/>
      <value value="7625919"/>
      <value value="8648528"/>
      <value value="5660902"/>
      <value value="1096211"/>
      <value value="741700"/>
      <value value="2246862"/>
      <value value="745988"/>
      <value value="9374470"/>
      <value value="7633659"/>
      <value value="6816288"/>
      <value value="6231545"/>
      <value value="7483009"/>
      <value value="1942941"/>
      <value value="4890607"/>
      <value value="5580028"/>
      <value value="4459400"/>
      <value value="4552321"/>
      <value value="6184464"/>
      <value value="9628556"/>
      <value value="5183302"/>
      <value value="8698605"/>
      <value value="2739935"/>
      <value value="4868964"/>
      <value value="6337619"/>
      <value value="1785047"/>
      <value value="6067128"/>
      <value value="7454741"/>
      <value value="3782285"/>
      <value value="668177"/>
      <value value="748874"/>
      <value value="1120118"/>
      <value value="1285608"/>
      <value value="1545667"/>
      <value value="7959374"/>
      <value value="492816"/>
      <value value="3939132"/>
      <value value="1476291"/>
      <value value="6406850"/>
      <value value="5854032"/>
      <value value="5254744"/>
      <value value="1892778"/>
      <value value="5319003"/>
      <value value="1247225"/>
      <value value="1791963"/>
      <value value="7265281"/>
      <value value="8825345"/>
      <value value="5211463"/>
      <value value="9090694"/>
      <value value="1096077"/>
      <value value="1990094"/>
      <value value="8682828"/>
      <value value="837426"/>
      <value value="4475430"/>
      <value value="5849681"/>
      <value value="2001047"/>
      <value value="1504365"/>
      <value value="7118172"/>
      <value value="6203608"/>
      <value value="8930294"/>
      <value value="5325180"/>
      <value value="9817199"/>
      <value value="5631237"/>
      <value value="9406395"/>
      <value value="9030844"/>
      <value value="3822268"/>
      <value value="7931455"/>
      <value value="1877348"/>
      <value value="7250465"/>
      <value value="1590520"/>
      <value value="8754905"/>
      <value value="487874"/>
      <value value="1950360"/>
      <value value="42155"/>
      <value value="7913510"/>
      <value value="8592144"/>
      <value value="1412700"/>
      <value value="7036979"/>
      <value value="7416986"/>
      <value value="8003145"/>
      <value value="1199726"/>
      <value value="9027882"/>
      <value value="3690118"/>
      <value value="9622992"/>
      <value value="5605466"/>
      <value value="9633050"/>
      <value value="4112398"/>
      <value value="6468007"/>
      <value value="7274981"/>
      <value value="910584"/>
      <value value="5453426"/>
      <value value="57561"/>
      <value value="3353901"/>
      <value value="7631367"/>
      <value value="7691420"/>
      <value value="9241180"/>
      <value value="4166153"/>
      <value value="1351986"/>
      <value value="8960844"/>
      <value value="9557659"/>
      <value value="2273086"/>
      <value value="8273459"/>
      <value value="1367322"/>
      <value value="6833956"/>
      <value value="7395386"/>
      <value value="3223681"/>
      <value value="1803705"/>
      <value value="3676638"/>
      <value value="2000332"/>
      <value value="5093492"/>
      <value value="88138"/>
      <value value="6610289"/>
      <value value="5335959"/>
      <value value="9818858"/>
      <value value="1651755"/>
      <value value="5327785"/>
      <value value="9141066"/>
      <value value="917446"/>
      <value value="2182493"/>
      <value value="9607150"/>
      <value value="2657704"/>
      <value value="7915951"/>
      <value value="231705"/>
      <value value="406062"/>
      <value value="674916"/>
      <value value="6855524"/>
      <value value="1269262"/>
      <value value="8271855"/>
      <value value="8375908"/>
      <value value="9886170"/>
      <value value="8102049"/>
      <value value="1260359"/>
      <value value="6100163"/>
      <value value="4093656"/>
      <value value="3397805"/>
      <value value="4344500"/>
      <value value="638483"/>
      <value value="4770855"/>
      <value value="370815"/>
      <value value="9834049"/>
      <value value="3060118"/>
      <value value="4922321"/>
      <value value="4861777"/>
      <value value="8880434"/>
      <value value="1037599"/>
      <value value="5190362"/>
      <value value="5136059"/>
      <value value="1656728"/>
      <value value="8687721"/>
      <value value="4954794"/>
      <value value="4747833"/>
      <value value="7236004"/>
      <value value="5246841"/>
      <value value="6379297"/>
      <value value="518230"/>
      <value value="9248130"/>
      <value value="370343"/>
      <value value="4123667"/>
      <value value="2079229"/>
      <value value="463152"/>
      <value value="6252132"/>
      <value value="4867163"/>
      <value value="9935595"/>
      <value value="8722900"/>
      <value value="8269340"/>
      <value value="3607984"/>
      <value value="356708"/>
      <value value="807184"/>
      <value value="3590972"/>
      <value value="7491049"/>
      <value value="2448266"/>
      <value value="5124295"/>
      <value value="805742"/>
      <value value="9789541"/>
      <value value="6186215"/>
      <value value="6148082"/>
      <value value="7619686"/>
      <value value="7674867"/>
      <value value="2370720"/>
      <value value="4021304"/>
      <value value="8971345"/>
      <value value="8507549"/>
      <value value="7426976"/>
      <value value="298198"/>
      <value value="2270686"/>
      <value value="4096908"/>
      <value value="1202327"/>
      <value value="9471836"/>
      <value value="2007679"/>
      <value value="1208104"/>
      <value value="7439485"/>
      <value value="1217040"/>
      <value value="70847"/>
      <value value="1233703"/>
      <value value="1281128"/>
      <value value="8195008"/>
      <value value="2369316"/>
      <value value="9792136"/>
      <value value="6247704"/>
      <value value="1553936"/>
      <value value="3246445"/>
      <value value="6533568"/>
      <value value="4940691"/>
      <value value="2409586"/>
      <value value="1901512"/>
      <value value="422825"/>
      <value value="2483987"/>
      <value value="6397834"/>
      <value value="9470909"/>
      <value value="6143662"/>
      <value value="469752"/>
      <value value="8195403"/>
      <value value="1865303"/>
      <value value="6393148"/>
      <value value="963936"/>
      <value value="6930924"/>
      <value value="5519172"/>
      <value value="8107445"/>
      <value value="5555446"/>
      <value value="1083296"/>
      <value value="5877050"/>
      <value value="8513341"/>
      <value value="9316379"/>
      <value value="2010977"/>
      <value value="9679959"/>
      <value value="9458814"/>
      <value value="6511237"/>
      <value value="3528487"/>
      <value value="399802"/>
      <value value="1704290"/>
      <value value="891160"/>
      <value value="1406823"/>
      <value value="4225078"/>
      <value value="3662333"/>
      <value value="4763339"/>
      <value value="8719004"/>
      <value value="8616032"/>
      <value value="1858156"/>
      <value value="2389625"/>
      <value value="7076128"/>
      <value value="7282411"/>
      <value value="9859690"/>
      <value value="385376"/>
      <value value="2134535"/>
      <value value="1723598"/>
      <value value="6199325"/>
      <value value="6755270"/>
      <value value="7907613"/>
      <value value="388478"/>
      <value value="9620729"/>
      <value value="4179369"/>
      <value value="5902152"/>
      <value value="2008429"/>
      <value value="6237821"/>
      <value value="6626601"/>
      <value value="4335500"/>
      <value value="9475522"/>
      <value value="5113306"/>
      <value value="1381685"/>
      <value value="5401298"/>
      <value value="5175054"/>
      <value value="5756154"/>
      <value value="6212645"/>
      <value value="9371151"/>
      <value value="7878314"/>
      <value value="9091675"/>
      <value value="7253861"/>
      <value value="5949197"/>
      <value value="678930"/>
      <value value="8993910"/>
      <value value="5498717"/>
      <value value="3828020"/>
      <value value="9242127"/>
      <value value="3421859"/>
      <value value="949657"/>
      <value value="3233971"/>
      <value value="1996448"/>
      <value value="3009062"/>
      <value value="9670782"/>
      <value value="2520249"/>
      <value value="8191265"/>
      <value value="2971277"/>
      <value value="3973843"/>
      <value value="8310052"/>
      <value value="1195793"/>
      <value value="1568263"/>
      <value value="5430306"/>
      <value value="9831265"/>
      <value value="7182028"/>
      <value value="4052711"/>
      <value value="3921780"/>
      <value value="839422"/>
      <value value="7400465"/>
      <value value="3344142"/>
      <value value="527126"/>
      <value value="8923429"/>
      <value value="7933176"/>
      <value value="5347190"/>
      <value value="4118137"/>
      <value value="9077902"/>
      <value value="840868"/>
      <value value="9537738"/>
      <value value="8426409"/>
      <value value="8730926"/>
      <value value="2839009"/>
      <value value="8099729"/>
      <value value="7801525"/>
      <value value="3415530"/>
      <value value="3860681"/>
      <value value="3521258"/>
      <value value="6305923"/>
      <value value="5690771"/>
      <value value="2504117"/>
      <value value="1966384"/>
      <value value="3593622"/>
      <value value="3103879"/>
      <value value="1574218"/>
      <value value="4905046"/>
      <value value="800883"/>
      <value value="5688795"/>
      <value value="3739606"/>
      <value value="1492186"/>
      <value value="8526856"/>
      <value value="328631"/>
      <value value="6364779"/>
      <value value="7895666"/>
      <value value="424602"/>
      <value value="105909"/>
      <value value="2373217"/>
      <value value="4854765"/>
      <value value="9166125"/>
      <value value="8098424"/>
      <value value="6348351"/>
      <value value="4185096"/>
      <value value="1328218"/>
      <value value="6405809"/>
      <value value="6342186"/>
      <value value="3087723"/>
      <value value="9268831"/>
      <value value="1288412"/>
      <value value="1984433"/>
      <value value="8287451"/>
      <value value="5038247"/>
      <value value="7546951"/>
      <value value="8919096"/>
      <value value="904235"/>
      <value value="3817943"/>
      <value value="3078077"/>
      <value value="2709816"/>
      <value value="5968122"/>
      <value value="1828927"/>
      <value value="2569699"/>
      <value value="2617813"/>
      <value value="3153457"/>
      <value value="7469691"/>
      <value value="6318991"/>
      <value value="6278338"/>
      <value value="2264853"/>
      <value value="4243590"/>
      <value value="9976619"/>
      <value value="1116058"/>
      <value value="3940817"/>
      <value value="1209788"/>
      <value value="4397096"/>
      <value value="9712476"/>
      <value value="4976857"/>
      <value value="1140360"/>
      <value value="5109794"/>
      <value value="2140669"/>
      <value value="4865403"/>
      <value value="3108412"/>
      <value value="4364390"/>
      <value value="2422237"/>
      <value value="196987"/>
      <value value="6527357"/>
      <value value="4695624"/>
      <value value="6681833"/>
      <value value="1435191"/>
      <value value="8656509"/>
      <value value="2839935"/>
      <value value="3910648"/>
      <value value="1077129"/>
      <value value="8492751"/>
      <value value="1795961"/>
      <value value="1353771"/>
      <value value="908791"/>
      <value value="6731224"/>
      <value value="2581386"/>
      <value value="6220339"/>
      <value value="2460455"/>
      <value value="8874342"/>
      <value value="2782138"/>
      <value value="7437345"/>
      <value value="413111"/>
      <value value="8328103"/>
      <value value="9016321"/>
      <value value="8667052"/>
      <value value="3334035"/>
      <value value="4349234"/>
      <value value="192336"/>
      <value value="6490992"/>
      <value value="4640344"/>
      <value value="354389"/>
      <value value="5194074"/>
      <value value="764957"/>
      <value value="8510973"/>
      <value value="7482668"/>
      <value value="1191595"/>
      <value value="9797760"/>
      <value value="7254423"/>
      <value value="970278"/>
      <value value="3459139"/>
      <value value="8649437"/>
      <value value="2917464"/>
      <value value="2165643"/>
      <value value="4378342"/>
      <value value="6806792"/>
      <value value="7703439"/>
      <value value="6255253"/>
      <value value="1836797"/>
      <value value="8788308"/>
      <value value="2895461"/>
      <value value="6212524"/>
      <value value="7089024"/>
      <value value="8079521"/>
      <value value="8513393"/>
      <value value="7775855"/>
      <value value="7757391"/>
      <value value="9663573"/>
      <value value="3831142"/>
      <value value="5372444"/>
      <value value="8386296"/>
      <value value="9074030"/>
      <value value="8023785"/>
      <value value="556798"/>
      <value value="5545186"/>
      <value value="3876832"/>
      <value value="5361840"/>
      <value value="8551369"/>
      <value value="8282357"/>
      <value value="2070053"/>
      <value value="6458491"/>
      <value value="8262495"/>
      <value value="3024084"/>
      <value value="9475308"/>
      <value value="8332081"/>
      <value value="3132830"/>
      <value value="3974849"/>
      <value value="3991660"/>
      <value value="2480556"/>
      <value value="1525839"/>
      <value value="5127426"/>
      <value value="4706619"/>
      <value value="9325385"/>
      <value value="5560550"/>
      <value value="8438852"/>
      <value value="9264570"/>
      <value value="672294"/>
      <value value="5449508"/>
      <value value="2119226"/>
      <value value="7535845"/>
      <value value="6601878"/>
      <value value="6838849"/>
      <value value="6758389"/>
      <value value="7250059"/>
      <value value="7122249"/>
      <value value="2647237"/>
      <value value="4277989"/>
      <value value="8357150"/>
      <value value="1608373"/>
      <value value="9188640"/>
      <value value="9899737"/>
      <value value="9694891"/>
      <value value="2200737"/>
      <value value="3324849"/>
      <value value="7426612"/>
      <value value="8395824"/>
      <value value="678006"/>
      <value value="3388549"/>
      <value value="3789905"/>
      <value value="3009825"/>
      <value value="8794280"/>
      <value value="3089437"/>
      <value value="5935059"/>
      <value value="2310300"/>
      <value value="5956097"/>
      <value value="7412727"/>
      <value value="9804676"/>
      <value value="9902791"/>
      <value value="1015799"/>
      <value value="1323684"/>
      <value value="371492"/>
      <value value="648636"/>
      <value value="7920445"/>
      <value value="9831364"/>
      <value value="3935892"/>
      <value value="2022593"/>
      <value value="6853791"/>
      <value value="5820333"/>
      <value value="7807559"/>
      <value value="8029776"/>
      <value value="1479611"/>
      <value value="4765664"/>
      <value value="2306440"/>
      <value value="1337813"/>
      <value value="4365599"/>
      <value value="4918394"/>
      <value value="9085951"/>
      <value value="4270897"/>
      <value value="1022017"/>
      <value value="8460587"/>
      <value value="9135482"/>
      <value value="8786734"/>
      <value value="2520774"/>
      <value value="6810586"/>
      <value value="3745161"/>
      <value value="6973512"/>
      <value value="5478209"/>
      <value value="377188"/>
      <value value="5544923"/>
      <value value="497747"/>
      <value value="5749101"/>
      <value value="9175408"/>
      <value value="9141082"/>
      <value value="7782138"/>
      <value value="5613973"/>
      <value value="5304093"/>
      <value value="6045773"/>
      <value value="5164377"/>
      <value value="7889063"/>
      <value value="4856268"/>
      <value value="3829543"/>
      <value value="924332"/>
      <value value="6268854"/>
      <value value="420796"/>
      <value value="2586933"/>
      <value value="233979"/>
      <value value="6915286"/>
      <value value="3148022"/>
      <value value="3519245"/>
      <value value="4874923"/>
      <value value="474584"/>
      <value value="8220899"/>
      <value value="5501517"/>
      <value value="9670020"/>
      <value value="9456636"/>
      <value value="2408946"/>
      <value value="9308595"/>
      <value value="9264908"/>
      <value value="2017286"/>
      <value value="4238233"/>
      <value value="2679590"/>
      <value value="4602131"/>
      <value value="1339053"/>
      <value value="7007722"/>
      <value value="5350261"/>
      <value value="1142516"/>
      <value value="1325854"/>
      <value value="9624683"/>
      <value value="9574668"/>
      <value value="3508151"/>
      <value value="3761038"/>
      <value value="2196246"/>
      <value value="8271731"/>
      <value value="596489"/>
      <value value="7994651"/>
      <value value="8940661"/>
      <value value="6898756"/>
      <value value="5795457"/>
      <value value="9038377"/>
      <value value="744813"/>
      <value value="3114813"/>
      <value value="656023"/>
      <value value="4351039"/>
      <value value="7047012"/>
      <value value="6408589"/>
      <value value="5123256"/>
      <value value="8637125"/>
      <value value="5762200"/>
      <value value="6186853"/>
      <value value="4172320"/>
      <value value="9176416"/>
      <value value="8721158"/>
      <value value="4100888"/>
      <value value="1516575"/>
      <value value="2663264"/>
      <value value="4335038"/>
      <value value="9943566"/>
      <value value="7028578"/>
      <value value="2245061"/>
      <value value="7181306"/>
      <value value="8275299"/>
      <value value="2094556"/>
      <value value="7928269"/>
      <value value="6432970"/>
      <value value="5732872"/>
      <value value="6388036"/>
      <value value="7368406"/>
      <value value="347480"/>
      <value value="4676090"/>
      <value value="4165121"/>
      <value value="2215309"/>
      <value value="1432269"/>
      <value value="1309582"/>
      <value value="5490805"/>
      <value value="1196933"/>
      <value value="6452240"/>
      <value value="4343034"/>
      <value value="7304358"/>
      <value value="6335948"/>
      <value value="6440872"/>
      <value value="990142"/>
      <value value="9914286"/>
      <value value="8064698"/>
      <value value="9802364"/>
      <value value="2190088"/>
      <value value="1072891"/>
      <value value="3676174"/>
      <value value="7138549"/>
      <value value="9702873"/>
      <value value="3185589"/>
      <value value="9675407"/>
      <value value="3731753"/>
      <value value="2767580"/>
      <value value="6573241"/>
      <value value="7807344"/>
      <value value="5051251"/>
      <value value="717281"/>
      <value value="2705889"/>
      <value value="7094651"/>
      <value value="3487327"/>
      <value value="4973305"/>
      <value value="9022784"/>
      <value value="532889"/>
      <value value="9668514"/>
      <value value="5051900"/>
      <value value="7054408"/>
      <value value="2429839"/>
      <value value="8531648"/>
      <value value="1026753"/>
      <value value="8330691"/>
      <value value="6060994"/>
      <value value="6138028"/>
      <value value="3847730"/>
      <value value="2440342"/>
      <value value="602134"/>
      <value value="7914340"/>
      <value value="9477636"/>
      <value value="7293328"/>
      <value value="8231218"/>
      <value value="4227087"/>
      <value value="4361280"/>
      <value value="6586783"/>
      <value value="7164836"/>
      <value value="5087380"/>
      <value value="376601"/>
      <value value="2332804"/>
      <value value="6236964"/>
      <value value="8449078"/>
      <value value="5728710"/>
      <value value="6328995"/>
      <value value="1598856"/>
      <value value="571771"/>
      <value value="1410429"/>
      <value value="3201002"/>
      <value value="1145440"/>
      <value value="6980682"/>
      <value value="4482835"/>
      <value value="7529729"/>
      <value value="3229834"/>
      <value value="6553402"/>
      <value value="6297227"/>
      <value value="8146895"/>
      <value value="6233559"/>
      <value value="334357"/>
      <value value="8190083"/>
      <value value="6746932"/>
      <value value="1937787"/>
      <value value="2693254"/>
      <value value="733408"/>
      <value value="1628828"/>
      <value value="5132204"/>
      <value value="9251243"/>
      <value value="5632425"/>
      <value value="1893104"/>
      <value value="5813693"/>
      <value value="5305173"/>
      <value value="6253390"/>
      <value value="380594"/>
      <value value="7258951"/>
      <value value="9003398"/>
      <value value="6711088"/>
      <value value="1691679"/>
      <value value="2389936"/>
      <value value="535629"/>
      <value value="4512690"/>
      <value value="3873370"/>
      <value value="4595794"/>
      <value value="1421203"/>
      <value value="9114453"/>
      <value value="1336313"/>
      <value value="2826209"/>
      <value value="716548"/>
      <value value="1312292"/>
      <value value="4369872"/>
      <value value="4638362"/>
      <value value="510723"/>
      <value value="6692269"/>
      <value value="73885"/>
      <value value="4655805"/>
      <value value="6744974"/>
      <value value="2459136"/>
      <value value="5932992"/>
      <value value="9166567"/>
      <value value="8122796"/>
      <value value="9275113"/>
      <value value="4416532"/>
      <value value="8740801"/>
      <value value="2147653"/>
      <value value="5360977"/>
      <value value="4405504"/>
      <value value="9270559"/>
      <value value="4176573"/>
      <value value="4027286"/>
      <value value="3350264"/>
      <value value="5006240"/>
      <value value="4816805"/>
      <value value="1587787"/>
      <value value="1161040"/>
      <value value="8497558"/>
      <value value="1746466"/>
      <value value="9667807"/>
      <value value="1231752"/>
      <value value="3875501"/>
      <value value="4534221"/>
      <value value="1320494"/>
      <value value="4058976"/>
      <value value="5216402"/>
      <value value="6443576"/>
      <value value="5234802"/>
      <value value="9971526"/>
      <value value="7902119"/>
      <value value="2377041"/>
      <value value="640319"/>
      <value value="6416630"/>
      <value value="4915348"/>
      <value value="6356727"/>
      <value value="9435973"/>
      <value value="7513252"/>
      <value value="1933337"/>
      <value value="4692496"/>
      <value value="8813231"/>
      <value value="3370636"/>
      <value value="9119490"/>
      <value value="377164"/>
      <value value="1443587"/>
      <value value="553320"/>
      <value value="1473744"/>
      <value value="3450452"/>
      <value value="9734689"/>
      <value value="5017894"/>
      <value value="9499777"/>
      <value value="2284676"/>
      <value value="4216376"/>
      <value value="2498467"/>
      <value value="1280299"/>
      <value value="2735217"/>
      <value value="4706485"/>
      <value value="2834503"/>
      <value value="1941820"/>
      <value value="6188814"/>
      <value value="8317521"/>
      <value value="7971760"/>
      <value value="9551443"/>
      <value value="4598942"/>
      <value value="3406214"/>
      <value value="3285384"/>
      <value value="8572152"/>
      <value value="9113199"/>
      <value value="6023480"/>
      <value value="5812968"/>
      <value value="418479"/>
      <value value="640543"/>
      <value value="6162868"/>
      <value value="1385151"/>
      <value value="6391659"/>
      <value value="2019320"/>
      <value value="3431053"/>
      <value value="716579"/>
      <value value="2024245"/>
      <value value="5464913"/>
      <value value="8848694"/>
      <value value="4501098"/>
      <value value="2506208"/>
      <value value="8460824"/>
      <value value="2799641"/>
      <value value="5282126"/>
      <value value="1783108"/>
      <value value="2358314"/>
      <value value="3433157"/>
      <value value="8711940"/>
      <value value="8642641"/>
      <value value="4158576"/>
      <value value="1977257"/>
      <value value="9672332"/>
      <value value="2114457"/>
      <value value="5339258"/>
      <value value="9668748"/>
      <value value="3310381"/>
      <value value="8785108"/>
      <value value="4120954"/>
      <value value="8641607"/>
      <value value="9451835"/>
      <value value="2276398"/>
      <value value="8631779"/>
      <value value="8391174"/>
      <value value="1190005"/>
      <value value="5892552"/>
      <value value="6831186"/>
      <value value="2530711"/>
      <value value="4107821"/>
      <value value="5161990"/>
      <value value="491678"/>
      <value value="8840243"/>
      <value value="3125195"/>
      <value value="5287423"/>
      <value value="6651731"/>
      <value value="8196722"/>
      <value value="96353"/>
      <value value="5981196"/>
      <value value="6476416"/>
      <value value="3587978"/>
      <value value="4864788"/>
      <value value="388537"/>
      <value value="9731179"/>
      <value value="7094700"/>
      <value value="6023680"/>
      <value value="9603722"/>
      <value value="4873261"/>
      <value value="8390005"/>
      <value value="1036736"/>
      <value value="9548239"/>
      <value value="9140467"/>
      <value value="7931360"/>
      <value value="6722362"/>
      <value value="2688541"/>
      <value value="1742225"/>
      <value value="4776782"/>
      <value value="7710997"/>
      <value value="2941194"/>
      <value value="5655101"/>
      <value value="8148559"/>
      <value value="6612955"/>
      <value value="2423284"/>
      <value value="1806119"/>
      <value value="3890045"/>
      <value value="189643"/>
      <value value="2148831"/>
      <value value="9541238"/>
      <value value="6996995"/>
      <value value="1058087"/>
      <value value="2797181"/>
      <value value="670254"/>
      <value value="643503"/>
      <value value="1795490"/>
      <value value="8662651"/>
      <value value="5511275"/>
      <value value="9176340"/>
      <value value="2444360"/>
      <value value="4080999"/>
      <value value="8682285"/>
      <value value="7236131"/>
      <value value="2836115"/>
      <value value="7308364"/>
      <value value="5300159"/>
      <value value="5269707"/>
      <value value="5493465"/>
      <value value="990395"/>
      <value value="8864843"/>
      <value value="4273682"/>
      <value value="6961628"/>
      <value value="7382706"/>
      <value value="4466278"/>
      <value value="6648555"/>
      <value value="7947960"/>
      <value value="9237404"/>
      <value value="5648587"/>
      <value value="6518116"/>
      <value value="7391442"/>
      <value value="3942031"/>
      <value value="4429388"/>
      <value value="4018235"/>
      <value value="1856764"/>
      <value value="6279065"/>
      <value value="5442737"/>
      <value value="2026846"/>
      <value value="3089053"/>
      <value value="4103782"/>
      <value value="1719186"/>
      <value value="4684841"/>
      <value value="5602433"/>
      <value value="4871242"/>
      <value value="7791526"/>
      <value value="7147289"/>
      <value value="1291992"/>
      <value value="2222250"/>
      <value value="4190075"/>
      <value value="4724070"/>
      <value value="7242349"/>
      <value value="1146898"/>
      <value value="4803009"/>
      <value value="4186048"/>
      <value value="4730318"/>
      <value value="4763866"/>
      <value value="8259181"/>
      <value value="7076240"/>
      <value value="388170"/>
      <value value="8790194"/>
      <value value="7925252"/>
      <value value="709810"/>
      <value value="7767238"/>
      <value value="6804818"/>
      <value value="6759794"/>
      <value value="6288688"/>
      <value value="9163792"/>
      <value value="8144692"/>
      <value value="793178"/>
      <value value="2446513"/>
      <value value="9313402"/>
      <value value="9333712"/>
      <value value="5940174"/>
      <value value="5763958"/>
      <value value="7389718"/>
      <value value="54809"/>
      <value value="6066523"/>
      <value value="1449486"/>
      <value value="6685346"/>
      <value value="48138"/>
      <value value="9636066"/>
      <value value="1394086"/>
      <value value="3810113"/>
      <value value="4638025"/>
      <value value="5070969"/>
      <value value="6244330"/>
      <value value="3192643"/>
      <value value="1773740"/>
      <value value="8215870"/>
      <value value="6692222"/>
      <value value="3499066"/>
      <value value="4640729"/>
      <value value="3147872"/>
      <value value="3786180"/>
      <value value="1434857"/>
      <value value="5103832"/>
      <value value="7396759"/>
      <value value="8544673"/>
      <value value="5785828"/>
      <value value="8423483"/>
      <value value="7080706"/>
      <value value="1418572"/>
      <value value="8577528"/>
      <value value="6704420"/>
      <value value="140969"/>
      <value value="9232298"/>
      <value value="9877500"/>
      <value value="943679"/>
      <value value="6892234"/>
      <value value="3120969"/>
      <value value="7627110"/>
      <value value="3900626"/>
      <value value="4033608"/>
      <value value="7846009"/>
      <value value="3381313"/>
      <value value="2863633"/>
      <value value="3740253"/>
      <value value="6136072"/>
      <value value="7772044"/>
      <value value="8321909"/>
      <value value="7053354"/>
      <value value="2988318"/>
      <value value="5240468"/>
      <value value="923015"/>
      <value value="9360428"/>
      <value value="7043979"/>
      <value value="4424294"/>
      <value value="3064972"/>
      <value value="6329070"/>
      <value value="1005510"/>
      <value value="2469105"/>
      <value value="7342249"/>
      <value value="1920621"/>
      <value value="3993009"/>
      <value value="6419148"/>
      <value value="804392"/>
      <value value="2184047"/>
      <value value="5627405"/>
      <value value="1880070"/>
      <value value="4033682"/>
      <value value="1094494"/>
      <value value="8643038"/>
      <value value="3201487"/>
      <value value="4495264"/>
      <value value="3488027"/>
      <value value="2140646"/>
      <value value="8783441"/>
      <value value="1091825"/>
      <value value="9222346"/>
      <value value="9032123"/>
      <value value="6751917"/>
      <value value="200965"/>
      <value value="5736408"/>
      <value value="1159155"/>
      <value value="2198958"/>
      <value value="4334889"/>
      <value value="1807565"/>
      <value value="2617055"/>
      <value value="5062781"/>
      <value value="3558432"/>
      <value value="2424746"/>
      <value value="6755753"/>
      <value value="2163701"/>
      <value value="679412"/>
      <value value="9574512"/>
      <value value="3127476"/>
      <value value="312272"/>
      <value value="6902311"/>
      <value value="1595814"/>
      <value value="1128683"/>
      <value value="9803830"/>
      <value value="6847911"/>
      <value value="3776294"/>
      <value value="8612956"/>
      <value value="6009723"/>
      <value value="6625673"/>
      <value value="5347358"/>
      <value value="4229358"/>
      <value value="1754779"/>
      <value value="8572460"/>
      <value value="734743"/>
      <value value="2601900"/>
      <value value="7343740"/>
      <value value="8494007"/>
      <value value="7755818"/>
      <value value="8849268"/>
      <value value="6909839"/>
      <value value="5951544"/>
      <value value="1692025"/>
      <value value="921405"/>
      <value value="8260056"/>
      <value value="1645247"/>
      <value value="9849851"/>
      <value value="7383537"/>
      <value value="2094228"/>
      <value value="8773449"/>
      <value value="1235293"/>
      <value value="4225573"/>
      <value value="4060021"/>
      <value value="7682850"/>
      <value value="6494623"/>
      <value value="85519"/>
      <value value="2419187"/>
      <value value="6457576"/>
      <value value="3610178"/>
      <value value="9409848"/>
      <value value="8361496"/>
      <value value="3547227"/>
      <value value="7725405"/>
      <value value="5316134"/>
      <value value="5250859"/>
      <value value="1107559"/>
      <value value="7101258"/>
      <value value="4330810"/>
      <value value="2487780"/>
      <value value="170316"/>
      <value value="7156967"/>
      <value value="3919401"/>
      <value value="9054508"/>
      <value value="8055693"/>
      <value value="2264131"/>
      <value value="4747201"/>
      <value value="1969344"/>
      <value value="5930413"/>
      <value value="9883041"/>
      <value value="1812919"/>
      <value value="6757216"/>
      <value value="5771659"/>
      <value value="6798535"/>
      <value value="4741169"/>
      <value value="8711479"/>
      <value value="4657344"/>
      <value value="1286404"/>
      <value value="3796189"/>
      <value value="9555785"/>
      <value value="3209623"/>
      <value value="4593797"/>
      <value value="1386189"/>
      <value value="4178093"/>
      <value value="651847"/>
      <value value="3940308"/>
      <value value="137507"/>
      <value value="6856689"/>
      <value value="5218606"/>
      <value value="4751096"/>
      <value value="8385531"/>
      <value value="8752514"/>
      <value value="5964754"/>
      <value value="5525669"/>
      <value value="7125959"/>
      <value value="7583966"/>
      <value value="8136459"/>
      <value value="5638490"/>
      <value value="1412590"/>
      <value value="3336205"/>
      <value value="2759615"/>
      <value value="9361183"/>
      <value value="91453"/>
      <value value="7628375"/>
      <value value="4606066"/>
      <value value="5780253"/>
      <value value="8930800"/>
      <value value="9397171"/>
      <value value="9541109"/>
      <value value="5985963"/>
      <value value="5146549"/>
      <value value="4876159"/>
      <value value="2577246"/>
      <value value="6670199"/>
      <value value="1250852"/>
      <value value="4759671"/>
      <value value="9502596"/>
      <value value="28142"/>
      <value value="5060947"/>
      <value value="8443951"/>
      <value value="9209188"/>
      <value value="6836229"/>
      <value value="389359"/>
      <value value="1038265"/>
      <value value="3451333"/>
      <value value="4779892"/>
      <value value="5799635"/>
      <value value="4773130"/>
      <value value="9961715"/>
      <value value="2057394"/>
      <value value="678197"/>
      <value value="9745287"/>
      <value value="4994663"/>
      <value value="3893368"/>
      <value value="4369200"/>
      <value value="5481569"/>
      <value value="7033449"/>
      <value value="2362113"/>
      <value value="4162868"/>
      <value value="7519253"/>
      <value value="8341469"/>
      <value value="4705724"/>
      <value value="7874376"/>
      <value value="6898898"/>
      <value value="2119574"/>
      <value value="3466880"/>
      <value value="9352500"/>
      <value value="4937398"/>
      <value value="9642972"/>
      <value value="7098518"/>
      <value value="8413146"/>
      <value value="5304671"/>
      <value value="7931524"/>
      <value value="3015667"/>
      <value value="4241488"/>
      <value value="1987619"/>
      <value value="6485583"/>
      <value value="8364592"/>
      <value value="7321915"/>
      <value value="9477494"/>
      <value value="9668967"/>
      <value value="3417462"/>
      <value value="6110102"/>
      <value value="6351644"/>
      <value value="5104996"/>
      <value value="845472"/>
      <value value="4945807"/>
      <value value="9421538"/>
      <value value="4255823"/>
      <value value="3138105"/>
      <value value="3547973"/>
      <value value="672788"/>
      <value value="3991001"/>
      <value value="146861"/>
      <value value="9096812"/>
      <value value="638351"/>
      <value value="892138"/>
      <value value="3326127"/>
      <value value="8077304"/>
      <value value="6431551"/>
      <value value="2087636"/>
      <value value="4540086"/>
      <value value="2678836"/>
      <value value="1792901"/>
      <value value="9174398"/>
      <value value="227435"/>
      <value value="3504496"/>
      <value value="3503324"/>
      <value value="7364750"/>
      <value value="3085181"/>
      <value value="3247707"/>
      <value value="5698764"/>
      <value value="6504300"/>
      <value value="5109233"/>
      <value value="8657235"/>
      <value value="7669714"/>
      <value value="8667077"/>
      <value value="180486"/>
      <value value="6531320"/>
      <value value="6942578"/>
      <value value="713919"/>
      <value value="8165207"/>
      <value value="8415934"/>
      <value value="658008"/>
      <value value="7759830"/>
      <value value="866553"/>
      <value value="2983522"/>
      <value value="3439390"/>
      <value value="5342652"/>
      <value value="72535"/>
      <value value="5610940"/>
      <value value="6216583"/>
      <value value="3371720"/>
      <value value="156255"/>
      <value value="1105849"/>
      <value value="7803955"/>
      <value value="5737494"/>
      <value value="7654957"/>
      <value value="2251505"/>
      <value value="3308708"/>
      <value value="3023949"/>
      <value value="1247592"/>
      <value value="1253642"/>
      <value value="3544222"/>
      <value value="1431886"/>
      <value value="7984430"/>
      <value value="6252130"/>
      <value value="6318445"/>
      <value value="7546271"/>
      <value value="3058938"/>
      <value value="2453794"/>
      <value value="2922749"/>
      <value value="226996"/>
      <value value="9535663"/>
      <value value="6802608"/>
      <value value="8566770"/>
      <value value="429306"/>
      <value value="9750638"/>
      <value value="8210926"/>
      <value value="3122419"/>
      <value value="7446454"/>
      <value value="5873492"/>
      <value value="2851205"/>
      <value value="2490942"/>
      <value value="3114990"/>
      <value value="5440261"/>
      <value value="5367403"/>
      <value value="8350539"/>
      <value value="4347487"/>
      <value value="4898081"/>
      <value value="7042129"/>
      <value value="3577025"/>
      <value value="530659"/>
      <value value="9362427"/>
      <value value="7472908"/>
      <value value="9693170"/>
      <value value="1065219"/>
      <value value="715268"/>
      <value value="8591847"/>
      <value value="6118932"/>
      <value value="6462777"/>
      <value value="3359551"/>
      <value value="1421640"/>
      <value value="4636922"/>
      <value value="10235"/>
      <value value="2555573"/>
      <value value="7146051"/>
      <value value="698706"/>
      <value value="3973009"/>
      <value value="107047"/>
      <value value="3468677"/>
      <value value="4501318"/>
      <value value="5082457"/>
      <value value="855851"/>
      <value value="7446110"/>
      <value value="3958610"/>
      <value value="5854560"/>
      <value value="7958271"/>
      <value value="8941497"/>
      <value value="2011555"/>
      <value value="9466655"/>
      <value value="3458348"/>
      <value value="7033974"/>
      <value value="8829079"/>
      <value value="5479565"/>
      <value value="1849223"/>
      <value value="7649315"/>
      <value value="5605046"/>
      <value value="1075341"/>
      <value value="6053281"/>
      <value value="7908697"/>
      <value value="1109330"/>
      <value value="8069908"/>
      <value value="9752069"/>
      <value value="5831802"/>
      <value value="4792631"/>
      <value value="3649084"/>
      <value value="6784767"/>
      <value value="3654544"/>
      <value value="675557"/>
      <value value="8728593"/>
      <value value="6795876"/>
      <value value="6633748"/>
      <value value="6386843"/>
      <value value="4899408"/>
      <value value="1219627"/>
      <value value="4968255"/>
      <value value="3484688"/>
      <value value="9734585"/>
      <value value="5613175"/>
      <value value="2997440"/>
      <value value="1911885"/>
      <value value="5357669"/>
      <value value="1905214"/>
      <value value="2604697"/>
      <value value="3359973"/>
      <value value="620122"/>
      <value value="8387188"/>
      <value value="438300"/>
      <value value="6000967"/>
      <value value="4932642"/>
      <value value="6255144"/>
      <value value="9901452"/>
      <value value="2403000"/>
      <value value="9830158"/>
      <value value="2154536"/>
      <value value="4927162"/>
      <value value="2915168"/>
      <value value="6554849"/>
      <value value="6001588"/>
      <value value="1203705"/>
      <value value="8298960"/>
      <value value="862859"/>
      <value value="532094"/>
      <value value="9913119"/>
      <value value="4318481"/>
      <value value="1652907"/>
      <value value="4448355"/>
      <value value="6886474"/>
      <value value="9773995"/>
      <value value="8557988"/>
      <value value="8865298"/>
      <value value="3213180"/>
      <value value="9911635"/>
      <value value="3576676"/>
      <value value="2971273"/>
      <value value="5167874"/>
      <value value="3594830"/>
      <value value="8663878"/>
      <value value="879791"/>
      <value value="6611932"/>
      <value value="4252650"/>
      <value value="2754548"/>
      <value value="9765488"/>
      <value value="7826306"/>
      <value value="6040382"/>
      <value value="3401613"/>
      <value value="6191949"/>
      <value value="3570291"/>
      <value value="8212687"/>
      <value value="5225751"/>
      <value value="3250956"/>
      <value value="9662416"/>
      <value value="789027"/>
      <value value="7372913"/>
      <value value="7641840"/>
      <value value="5545793"/>
      <value value="9534648"/>
      <value value="7273900"/>
      <value value="1211791"/>
      <value value="435024"/>
      <value value="231354"/>
      <value value="3064278"/>
      <value value="6953700"/>
      <value value="5129402"/>
      <value value="7440328"/>
      <value value="7164786"/>
      <value value="1651543"/>
      <value value="1230785"/>
      <value value="608102"/>
      <value value="7787172"/>
      <value value="3474579"/>
      <value value="6434485"/>
      <value value="7934640"/>
      <value value="4569720"/>
      <value value="4946195"/>
      <value value="8563009"/>
      <value value="4925183"/>
      <value value="4758584"/>
      <value value="1416560"/>
      <value value="144572"/>
      <value value="3638037"/>
      <value value="1421480"/>
      <value value="2395902"/>
      <value value="1645371"/>
      <value value="8716884"/>
      <value value="6713734"/>
      <value value="4719901"/>
      <value value="4770660"/>
      <value value="6119512"/>
      <value value="9099183"/>
      <value value="2192577"/>
      <value value="90177"/>
      <value value="5111924"/>
      <value value="8510949"/>
      <value value="5015693"/>
      <value value="4421513"/>
      <value value="993997"/>
      <value value="7262921"/>
      <value value="4012477"/>
      <value value="9578275"/>
      <value value="4435451"/>
      <value value="4649413"/>
      <value value="1286166"/>
      <value value="2402671"/>
      <value value="6831111"/>
      <value value="5810057"/>
      <value value="5765687"/>
      <value value="102162"/>
      <value value="8949833"/>
      <value value="6263714"/>
      <value value="4910180"/>
      <value value="5296268"/>
      <value value="1963173"/>
      <value value="5723056"/>
      <value value="5027829"/>
      <value value="2200620"/>
      <value value="1092015"/>
      <value value="7597252"/>
      <value value="1482548"/>
      <value value="9833372"/>
      <value value="2597562"/>
      <value value="689281"/>
      <value value="1255172"/>
      <value value="9083928"/>
      <value value="6091585"/>
      <value value="2707566"/>
      <value value="3488108"/>
      <value value="7432976"/>
      <value value="2767865"/>
      <value value="9262785"/>
      <value value="8360610"/>
      <value value="6775776"/>
      <value value="5629244"/>
      <value value="7124976"/>
      <value value="9770426"/>
      <value value="3237493"/>
      <value value="1521144"/>
      <value value="8265841"/>
      <value value="2535888"/>
      <value value="1753274"/>
      <value value="3940512"/>
      <value value="8534414"/>
      <value value="3805340"/>
      <value value="2336434"/>
      <value value="6842098"/>
      <value value="2654141"/>
      <value value="4392545"/>
      <value value="2080496"/>
      <value value="5740873"/>
      <value value="4575890"/>
      <value value="6727166"/>
      <value value="3267387"/>
      <value value="5233499"/>
      <value value="2511017"/>
      <value value="6200333"/>
      <value value="5467452"/>
      <value value="6237977"/>
      <value value="886635"/>
      <value value="7203761"/>
      <value value="1604267"/>
      <value value="2713830"/>
      <value value="4491201"/>
      <value value="4762532"/>
      <value value="1835517"/>
      <value value="8314283"/>
      <value value="9234322"/>
      <value value="3339377"/>
      <value value="9729765"/>
      <value value="7610788"/>
      <value value="5269010"/>
      <value value="9534292"/>
      <value value="263017"/>
      <value value="6891831"/>
      <value value="4826869"/>
      <value value="3865787"/>
      <value value="7129089"/>
      <value value="71038"/>
      <value value="4173503"/>
      <value value="9806826"/>
      <value value="7078695"/>
      <value value="6784634"/>
      <value value="7052158"/>
      <value value="7076844"/>
      <value value="6849264"/>
      <value value="1019040"/>
      <value value="4743998"/>
      <value value="4030241"/>
      <value value="794265"/>
      <value value="1193962"/>
      <value value="2221679"/>
      <value value="2515586"/>
      <value value="2039477"/>
      <value value="3128428"/>
      <value value="4643534"/>
      <value value="8192443"/>
      <value value="9439170"/>
      <value value="3479690"/>
      <value value="1101242"/>
      <value value="670987"/>
      <value value="3200641"/>
      <value value="5146010"/>
      <value value="6149792"/>
      <value value="5693496"/>
      <value value="4716619"/>
      <value value="7778531"/>
      <value value="2844383"/>
      <value value="6940830"/>
      <value value="832974"/>
      <value value="4135772"/>
      <value value="7859622"/>
      <value value="6398276"/>
      <value value="9938508"/>
      <value value="2970553"/>
      <value value="8381737"/>
      <value value="8476074"/>
      <value value="9394849"/>
      <value value="4741768"/>
      <value value="7711977"/>
      <value value="7448406"/>
      <value value="6622784"/>
      <value value="9150660"/>
      <value value="2687803"/>
      <value value="9657528"/>
      <value value="6150056"/>
      <value value="8994252"/>
      <value value="5729162"/>
      <value value="1068630"/>
      <value value="4526744"/>
      <value value="7964042"/>
      <value value="5873467"/>
      <value value="4538624"/>
      <value value="3543519"/>
      <value value="5839243"/>
      <value value="4489321"/>
      <value value="6437675"/>
      <value value="7130028"/>
      <value value="8215404"/>
      <value value="6803467"/>
      <value value="8519010"/>
      <value value="6504131"/>
      <value value="5067841"/>
      <value value="6411371"/>
      <value value="2936484"/>
      <value value="3043708"/>
      <value value="1322180"/>
      <value value="9965229"/>
      <value value="573555"/>
      <value value="986392"/>
      <value value="8274593"/>
      <value value="9488823"/>
      <value value="4233135"/>
      <value value="1320776"/>
      <value value="7636528"/>
      <value value="2998454"/>
      <value value="9352575"/>
      <value value="6435485"/>
      <value value="5455576"/>
      <value value="7828925"/>
      <value value="8777941"/>
      <value value="4708908"/>
      <value value="6870388"/>
      <value value="8063691"/>
      <value value="5406261"/>
      <value value="7925012"/>
      <value value="9937800"/>
      <value value="4201044"/>
      <value value="2248191"/>
      <value value="5848107"/>
      <value value="6928309"/>
      <value value="4500591"/>
      <value value="1150613"/>
      <value value="94496"/>
      <value value="141501"/>
      <value value="1764851"/>
      <value value="3326577"/>
      <value value="5814725"/>
      <value value="2775251"/>
      <value value="1016033"/>
      <value value="8122795"/>
      <value value="6271785"/>
      <value value="8344335"/>
      <value value="4408011"/>
      <value value="8769038"/>
      <value value="443495"/>
      <value value="671040"/>
      <value value="4579992"/>
      <value value="9099666"/>
      <value value="5350361"/>
      <value value="2763849"/>
      <value value="5296547"/>
      <value value="2172634"/>
      <value value="4311438"/>
      <value value="4007670"/>
      <value value="5242728"/>
      <value value="3761375"/>
      <value value="744552"/>
      <value value="6118095"/>
      <value value="6252702"/>
      <value value="2312206"/>
      <value value="3394418"/>
      <value value="4659602"/>
      <value value="2526105"/>
      <value value="171605"/>
      <value value="3997705"/>
      <value value="9339729"/>
      <value value="1282678"/>
      <value value="2234770"/>
      <value value="3408329"/>
      <value value="1374219"/>
      <value value="7723008"/>
      <value value="9053662"/>
      <value value="490837"/>
      <value value="924300"/>
      <value value="2705592"/>
      <value value="1772832"/>
      <value value="8185233"/>
      <value value="2494437"/>
      <value value="4567031"/>
      <value value="5857431"/>
      <value value="8314046"/>
      <value value="6737504"/>
      <value value="8730676"/>
      <value value="2599018"/>
      <value value="7353634"/>
      <value value="1912857"/>
      <value value="1164435"/>
      <value value="6275065"/>
      <value value="1503014"/>
      <value value="5988151"/>
      <value value="5419016"/>
      <value value="6083351"/>
      <value value="8167861"/>
      <value value="5355482"/>
      <value value="5067623"/>
      <value value="2209937"/>
      <value value="2850197"/>
      <value value="4928778"/>
      <value value="5736958"/>
      <value value="1069742"/>
      <value value="1922860"/>
      <value value="3911987"/>
      <value value="8265364"/>
      <value value="4239948"/>
      <value value="1138143"/>
      <value value="7908415"/>
      <value value="1215454"/>
      <value value="9745387"/>
      <value value="5543572"/>
      <value value="124113"/>
      <value value="6950795"/>
      <value value="7689591"/>
      <value value="7202201"/>
      <value value="5213911"/>
      <value value="3256150"/>
      <value value="775460"/>
      <value value="7799109"/>
      <value value="8247204"/>
      <value value="1506162"/>
      <value value="7526034"/>
      <value value="9304136"/>
      <value value="3365539"/>
      <value value="6401833"/>
      <value value="5065520"/>
      <value value="2509053"/>
      <value value="6698654"/>
      <value value="6461341"/>
      <value value="3010506"/>
      <value value="2267037"/>
      <value value="5241317"/>
      <value value="6458553"/>
      <value value="6473009"/>
      <value value="6027778"/>
      <value value="3111944"/>
      <value value="2004636"/>
      <value value="9694449"/>
      <value value="1582330"/>
      <value value="9517734"/>
      <value value="549833"/>
      <value value="356599"/>
      <value value="1195984"/>
      <value value="9329495"/>
      <value value="7860447"/>
      <value value="6236742"/>
      <value value="9822490"/>
      <value value="3531070"/>
      <value value="5694958"/>
      <value value="9261911"/>
      <value value="888099"/>
      <value value="2463576"/>
      <value value="9551971"/>
      <value value="8373187"/>
      <value value="2481050"/>
      <value value="7420756"/>
      <value value="5561434"/>
      <value value="9284857"/>
      <value value="6635357"/>
      <value value="4544780"/>
      <value value="3696901"/>
      <value value="559585"/>
      <value value="6466297"/>
      <value value="6549379"/>
      <value value="7635902"/>
      <value value="6316312"/>
      <value value="9502277"/>
      <value value="9322744"/>
      <value value="1859694"/>
      <value value="7176660"/>
      <value value="7556534"/>
      <value value="7688472"/>
      <value value="3460002"/>
      <value value="7508286"/>
      <value value="9876127"/>
      <value value="7230986"/>
      <value value="7217457"/>
      <value value="1995821"/>
      <value value="3500023"/>
      <value value="2228977"/>
      <value value="7339067"/>
      <value value="4861331"/>
      <value value="95794"/>
      <value value="4401826"/>
      <value value="6660373"/>
      <value value="1254040"/>
      <value value="4292184"/>
      <value value="7993163"/>
      <value value="7962772"/>
      <value value="744866"/>
      <value value="2105927"/>
      <value value="6321296"/>
      <value value="8286476"/>
      <value value="2289474"/>
      <value value="6568146"/>
      <value value="8750153"/>
      <value value="8723534"/>
      <value value="2849470"/>
      <value value="919024"/>
      <value value="5515425"/>
      <value value="3231059"/>
      <value value="9810634"/>
      <value value="2189274"/>
      <value value="8024117"/>
      <value value="4763012"/>
      <value value="529698"/>
      <value value="1596038"/>
      <value value="3984353"/>
      <value value="7292753"/>
      <value value="5722027"/>
      <value value="6733015"/>
      <value value="6924130"/>
      <value value="4863653"/>
      <value value="3115961"/>
      <value value="8242904"/>
      <value value="3578432"/>
      <value value="382170"/>
      <value value="9261769"/>
      <value value="7308220"/>
      <value value="6739148"/>
      <value value="398643"/>
      <value value="8224094"/>
      <value value="9498170"/>
      <value value="7708414"/>
      <value value="2127504"/>
      <value value="8505469"/>
      <value value="2165506"/>
      <value value="6096967"/>
      <value value="6039280"/>
      <value value="30369"/>
      <value value="4393733"/>
      <value value="9782390"/>
      <value value="4782833"/>
      <value value="215942"/>
      <value value="3858876"/>
      <value value="7050745"/>
      <value value="9049184"/>
      <value value="6533644"/>
      <value value="698260"/>
      <value value="1044889"/>
      <value value="3333888"/>
      <value value="992276"/>
      <value value="1520689"/>
      <value value="6627596"/>
      <value value="6689354"/>
      <value value="7468488"/>
      <value value="7961814"/>
      <value value="2835810"/>
      <value value="5934773"/>
      <value value="7693906"/>
      <value value="7823811"/>
      <value value="772698"/>
      <value value="38022"/>
      <value value="4203152"/>
      <value value="5564750"/>
      <value value="3645832"/>
      <value value="5593837"/>
      <value value="3673971"/>
      <value value="3025286"/>
      <value value="9949334"/>
      <value value="6768036"/>
      <value value="7933578"/>
      <value value="5303192"/>
      <value value="9421219"/>
      <value value="4600501"/>
      <value value="7412395"/>
      <value value="6193912"/>
      <value value="6049324"/>
      <value value="3013355"/>
      <value value="2533920"/>
      <value value="5308015"/>
      <value value="9459512"/>
      <value value="6629688"/>
      <value value="1536849"/>
      <value value="1709662"/>
      <value value="6393343"/>
      <value value="2381268"/>
      <value value="3472396"/>
      <value value="8746651"/>
      <value value="2119244"/>
      <value value="1578049"/>
      <value value="8878290"/>
      <value value="7798291"/>
      <value value="8575480"/>
      <value value="4090346"/>
      <value value="3408756"/>
      <value value="7294105"/>
      <value value="1697216"/>
      <value value="9488336"/>
      <value value="2199373"/>
      <value value="1636973"/>
      <value value="5289174"/>
      <value value="5084915"/>
      <value value="9013151"/>
      <value value="2358598"/>
      <value value="2055324"/>
      <value value="3280828"/>
      <value value="5883664"/>
      <value value="6911765"/>
      <value value="6787065"/>
      <value value="3840187"/>
      <value value="3909777"/>
      <value value="2313657"/>
      <value value="4870974"/>
      <value value="2385524"/>
      <value value="7005962"/>
      <value value="2851973"/>
      <value value="7004890"/>
      <value value="9849175"/>
      <value value="6246815"/>
      <value value="5863715"/>
      <value value="6532659"/>
      <value value="3534081"/>
      <value value="3583978"/>
      <value value="8676244"/>
      <value value="4108214"/>
      <value value="2585790"/>
      <value value="8038833"/>
      <value value="9678348"/>
      <value value="174205"/>
      <value value="2070610"/>
      <value value="5106853"/>
      <value value="6311156"/>
      <value value="9565355"/>
      <value value="4551580"/>
      <value value="7892254"/>
      <value value="371223"/>
      <value value="4395141"/>
      <value value="2166281"/>
      <value value="9841598"/>
      <value value="1278895"/>
      <value value="7880310"/>
      <value value="7522351"/>
      <value value="855401"/>
      <value value="3412133"/>
      <value value="1592883"/>
      <value value="1684234"/>
      <value value="7087539"/>
      <value value="9032494"/>
      <value value="2288542"/>
      <value value="3786443"/>
      <value value="6718750"/>
      <value value="770820"/>
      <value value="7423333"/>
      <value value="3182702"/>
      <value value="1936928"/>
      <value value="5285450"/>
      <value value="1450460"/>
      <value value="9631604"/>
      <value value="1739302"/>
      <value value="54495"/>
      <value value="9005791"/>
      <value value="2142306"/>
      <value value="9021532"/>
      <value value="7812891"/>
      <value value="2414956"/>
      <value value="1804003"/>
      <value value="1178597"/>
      <value value="2943551"/>
      <value value="9688442"/>
      <value value="9924064"/>
      <value value="2706693"/>
      <value value="2281774"/>
      <value value="9719347"/>
      <value value="3363808"/>
      <value value="8533877"/>
      <value value="8588504"/>
      <value value="7235431"/>
      <value value="6197419"/>
      <value value="8609660"/>
      <value value="5015733"/>
      <value value="6091727"/>
      <value value="5244314"/>
      <value value="6922099"/>
      <value value="4884397"/>
      <value value="1853505"/>
      <value value="1782654"/>
      <value value="9941042"/>
      <value value="5731446"/>
      <value value="7622181"/>
      <value value="2412301"/>
      <value value="5238690"/>
      <value value="5162587"/>
      <value value="8724469"/>
      <value value="3521997"/>
      <value value="6805318"/>
      <value value="5388839"/>
      <value value="9086349"/>
      <value value="1713632"/>
      <value value="3585368"/>
      <value value="6065716"/>
      <value value="6567034"/>
      <value value="4983764"/>
      <value value="5239792"/>
      <value value="8323417"/>
      <value value="24038"/>
      <value value="6444217"/>
      <value value="356892"/>
      <value value="7406395"/>
      <value value="6758981"/>
      <value value="8202160"/>
      <value value="5019159"/>
      <value value="1555919"/>
      <value value="4243026"/>
      <value value="6301712"/>
      <value value="6825088"/>
      <value value="3493463"/>
      <value value="5988849"/>
      <value value="4637389"/>
      <value value="8784985"/>
      <value value="720536"/>
      <value value="6821727"/>
      <value value="7966615"/>
      <value value="1403254"/>
      <value value="4320559"/>
      <value value="9605221"/>
      <value value="8330847"/>
      <value value="9061042"/>
      <value value="9281770"/>
      <value value="9134857"/>
      <value value="3897267"/>
      <value value="2097465"/>
      <value value="587455"/>
      <value value="9428418"/>
      <value value="7122786"/>
      <value value="4237186"/>
      <value value="3528395"/>
      <value value="5169527"/>
      <value value="9286062"/>
      <value value="8166507"/>
      <value value="2970386"/>
      <value value="6622509"/>
      <value value="9156943"/>
      <value value="4440808"/>
      <value value="8731268"/>
      <value value="8386672"/>
      <value value="4186734"/>
      <value value="4757856"/>
      <value value="8310835"/>
      <value value="3493940"/>
      <value value="8283487"/>
      <value value="2230971"/>
      <value value="1499895"/>
      <value value="3897249"/>
      <value value="8847889"/>
      <value value="7969426"/>
      <value value="6598741"/>
      <value value="4968107"/>
      <value value="4783976"/>
      <value value="8257316"/>
      <value value="3958180"/>
      <value value="5869827"/>
      <value value="5273308"/>
      <value value="8203531"/>
      <value value="2034180"/>
      <value value="7424824"/>
      <value value="5925587"/>
      <value value="909052"/>
      <value value="4806261"/>
      <value value="913424"/>
      <value value="1971286"/>
      <value value="8120689"/>
      <value value="4600650"/>
      <value value="9276635"/>
      <value value="2596502"/>
      <value value="9599168"/>
      <value value="2926646"/>
      <value value="8544074"/>
      <value value="2146567"/>
      <value value="160296"/>
      <value value="1149615"/>
      <value value="14359"/>
      <value value="7854175"/>
      <value value="2848534"/>
      <value value="9877876"/>
      <value value="2656676"/>
      <value value="3627180"/>
      <value value="5956331"/>
      <value value="3193959"/>
      <value value="304054"/>
      <value value="5558122"/>
      <value value="8207131"/>
      <value value="423136"/>
      <value value="7442007"/>
      <value value="2220667"/>
      <value value="3629527"/>
      <value value="9937137"/>
      <value value="6167853"/>
      <value value="544248"/>
      <value value="276434"/>
      <value value="352643"/>
      <value value="687070"/>
      <value value="6571215"/>
      <value value="2657334"/>
      <value value="310860"/>
      <value value="9973776"/>
      <value value="7193824"/>
      <value value="5552315"/>
      <value value="4964827"/>
      <value value="1085752"/>
      <value value="3097855"/>
      <value value="9183930"/>
      <value value="9605545"/>
      <value value="1398160"/>
      <value value="4144056"/>
      <value value="8535455"/>
      <value value="4509047"/>
      <value value="581742"/>
      <value value="5629999"/>
      <value value="2826818"/>
      <value value="2688103"/>
      <value value="8770917"/>
      <value value="3433767"/>
      <value value="5209883"/>
      <value value="4624866"/>
      <value value="2038820"/>
      <value value="265707"/>
      <value value="4374887"/>
      <value value="3874074"/>
      <value value="4910471"/>
      <value value="481033"/>
      <value value="3774785"/>
      <value value="1791526"/>
      <value value="7570115"/>
      <value value="6968228"/>
      <value value="819457"/>
      <value value="8361192"/>
      <value value="6577943"/>
      <value value="3956687"/>
      <value value="3940555"/>
      <value value="8029350"/>
      <value value="6571255"/>
      <value value="582913"/>
      <value value="3915617"/>
      <value value="5987936"/>
      <value value="9322937"/>
      <value value="9755369"/>
      <value value="5134808"/>
      <value value="2223412"/>
      <value value="5766182"/>
      <value value="17415"/>
      <value value="5440981"/>
      <value value="1252704"/>
      <value value="580475"/>
      <value value="8799190"/>
      <value value="7002471"/>
      <value value="2912022"/>
      <value value="1390142"/>
      <value value="9584986"/>
      <value value="3104369"/>
      <value value="2810500"/>
      <value value="5678610"/>
      <value value="2056487"/>
      <value value="396875"/>
      <value value="761232"/>
      <value value="1785333"/>
      <value value="179429"/>
      <value value="240595"/>
      <value value="9475565"/>
      <value value="8822311"/>
      <value value="922393"/>
      <value value="2511614"/>
      <value value="4024366"/>
      <value value="5832458"/>
      <value value="8807061"/>
      <value value="894801"/>
      <value value="8794281"/>
      <value value="328205"/>
      <value value="10136"/>
      <value value="3574589"/>
      <value value="8609779"/>
      <value value="1642795"/>
      <value value="4135158"/>
      <value value="345235"/>
      <value value="8690319"/>
      <value value="4729649"/>
      <value value="690608"/>
      <value value="5963203"/>
      <value value="6009099"/>
      <value value="3786644"/>
      <value value="8814792"/>
      <value value="2723111"/>
      <value value="6511306"/>
      <value value="7008455"/>
      <value value="7852761"/>
      <value value="5700680"/>
      <value value="3079902"/>
      <value value="8269588"/>
      <value value="1295200"/>
      <value value="8393791"/>
      <value value="8625659"/>
      <value value="6417217"/>
      <value value="7109881"/>
      <value value="899629"/>
      <value value="3089236"/>
      <value value="4387175"/>
      <value value="4555149"/>
      <value value="7703274"/>
      <value value="3833459"/>
      <value value="8917783"/>
      <value value="8736796"/>
      <value value="2515411"/>
      <value value="14512"/>
      <value value="2681291"/>
      <value value="6350072"/>
      <value value="9131935"/>
      <value value="8820402"/>
      <value value="2886867"/>
      <value value="2003707"/>
      <value value="8536536"/>
      <value value="8240417"/>
      <value value="235202"/>
      <value value="303346"/>
      <value value="1490580"/>
      <value value="6092964"/>
      <value value="9707166"/>
      <value value="2219343"/>
      <value value="3104467"/>
      <value value="4178001"/>
      <value value="5110237"/>
      <value value="6822256"/>
      <value value="4486535"/>
      <value value="610848"/>
      <value value="8118224"/>
      <value value="4212239"/>
      <value value="4383863"/>
      <value value="6265200"/>
      <value value="1929985"/>
      <value value="8100047"/>
      <value value="9874664"/>
      <value value="3180287"/>
      <value value="1744728"/>
      <value value="1568631"/>
      <value value="9513613"/>
      <value value="6940010"/>
      <value value="6676790"/>
      <value value="1122290"/>
      <value value="4818894"/>
      <value value="2451684"/>
      <value value="3473685"/>
      <value value="3357937"/>
      <value value="7131491"/>
      <value value="3975424"/>
      <value value="2172778"/>
      <value value="2000579"/>
      <value value="9968869"/>
      <value value="1980776"/>
      <value value="433261"/>
      <value value="4786649"/>
      <value value="906293"/>
      <value value="811509"/>
      <value value="7686671"/>
      <value value="2932515"/>
      <value value="9709039"/>
      <value value="4486570"/>
      <value value="2792538"/>
      <value value="6815395"/>
      <value value="3370185"/>
      <value value="3715904"/>
      <value value="3011747"/>
      <value value="7744118"/>
      <value value="7271431"/>
      <value value="3550280"/>
      <value value="1694960"/>
      <value value="4330984"/>
      <value value="5337096"/>
      <value value="7394113"/>
      <value value="9787244"/>
      <value value="5904449"/>
      <value value="6486993"/>
      <value value="819695"/>
      <value value="1981458"/>
      <value value="8828481"/>
      <value value="626767"/>
      <value value="7689112"/>
      <value value="7510515"/>
      <value value="4454605"/>
      <value value="1488931"/>
      <value value="5148827"/>
      <value value="8832577"/>
      <value value="5583045"/>
      <value value="9271956"/>
      <value value="4616257"/>
      <value value="6277949"/>
      <value value="645781"/>
      <value value="2031010"/>
      <value value="9767749"/>
      <value value="6787646"/>
      <value value="8087873"/>
      <value value="9086856"/>
      <value value="2277524"/>
      <value value="6497812"/>
      <value value="4550990"/>
      <value value="5552732"/>
      <value value="791682"/>
      <value value="3684228"/>
      <value value="175109"/>
      <value value="2206369"/>
      <value value="3026562"/>
      <value value="4492162"/>
      <value value="6234919"/>
      <value value="2054400"/>
      <value value="5568572"/>
      <value value="4466663"/>
      <value value="4167448"/>
      <value value="2785436"/>
      <value value="4953982"/>
      <value value="1006331"/>
      <value value="8750677"/>
      <value value="2117359"/>
      <value value="3312809"/>
      <value value="9580732"/>
      <value value="3499293"/>
      <value value="1098069"/>
      <value value="2466889"/>
      <value value="7043495"/>
      <value value="4296846"/>
      <value value="2841499"/>
      <value value="3029312"/>
      <value value="3221673"/>
      <value value="2099326"/>
      <value value="8942493"/>
      <value value="6233225"/>
      <value value="5141468"/>
      <value value="3899444"/>
      <value value="228416"/>
      <value value="4215636"/>
      <value value="4671769"/>
      <value value="8075846"/>
      <value value="5481703"/>
      <value value="6688687"/>
      <value value="8449019"/>
      <value value="3396660"/>
      <value value="6845395"/>
      <value value="4230027"/>
      <value value="1769788"/>
      <value value="5503258"/>
      <value value="2680877"/>
      <value value="6168719"/>
      <value value="7038891"/>
      <value value="7907872"/>
      <value value="4239042"/>
      <value value="3152032"/>
      <value value="649278"/>
      <value value="8263915"/>
      <value value="4853491"/>
      <value value="6472967"/>
      <value value="5190984"/>
      <value value="740916"/>
      <value value="4271186"/>
      <value value="9350870"/>
      <value value="6537140"/>
      <value value="8718511"/>
      <value value="9667888"/>
      <value value="2121474"/>
      <value value="5918464"/>
      <value value="6697604"/>
      <value value="9171496"/>
      <value value="5381364"/>
      <value value="7963150"/>
      <value value="8162970"/>
      <value value="7112219"/>
      <value value="6509030"/>
      <value value="4862967"/>
      <value value="2008981"/>
      <value value="3456030"/>
      <value value="2477303"/>
      <value value="8074854"/>
      <value value="1769127"/>
      <value value="6080251"/>
      <value value="5389379"/>
      <value value="4938443"/>
      <value value="7181474"/>
      <value value="9435797"/>
      <value value="2383170"/>
      <value value="4205820"/>
      <value value="880197"/>
      <value value="5847005"/>
      <value value="8828524"/>
      <value value="7758423"/>
      <value value="285941"/>
      <value value="2250733"/>
      <value value="5545081"/>
      <value value="483220"/>
      <value value="6832196"/>
      <value value="1605389"/>
      <value value="3968328"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;None&quot;"/>
      <value value="&quot;Stage1&quot;"/>
      <value value="&quot;Stage1b&quot;"/>
      <value value="&quot;Stage2&quot;"/>
      <value value="&quot;Stage3&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_pipeline">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.219"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_trans_std">
      <value value="0.12"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="r0_range">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="15"/>
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
    <enumeratedValueSet variable="complacency_loss">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_essential">
      <value value="&quot;Extreme&quot;"/>
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
    <enumeratedValueSet variable="cont_scale">
      <value value="true"/>
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
    <enumeratedValueSet variable="duration_skew">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="392"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
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
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="exposuresymptmult">
      <value value="0.4513142841269099"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="first_case_calibrate">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_loc_trans_red">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_distance_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.17728283228345285"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.66"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hetro_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="house_init_group">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="house_resample_red_group">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="house_resample_scale_up">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="in_dose1">
      <value value="&quot;_1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="in_dose2">
      <value value="&quot;_60&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incubation_period">
      <value value="4.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incur_timenow_limit">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incursion_phase_speed_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_cases_region">
      <value value="1"/>
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_metric_threshold">
      <value value="240"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_stage">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_timenow_limit">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_trace_prop">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_primary_prop">
      <value value="0.66"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_variant_2_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_dose_rate_table">
      <value value="&quot;input/vic/dose_rate&quot;"/>
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
    <enumeratedValueSet variable="input_vac_branch">
      <value value="&quot;input/vic/vac_branch&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_vac_params">
      <value value="&quot;input/vic/vaccine_params.csv&quot;"/>
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
      <value value="35"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max_stage">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mid_report_day">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="min_stage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="minmaskwearing">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="override_asympt_table">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_final_phase">
      <value value="3"/>
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
    <enumeratedValueSet variable="param_recovered_prop">
      <value value="0"/>
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
    <enumeratedValueSet variable="param_vac_rate_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake_mult">
      <value value="0.85"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="pipe_end_override">
      <value value="&quot;off&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_pipe_time">
      <value value="105"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.2938068791332573"/>
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
    <enumeratedValueSet variable="precise_r0">
      <value value="true"/>
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
    <enumeratedValueSet variable="prev_var_area">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prev_var_risk">
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
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avoid_essential">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rat_day_max">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rat_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="realnotcasethres">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0"/>
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
    <enumeratedValueSet variable="reinfect_delay_base">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_cont_buffer">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_down_threshold">
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_factor">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_up_limit">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_up_threshold">
      <value value="120"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="schoolsopen">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="se_illnesspd">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="se_incubation">
      <value value="2.25"/>
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
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="success_14day_cases">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="suffix_rollout">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_prop">
      <value value="0.6572233735674808"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="total_population">
      <value value="234000000"/>
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
    <enumeratedValueSet variable="trans_draw_max">
      <value value="0.1579"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trans_draw_min">
      <value value="0.1335"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transmit_skew">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_avoid">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_avoid_compbound">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_everyone">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_mask_wear">
      <value value="35"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_schools_open">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_span">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_spread">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_stage">
      <value value="&quot;1b&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_visit_rad">
      <value value="8.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_restrict_ease_day">
      <value value="77"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_trans_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_variant_eff_prop">
      <value value="0.86"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vactype_override">
      <value value="&quot;off&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="variant_transmiss_growth">
      <value value="1.5"/>
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
    <metric>global_transmissibility</metric>
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
    <metric>dieArray_listOut</metric>
    <metric>hospArray_listOut</metric>
    <metric>case_listOut</metric>
    <metric>case7_listOut</metric>
    <metric>case14_listOut</metric>
    <metric>case28_listOut</metric>
    <metric>age_listOut</metric>
    <metric>atsi_listOut</metric>
    <metric>morbid_listOut</metric>
    <metric>casesinperiod7_min</metric>
    <metric>pre_stop_day</metric>
    <metric>casesinperiod7_switchTime</metric>
    <metric>cumulativeInfected_switchTime</metric>
    <metric>cumulativeInfected_minusInit</metric>
    <enumeratedValueSet variable="rand_seed">
      <value value="3542518"/>
      <value value="9049460"/>
      <value value="1517587"/>
      <value value="8572184"/>
      <value value="8568430"/>
      <value value="2944231"/>
      <value value="342144"/>
      <value value="2455526"/>
      <value value="5226669"/>
      <value value="5036180"/>
      <value value="4916336"/>
      <value value="6396309"/>
      <value value="9387252"/>
      <value value="1173796"/>
      <value value="3710349"/>
      <value value="7586137"/>
      <value value="7674916"/>
      <value value="5764580"/>
      <value value="4924648"/>
      <value value="9432786"/>
      <value value="6326166"/>
      <value value="6499406"/>
      <value value="6534705"/>
      <value value="895781"/>
      <value value="5651050"/>
      <value value="450530"/>
      <value value="6312182"/>
      <value value="5106814"/>
      <value value="3115556"/>
      <value value="6804479"/>
      <value value="7356337"/>
      <value value="5444718"/>
      <value value="5496387"/>
      <value value="361635"/>
      <value value="9752654"/>
      <value value="1002007"/>
      <value value="6112659"/>
      <value value="8867980"/>
      <value value="3900664"/>
      <value value="7481193"/>
      <value value="8544006"/>
      <value value="9879219"/>
      <value value="5571693"/>
      <value value="8270530"/>
      <value value="7734667"/>
      <value value="7158808"/>
      <value value="1830615"/>
      <value value="6115574"/>
      <value value="241163"/>
      <value value="2069330"/>
      <value value="446753"/>
      <value value="4275682"/>
      <value value="6853103"/>
      <value value="3494189"/>
      <value value="9072053"/>
      <value value="2014188"/>
      <value value="2486847"/>
      <value value="8572941"/>
      <value value="7793529"/>
      <value value="5453368"/>
      <value value="231312"/>
      <value value="4075859"/>
      <value value="6580146"/>
      <value value="6767830"/>
      <value value="6346864"/>
      <value value="9961645"/>
      <value value="6191857"/>
      <value value="3176373"/>
      <value value="9637189"/>
      <value value="6380450"/>
      <value value="5024418"/>
      <value value="8303739"/>
      <value value="1763303"/>
      <value value="2211424"/>
      <value value="9181170"/>
      <value value="4889253"/>
      <value value="3286663"/>
      <value value="5935992"/>
      <value value="597213"/>
      <value value="7970735"/>
      <value value="51271"/>
      <value value="5970812"/>
      <value value="7750194"/>
      <value value="4201394"/>
      <value value="2691694"/>
      <value value="6804056"/>
      <value value="8698433"/>
      <value value="9956018"/>
      <value value="2992689"/>
      <value value="3182589"/>
      <value value="8525903"/>
      <value value="1391927"/>
      <value value="5838673"/>
      <value value="7310212"/>
      <value value="7105019"/>
      <value value="1764949"/>
      <value value="8456943"/>
      <value value="6582616"/>
      <value value="5232265"/>
      <value value="7088181"/>
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
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.219"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_trans_std">
      <value value="0.12"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="r0_range">
      <value value="6.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="15"/>
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
    <enumeratedValueSet variable="complacency_loss">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="compound_essential">
      <value value="&quot;Extreme&quot;"/>
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
    <enumeratedValueSet variable="cont_scale">
      <value value="true"/>
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
    <enumeratedValueSet variable="duration_skew">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="390"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
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
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="exposuresymptmult">
      <value value="0.4513142841269099"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="first_case_calibrate">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_loc_trans_red">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_distance_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.17728283228345285"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.66"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hetro_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="house_init_group">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="house_resample_red_group">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="house_resample_scale_up">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="in_dose1">
      <value value="&quot;_1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="in_dose2">
      <value value="&quot;_60&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incubation_period">
      <value value="4.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incur_timenow_limit">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incursion_phase_speed_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_cases_region">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_metric_threshold">
      <value value="240"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_stage">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_timenow_limit">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init_trace_prop">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_primary_prop">
      <value value="0.66"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_variant_2_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_dose_rate_table">
      <value value="&quot;input/vic/dose_rate&quot;"/>
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
    <enumeratedValueSet variable="input_vac_branch">
      <value value="&quot;input/vic/vac_branch&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="input_vac_params">
      <value value="&quot;input/vic/vaccine_params.csv&quot;"/>
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
      <value value="35"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max_stage">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mid_report_day">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="min_stage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="minmaskwearing">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="override_asympt_table">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_final_phase">
      <value value="3"/>
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
    <enumeratedValueSet variable="param_recovered_prop">
      <value value="0.45"/>
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
    <enumeratedValueSet variable="param_vac_rate_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake_mult">
      <value value="0.85"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="pipe_end_override">
      <value value="&quot;off&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="policy_pipe_time">
      <value value="105"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.2938068791332573"/>
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
    <enumeratedValueSet variable="precise_r0">
      <value value="true"/>
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
    <enumeratedValueSet variable="prev_var_area">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prev_var_risk">
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
      <value value="19"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="19"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avoid_essential">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rat_day_max">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rat_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="realnotcasethres">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0"/>
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
    <enumeratedValueSet variable="reinfect_delay_base">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_cont_buffer">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_down_threshold">
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_factor">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_up_limit">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_up_threshold">
      <value value="120"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="schoolsopen">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="se_illnesspd">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="se_incubation">
      <value value="2.25"/>
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
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="success_14day_cases">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="suffix_rollout">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_prop">
      <value value="0.6572233735674808"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="total_population">
      <value value="234000000"/>
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
    <enumeratedValueSet variable="trans_draw_max">
      <value value="0.1579"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trans_draw_min">
      <value value="0.1335"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transmit_skew">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_avoid">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_avoid_compbound">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_everyone">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_mask_wear">
      <value value="35"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_schools_open">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_span">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_spread">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_stage">
      <value value="&quot;1b&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_ease_visit_rad">
      <value value="8.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_restrict_ease_day">
      <value value="77"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_trans_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_variant_eff_prop">
      <value value="0.86"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vactype_override">
      <value value="&quot;off&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="variant_transmiss_growth">
      <value value="1.5"/>
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

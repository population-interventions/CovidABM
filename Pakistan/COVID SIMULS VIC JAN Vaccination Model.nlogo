;; This version of the model has been speifically designed to estimate issues associated with Victoria's second wave of infections, beginning in early July
;; The intent of the model is for it to be used as a guide for considering differences in potential patterns of infection under various policy futures
;; As with any model, it's results should be interpreted with caution and placed alongside other evidence when interpreting results

__includes[
  "globals.nls"
  "housing.nls"
  "main.nls"
  "simul.nls"
  "setup.nls"
  "scale.nls"
  "stages.nls"
  "policy.nls"
  "trace.nls"
  "count.nls"
  "vaccine.nls"
  "incursion.nls"
  "debug.nls"
  "dataOut.nls"
]
@#$#@#$#@
GRAPHICS-WINDOW
346
61
960
676
-1
-1
6.66
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
90
0
90
1
1
1
ticks
30.0

BUTTON
239
99
303
133
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
207
144
271
178
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
219
239
321
274
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
220
279
320
313
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
214
187
327
220
Population
Population
1000
2500
2500.0
500
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
1.0
1
1
NIL
HORIZONTAL

PLOT
2350
852
2755
1025
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
"Infected Proportion" 1.0 0 -2674135 true "" "plot count simuls with [ color = red ] * (Total_Population / 100 / count Simuls) "
"Susceptible" 1.0 0 -14070903 true "" "plot count simuls with [ color = 85 ] * (Total_Population / 100 / count Simuls)"
"Recovered" 1.0 0 -987046 true "" "plot count simuls with [ color = yellow ] * (Total_Population / 100 / count Simuls)"
"New Infections" 1.0 0 -11221820 true "" "plot count simuls with [ color = red and timenow = Incubation_Period ] * ( Total_Population / 100 / count Simuls )"

SLIDER
2713
160
2913
193
Illness_period
Illness_period
0
25
21.2
.1
1
NIL
HORIZONTAL

BUTTON
272
144
336
178
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
17
638
166
695
Deaths
Deathcount
0
1
14

MONITOR
2522
29
2677
86
# simuls
count simuls * (Total_Population / population)
0
1
14

MONITOR
2283
467
2452
524
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
2.0E-4
0.01
1
NIL
HORIZONTAL

MONITOR
17
700
166
757
% Total Infections
cumulativeInfected / Total_Population * 100
2
1
14

MONITOR
1484
453
1614
498
Case Fatality Rate %
caseFatalityRate * 100
2
1
11

PLOT
1243
218
1445
347
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
82.0
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
82.0
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
1865
210
2133
359
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
2285
634
2417
679
Infection Growth %
infectionchange
2
1
11

INPUTBOX
217
325
322
386
initial_cases
10.0
1
0
Number

INPUTBOX
217
458
324
520
total_population
2.34E11
1
0
Number

MONITOR
1045
299
1217
344
Close contacts per day
AverageContacts
2
1
11

SLIDER
2715
117
2917
150
Incubation_Period
Incubation_Period
0
10
4.7
.1
1
NIL
HORIZONTAL

PLOT
1864
38
2133
200
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
"pen-1" 1.0 0 -13840069 true "" "histogram [ agerange ] of simuls with [ vaccinated = 1 ]"
"pen-2" 1.0 0 -2674135 true "" "histogram [ agerange ] of simuls with [ color = red ]"

PLOT
1040
747
1462
995
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
"Current Cases" 1.0 1 -7858858 true "" "plot currentInfections "
"Total Infected" 1.0 0 -13345367 true "" "plot cumulativeInfected"
"ICU Beds Required" 1.0 0 -16777216 true "" "plot ICUBedsRequired "

MONITOR
1478
505
1603
554
New Infections
(Scale_Factor ^ scalephase) * (count simuls with [ color = red and timenow = 1 ])
0
1
12

PLOT
1039
489
1456
609
New Infections Per Day
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
"New Cases" 1.0 1 -5298144 true "" "plot (Scale_Factor ^ scalephase) * (count simuls with [ color = red and timenow = 1 ])"

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
1760
909
1842
954
Red (raw)
count simuls with [ color = red ]
0
1
11

SWITCH
1470
791
1563
824
scale
scale
0
1
-1000

MONITOR
917
13
975
58
NIL
Days
17
1
11

MONITOR
1469
829
1576
878
Scale Exponent
scalePhase
17
1
12

MONITOR
1612
988
1692
1033
NIL
count simuls
17
1
11

MONITOR
2360
384
2474
429
Potential contacts
PotentialContacts
0
1
11

PLOT
2140
40
2429
202
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

INPUTBOX
2777
714
2933
775
se_illnesspd
4.0
1
0
Number

INPUTBOX
2777
774
2933
835
se_incubation
2.25
1
0
Number

PLOT
2452
112
2692
237
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
1537
674
1602
719
Virulence
mean [ personalvirulence] of simuls
1
1
11

SLIDER
14
450
199
483
Global_Transmissibility
Global_Transmissibility
0
1
0.31
0.001
1
NIL
HORIZONTAL

SLIDER
1627
179
1805
212
Essential_Workers
Essential_Workers
0
100
10.0
1
1
NIL
HORIZONTAL

SLIDER
559
850
756
883
Ess_W_Risk_Reduction
Ess_W_Risk_Reduction
0
100
0.0
1
1
NIL
HORIZONTAL

SWITCH
1484
359
1619
392
tracking
tracking
0
1
-1000

SLIDER
1479
93
1613
126
Mask_Wearing
Mask_Wearing
0
100
90.0
1
1
NIL
HORIZONTAL

SWITCH
1483
282
1618
315
schoolsOpen
schoolsOpen
1
1
-1000

MONITOR
832
13
904
58
Household
mean [ householdunit ] of simuls
1
1
11

PLOT
2577
417
2857
565
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
2724
582
2856
627
EW Infection %
EWInfections / Population
1
1
11

MONITOR
2584
579
2717
624
Student Infections %
studentInfections / Population
1
1
11

SWITCH
1483
322
1617
355
MaskPolicy
MaskPolicy
0
1
-1000

SLIDER
338
1012
533
1045
Case_Reporting_Delay
Case_Reporting_Delay
0
20
2.0
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
0.035
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
2.5
1
1
NIL
HORIZONTAL

SLIDER
335
892
533
925
Asymptomatic_Trans
Asymptomatic_Trans
0
1
0.75
.01
1
NIL
HORIZONTAL

MONITOR
1473
624
1575
669
NIL
currentinfections
17
1
11

MONITOR
1790
402
1844
447
Average Illness time
mean [ timenow ] of simuls with [ color = red ]
1
1
11

PLOT
1039
359
1454
483
New cases in last 7, 14, 28 days
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
"7" 1.0 0 -16777216 true "" "plot casesinperiod7"
"14" 1.0 0 -7500403 true "" "plot casesinperiod14"
"28" 1.0 0 -2674135 true "" "plot casesinperiod28"

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
"Scale" 1.0 0 -14454117 true "" "plot scalePhase"

MONITOR
1762
963
1844
1008
Yellow (raw)
count simuls with [ color = yellow ]
0
1
11

MONITOR
2485
383
2558
428
Time = 1 
count simuls with [ timenow = 2 ]
0
1
11

MONITOR
2277
387
2342
432
Students
count simuls with [ studentFlag = 1 ]
0
1
11

SLIDER
1263
1003
1470
1036
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
17
493
189
526
Vaccine_Available
Vaccine_Available
1
1
-1000

MONITOR
1239
13
1358
58
Vaccinated %
( count simuls with [ vaccinated = 1 ] / Population )* 100
2
1
11

SLIDER
13
15
290
48
RAND_SEED
RAND_SEED
0
10000000
1294130.0
1
1
NIL
HORIZONTAL

MONITOR
1369
14
1459
59
Vaccinated
count simuls with [ vaccinated = 1 ]
17
1
11

PLOT
1243
64
1438
203
Vaccinated
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
"default" 1.0 0 -16777216 true "" "plot count simuls with [ vaccinated = 1 ]"

SLIDER
18
220
193
253
param_vac_uptake
param_vac_uptake
0.6
1
0.7
0.1
1
NIL
HORIZONTAL

SLIDER
17
329
192
362
param_vac_tran_reduct
param_vac_tran_reduct
0.5
0.9
0.9
0.05
1
NIL
HORIZONTAL

SLIDER
17
532
189
565
param_vacEffDays
param_vacEffDays
0
30
21.0
1
1
NIL
HORIZONTAL

MONITOR
1479
132
1616
177
NIL
spatial_distance
17
1
11

MONITOR
1479
179
1613
224
NIL
case_isolation
17
1
11

MONITOR
1483
229
1616
274
NIL
quarantine
17
1
11

MONITOR
2453
654
2611
699
NIL
Asymptom_Prop
17
1
11

MONITOR
1042
247
1214
292
NIL
Track_and_Trace_Efficiency
17
1
11

MONITOR
1472
673
1529
718
NIL
stage
17
1
11

MONITOR
1645
452
1748
497
Interaction Infectivity
transmission_average
6
1
11

MONITOR
1707
402
1787
447
Virulent Interactions
transmission_count_metric
17
1
11

PLOT
1859
537
2266
711
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

INPUTBOX
217
390
322
450
secondary_cases
20.0
1
0
Number

CHOOSER
17
404
195
449
param_policy
param_policy
"TightSupress" "ModerateSupress" "TightSupress_No_4" "ModerateSupress_No_4" "AggressElim" "ModerateElim" "None" "Stage 1" "Stage 1b" "Stage 2" "Stage 3" "Stage 4" "StageCal None" "StageCal Test" "StageCal_1" "StageCal_1b" "StageCal_2" "StageCal_3" "StageCal_4"
13

SLIDER
1610
909
1747
942
Scale_Threshold
Scale_Threshold
50
500
240.0
10
1
NIL
HORIZONTAL

SLIDER
1610
947
1748
980
Scale_Factor
Scale_Factor
2
10
4.0
1
1
NIL
HORIZONTAL

MONITOR
1469
886
1577
931
Person per Simul
(Scale_Factor ^ scalephase)
17
1
11

MONITOR
1469
940
1579
985
People in Model
(Population * Scale_Factor ^ scalephase)
17
1
11

PLOT
1859
717
2324
875
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
"Tracked" 1.0 0 -16777216 true "" "plot count simuls with [ color = red and tracked = 1 ] * Scale_Factor ^ scalephase"
"Total" 1.0 0 -7500403 true "" "plot count simuls with [ color = red ] * Scale_Factor ^ scalephase"
"Reported" 1.0 0 -2674135 true "" "plot count simuls with [ color = red and tracked = 1 and caseReportTime <= ticks and report_case_draw < report_proportion] * Scale_Factor ^ scalephase"

SLIDER
337
930
532
963
Asymptom_Prop
Asymptom_Prop
0
1
0.3
0.01
1
NIL
HORIZONTAL

SLIDER
550
1018
745
1051
Asymptom_Trace_Mult
Asymptom_Trace_Mult
0
1
0.33
0.01
1
NIL
HORIZONTAL

PLOT
1859
384
2268
534
Average Interaction Infectivity
NIL
NIL
0.0
10.0
0.0
0.2
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot transmission_average"

MONITOR
1752
452
1845
497
Expected New Cases
transmission_count_metric * transmission_average
6
1
11

PLOT
1863
879
2327
1027
States (raw)
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
"Isolating" 1.0 0 -12345184 true "" "plot count simuls with [color = cyan and isolating = 1]"
"Infected" 1.0 0 -2674135 true "" "plot count simuls with [color = red]"
"Tracked" 1.0 0 -5825686 true "" "plot count simuls with [color = red and tracked = 1]"
"Comply" 1.0 0 -13840069 true "" "plot count simuls with [color = cyan and isolateCompliant = 1]"
"Recovered" 1.0 0 -1184463 true "" "plot count simuls with [color = yellow]"

SLIDER
560
809
757
842
Gather_Location_Count
Gather_Location_Count
0
1000
150.0
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
82.0
1
1
NIL
HORIZONTAL

PLOT
2454
247
2733
367
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
1754
504
1843
549
Real New Cases
new_case_real
17
1
11

BUTTON
458
17
563
51
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
575
17
682
50
profile_on
profile_on
1
1
-1000

BUTTON
345
17
449
52
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
1044
13
1217
46
End_Day
End_Day
-1
730
138.0
1
1
NIL
HORIZONTAL

SLIDER
783
688
981
721
Isolation_Transmission
Isolation_Transmission
0
1
0.33
0.01
1
NIL
HORIZONTAL

SLIDER
338
972
535
1005
Non_Infective_Time
Non_Infective_Time
0
4
2.0
1
1
NIL
HORIZONTAL

MONITOR
1047
99
1222
144
NIL
casesinperiod7
17
1
11

PLOT
2143
212
2433
361
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
1470
751
1574
784
track_R
track_R
0
1
-1000

PLOT
1614
782
1843
902
Average R 2
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
"default" 1.0 0 -16777216 true "" "ifelse table:get totalEndCount 2 > 0 [plot table:get totalEndR 2 / table:get totalEndCount 2][plot 0]"
"pen-1" 1.0 0 -7500403 true "" "plot table:get endR_mean_metric 2"

MONITOR
1732
732
1841
777
average_R 2
table:get average_R 2
6
1
11

PLOT
2279
464
2558
624
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
17
578
167
635
Total Infected
cumulativeInfected
17
1
14

MONITOR
17
768
172
825
% Living Recovered
recoverProportion * 100
2
1
14

SLIDER
558
729
756
762
Recovered_Match_Rate
Recovered_Match_Rate
0
0.5
0.1
0.005
1
NIL
HORIZONTAL

SWITCH
17
365
191
398
param_trigger_loosen
param_trigger_loosen
1
1
-1000

MONITOR
1485
400
1590
445
NIL
policyTriggerScale
17
1
11

SLIDER
1044
53
1217
86
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
909
725
1014
770
slopeAverage %
slopeAverage * 100
3
1
11

PLOT
771
772
1026
892
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
"pen-2" 1.0 0 -2674135 true "" "plot slope_prior0 / 20"

MONITOR
1645
504
1748
549
Tracked Infection %
100 * (count simuls with [color = red and tracked = 1]) / (count simuls with [color = red])
2
1
11

SLIDER
14
964
204
997
calibrate_stage_switch
calibrate_stage_switch
0
10000
300.0
100
1
NIL
HORIZONTAL

SLIDER
17
1005
317
1038
stage_test_index
stage_test_index
0
60
59.0
1
1
NIL
HORIZONTAL

SLIDER
553
894
726
927
sympt_present_prop
sympt_present_prop
0
1
0.5
0.01
1
NIL
HORIZONTAL

SLIDER
552
937
725
970
sympt_present_min
sympt_present_min
0
12
6.0
1
1
NIL
HORIZONTAL

SLIDER
550
978
723
1011
sympt_present_max
sympt_present_max
0
12
9.0
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
1
1
-1000

SLIDER
775
903
975
936
Household_Iso_Factor
Household_Iso_Factor
0
1
0.8
0.01
1
NIL
HORIZONTAL

SLIDER
775
979
972
1012
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
775
944
973
977
Track_Iso_Factor
Track_Iso_Factor
0
1
0.5
0.05
1
NIL
HORIZONTAL

SWITCH
779
730
896
763
track_slope
track_slope
1
1
-1000

SLIDER
17
293
192
326
param_vac_wane
param_vac_wane
0
0.05
0.002
0.001
1
NIL
HORIZONTAL

SLIDER
18
255
193
288
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
18
184
193
217
param_recovered_prop
param_recovered_prop
0
0.5
0.0
0.05
1
NIL
HORIZONTAL

MONITOR
1614
732
1724
777
average_R 1
table:get average_R 1
6
1
11

PLOT
1613
607
1841
727
Average R 1
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
"default" 1.0 0 -16777216 true "" "ifelse table:get totalEndCount 1 > 0 [plot table:get totalEndR 1 / table:get totalEndCount 1][plot 0]"
"pen-1" 1.0 0 -7500403 true "" "plot table:get endR_mean_metric 1"

INPUTBOX
215
528
323
588
preSimDailyCases
0.0
1
0
Number

SLIDER
1043
1045
1252
1078
yearly_recover_prop_loss
yearly_recover_prop_loss
0
0.999
0.0
0.01
1
NIL
HORIZONTAL

SLIDER
302
807
536
840
variant_transmiss_growth
variant_transmiss_growth
1
3
1.5
0.05
1
NIL
HORIZONTAL

SLIDER
302
765
535
798
immune_from_reinfect
immune_from_reinfect
0
1
1.0
0.05
1
NIL
HORIZONTAL

SLIDER
303
727
536
760
immune_from_prev_variant
immune_from_prev_variant
0
1
0.6794928661985937
0.05
1
NIL
HORIZONTAL

MONITOR
19
830
173
887
% Recovered First
recoverProportion * 100 * (table:get recoverCountByVariant 1) / (table:get recoverCountByVariant 1 + table:get recoverCountByVariant 2)
2
1
14

MONITOR
19
895
173
952
% Recovered Second
recoverProportion * 100 * (table:get recoverCountByVariant 2) / (table:get recoverCountByVariant 1 + table:get recoverCountByVariant 2)
2
1
14

MONITOR
187
759
252
804
% Yellow
100 * (count simuls with [color = yellow]) / Population
2
1
11

MONITOR
187
808
280
853
% Yellow First
100 * (count simuls with [color = yellow and recoveryVariant = 1]) / Population
2
1
11

MONITOR
187
857
296
902
% Yellow Second
100 * (count simuls with [color = yellow and recoveryVariant = 2]) / Population
2
1
11

SLIDER
560
768
758
801
Recov_Var_Match_Rate
Recov_Var_Match_Rate
0
1
0.85
0.01
1
NIL
HORIZONTAL

SWITCH
689
17
799
50
set_shape
set_shape
0
1
-1000

MONITOR
1599
402
1686
447
Incursion Var
global_incursionVariant
17
1
11

SLIDER
303
850
534
883
vac_variant_eff_prop
vac_variant_eff_prop
0
1
0.86
0.01
1
NIL
HORIZONTAL

MONITOR
187
907
296
952
% Yellow Third
100 * (count simuls with [color = yellow and recoveryVariant = 3]) / Population
17
1
11

SLIDER
560
690
760
723
complacency_loss
complacency_loss
0
1
0.5
0.1
1
NIL
HORIZONTAL

MONITOR
1613
557
1772
602
NIL
average_R_all_regions
17
1
11

SLIDER
19
147
191
180
param_final_phase
param_final_phase
-1
10
0.0
1
1
NIL
HORIZONTAL

SLIDER
19
109
194
142
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
1040
1005
1250
1038
house_resample_red_group
house_resample_red_group
0
1
0.8
0.01
1
NIL
HORIZONTAL

SLIDER
1045
153
1218
186
report_proportion
report_proportion
0
1
0.13
0.01
1
NIL
HORIZONTAL

MONITOR
1042
195
1222
240
Case report %
100 * (count simuls with [ color = red and tracked = 1 and caseReportTime <= ticks and report_case_draw < report_proportion]) / (count simuls with [ color = red ])
2
1
11

SLIDER
775
1020
1023
1053
accept_isolation_prop
accept_isolation_prop
0
1
0.25019750025413173
0.01
1
NIL
HORIZONTAL

SLIDER
1265
1048
1484
1081
incursion_phase_speed_mult
incursion_phase_speed_mult
0
2
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
304
685
539
718
initial_variant_2_prop
initial_variant_2_prop
0
1
0.0
0.01
1
NIL
HORIZONTAL

SWITCH
213
964
317
997
calibrate
calibrate
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
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="stageTest_Stages" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>average_R_region_1</metric>
    <metric>average_R_region_2</metric>
    <metric>average_R_all_regions</metric>
    <metric>global_transmissibility</metric>
    <metric>days</metric>
    <metric>totalEndCount</metric>
    <metric>scalephase</metric>
    <metric>cumulativeInfected</metric>
    <metric>infectionsToday</metric>
    <metric>slopeAverage</metric>
    <metric>trackAverage</metric>
    <metric>infectedTrackAverage</metric>
    <metric>testName</metric>
    <enumeratedValueSet variable="rand_seed">
      <value value="4704037"/>
      <value value="7702055"/>
      <value value="8000288"/>
      <value value="2336006"/>
      <value value="8136345"/>
      <value value="9942333"/>
      <value value="8256294"/>
      <value value="6483876"/>
      <value value="4392163"/>
      <value value="7935223"/>
      <value value="9030926"/>
      <value value="2316971"/>
      <value value="6836155"/>
      <value value="6024665"/>
      <value value="8567415"/>
      <value value="8742276"/>
      <value value="7314852"/>
      <value value="3644267"/>
      <value value="941632"/>
      <value value="9260678"/>
      <value value="6465231"/>
      <value value="5768450"/>
      <value value="5925481"/>
      <value value="1522541"/>
      <value value="1822426"/>
      <value value="599611"/>
      <value value="2376502"/>
      <value value="6326778"/>
      <value value="1524146"/>
      <value value="7686637"/>
      <value value="6131357"/>
      <value value="9810567"/>
      <value value="7895723"/>
      <value value="3609552"/>
      <value value="5869989"/>
      <value value="5818151"/>
      <value value="5073199"/>
      <value value="9595757"/>
      <value value="2017101"/>
      <value value="5391921"/>
      <value value="9014818"/>
      <value value="4125550"/>
      <value value="131096"/>
      <value value="5258756"/>
      <value value="1804335"/>
      <value value="7337008"/>
      <value value="6950996"/>
      <value value="6349898"/>
      <value value="2639447"/>
      <value value="3398813"/>
      <value value="7969355"/>
      <value value="6603319"/>
      <value value="925307"/>
      <value value="3666351"/>
      <value value="595211"/>
      <value value="5239411"/>
      <value value="3645978"/>
      <value value="6851722"/>
      <value value="9873351"/>
      <value value="6567821"/>
      <value value="3127534"/>
      <value value="9704078"/>
      <value value="7151108"/>
      <value value="3018173"/>
      <value value="3286562"/>
      <value value="3361893"/>
      <value value="2933081"/>
      <value value="1629329"/>
      <value value="2328484"/>
      <value value="4110299"/>
      <value value="5133044"/>
      <value value="9157183"/>
      <value value="7431311"/>
      <value value="5608710"/>
      <value value="8086727"/>
      <value value="1388540"/>
      <value value="3985289"/>
      <value value="1092114"/>
      <value value="628858"/>
      <value value="6649573"/>
      <value value="4303126"/>
      <value value="8735985"/>
      <value value="3922779"/>
      <value value="894976"/>
      <value value="9219367"/>
      <value value="6502900"/>
      <value value="2046480"/>
      <value value="4513624"/>
      <value value="6658707"/>
      <value value="7307277"/>
      <value value="8950502"/>
      <value value="4161537"/>
      <value value="4890197"/>
      <value value="6408912"/>
      <value value="2392993"/>
      <value value="1945805"/>
      <value value="4244694"/>
      <value value="3648777"/>
      <value value="3265763"/>
      <value value="2436245"/>
      <value value="6281764"/>
      <value value="8198010"/>
      <value value="7949855"/>
      <value value="5329918"/>
      <value value="1409710"/>
      <value value="5016218"/>
      <value value="6249517"/>
      <value value="2292984"/>
      <value value="832857"/>
      <value value="5293565"/>
      <value value="1439440"/>
      <value value="7545662"/>
      <value value="5052897"/>
      <value value="5583106"/>
      <value value="7443595"/>
      <value value="7173712"/>
      <value value="1884470"/>
      <value value="9023879"/>
      <value value="849706"/>
      <value value="5469427"/>
      <value value="9586612"/>
      <value value="8140310"/>
      <value value="763463"/>
      <value value="8416047"/>
      <value value="3711250"/>
      <value value="6495679"/>
      <value value="3666340"/>
      <value value="5209109"/>
      <value value="7030720"/>
      <value value="7245345"/>
      <value value="3461141"/>
      <value value="9158127"/>
      <value value="7514483"/>
      <value value="9328822"/>
      <value value="1213638"/>
      <value value="6535607"/>
      <value value="9246652"/>
      <value value="7572827"/>
      <value value="1691134"/>
      <value value="7625614"/>
      <value value="8415240"/>
      <value value="5183053"/>
      <value value="4960039"/>
      <value value="6508152"/>
      <value value="9668618"/>
      <value value="5921445"/>
      <value value="1829088"/>
      <value value="4823914"/>
      <value value="9912486"/>
      <value value="1648547"/>
      <value value="4266156"/>
      <value value="7804697"/>
      <value value="7055260"/>
      <value value="8858257"/>
      <value value="5921987"/>
      <value value="9944116"/>
      <value value="7968013"/>
      <value value="1994415"/>
      <value value="6625274"/>
      <value value="9083104"/>
      <value value="257675"/>
      <value value="3771302"/>
      <value value="4911330"/>
      <value value="799282"/>
      <value value="8736357"/>
      <value value="2746870"/>
      <value value="8404630"/>
      <value value="5362943"/>
      <value value="3655385"/>
      <value value="6885855"/>
      <value value="4077885"/>
      <value value="1049472"/>
      <value value="9781381"/>
      <value value="2993719"/>
      <value value="6033664"/>
      <value value="1146683"/>
      <value value="1020769"/>
      <value value="9633569"/>
      <value value="6512521"/>
      <value value="6236228"/>
      <value value="6110439"/>
      <value value="95720"/>
      <value value="26836"/>
      <value value="1831395"/>
      <value value="8747478"/>
      <value value="4888588"/>
      <value value="1935554"/>
      <value value="4612873"/>
      <value value="5464661"/>
      <value value="2578469"/>
      <value value="4278517"/>
      <value value="1997074"/>
      <value value="1795167"/>
      <value value="5318592"/>
      <value value="7390273"/>
      <value value="1802877"/>
      <value value="3438100"/>
      <value value="3910879"/>
      <value value="5786267"/>
      <value value="9460143"/>
      <value value="568341"/>
      <value value="331869"/>
      <value value="9626512"/>
      <value value="5778108"/>
      <value value="332253"/>
      <value value="9684573"/>
      <value value="8522710"/>
      <value value="1532697"/>
      <value value="8246929"/>
      <value value="1158327"/>
      <value value="9577535"/>
      <value value="7892282"/>
      <value value="5007701"/>
      <value value="7415832"/>
      <value value="501403"/>
      <value value="2180473"/>
      <value value="2260765"/>
      <value value="4027640"/>
      <value value="1877718"/>
      <value value="7207894"/>
      <value value="4915541"/>
      <value value="8839073"/>
      <value value="4484382"/>
      <value value="1753012"/>
      <value value="4041126"/>
      <value value="6025569"/>
      <value value="4107053"/>
      <value value="4877965"/>
      <value value="5461736"/>
      <value value="6824342"/>
      <value value="9527660"/>
      <value value="7034015"/>
      <value value="4034362"/>
      <value value="6489002"/>
      <value value="7782129"/>
      <value value="6719289"/>
      <value value="6789713"/>
      <value value="6199456"/>
      <value value="5777859"/>
      <value value="295921"/>
      <value value="1443094"/>
      <value value="7330946"/>
      <value value="3049739"/>
      <value value="4862135"/>
      <value value="1317423"/>
      <value value="1918213"/>
      <value value="4982191"/>
      <value value="8363819"/>
      <value value="9863401"/>
      <value value="7581844"/>
      <value value="6394776"/>
      <value value="9496534"/>
      <value value="1381870"/>
      <value value="8390632"/>
      <value value="2083882"/>
      <value value="3340871"/>
      <value value="4531063"/>
      <value value="994812"/>
      <value value="7705516"/>
      <value value="7698855"/>
      <value value="8027943"/>
      <value value="4550265"/>
      <value value="1118783"/>
      <value value="2969696"/>
      <value value="4178601"/>
      <value value="5718579"/>
      <value value="3104483"/>
      <value value="6534872"/>
      <value value="3990450"/>
      <value value="1790383"/>
      <value value="4450113"/>
      <value value="9482463"/>
      <value value="237378"/>
      <value value="4567277"/>
      <value value="2107209"/>
      <value value="5110140"/>
      <value value="9165044"/>
      <value value="9451423"/>
      <value value="496032"/>
      <value value="768490"/>
      <value value="9989296"/>
      <value value="9455202"/>
      <value value="8761617"/>
      <value value="5894512"/>
      <value value="8953697"/>
      <value value="4194980"/>
      <value value="3935049"/>
      <value value="3702239"/>
      <value value="7073530"/>
      <value value="198992"/>
      <value value="4318052"/>
      <value value="1592050"/>
      <value value="5937957"/>
      <value value="1176730"/>
      <value value="6790680"/>
      <value value="5720983"/>
      <value value="812944"/>
      <value value="4972675"/>
      <value value="4750424"/>
      <value value="317334"/>
      <value value="5552559"/>
      <value value="6654680"/>
      <value value="3483592"/>
      <value value="2944863"/>
      <value value="1149094"/>
      <value value="796717"/>
      <value value="7804602"/>
      <value value="7293180"/>
      <value value="545020"/>
      <value value="9554501"/>
      <value value="7936432"/>
      <value value="2514488"/>
      <value value="4903980"/>
      <value value="4062357"/>
      <value value="291098"/>
      <value value="7276263"/>
      <value value="7630841"/>
      <value value="8613074"/>
      <value value="7283173"/>
      <value value="4804107"/>
      <value value="3608438"/>
      <value value="2517330"/>
      <value value="7456329"/>
      <value value="2561250"/>
      <value value="8822372"/>
      <value value="5602860"/>
      <value value="2260541"/>
      <value value="1743340"/>
      <value value="4629342"/>
      <value value="4312224"/>
      <value value="6677732"/>
      <value value="6125727"/>
      <value value="3810911"/>
      <value value="5749060"/>
      <value value="8881706"/>
      <value value="4570810"/>
      <value value="2345170"/>
      <value value="8013275"/>
      <value value="4130496"/>
      <value value="9854666"/>
      <value value="7399467"/>
      <value value="6222366"/>
      <value value="6732327"/>
      <value value="4457328"/>
      <value value="7728149"/>
      <value value="1987031"/>
      <value value="78787"/>
      <value value="8576267"/>
      <value value="2970811"/>
      <value value="5558378"/>
      <value value="1283285"/>
      <value value="1425276"/>
      <value value="613350"/>
      <value value="1149521"/>
      <value value="4872667"/>
      <value value="1384415"/>
      <value value="4691471"/>
      <value value="7937257"/>
      <value value="8013476"/>
      <value value="3958487"/>
      <value value="9642548"/>
      <value value="1636697"/>
      <value value="2632646"/>
      <value value="1515433"/>
      <value value="7686079"/>
      <value value="9017098"/>
      <value value="3167868"/>
      <value value="2165639"/>
      <value value="9896347"/>
      <value value="3338079"/>
      <value value="1773510"/>
      <value value="3137893"/>
      <value value="7500181"/>
      <value value="6002636"/>
      <value value="7606746"/>
      <value value="8891696"/>
      <value value="4970338"/>
      <value value="3038235"/>
      <value value="9625024"/>
      <value value="5693055"/>
      <value value="5135631"/>
      <value value="4009407"/>
      <value value="544004"/>
      <value value="1026380"/>
      <value value="613564"/>
      <value value="9623977"/>
      <value value="8094455"/>
      <value value="2032322"/>
      <value value="4604461"/>
      <value value="2402149"/>
      <value value="9637590"/>
      <value value="8345666"/>
      <value value="6069160"/>
      <value value="8173318"/>
      <value value="7981301"/>
      <value value="9514174"/>
      <value value="4795649"/>
      <value value="2427691"/>
      <value value="4460580"/>
      <value value="3407752"/>
      <value value="2086455"/>
      <value value="8945376"/>
      <value value="8868989"/>
      <value value="8964054"/>
      <value value="340735"/>
      <value value="1979672"/>
      <value value="7262678"/>
      <value value="5613455"/>
      <value value="7544521"/>
      <value value="8153697"/>
      <value value="5808252"/>
      <value value="9621744"/>
      <value value="6195024"/>
      <value value="7652040"/>
      <value value="3176581"/>
      <value value="9687079"/>
      <value value="9097679"/>
      <value value="4534947"/>
      <value value="7649126"/>
      <value value="120195"/>
      <value value="9947672"/>
      <value value="4505216"/>
      <value value="9658311"/>
      <value value="7314866"/>
      <value value="4895212"/>
      <value value="6321445"/>
      <value value="6320241"/>
      <value value="4986748"/>
      <value value="6451835"/>
      <value value="4430092"/>
      <value value="6553283"/>
      <value value="8032804"/>
      <value value="5736301"/>
      <value value="2878929"/>
      <value value="406040"/>
      <value value="5186367"/>
      <value value="5594903"/>
      <value value="6915278"/>
      <value value="6764379"/>
      <value value="7554414"/>
      <value value="9438530"/>
      <value value="9302913"/>
      <value value="8585800"/>
      <value value="5416203"/>
      <value value="3543840"/>
      <value value="6492978"/>
      <value value="6992864"/>
      <value value="5600133"/>
      <value value="6286557"/>
      <value value="4447200"/>
      <value value="4088005"/>
      <value value="3151427"/>
      <value value="6268913"/>
      <value value="4224943"/>
      <value value="864442"/>
      <value value="2177940"/>
      <value value="5381025"/>
      <value value="4498705"/>
      <value value="2032507"/>
      <value value="2088084"/>
      <value value="9402605"/>
      <value value="6427860"/>
      <value value="9735190"/>
      <value value="8704273"/>
      <value value="5056346"/>
      <value value="8000600"/>
      <value value="4233870"/>
      <value value="8738598"/>
      <value value="9860960"/>
      <value value="3487579"/>
      <value value="9473759"/>
      <value value="5142927"/>
      <value value="9048876"/>
      <value value="7233417"/>
      <value value="2773001"/>
      <value value="5487661"/>
      <value value="230665"/>
      <value value="8732198"/>
      <value value="9393947"/>
      <value value="7093619"/>
      <value value="5649452"/>
      <value value="722803"/>
      <value value="7496579"/>
      <value value="6639669"/>
      <value value="7151364"/>
      <value value="5889992"/>
      <value value="2900471"/>
      <value value="1213144"/>
      <value value="5715312"/>
      <value value="5693273"/>
      <value value="1341449"/>
      <value value="8662040"/>
      <value value="4350651"/>
      <value value="1177042"/>
      <value value="3857414"/>
      <value value="4937978"/>
      <value value="1068881"/>
      <value value="3321371"/>
      <value value="3579408"/>
      <value value="512638"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;StageCal Test&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.31"/>
      <value value="0.375"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
      <value value="55"/>
      <value value="57"/>
      <value value="58"/>
      <value value="59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="82"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="138"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="house_resample_red_group">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="immune_from_prev_variant">
      <value value="0.6794928661985937"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="immune_from_reinfect">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incubation_period">
      <value value="4.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incursion_phase_speed_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_variant_2_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_final_phase">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incur_phase_limit">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_recovered_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_rate_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_tran_reduct">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_wane">
      <value value="0.002"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vaceffdays">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailycases">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="82"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="82"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="0.25019750025413173"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.85"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="0.13"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_factor">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_threshold">
      <value value="240"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="schoolsopen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="se_illnesspd">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="se_incubation">
      <value value="2.25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="secondary_cases">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set_shape">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="2.0E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_max">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_min">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_prop">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="total_population">
      <value value="234000000000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_iso_factor">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_r">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_slope">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tracking">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_variant_eff_prop">
      <value value="0.86"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="variant_transmiss_growth">
      <value value="1.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.035"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="yearly_recover_prop_loss">
      <value value="0"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="MainRun_PK" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>days</metric>
    <metric>stage_listOut</metric>
    <metric>scalephase</metric>
    <metric>cumulativeInfected</metric>
    <metric>casesReportedToday</metric>
    <metric>Deathcount</metric>
    <metric>totalOverseasIncursions</metric>
    <metric>infectNoVacArray_listOut</metric>
    <metric>infectVacArray_listOut</metric>
    <metric>age_listOut</metric>
    <metric>atsi_listOut</metric>
    <metric>morbid_listOut</metric>
    <enumeratedValueSet variable="rand_seed">
      <value value="5445509"/>
      <value value="6197459"/>
      <value value="7337831"/>
      <value value="8301531"/>
      <value value="56290"/>
      <value value="7786412"/>
      <value value="4036610"/>
      <value value="737234"/>
      <value value="8687609"/>
      <value value="3990339"/>
      <value value="8531666"/>
      <value value="2226834"/>
      <value value="2848620"/>
      <value value="4501529"/>
      <value value="7143098"/>
      <value value="9241537"/>
      <value value="8466552"/>
      <value value="7662871"/>
      <value value="3221804"/>
      <value value="2159862"/>
      <value value="9892735"/>
      <value value="7782131"/>
      <value value="8991261"/>
      <value value="8361258"/>
      <value value="299370"/>
      <value value="6955257"/>
      <value value="39930"/>
      <value value="7951247"/>
      <value value="624644"/>
      <value value="2924908"/>
      <value value="1666023"/>
      <value value="8055906"/>
      <value value="3664447"/>
      <value value="878572"/>
      <value value="712554"/>
      <value value="1564488"/>
      <value value="1681409"/>
      <value value="3606038"/>
      <value value="2332615"/>
      <value value="6131639"/>
      <value value="3043159"/>
      <value value="5031746"/>
      <value value="4693449"/>
      <value value="4840497"/>
      <value value="7938253"/>
      <value value="4317086"/>
      <value value="4863903"/>
      <value value="8288558"/>
      <value value="6229885"/>
      <value value="8345561"/>
      <value value="4220544"/>
      <value value="8848533"/>
      <value value="3481834"/>
      <value value="8677625"/>
      <value value="2909925"/>
      <value value="4440882"/>
      <value value="5854376"/>
      <value value="2723448"/>
      <value value="3540882"/>
      <value value="4835343"/>
      <value value="3267543"/>
      <value value="9405469"/>
      <value value="9857977"/>
      <value value="6478921"/>
      <value value="9107945"/>
      <value value="5688457"/>
      <value value="6938279"/>
      <value value="3196045"/>
      <value value="9852916"/>
      <value value="2633301"/>
      <value value="103500"/>
      <value value="7911972"/>
      <value value="4399161"/>
      <value value="3712720"/>
      <value value="6888216"/>
      <value value="2250267"/>
      <value value="1994408"/>
      <value value="9459976"/>
      <value value="1743816"/>
      <value value="1951097"/>
      <value value="1569685"/>
      <value value="6346508"/>
      <value value="2292953"/>
      <value value="3179400"/>
      <value value="2216335"/>
      <value value="1872422"/>
      <value value="3613435"/>
      <value value="8249678"/>
      <value value="3445467"/>
      <value value="2704974"/>
      <value value="4063806"/>
      <value value="3092227"/>
      <value value="8341326"/>
      <value value="4990592"/>
      <value value="4783306"/>
      <value value="9518688"/>
      <value value="8565327"/>
      <value value="7656524"/>
      <value value="853802"/>
      <value value="9552316"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;ModerateSupress_No_4&quot;"/>
      <value value="&quot;ModerateSupress&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.246"/>
      <value value="0.296"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="730"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="immune_from_prev_variant">
      <value value="0.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="immune_from_reinfect">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incubation_period">
      <value value="4.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="180000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_final_phase">
      <value value="5"/>
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_recovered_prop">
      <value value="0.05"/>
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_rate_mult">
      <value value="1.5"/>
      <value value="1"/>
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_tran_reduct">
      <value value="0.75"/>
      <value value="0.875"/>
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_wane">
      <value value="0.002"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vaceffdays">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incur_phase_limit">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailycases">
      <value value="10000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.85"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.12"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_factor">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_threshold">
      <value value="240"/>
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
    <enumeratedValueSet variable="secondary_cases">
      <value value="180000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set_shape">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="12"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.002"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_max">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_min">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_prop">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="total_population">
      <value value="234000000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_iso_factor">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_r">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_slope">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tracking">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_variant_eff_prop">
      <value value="0.8"/>
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="variant_transmiss_growth">
      <value value="1.3"/>
      <value value="1.6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="yearly_recover_prop_loss">
      <value value="0"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="stageTest_None" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>average_R_region_1</metric>
    <metric>average_R_region_2</metric>
    <metric>average_R_all_regions</metric>
    <metric>global_transmissibility</metric>
    <metric>days</metric>
    <metric>totalEndCount</metric>
    <metric>scalephase</metric>
    <metric>cumulativeInfected</metric>
    <metric>infectionsToday</metric>
    <metric>slopeAverage</metric>
    <metric>trackAverage</metric>
    <metric>infectedTrackAverage</metric>
    <metric>testName</metric>
    <enumeratedValueSet variable="rand_seed">
      <value value="1294124"/>
      <value value="2882764"/>
      <value value="938960"/>
      <value value="7254736"/>
      <value value="3196505"/>
      <value value="7309520"/>
      <value value="804831"/>
      <value value="3951611"/>
      <value value="9810757"/>
      <value value="9806763"/>
      <value value="5328423"/>
      <value value="5705711"/>
      <value value="7097883"/>
      <value value="770838"/>
      <value value="9005743"/>
      <value value="809897"/>
      <value value="9925623"/>
      <value value="94926"/>
      <value value="2354219"/>
      <value value="9985909"/>
      <value value="2716353"/>
      <value value="85463"/>
      <value value="133499"/>
      <value value="3225251"/>
      <value value="5586610"/>
      <value value="7901303"/>
      <value value="2630008"/>
      <value value="2880904"/>
      <value value="4616906"/>
      <value value="8479623"/>
      <value value="7051303"/>
      <value value="8049323"/>
      <value value="2967666"/>
      <value value="5415082"/>
      <value value="2373100"/>
      <value value="3818769"/>
      <value value="9075840"/>
      <value value="5267300"/>
      <value value="4068620"/>
      <value value="8099521"/>
      <value value="9359238"/>
      <value value="5875146"/>
      <value value="4653802"/>
      <value value="5517179"/>
      <value value="313306"/>
      <value value="7060551"/>
      <value value="8094495"/>
      <value value="2113017"/>
      <value value="7299131"/>
      <value value="4078605"/>
      <value value="3320929"/>
      <value value="9384704"/>
      <value value="3530302"/>
      <value value="8448237"/>
      <value value="7670732"/>
      <value value="2118639"/>
      <value value="4472685"/>
      <value value="5553384"/>
      <value value="3919681"/>
      <value value="3914953"/>
      <value value="3885403"/>
      <value value="4206269"/>
      <value value="6875426"/>
      <value value="2188839"/>
      <value value="83169"/>
      <value value="5416926"/>
      <value value="3219828"/>
      <value value="4156024"/>
      <value value="1934932"/>
      <value value="9546092"/>
      <value value="1963089"/>
      <value value="9980659"/>
      <value value="197023"/>
      <value value="9414268"/>
      <value value="1603803"/>
      <value value="4577955"/>
      <value value="4757859"/>
      <value value="4005843"/>
      <value value="7943408"/>
      <value value="8676916"/>
      <value value="1879594"/>
      <value value="3953821"/>
      <value value="7448897"/>
      <value value="749476"/>
      <value value="8673886"/>
      <value value="5542280"/>
      <value value="5255577"/>
      <value value="8449577"/>
      <value value="8729531"/>
      <value value="1336395"/>
      <value value="1608656"/>
      <value value="9353815"/>
      <value value="6485641"/>
      <value value="6851448"/>
      <value value="2408658"/>
      <value value="9190706"/>
      <value value="4005386"/>
      <value value="79254"/>
      <value value="3003634"/>
      <value value="4984576"/>
      <value value="7543067"/>
      <value value="9552694"/>
      <value value="1231399"/>
      <value value="516814"/>
      <value value="7187454"/>
      <value value="5401929"/>
      <value value="4053148"/>
      <value value="4386085"/>
      <value value="1636322"/>
      <value value="2670312"/>
      <value value="1613556"/>
      <value value="9770234"/>
      <value value="2354621"/>
      <value value="2012035"/>
      <value value="9747770"/>
      <value value="9290132"/>
      <value value="1156287"/>
      <value value="4984101"/>
      <value value="6709851"/>
      <value value="8989901"/>
      <value value="1417128"/>
      <value value="4544224"/>
      <value value="4606449"/>
      <value value="7866967"/>
      <value value="8457281"/>
      <value value="4938813"/>
      <value value="5973838"/>
      <value value="2987950"/>
      <value value="7499123"/>
      <value value="4779356"/>
      <value value="7557485"/>
      <value value="1630779"/>
      <value value="324991"/>
      <value value="888538"/>
      <value value="822950"/>
      <value value="9068844"/>
      <value value="7300163"/>
      <value value="1270614"/>
      <value value="8449859"/>
      <value value="3385792"/>
      <value value="3304224"/>
      <value value="5772198"/>
      <value value="2878987"/>
      <value value="8172180"/>
      <value value="7359297"/>
      <value value="6182570"/>
      <value value="8808200"/>
      <value value="4363402"/>
      <value value="5463499"/>
      <value value="2051254"/>
      <value value="9912119"/>
      <value value="3159941"/>
      <value value="3960253"/>
      <value value="5748024"/>
      <value value="3180874"/>
      <value value="8967039"/>
      <value value="3587230"/>
      <value value="2438346"/>
      <value value="2592157"/>
      <value value="9895313"/>
      <value value="7644611"/>
      <value value="8742792"/>
      <value value="8314378"/>
      <value value="2442613"/>
      <value value="3143177"/>
      <value value="1756489"/>
      <value value="4075528"/>
      <value value="7311465"/>
      <value value="8876625"/>
      <value value="3922098"/>
      <value value="5142524"/>
      <value value="6940852"/>
      <value value="7666106"/>
      <value value="2676050"/>
      <value value="8249128"/>
      <value value="994631"/>
      <value value="5355402"/>
      <value value="3706291"/>
      <value value="5263190"/>
      <value value="3876132"/>
      <value value="9092623"/>
      <value value="9789402"/>
      <value value="452297"/>
      <value value="9865600"/>
      <value value="7335386"/>
      <value value="5610969"/>
      <value value="3288881"/>
      <value value="4872197"/>
      <value value="2381357"/>
      <value value="2221320"/>
      <value value="8572788"/>
      <value value="7539726"/>
      <value value="4842255"/>
      <value value="1485328"/>
      <value value="6827696"/>
      <value value="9527095"/>
      <value value="1414846"/>
      <value value="100075"/>
      <value value="8924585"/>
      <value value="3210488"/>
      <value value="1239477"/>
      <value value="4315868"/>
      <value value="4793772"/>
      <value value="3933639"/>
      <value value="4995259"/>
      <value value="7907443"/>
      <value value="7184211"/>
      <value value="1548426"/>
      <value value="2355911"/>
      <value value="3110505"/>
      <value value="3025512"/>
      <value value="8417847"/>
      <value value="1559409"/>
      <value value="4069259"/>
      <value value="6641281"/>
      <value value="4119831"/>
      <value value="9170564"/>
      <value value="5628738"/>
      <value value="9832421"/>
      <value value="2293845"/>
      <value value="4967915"/>
      <value value="4034249"/>
      <value value="2655246"/>
      <value value="4120152"/>
      <value value="9379177"/>
      <value value="6609358"/>
      <value value="2356939"/>
      <value value="9104968"/>
      <value value="9505848"/>
      <value value="5797278"/>
      <value value="3608373"/>
      <value value="9495700"/>
      <value value="4767627"/>
      <value value="379509"/>
      <value value="10243"/>
      <value value="6061779"/>
      <value value="5441171"/>
      <value value="9424318"/>
      <value value="5835428"/>
      <value value="9930242"/>
      <value value="7292124"/>
      <value value="4058272"/>
      <value value="3173806"/>
      <value value="7221205"/>
      <value value="6952106"/>
      <value value="5773806"/>
      <value value="8844994"/>
      <value value="8598341"/>
      <value value="6528411"/>
      <value value="2594625"/>
      <value value="5109393"/>
      <value value="8212363"/>
      <value value="4130947"/>
      <value value="7701090"/>
      <value value="4282507"/>
      <value value="4862201"/>
      <value value="3622705"/>
      <value value="4875791"/>
      <value value="4192844"/>
      <value value="6465089"/>
      <value value="7673972"/>
      <value value="9504058"/>
      <value value="6974309"/>
      <value value="1641239"/>
      <value value="4321894"/>
      <value value="9975895"/>
      <value value="979369"/>
      <value value="2796156"/>
      <value value="5162063"/>
      <value value="6149702"/>
      <value value="1730673"/>
      <value value="3891480"/>
      <value value="4625248"/>
      <value value="4554726"/>
      <value value="2737470"/>
      <value value="1079881"/>
      <value value="2647372"/>
      <value value="8268296"/>
      <value value="6644542"/>
      <value value="707424"/>
      <value value="2177486"/>
      <value value="1748283"/>
      <value value="2082624"/>
      <value value="8508295"/>
      <value value="3446143"/>
      <value value="1366935"/>
      <value value="9346218"/>
      <value value="128325"/>
      <value value="8295999"/>
      <value value="2170586"/>
      <value value="3217829"/>
      <value value="5933466"/>
      <value value="3337807"/>
      <value value="2793194"/>
      <value value="8911096"/>
      <value value="8417601"/>
      <value value="1629553"/>
      <value value="1066733"/>
      <value value="5025837"/>
      <value value="2501333"/>
      <value value="6476013"/>
      <value value="8093445"/>
      <value value="3807797"/>
      <value value="2656142"/>
      <value value="3458577"/>
      <value value="9512456"/>
      <value value="1361142"/>
      <value value="888481"/>
      <value value="3743801"/>
      <value value="5575164"/>
      <value value="8027925"/>
      <value value="3158108"/>
      <value value="2903157"/>
      <value value="423104"/>
      <value value="7092747"/>
      <value value="6808610"/>
      <value value="2711485"/>
      <value value="1335724"/>
      <value value="3257903"/>
      <value value="658887"/>
      <value value="4718518"/>
      <value value="5866676"/>
      <value value="9332305"/>
      <value value="7393922"/>
      <value value="3574171"/>
      <value value="7853275"/>
      <value value="7809006"/>
      <value value="707581"/>
      <value value="7161669"/>
      <value value="9830407"/>
      <value value="2472456"/>
      <value value="2677863"/>
      <value value="737906"/>
      <value value="3406949"/>
      <value value="4099583"/>
      <value value="7214490"/>
      <value value="6088224"/>
      <value value="9898773"/>
      <value value="1841892"/>
      <value value="1653126"/>
      <value value="8669073"/>
      <value value="4889539"/>
      <value value="8099714"/>
      <value value="372189"/>
      <value value="6736281"/>
      <value value="1892594"/>
      <value value="5891881"/>
      <value value="7077795"/>
      <value value="6470245"/>
      <value value="1173439"/>
      <value value="311254"/>
      <value value="3992211"/>
      <value value="7982712"/>
      <value value="6777889"/>
      <value value="5533341"/>
      <value value="3574818"/>
      <value value="5637148"/>
      <value value="7714251"/>
      <value value="7981755"/>
      <value value="6389653"/>
      <value value="4704256"/>
      <value value="3767176"/>
      <value value="2434424"/>
      <value value="8609013"/>
      <value value="8944437"/>
      <value value="2712779"/>
      <value value="6321910"/>
      <value value="2907091"/>
      <value value="4719224"/>
      <value value="4744616"/>
      <value value="8260327"/>
      <value value="908580"/>
      <value value="3440916"/>
      <value value="6090096"/>
      <value value="1117414"/>
      <value value="7512218"/>
      <value value="1475126"/>
      <value value="9459114"/>
      <value value="4025780"/>
      <value value="9563153"/>
      <value value="2991985"/>
      <value value="2292825"/>
      <value value="6076411"/>
      <value value="8735886"/>
      <value value="1617082"/>
      <value value="8348991"/>
      <value value="4575732"/>
      <value value="449765"/>
      <value value="5605056"/>
      <value value="3652109"/>
      <value value="2717177"/>
      <value value="422691"/>
      <value value="8670636"/>
      <value value="1862895"/>
      <value value="232389"/>
      <value value="6609147"/>
      <value value="846856"/>
      <value value="9837404"/>
      <value value="3102515"/>
      <value value="495223"/>
      <value value="9003068"/>
      <value value="178854"/>
      <value value="6480580"/>
      <value value="512300"/>
      <value value="7348594"/>
      <value value="8464099"/>
      <value value="8918939"/>
      <value value="932094"/>
      <value value="1568188"/>
      <value value="3812165"/>
      <value value="2482565"/>
      <value value="3653648"/>
      <value value="9057868"/>
      <value value="4306406"/>
      <value value="3382228"/>
      <value value="1708629"/>
      <value value="7873143"/>
      <value value="5324143"/>
      <value value="1090098"/>
      <value value="2884565"/>
      <value value="6290945"/>
      <value value="3946896"/>
      <value value="2838980"/>
      <value value="2998846"/>
      <value value="2313371"/>
      <value value="8799471"/>
      <value value="8768302"/>
      <value value="504193"/>
      <value value="9190714"/>
      <value value="4070720"/>
      <value value="9118628"/>
      <value value="3745427"/>
      <value value="194307"/>
      <value value="9585223"/>
      <value value="6641458"/>
      <value value="3391305"/>
      <value value="213741"/>
      <value value="3813618"/>
      <value value="890593"/>
      <value value="8099723"/>
      <value value="872525"/>
      <value value="8350948"/>
      <value value="5077747"/>
      <value value="4481055"/>
      <value value="1528503"/>
      <value value="8419107"/>
      <value value="4823142"/>
      <value value="3653451"/>
      <value value="1975139"/>
      <value value="1772105"/>
      <value value="9359822"/>
      <value value="3636698"/>
      <value value="4126971"/>
      <value value="8548265"/>
      <value value="8662876"/>
      <value value="4175432"/>
      <value value="6536921"/>
      <value value="7968882"/>
      <value value="7263921"/>
      <value value="4785589"/>
      <value value="6990120"/>
      <value value="5210534"/>
      <value value="7107635"/>
      <value value="8123457"/>
      <value value="6750053"/>
      <value value="1522694"/>
      <value value="1758071"/>
      <value value="6539216"/>
      <value value="741840"/>
      <value value="9726739"/>
      <value value="8276408"/>
      <value value="4991929"/>
      <value value="2688854"/>
      <value value="7320565"/>
      <value value="7574783"/>
      <value value="5634586"/>
      <value value="1187676"/>
      <value value="2839275"/>
      <value value="1326391"/>
      <value value="8248823"/>
      <value value="4468682"/>
      <value value="4237150"/>
      <value value="8973616"/>
      <value value="4214943"/>
      <value value="5526734"/>
      <value value="449248"/>
      <value value="2065771"/>
      <value value="410854"/>
      <value value="746948"/>
      <value value="3849499"/>
      <value value="2605537"/>
      <value value="1735891"/>
      <value value="3616491"/>
      <value value="4489957"/>
      <value value="3397091"/>
      <value value="7759162"/>
      <value value="792439"/>
      <value value="1149183"/>
      <value value="6104103"/>
      <value value="2677952"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;StageCal Test&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.31"/>
      <value value="0.375"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="82"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="121"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="house_resample_red_group">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="immune_from_prev_variant">
      <value value="0.7009964376361408"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="immune_from_reinfect">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incubation_period">
      <value value="4.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_final_phase">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incur_phase_limit">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_recovered_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_rate_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_tran_reduct">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_wane">
      <value value="0.002"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vaceffdays">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailycases">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="82"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="82"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.85"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_factor">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scale_threshold">
      <value value="240"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="schoolsopen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="se_illnesspd">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="se_incubation">
      <value value="2.25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="secondary_cases">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set_shape">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="2.0E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_max">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_min">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sympt_present_prop">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="total_population">
      <value value="234000000000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_iso_factor">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_r">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_slope">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tracking">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_variant_eff_prop">
      <value value="0.86"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="variant_transmiss_growth">
      <value value="1.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.035"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="2.5"/>
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

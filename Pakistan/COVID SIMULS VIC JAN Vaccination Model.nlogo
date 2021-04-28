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
1044
307
1174
352
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
1044
254
1216
299
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
1473
569
1598
618
Reported Inf Today
casesReportedToday
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
"New Cases" 1.0 1 -5298144 true "" "plot (Scale_Factor ^ scalephase) * (count simuls with [ color = red and timenow = Case_Reporting_Delay ])"

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
0.245
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
335
975
530
1008
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
1044
152
1159
197
Cases in period 7
casesinperiod7
0
1
11

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
783
1027
990
1061
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
2222222.0
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
1043
202
1215
247
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
"Reported" 1.0 0 -2674135 true "" "plot count simuls with [ color = red and tracked = 1 and caseReportTime <= ticks] * Scale_Factor ^ scalephase"

SLIDER
334
1014
529
1047
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
121.0
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
335
935
532
968
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
1473
457
1602
502
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
1484
398
1618
443
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
1044
99
1216
144
NIL
totalEndCount
17
1
11

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
297
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
780
908
980
941
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
780
984
977
1017
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
780
949
978
982
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
302
688
535
721
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
0.7009964376361408
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
185
770
250
815
% Yellow
100 * (count simuls with [color = yellow]) / Population
2
1
11

MONITOR
185
818
278
863
% Yellow First
100 * (count simuls with [color = yellow and recoveryVariant = 1]) / Population
2
1
11

MONITOR
184
867
293
912
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
1475
515
1562
560
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
184
917
293
962
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
0
10
6.0
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
1039
house_resample_red_group
house_resample_red_group
0
1
0.8
0.01
1
NIL
HORIZONTAL

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
  <experiment name="stageTest_big6" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>average_R</metric>
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
      <value value="2167835"/>
      <value value="5872891"/>
      <value value="5490626"/>
      <value value="2392919"/>
      <value value="5539148"/>
      <value value="4233385"/>
      <value value="8985923"/>
      <value value="7956035"/>
      <value value="1821737"/>
      <value value="8979356"/>
      <value value="2003687"/>
      <value value="1076997"/>
      <value value="2435640"/>
      <value value="7707185"/>
      <value value="6222491"/>
      <value value="6049523"/>
      <value value="9073385"/>
      <value value="5675830"/>
      <value value="9424616"/>
      <value value="9463482"/>
      <value value="2178872"/>
      <value value="4543370"/>
      <value value="5354614"/>
      <value value="1880173"/>
      <value value="3986787"/>
      <value value="7546028"/>
      <value value="1748120"/>
      <value value="1655591"/>
      <value value="8522932"/>
      <value value="1276806"/>
      <value value="497023"/>
      <value value="3660965"/>
      <value value="5225315"/>
      <value value="9507258"/>
      <value value="3403171"/>
      <value value="8185082"/>
      <value value="2992609"/>
      <value value="739918"/>
      <value value="1371266"/>
      <value value="9211179"/>
      <value value="5690415"/>
      <value value="9351719"/>
      <value value="4247046"/>
      <value value="7323621"/>
      <value value="1836898"/>
      <value value="6302589"/>
      <value value="2643128"/>
      <value value="3743983"/>
      <value value="6546618"/>
      <value value="2829227"/>
      <value value="2398048"/>
      <value value="7377604"/>
      <value value="1861478"/>
      <value value="8610300"/>
      <value value="9915193"/>
      <value value="3043623"/>
      <value value="1772891"/>
      <value value="3104689"/>
      <value value="9962901"/>
      <value value="7962469"/>
      <value value="9043216"/>
      <value value="7076638"/>
      <value value="7000378"/>
      <value value="5502094"/>
      <value value="5948064"/>
      <value value="2518246"/>
      <value value="5770541"/>
      <value value="8244399"/>
      <value value="8975083"/>
      <value value="9508566"/>
      <value value="5849629"/>
      <value value="3029124"/>
      <value value="6351568"/>
      <value value="8161480"/>
      <value value="5991241"/>
      <value value="7546258"/>
      <value value="3071173"/>
      <value value="1554868"/>
      <value value="2760287"/>
      <value value="2008338"/>
      <value value="7404701"/>
      <value value="8973508"/>
      <value value="9649599"/>
      <value value="9931248"/>
      <value value="9154076"/>
      <value value="1992121"/>
      <value value="2605923"/>
      <value value="5423050"/>
      <value value="1684698"/>
      <value value="3987534"/>
      <value value="7449710"/>
      <value value="4241291"/>
      <value value="8582055"/>
      <value value="9310404"/>
      <value value="8218962"/>
      <value value="5717284"/>
      <value value="6701362"/>
      <value value="2051398"/>
      <value value="5446501"/>
      <value value="2569581"/>
      <value value="3652156"/>
      <value value="4118849"/>
      <value value="4879567"/>
      <value value="6674106"/>
      <value value="4529305"/>
      <value value="2716538"/>
      <value value="2217241"/>
      <value value="4708969"/>
      <value value="247520"/>
      <value value="6681656"/>
      <value value="7046841"/>
      <value value="5344224"/>
      <value value="5790340"/>
      <value value="7759418"/>
      <value value="4484976"/>
      <value value="9002119"/>
      <value value="9009710"/>
      <value value="7649777"/>
      <value value="9509795"/>
      <value value="4106658"/>
      <value value="412830"/>
      <value value="6969163"/>
      <value value="4343430"/>
      <value value="4253713"/>
      <value value="6078377"/>
      <value value="3546254"/>
      <value value="7388616"/>
      <value value="5133809"/>
      <value value="2139816"/>
      <value value="2639695"/>
      <value value="386961"/>
      <value value="2013634"/>
      <value value="8293389"/>
      <value value="9298487"/>
      <value value="2192560"/>
      <value value="8371145"/>
      <value value="211254"/>
      <value value="4824469"/>
      <value value="3822104"/>
      <value value="4124036"/>
      <value value="893318"/>
      <value value="7844692"/>
      <value value="7799779"/>
      <value value="1907504"/>
      <value value="414151"/>
      <value value="3944251"/>
      <value value="2398592"/>
      <value value="845783"/>
      <value value="2613127"/>
      <value value="7203257"/>
      <value value="5972891"/>
      <value value="3567090"/>
      <value value="7685969"/>
      <value value="8815434"/>
      <value value="7755646"/>
      <value value="4666808"/>
      <value value="6017154"/>
      <value value="8035943"/>
      <value value="3487101"/>
      <value value="6309904"/>
      <value value="611670"/>
      <value value="370051"/>
      <value value="6628923"/>
      <value value="153293"/>
      <value value="115179"/>
      <value value="473789"/>
      <value value="313017"/>
      <value value="7609515"/>
      <value value="118513"/>
      <value value="4461807"/>
      <value value="2460704"/>
      <value value="8685926"/>
      <value value="6293969"/>
      <value value="676305"/>
      <value value="6420478"/>
      <value value="4551166"/>
      <value value="867040"/>
      <value value="9525959"/>
      <value value="4073763"/>
      <value value="2454282"/>
      <value value="8584092"/>
      <value value="7585561"/>
      <value value="8582369"/>
      <value value="2122602"/>
      <value value="3485566"/>
      <value value="5691959"/>
      <value value="2152512"/>
      <value value="7258107"/>
      <value value="712326"/>
      <value value="6857735"/>
      <value value="2007417"/>
      <value value="1236330"/>
      <value value="4812211"/>
      <value value="6798367"/>
      <value value="5909480"/>
      <value value="4792503"/>
      <value value="250696"/>
      <value value="9854830"/>
      <value value="9019832"/>
      <value value="3775495"/>
      <value value="7844992"/>
      <value value="1334149"/>
      <value value="3683818"/>
      <value value="8775334"/>
      <value value="1131697"/>
      <value value="7562927"/>
      <value value="4285411"/>
      <value value="8434293"/>
      <value value="4054720"/>
      <value value="4140960"/>
      <value value="9895544"/>
      <value value="5339662"/>
      <value value="4264238"/>
      <value value="1480065"/>
      <value value="9930860"/>
      <value value="6492078"/>
      <value value="1562662"/>
      <value value="5868165"/>
      <value value="5891698"/>
      <value value="8303455"/>
      <value value="2921939"/>
      <value value="4095215"/>
      <value value="997650"/>
      <value value="4793856"/>
      <value value="1975520"/>
      <value value="5939079"/>
      <value value="493440"/>
      <value value="272009"/>
      <value value="198509"/>
      <value value="2085457"/>
      <value value="396470"/>
      <value value="2345589"/>
      <value value="2084040"/>
      <value value="4819392"/>
      <value value="6919830"/>
      <value value="6435815"/>
      <value value="1734184"/>
      <value value="8734845"/>
      <value value="1883603"/>
      <value value="7397876"/>
      <value value="9840321"/>
      <value value="95320"/>
      <value value="2884099"/>
      <value value="3603829"/>
      <value value="8347402"/>
      <value value="1643765"/>
      <value value="2273358"/>
      <value value="2728527"/>
      <value value="5811681"/>
      <value value="9423452"/>
      <value value="2025961"/>
      <value value="9553732"/>
      <value value="9664270"/>
      <value value="9764169"/>
      <value value="9513215"/>
      <value value="1969754"/>
      <value value="381126"/>
      <value value="7259045"/>
      <value value="5573966"/>
      <value value="2010526"/>
      <value value="8987465"/>
      <value value="8177955"/>
      <value value="2053866"/>
      <value value="6296939"/>
      <value value="4621170"/>
      <value value="798360"/>
      <value value="6648269"/>
      <value value="7934034"/>
      <value value="3819595"/>
      <value value="8102095"/>
      <value value="3283017"/>
      <value value="7960289"/>
      <value value="8333000"/>
      <value value="2850632"/>
      <value value="1052621"/>
      <value value="3455044"/>
      <value value="9542523"/>
      <value value="1258005"/>
      <value value="4947585"/>
      <value value="7797471"/>
      <value value="2633303"/>
      <value value="8354195"/>
      <value value="9993570"/>
      <value value="6669808"/>
      <value value="1173972"/>
      <value value="7663670"/>
      <value value="9021018"/>
      <value value="3086225"/>
      <value value="6717306"/>
      <value value="3489729"/>
      <value value="3890612"/>
      <value value="810032"/>
      <value value="177207"/>
      <value value="5746893"/>
      <value value="8379667"/>
      <value value="1169901"/>
      <value value="174948"/>
      <value value="6916850"/>
      <value value="588638"/>
      <value value="6790411"/>
      <value value="468872"/>
      <value value="5721422"/>
      <value value="1820055"/>
      <value value="7501166"/>
      <value value="9362077"/>
      <value value="1245012"/>
      <value value="2593689"/>
      <value value="8402330"/>
      <value value="6487503"/>
      <value value="1086349"/>
      <value value="6861884"/>
      <value value="450585"/>
      <value value="1894088"/>
      <value value="60215"/>
      <value value="1602354"/>
      <value value="2793312"/>
      <value value="9874742"/>
      <value value="9199618"/>
      <value value="2949952"/>
      <value value="5792696"/>
      <value value="2362140"/>
      <value value="1927993"/>
      <value value="1915550"/>
      <value value="4038195"/>
      <value value="685359"/>
      <value value="1662428"/>
      <value value="4076524"/>
      <value value="1691626"/>
      <value value="9696333"/>
      <value value="5516053"/>
      <value value="1237178"/>
      <value value="2947835"/>
      <value value="3558762"/>
      <value value="5774850"/>
      <value value="9203200"/>
      <value value="6573829"/>
      <value value="7778153"/>
      <value value="7783100"/>
      <value value="824904"/>
      <value value="9492621"/>
      <value value="8363722"/>
      <value value="8152554"/>
      <value value="6808215"/>
      <value value="3450748"/>
      <value value="4336100"/>
      <value value="6926257"/>
      <value value="5201476"/>
      <value value="3552215"/>
      <value value="2678313"/>
      <value value="268700"/>
      <value value="9355391"/>
      <value value="2163469"/>
      <value value="5083883"/>
      <value value="7401643"/>
      <value value="3547853"/>
      <value value="8964424"/>
      <value value="5211391"/>
      <value value="3726529"/>
      <value value="9651521"/>
      <value value="7017959"/>
      <value value="8238837"/>
      <value value="258339"/>
      <value value="8939729"/>
      <value value="9502095"/>
      <value value="280200"/>
      <value value="1482222"/>
      <value value="2916192"/>
      <value value="2935929"/>
      <value value="8665236"/>
      <value value="1543868"/>
      <value value="2577116"/>
      <value value="1933871"/>
      <value value="5802035"/>
      <value value="8080530"/>
      <value value="6002280"/>
      <value value="4367303"/>
      <value value="8933105"/>
      <value value="4556107"/>
      <value value="9204633"/>
      <value value="3193470"/>
      <value value="1733928"/>
      <value value="6886812"/>
      <value value="6109029"/>
      <value value="6952323"/>
      <value value="2273452"/>
      <value value="7032881"/>
      <value value="7972057"/>
      <value value="5605751"/>
      <value value="7757260"/>
      <value value="5013458"/>
      <value value="8355375"/>
      <value value="4088998"/>
      <value value="4238920"/>
      <value value="6298786"/>
      <value value="5322861"/>
      <value value="3676844"/>
      <value value="1231808"/>
      <value value="443391"/>
      <value value="1158207"/>
      <value value="8165414"/>
      <value value="5548007"/>
      <value value="6775959"/>
      <value value="6100166"/>
      <value value="1817774"/>
      <value value="6585540"/>
      <value value="3437406"/>
      <value value="5372450"/>
      <value value="1067047"/>
      <value value="2947731"/>
      <value value="6981105"/>
      <value value="2184113"/>
      <value value="9935197"/>
      <value value="7530180"/>
      <value value="5854743"/>
      <value value="7652644"/>
      <value value="7737850"/>
      <value value="5387407"/>
      <value value="467822"/>
      <value value="1206070"/>
      <value value="2073641"/>
      <value value="5241198"/>
      <value value="8528126"/>
      <value value="3040979"/>
      <value value="5898498"/>
      <value value="3745528"/>
      <value value="9105148"/>
      <value value="9123454"/>
      <value value="4480127"/>
      <value value="1574783"/>
      <value value="1848610"/>
      <value value="1895420"/>
      <value value="6900174"/>
      <value value="2590685"/>
      <value value="6705882"/>
      <value value="506781"/>
      <value value="5599967"/>
      <value value="2693251"/>
      <value value="2521549"/>
      <value value="9427116"/>
      <value value="5341224"/>
      <value value="2279688"/>
      <value value="9798538"/>
      <value value="8457509"/>
      <value value="1094143"/>
      <value value="3482977"/>
      <value value="5213820"/>
      <value value="4487171"/>
      <value value="3902184"/>
      <value value="7134213"/>
      <value value="8605364"/>
      <value value="3629417"/>
      <value value="9446145"/>
      <value value="1829250"/>
      <value value="8191954"/>
      <value value="783547"/>
      <value value="2546416"/>
      <value value="3723281"/>
      <value value="9121712"/>
      <value value="5443621"/>
      <value value="4886019"/>
      <value value="4990137"/>
      <value value="8147744"/>
      <value value="1321751"/>
      <value value="2866542"/>
      <value value="1423705"/>
      <value value="6889574"/>
      <value value="525368"/>
      <value value="963772"/>
      <value value="4730455"/>
      <value value="8810335"/>
      <value value="202764"/>
      <value value="8590547"/>
      <value value="5681557"/>
      <value value="611386"/>
      <value value="7044402"/>
      <value value="6664013"/>
      <value value="3522710"/>
      <value value="1349803"/>
      <value value="845541"/>
      <value value="1957676"/>
      <value value="2170146"/>
      <value value="9033054"/>
      <value value="5299585"/>
      <value value="5156271"/>
      <value value="7328028"/>
      <value value="3753907"/>
      <value value="1988233"/>
      <value value="6884844"/>
      <value value="7323219"/>
      <value value="8255043"/>
      <value value="4469429"/>
      <value value="6832059"/>
      <value value="7315"/>
      <value value="2110296"/>
      <value value="300587"/>
      <value value="3914895"/>
      <value value="5399758"/>
      <value value="6909667"/>
      <value value="8710783"/>
      <value value="5566222"/>
      <value value="5757242"/>
      <value value="402684"/>
      <value value="3189936"/>
      <value value="3058543"/>
      <value value="2531010"/>
      <value value="2606459"/>
      <value value="4350856"/>
      <value value="9459050"/>
      <value value="6130006"/>
      <value value="7617149"/>
      <value value="8351047"/>
      <value value="2233833"/>
      <value value="8096879"/>
      <value value="7230610"/>
      <value value="5781979"/>
      <value value="2087631"/>
      <value value="1444656"/>
      <value value="9147236"/>
      <value value="401072"/>
      <value value="2081728"/>
      <value value="2149749"/>
      <value value="4014195"/>
      <value value="8056846"/>
      <value value="6978111"/>
      <value value="497903"/>
      <value value="9291692"/>
      <value value="5094476"/>
      <value value="8246706"/>
      <value value="9193476"/>
      <value value="5171510"/>
      <value value="8845929"/>
      <value value="4102475"/>
      <value value="3153219"/>
      <value value="3759946"/>
      <value value="6076454"/>
      <value value="5197263"/>
      <value value="9627906"/>
      <value value="2599858"/>
      <value value="4222929"/>
      <value value="2746024"/>
      <value value="4460538"/>
      <value value="4158392"/>
      <value value="5365286"/>
      <value value="2550663"/>
      <value value="788887"/>
      <value value="5909839"/>
      <value value="8313498"/>
      <value value="2592183"/>
      <value value="2030773"/>
      <value value="6326703"/>
      <value value="6885228"/>
      <value value="3011233"/>
      <value value="3921932"/>
      <value value="8968353"/>
      <value value="3681505"/>
      <value value="9440647"/>
      <value value="5794680"/>
      <value value="1655243"/>
      <value value="1372118"/>
      <value value="2868384"/>
      <value value="8529122"/>
      <value value="3696416"/>
      <value value="7828420"/>
      <value value="3296093"/>
      <value value="2955353"/>
      <value value="7473504"/>
      <value value="551933"/>
      <value value="3974620"/>
      <value value="2683940"/>
      <value value="7832091"/>
      <value value="8939449"/>
      <value value="5693309"/>
      <value value="4786901"/>
      <value value="5049161"/>
      <value value="5878519"/>
      <value value="6387547"/>
      <value value="8347456"/>
      <value value="4051609"/>
      <value value="6830814"/>
      <value value="5151406"/>
      <value value="7647179"/>
      <value value="605912"/>
      <value value="4278180"/>
      <value value="715341"/>
      <value value="9041672"/>
      <value value="1242712"/>
      <value value="6777468"/>
      <value value="2617265"/>
      <value value="1258441"/>
      <value value="8519646"/>
      <value value="2497181"/>
      <value value="2736908"/>
      <value value="8067851"/>
      <value value="1680060"/>
      <value value="8701959"/>
      <value value="9408175"/>
      <value value="6752082"/>
      <value value="4215913"/>
      <value value="1337875"/>
      <value value="2694624"/>
      <value value="5218088"/>
      <value value="7721418"/>
      <value value="8237804"/>
      <value value="449950"/>
      <value value="9170837"/>
      <value value="2944785"/>
      <value value="4627125"/>
      <value value="6412567"/>
      <value value="4751421"/>
      <value value="9074404"/>
      <value value="7925430"/>
      <value value="7321631"/>
      <value value="3620365"/>
      <value value="3940296"/>
      <value value="9055993"/>
      <value value="3809950"/>
      <value value="1406243"/>
      <value value="8630032"/>
      <value value="8720756"/>
      <value value="4898374"/>
      <value value="1043651"/>
      <value value="3772384"/>
      <value value="4115307"/>
      <value value="5340464"/>
      <value value="6744997"/>
      <value value="7856944"/>
      <value value="9070594"/>
      <value value="3987524"/>
      <value value="629513"/>
      <value value="4169783"/>
      <value value="276817"/>
      <value value="670030"/>
      <value value="5647329"/>
      <value value="3363132"/>
      <value value="2466465"/>
      <value value="8756667"/>
      <value value="1784899"/>
      <value value="2440280"/>
      <value value="2000205"/>
      <value value="5766825"/>
      <value value="9716688"/>
      <value value="6720552"/>
      <value value="8580365"/>
      <value value="2658375"/>
      <value value="3036568"/>
      <value value="3445474"/>
      <value value="9214369"/>
      <value value="1483919"/>
      <value value="262084"/>
      <value value="4946727"/>
      <value value="7328167"/>
      <value value="1830023"/>
      <value value="1703542"/>
      <value value="7367792"/>
      <value value="6633391"/>
      <value value="2177443"/>
      <value value="1135020"/>
      <value value="42521"/>
      <value value="6442467"/>
      <value value="9928968"/>
      <value value="4946903"/>
      <value value="7501316"/>
      <value value="5916168"/>
      <value value="5506280"/>
      <value value="6846337"/>
      <value value="1914706"/>
      <value value="7897966"/>
      <value value="8757079"/>
      <value value="3775816"/>
      <value value="7627161"/>
      <value value="3998741"/>
      <value value="5097624"/>
      <value value="40521"/>
      <value value="5903378"/>
      <value value="6779282"/>
      <value value="5607234"/>
      <value value="3882189"/>
      <value value="9156698"/>
      <value value="1172666"/>
      <value value="5521184"/>
      <value value="9640649"/>
      <value value="6681586"/>
      <value value="282144"/>
      <value value="7585397"/>
      <value value="9958984"/>
      <value value="9124257"/>
      <value value="4736633"/>
      <value value="1036451"/>
      <value value="3558356"/>
      <value value="3981759"/>
      <value value="8200425"/>
      <value value="9796502"/>
      <value value="5304989"/>
      <value value="4645195"/>
      <value value="3452508"/>
      <value value="8488887"/>
      <value value="2225573"/>
      <value value="84322"/>
      <value value="7060894"/>
      <value value="4476617"/>
      <value value="8014114"/>
      <value value="105039"/>
      <value value="764928"/>
      <value value="2289497"/>
      <value value="3267417"/>
      <value value="4944714"/>
      <value value="6430205"/>
      <value value="9259308"/>
      <value value="557211"/>
      <value value="227263"/>
      <value value="7991430"/>
      <value value="6710492"/>
      <value value="4370882"/>
      <value value="4950589"/>
      <value value="7870197"/>
      <value value="6847604"/>
      <value value="2201168"/>
      <value value="7801471"/>
      <value value="3688294"/>
      <value value="9598032"/>
      <value value="634231"/>
      <value value="4701677"/>
      <value value="1617211"/>
      <value value="2996469"/>
      <value value="2817088"/>
      <value value="8547548"/>
      <value value="3051811"/>
      <value value="8428274"/>
      <value value="3900969"/>
      <value value="115225"/>
      <value value="4985895"/>
      <value value="3635155"/>
      <value value="3287145"/>
      <value value="1793319"/>
      <value value="5452965"/>
      <value value="8966253"/>
      <value value="3450308"/>
      <value value="8242208"/>
      <value value="7022330"/>
      <value value="7526459"/>
      <value value="3882381"/>
      <value value="402606"/>
      <value value="9310030"/>
      <value value="2865821"/>
      <value value="8899823"/>
      <value value="7256426"/>
      <value value="5181398"/>
      <value value="4838044"/>
      <value value="8595995"/>
      <value value="6673036"/>
      <value value="8353718"/>
      <value value="1234820"/>
      <value value="544010"/>
      <value value="1878610"/>
      <value value="2932050"/>
      <value value="7622351"/>
      <value value="2972188"/>
      <value value="146081"/>
      <value value="7133843"/>
      <value value="5930247"/>
      <value value="4113849"/>
      <value value="2363113"/>
      <value value="4325816"/>
      <value value="8084801"/>
      <value value="5043441"/>
      <value value="338468"/>
      <value value="2485020"/>
      <value value="2383580"/>
      <value value="3724796"/>
      <value value="8069927"/>
      <value value="6487934"/>
      <value value="1895918"/>
      <value value="5900386"/>
      <value value="7296254"/>
      <value value="195882"/>
      <value value="6519708"/>
      <value value="9629573"/>
      <value value="4598218"/>
      <value value="9451319"/>
      <value value="4934473"/>
      <value value="323977"/>
      <value value="5679281"/>
      <value value="1626054"/>
      <value value="2958663"/>
      <value value="3269021"/>
      <value value="1222975"/>
      <value value="6782081"/>
      <value value="8462775"/>
      <value value="5872074"/>
      <value value="781650"/>
      <value value="1706978"/>
      <value value="6644892"/>
      <value value="6463439"/>
      <value value="2431331"/>
      <value value="345131"/>
      <value value="4376839"/>
      <value value="5547987"/>
      <value value="6305895"/>
      <value value="1089153"/>
      <value value="6770904"/>
      <value value="9359391"/>
      <value value="6867739"/>
      <value value="5439822"/>
      <value value="7162101"/>
      <value value="6852272"/>
      <value value="6972108"/>
      <value value="1993415"/>
      <value value="5156579"/>
      <value value="427615"/>
      <value value="6453544"/>
      <value value="6536892"/>
      <value value="4958334"/>
      <value value="3444688"/>
      <value value="9264658"/>
      <value value="1344133"/>
      <value value="2239092"/>
      <value value="3603544"/>
      <value value="2261479"/>
      <value value="9631756"/>
      <value value="4120926"/>
      <value value="8137955"/>
      <value value="2193457"/>
      <value value="367544"/>
      <value value="6707749"/>
      <value value="3729397"/>
      <value value="5900336"/>
      <value value="4458825"/>
      <value value="4932081"/>
      <value value="1721225"/>
      <value value="1678336"/>
      <value value="1561475"/>
      <value value="3827984"/>
      <value value="4756542"/>
      <value value="2911282"/>
      <value value="3078529"/>
      <value value="2284337"/>
      <value value="1623905"/>
      <value value="9233989"/>
      <value value="116726"/>
      <value value="1326491"/>
      <value value="4467278"/>
      <value value="5847011"/>
      <value value="3592980"/>
      <value value="593604"/>
      <value value="6003217"/>
      <value value="1940689"/>
      <value value="3882369"/>
      <value value="4514760"/>
      <value value="7442094"/>
      <value value="6276374"/>
      <value value="1932859"/>
      <value value="1843882"/>
      <value value="3685215"/>
      <value value="7573962"/>
      <value value="1518811"/>
      <value value="8177007"/>
      <value value="9191839"/>
      <value value="2418340"/>
      <value value="721953"/>
      <value value="9723914"/>
      <value value="3343200"/>
      <value value="3839185"/>
      <value value="3251944"/>
      <value value="7478550"/>
      <value value="6661986"/>
      <value value="28628"/>
      <value value="3505707"/>
      <value value="4812342"/>
      <value value="9056686"/>
      <value value="9889722"/>
      <value value="3033154"/>
      <value value="342554"/>
      <value value="3881988"/>
      <value value="9402504"/>
      <value value="6242992"/>
      <value value="7022482"/>
      <value value="9541276"/>
      <value value="3887838"/>
      <value value="1157692"/>
      <value value="3562406"/>
      <value value="7091016"/>
      <value value="1226176"/>
      <value value="3742146"/>
      <value value="1950030"/>
      <value value="3641494"/>
      <value value="7918978"/>
      <value value="3550757"/>
      <value value="2113531"/>
      <value value="1583176"/>
      <value value="4463190"/>
      <value value="9944419"/>
      <value value="593392"/>
      <value value="9508258"/>
      <value value="8232708"/>
      <value value="3765334"/>
      <value value="3059104"/>
      <value value="2701304"/>
      <value value="6002494"/>
      <value value="1040514"/>
      <value value="6990410"/>
      <value value="6200237"/>
      <value value="6254124"/>
      <value value="1457799"/>
      <value value="4936839"/>
      <value value="9525047"/>
      <value value="6683315"/>
      <value value="2703738"/>
      <value value="4504095"/>
      <value value="338458"/>
      <value value="6410066"/>
      <value value="8342883"/>
      <value value="5999843"/>
      <value value="6715802"/>
      <value value="8371248"/>
      <value value="3699483"/>
      <value value="9146989"/>
      <value value="7009963"/>
      <value value="9431717"/>
      <value value="8913151"/>
      <value value="9499491"/>
      <value value="5446796"/>
      <value value="9186514"/>
      <value value="4906042"/>
      <value value="779433"/>
      <value value="917540"/>
      <value value="4729113"/>
      <value value="9513101"/>
      <value value="3954544"/>
      <value value="2255418"/>
      <value value="4996890"/>
      <value value="8633029"/>
      <value value="3540214"/>
      <value value="713486"/>
      <value value="9003349"/>
      <value value="5623442"/>
      <value value="4600605"/>
      <value value="89025"/>
      <value value="3720481"/>
      <value value="688960"/>
      <value value="803796"/>
      <value value="369276"/>
      <value value="1876554"/>
      <value value="6835199"/>
      <value value="5975579"/>
      <value value="1495653"/>
      <value value="6240203"/>
      <value value="139522"/>
      <value value="7750026"/>
      <value value="5174300"/>
      <value value="4398617"/>
      <value value="2458084"/>
      <value value="7436915"/>
      <value value="170670"/>
      <value value="4235312"/>
      <value value="7570942"/>
      <value value="4759794"/>
      <value value="6956863"/>
      <value value="8612908"/>
      <value value="5304934"/>
      <value value="8729614"/>
      <value value="7321041"/>
      <value value="154574"/>
      <value value="4763656"/>
      <value value="736717"/>
      <value value="8201001"/>
      <value value="779289"/>
      <value value="5671096"/>
      <value value="7147802"/>
      <value value="3843347"/>
      <value value="8431501"/>
      <value value="4707693"/>
      <value value="3220589"/>
      <value value="635833"/>
      <value value="72213"/>
      <value value="566000"/>
      <value value="8571041"/>
      <value value="5292247"/>
      <value value="5034989"/>
      <value value="5715116"/>
      <value value="6727130"/>
      <value value="4504605"/>
      <value value="5421133"/>
      <value value="280276"/>
      <value value="4841191"/>
      <value value="1517985"/>
      <value value="9030062"/>
      <value value="1483297"/>
      <value value="1532666"/>
      <value value="8760089"/>
      <value value="7076692"/>
      <value value="1073890"/>
      <value value="2284325"/>
      <value value="3308006"/>
      <value value="754348"/>
      <value value="9059162"/>
      <value value="1003806"/>
      <value value="6501491"/>
      <value value="1645081"/>
      <value value="6443166"/>
      <value value="4481341"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;StageCal Test&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.34"/>
      <value value="0.45"/>
      <value value="0.54"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
      <value value="41"/>
      <value value="42"/>
      <value value="43"/>
      <value value="44"/>
      <value value="45"/>
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
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="4200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="88"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="freewheel">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housetotal">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incubation_period">
      <value value="4.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialscale">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="lockdown_off">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxstage">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="os_import_post_proportion">
      <value value="0.68"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="os_import_proportion">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac1_tran_reduct">
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac2_morb_eff">
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac2_tran_reduct">
      <value value="75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake">
      <value value="75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vaceffdays">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
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
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.042"/>
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
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="selfgovern">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="basestage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.01"/>
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
      <value value="2500000000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_r">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tracking">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="8.8"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="stageTest_big7" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>average_R</metric>
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
      <value value="2167835"/>
      <value value="5872891"/>
      <value value="5490626"/>
      <value value="2392919"/>
      <value value="5539148"/>
      <value value="4233385"/>
      <value value="8985923"/>
      <value value="7956035"/>
      <value value="1821737"/>
      <value value="8979356"/>
      <value value="2003687"/>
      <value value="1076997"/>
      <value value="2435640"/>
      <value value="7707185"/>
      <value value="6222491"/>
      <value value="6049523"/>
      <value value="9073385"/>
      <value value="5675830"/>
      <value value="9424616"/>
      <value value="9463482"/>
      <value value="2178872"/>
      <value value="4543370"/>
      <value value="5354614"/>
      <value value="1880173"/>
      <value value="3986787"/>
      <value value="7546028"/>
      <value value="1748120"/>
      <value value="1655591"/>
      <value value="8522932"/>
      <value value="1276806"/>
      <value value="497023"/>
      <value value="3660965"/>
      <value value="5225315"/>
      <value value="9507258"/>
      <value value="3403171"/>
      <value value="8185082"/>
      <value value="2992609"/>
      <value value="739918"/>
      <value value="1371266"/>
      <value value="9211179"/>
      <value value="5690415"/>
      <value value="9351719"/>
      <value value="4247046"/>
      <value value="7323621"/>
      <value value="1836898"/>
      <value value="6302589"/>
      <value value="2643128"/>
      <value value="3743983"/>
      <value value="6546618"/>
      <value value="2829227"/>
      <value value="2398048"/>
      <value value="7377604"/>
      <value value="1861478"/>
      <value value="8610300"/>
      <value value="9915193"/>
      <value value="3043623"/>
      <value value="1772891"/>
      <value value="3104689"/>
      <value value="9962901"/>
      <value value="7962469"/>
      <value value="9043216"/>
      <value value="7076638"/>
      <value value="7000378"/>
      <value value="5502094"/>
      <value value="5948064"/>
      <value value="2518246"/>
      <value value="5770541"/>
      <value value="8244399"/>
      <value value="8975083"/>
      <value value="9508566"/>
      <value value="5849629"/>
      <value value="3029124"/>
      <value value="6351568"/>
      <value value="8161480"/>
      <value value="5991241"/>
      <value value="7546258"/>
      <value value="3071173"/>
      <value value="1554868"/>
      <value value="2760287"/>
      <value value="2008338"/>
      <value value="7404701"/>
      <value value="8973508"/>
      <value value="9649599"/>
      <value value="9931248"/>
      <value value="9154076"/>
      <value value="1992121"/>
      <value value="2605923"/>
      <value value="5423050"/>
      <value value="1684698"/>
      <value value="3987534"/>
      <value value="7449710"/>
      <value value="4241291"/>
      <value value="8582055"/>
      <value value="9310404"/>
      <value value="8218962"/>
      <value value="5717284"/>
      <value value="6701362"/>
      <value value="2051398"/>
      <value value="5446501"/>
      <value value="2569581"/>
      <value value="3652156"/>
      <value value="4118849"/>
      <value value="4879567"/>
      <value value="6674106"/>
      <value value="4529305"/>
      <value value="2716538"/>
      <value value="2217241"/>
      <value value="4708969"/>
      <value value="247520"/>
      <value value="6681656"/>
      <value value="7046841"/>
      <value value="5344224"/>
      <value value="5790340"/>
      <value value="7759418"/>
      <value value="4484976"/>
      <value value="9002119"/>
      <value value="9009710"/>
      <value value="7649777"/>
      <value value="9509795"/>
      <value value="4106658"/>
      <value value="412830"/>
      <value value="6969163"/>
      <value value="4343430"/>
      <value value="4253713"/>
      <value value="6078377"/>
      <value value="3546254"/>
      <value value="7388616"/>
      <value value="5133809"/>
      <value value="2139816"/>
      <value value="2639695"/>
      <value value="386961"/>
      <value value="2013634"/>
      <value value="8293389"/>
      <value value="9298487"/>
      <value value="2192560"/>
      <value value="8371145"/>
      <value value="211254"/>
      <value value="4824469"/>
      <value value="3822104"/>
      <value value="4124036"/>
      <value value="893318"/>
      <value value="7844692"/>
      <value value="7799779"/>
      <value value="1907504"/>
      <value value="414151"/>
      <value value="3944251"/>
      <value value="2398592"/>
      <value value="845783"/>
      <value value="2613127"/>
      <value value="7203257"/>
      <value value="5972891"/>
      <value value="3567090"/>
      <value value="7685969"/>
      <value value="8815434"/>
      <value value="7755646"/>
      <value value="4666808"/>
      <value value="6017154"/>
      <value value="8035943"/>
      <value value="3487101"/>
      <value value="6309904"/>
      <value value="611670"/>
      <value value="370051"/>
      <value value="6628923"/>
      <value value="153293"/>
      <value value="115179"/>
      <value value="473789"/>
      <value value="313017"/>
      <value value="7609515"/>
      <value value="118513"/>
      <value value="4461807"/>
      <value value="2460704"/>
      <value value="8685926"/>
      <value value="6293969"/>
      <value value="676305"/>
      <value value="6420478"/>
      <value value="4551166"/>
      <value value="867040"/>
      <value value="9525959"/>
      <value value="4073763"/>
      <value value="2454282"/>
      <value value="8584092"/>
      <value value="7585561"/>
      <value value="8582369"/>
      <value value="2122602"/>
      <value value="3485566"/>
      <value value="5691959"/>
      <value value="2152512"/>
      <value value="7258107"/>
      <value value="712326"/>
      <value value="6857735"/>
      <value value="2007417"/>
      <value value="1236330"/>
      <value value="4812211"/>
      <value value="6798367"/>
      <value value="5909480"/>
      <value value="4792503"/>
      <value value="250696"/>
      <value value="9854830"/>
      <value value="9019832"/>
      <value value="3775495"/>
      <value value="7844992"/>
      <value value="1334149"/>
      <value value="3683818"/>
      <value value="8775334"/>
      <value value="1131697"/>
      <value value="7562927"/>
      <value value="4285411"/>
      <value value="8434293"/>
      <value value="4054720"/>
      <value value="4140960"/>
      <value value="9895544"/>
      <value value="5339662"/>
      <value value="4264238"/>
      <value value="1480065"/>
      <value value="9930860"/>
      <value value="6492078"/>
      <value value="1562662"/>
      <value value="5868165"/>
      <value value="5891698"/>
      <value value="8303455"/>
      <value value="2921939"/>
      <value value="4095215"/>
      <value value="997650"/>
      <value value="4793856"/>
      <value value="1975520"/>
      <value value="5939079"/>
      <value value="493440"/>
      <value value="272009"/>
      <value value="198509"/>
      <value value="2085457"/>
      <value value="396470"/>
      <value value="2345589"/>
      <value value="2084040"/>
      <value value="4819392"/>
      <value value="6919830"/>
      <value value="6435815"/>
      <value value="1734184"/>
      <value value="8734845"/>
      <value value="1883603"/>
      <value value="7397876"/>
      <value value="9840321"/>
      <value value="95320"/>
      <value value="2884099"/>
      <value value="3603829"/>
      <value value="8347402"/>
      <value value="1643765"/>
      <value value="2273358"/>
      <value value="2728527"/>
      <value value="5811681"/>
      <value value="9423452"/>
      <value value="2025961"/>
      <value value="9553732"/>
      <value value="9664270"/>
      <value value="9764169"/>
      <value value="9513215"/>
      <value value="1969754"/>
      <value value="381126"/>
      <value value="7259045"/>
      <value value="5573966"/>
      <value value="2010526"/>
      <value value="8987465"/>
      <value value="8177955"/>
      <value value="2053866"/>
      <value value="6296939"/>
      <value value="4621170"/>
      <value value="798360"/>
      <value value="6648269"/>
      <value value="7934034"/>
      <value value="3819595"/>
      <value value="8102095"/>
      <value value="3283017"/>
      <value value="7960289"/>
      <value value="8333000"/>
      <value value="2850632"/>
      <value value="1052621"/>
      <value value="3455044"/>
      <value value="9542523"/>
      <value value="1258005"/>
      <value value="4947585"/>
      <value value="7797471"/>
      <value value="2633303"/>
      <value value="8354195"/>
      <value value="9993570"/>
      <value value="6669808"/>
      <value value="1173972"/>
      <value value="7663670"/>
      <value value="9021018"/>
      <value value="3086225"/>
      <value value="6717306"/>
      <value value="3489729"/>
      <value value="3890612"/>
      <value value="810032"/>
      <value value="177207"/>
      <value value="5746893"/>
      <value value="8379667"/>
      <value value="1169901"/>
      <value value="174948"/>
      <value value="6916850"/>
      <value value="588638"/>
      <value value="6790411"/>
      <value value="468872"/>
      <value value="5721422"/>
      <value value="1820055"/>
      <value value="7501166"/>
      <value value="9362077"/>
      <value value="1245012"/>
      <value value="2593689"/>
      <value value="8402330"/>
      <value value="6487503"/>
      <value value="1086349"/>
      <value value="6861884"/>
      <value value="450585"/>
      <value value="1894088"/>
      <value value="60215"/>
      <value value="1602354"/>
      <value value="2793312"/>
      <value value="9874742"/>
      <value value="9199618"/>
      <value value="2949952"/>
      <value value="5792696"/>
      <value value="2362140"/>
      <value value="1927993"/>
      <value value="1915550"/>
      <value value="4038195"/>
      <value value="685359"/>
      <value value="1662428"/>
      <value value="4076524"/>
      <value value="1691626"/>
      <value value="9696333"/>
      <value value="5516053"/>
      <value value="1237178"/>
      <value value="2947835"/>
      <value value="3558762"/>
      <value value="5774850"/>
      <value value="9203200"/>
      <value value="6573829"/>
      <value value="7778153"/>
      <value value="7783100"/>
      <value value="824904"/>
      <value value="9492621"/>
      <value value="8363722"/>
      <value value="8152554"/>
      <value value="6808215"/>
      <value value="3450748"/>
      <value value="4336100"/>
      <value value="6926257"/>
      <value value="5201476"/>
      <value value="3552215"/>
      <value value="2678313"/>
      <value value="268700"/>
      <value value="9355391"/>
      <value value="2163469"/>
      <value value="5083883"/>
      <value value="7401643"/>
      <value value="3547853"/>
      <value value="8964424"/>
      <value value="5211391"/>
      <value value="3726529"/>
      <value value="9651521"/>
      <value value="7017959"/>
      <value value="8238837"/>
      <value value="258339"/>
      <value value="8939729"/>
      <value value="9502095"/>
      <value value="280200"/>
      <value value="1482222"/>
      <value value="2916192"/>
      <value value="2935929"/>
      <value value="8665236"/>
      <value value="1543868"/>
      <value value="2577116"/>
      <value value="1933871"/>
      <value value="5802035"/>
      <value value="8080530"/>
      <value value="6002280"/>
      <value value="4367303"/>
      <value value="8933105"/>
      <value value="4556107"/>
      <value value="9204633"/>
      <value value="3193470"/>
      <value value="1733928"/>
      <value value="6886812"/>
      <value value="6109029"/>
      <value value="6952323"/>
      <value value="2273452"/>
      <value value="7032881"/>
      <value value="7972057"/>
      <value value="5605751"/>
      <value value="7757260"/>
      <value value="5013458"/>
      <value value="8355375"/>
      <value value="4088998"/>
      <value value="4238920"/>
      <value value="6298786"/>
      <value value="5322861"/>
      <value value="3676844"/>
      <value value="1231808"/>
      <value value="443391"/>
      <value value="1158207"/>
      <value value="8165414"/>
      <value value="5548007"/>
      <value value="6775959"/>
      <value value="6100166"/>
      <value value="1817774"/>
      <value value="6585540"/>
      <value value="3437406"/>
      <value value="5372450"/>
      <value value="1067047"/>
      <value value="2947731"/>
      <value value="6981105"/>
      <value value="2184113"/>
      <value value="9935197"/>
      <value value="7530180"/>
      <value value="5854743"/>
      <value value="7652644"/>
      <value value="7737850"/>
      <value value="5387407"/>
      <value value="467822"/>
      <value value="1206070"/>
      <value value="2073641"/>
      <value value="5241198"/>
      <value value="8528126"/>
      <value value="3040979"/>
      <value value="5898498"/>
      <value value="3745528"/>
      <value value="9105148"/>
      <value value="9123454"/>
      <value value="4480127"/>
      <value value="1574783"/>
      <value value="1848610"/>
      <value value="1895420"/>
      <value value="6900174"/>
      <value value="2590685"/>
      <value value="6705882"/>
      <value value="506781"/>
      <value value="5599967"/>
      <value value="2693251"/>
      <value value="2521549"/>
      <value value="9427116"/>
      <value value="5341224"/>
      <value value="2279688"/>
      <value value="9798538"/>
      <value value="8457509"/>
      <value value="1094143"/>
      <value value="3482977"/>
      <value value="5213820"/>
      <value value="4487171"/>
      <value value="3902184"/>
      <value value="7134213"/>
      <value value="8605364"/>
      <value value="3629417"/>
      <value value="9446145"/>
      <value value="1829250"/>
      <value value="8191954"/>
      <value value="783547"/>
      <value value="2546416"/>
      <value value="3723281"/>
      <value value="9121712"/>
      <value value="5443621"/>
      <value value="4886019"/>
      <value value="4990137"/>
      <value value="8147744"/>
      <value value="1321751"/>
      <value value="2866542"/>
      <value value="1423705"/>
      <value value="6889574"/>
      <value value="525368"/>
      <value value="963772"/>
      <value value="4730455"/>
      <value value="8810335"/>
      <value value="202764"/>
      <value value="8590547"/>
      <value value="5681557"/>
      <value value="611386"/>
      <value value="7044402"/>
      <value value="6664013"/>
      <value value="3522710"/>
      <value value="1349803"/>
      <value value="845541"/>
      <value value="1957676"/>
      <value value="2170146"/>
      <value value="9033054"/>
      <value value="5299585"/>
      <value value="5156271"/>
      <value value="7328028"/>
      <value value="3753907"/>
      <value value="1988233"/>
      <value value="6884844"/>
      <value value="7323219"/>
      <value value="8255043"/>
      <value value="4469429"/>
      <value value="6832059"/>
      <value value="7315"/>
      <value value="2110296"/>
      <value value="300587"/>
      <value value="3914895"/>
      <value value="5399758"/>
      <value value="6909667"/>
      <value value="8710783"/>
      <value value="5566222"/>
      <value value="5757242"/>
      <value value="402684"/>
      <value value="3189936"/>
      <value value="3058543"/>
      <value value="2531010"/>
      <value value="2606459"/>
      <value value="4350856"/>
      <value value="9459050"/>
      <value value="6130006"/>
      <value value="7617149"/>
      <value value="8351047"/>
      <value value="2233833"/>
      <value value="8096879"/>
      <value value="7230610"/>
      <value value="5781979"/>
      <value value="2087631"/>
      <value value="1444656"/>
      <value value="9147236"/>
      <value value="401072"/>
      <value value="2081728"/>
      <value value="2149749"/>
      <value value="4014195"/>
      <value value="8056846"/>
      <value value="6978111"/>
      <value value="497903"/>
      <value value="9291692"/>
      <value value="5094476"/>
      <value value="8246706"/>
      <value value="9193476"/>
      <value value="5171510"/>
      <value value="8845929"/>
      <value value="4102475"/>
      <value value="3153219"/>
      <value value="3759946"/>
      <value value="6076454"/>
      <value value="5197263"/>
      <value value="9627906"/>
      <value value="2599858"/>
      <value value="4222929"/>
      <value value="2746024"/>
      <value value="4460538"/>
      <value value="4158392"/>
      <value value="5365286"/>
      <value value="2550663"/>
      <value value="788887"/>
      <value value="5909839"/>
      <value value="8313498"/>
      <value value="2592183"/>
      <value value="2030773"/>
      <value value="6326703"/>
      <value value="6885228"/>
      <value value="3011233"/>
      <value value="3921932"/>
      <value value="8968353"/>
      <value value="3681505"/>
      <value value="9440647"/>
      <value value="5794680"/>
      <value value="1655243"/>
      <value value="1372118"/>
      <value value="2868384"/>
      <value value="8529122"/>
      <value value="3696416"/>
      <value value="7828420"/>
      <value value="3296093"/>
      <value value="2955353"/>
      <value value="7473504"/>
      <value value="551933"/>
      <value value="3974620"/>
      <value value="2683940"/>
      <value value="7832091"/>
      <value value="8939449"/>
      <value value="5693309"/>
      <value value="4786901"/>
      <value value="5049161"/>
      <value value="5878519"/>
      <value value="6387547"/>
      <value value="8347456"/>
      <value value="4051609"/>
      <value value="6830814"/>
      <value value="5151406"/>
      <value value="7647179"/>
      <value value="605912"/>
      <value value="4278180"/>
      <value value="715341"/>
      <value value="9041672"/>
      <value value="1242712"/>
      <value value="6777468"/>
      <value value="2617265"/>
      <value value="1258441"/>
      <value value="8519646"/>
      <value value="2497181"/>
      <value value="2736908"/>
      <value value="8067851"/>
      <value value="1680060"/>
      <value value="8701959"/>
      <value value="9408175"/>
      <value value="6752082"/>
      <value value="4215913"/>
      <value value="1337875"/>
      <value value="2694624"/>
      <value value="5218088"/>
      <value value="7721418"/>
      <value value="8237804"/>
      <value value="449950"/>
      <value value="9170837"/>
      <value value="2944785"/>
      <value value="4627125"/>
      <value value="6412567"/>
      <value value="4751421"/>
      <value value="9074404"/>
      <value value="7925430"/>
      <value value="7321631"/>
      <value value="3620365"/>
      <value value="3940296"/>
      <value value="9055993"/>
      <value value="3809950"/>
      <value value="1406243"/>
      <value value="8630032"/>
      <value value="8720756"/>
      <value value="4898374"/>
      <value value="1043651"/>
      <value value="3772384"/>
      <value value="4115307"/>
      <value value="5340464"/>
      <value value="6744997"/>
      <value value="7856944"/>
      <value value="9070594"/>
      <value value="3987524"/>
      <value value="629513"/>
      <value value="4169783"/>
      <value value="276817"/>
      <value value="670030"/>
      <value value="5647329"/>
      <value value="3363132"/>
      <value value="2466465"/>
      <value value="8756667"/>
      <value value="1784899"/>
      <value value="2440280"/>
      <value value="2000205"/>
      <value value="5766825"/>
      <value value="9716688"/>
      <value value="6720552"/>
      <value value="8580365"/>
      <value value="2658375"/>
      <value value="3036568"/>
      <value value="3445474"/>
      <value value="9214369"/>
      <value value="1483919"/>
      <value value="262084"/>
      <value value="4946727"/>
      <value value="7328167"/>
      <value value="1830023"/>
      <value value="1703542"/>
      <value value="7367792"/>
      <value value="6633391"/>
      <value value="2177443"/>
      <value value="1135020"/>
      <value value="42521"/>
      <value value="6442467"/>
      <value value="9928968"/>
      <value value="4946903"/>
      <value value="7501316"/>
      <value value="5916168"/>
      <value value="5506280"/>
      <value value="6846337"/>
      <value value="1914706"/>
      <value value="7897966"/>
      <value value="8757079"/>
      <value value="3775816"/>
      <value value="7627161"/>
      <value value="3998741"/>
      <value value="5097624"/>
      <value value="40521"/>
      <value value="5903378"/>
      <value value="6779282"/>
      <value value="5607234"/>
      <value value="3882189"/>
      <value value="9156698"/>
      <value value="1172666"/>
      <value value="5521184"/>
      <value value="9640649"/>
      <value value="6681586"/>
      <value value="282144"/>
      <value value="7585397"/>
      <value value="9958984"/>
      <value value="9124257"/>
      <value value="4736633"/>
      <value value="1036451"/>
      <value value="3558356"/>
      <value value="3981759"/>
      <value value="8200425"/>
      <value value="9796502"/>
      <value value="5304989"/>
      <value value="4645195"/>
      <value value="3452508"/>
      <value value="8488887"/>
      <value value="2225573"/>
      <value value="84322"/>
      <value value="7060894"/>
      <value value="4476617"/>
      <value value="8014114"/>
      <value value="105039"/>
      <value value="764928"/>
      <value value="2289497"/>
      <value value="3267417"/>
      <value value="4944714"/>
      <value value="6430205"/>
      <value value="9259308"/>
      <value value="557211"/>
      <value value="227263"/>
      <value value="7991430"/>
      <value value="6710492"/>
      <value value="4370882"/>
      <value value="4950589"/>
      <value value="7870197"/>
      <value value="6847604"/>
      <value value="2201168"/>
      <value value="7801471"/>
      <value value="3688294"/>
      <value value="9598032"/>
      <value value="634231"/>
      <value value="4701677"/>
      <value value="1617211"/>
      <value value="2996469"/>
      <value value="2817088"/>
      <value value="8547548"/>
      <value value="3051811"/>
      <value value="8428274"/>
      <value value="3900969"/>
      <value value="115225"/>
      <value value="4985895"/>
      <value value="3635155"/>
      <value value="3287145"/>
      <value value="1793319"/>
      <value value="5452965"/>
      <value value="8966253"/>
      <value value="3450308"/>
      <value value="8242208"/>
      <value value="7022330"/>
      <value value="7526459"/>
      <value value="3882381"/>
      <value value="402606"/>
      <value value="9310030"/>
      <value value="2865821"/>
      <value value="8899823"/>
      <value value="7256426"/>
      <value value="5181398"/>
      <value value="4838044"/>
      <value value="8595995"/>
      <value value="6673036"/>
      <value value="8353718"/>
      <value value="1234820"/>
      <value value="544010"/>
      <value value="1878610"/>
      <value value="2932050"/>
      <value value="7622351"/>
      <value value="2972188"/>
      <value value="146081"/>
      <value value="7133843"/>
      <value value="5930247"/>
      <value value="4113849"/>
      <value value="2363113"/>
      <value value="4325816"/>
      <value value="8084801"/>
      <value value="5043441"/>
      <value value="338468"/>
      <value value="2485020"/>
      <value value="2383580"/>
      <value value="3724796"/>
      <value value="8069927"/>
      <value value="6487934"/>
      <value value="1895918"/>
      <value value="5900386"/>
      <value value="7296254"/>
      <value value="195882"/>
      <value value="6519708"/>
      <value value="9629573"/>
      <value value="4598218"/>
      <value value="9451319"/>
      <value value="4934473"/>
      <value value="323977"/>
      <value value="5679281"/>
      <value value="1626054"/>
      <value value="2958663"/>
      <value value="3269021"/>
      <value value="1222975"/>
      <value value="6782081"/>
      <value value="8462775"/>
      <value value="5872074"/>
      <value value="781650"/>
      <value value="1706978"/>
      <value value="6644892"/>
      <value value="6463439"/>
      <value value="2431331"/>
      <value value="345131"/>
      <value value="4376839"/>
      <value value="5547987"/>
      <value value="6305895"/>
      <value value="1089153"/>
      <value value="6770904"/>
      <value value="9359391"/>
      <value value="6867739"/>
      <value value="5439822"/>
      <value value="7162101"/>
      <value value="6852272"/>
      <value value="6972108"/>
      <value value="1993415"/>
      <value value="5156579"/>
      <value value="427615"/>
      <value value="6453544"/>
      <value value="6536892"/>
      <value value="4958334"/>
      <value value="3444688"/>
      <value value="9264658"/>
      <value value="1344133"/>
      <value value="2239092"/>
      <value value="3603544"/>
      <value value="2261479"/>
      <value value="9631756"/>
      <value value="4120926"/>
      <value value="8137955"/>
      <value value="2193457"/>
      <value value="367544"/>
      <value value="6707749"/>
      <value value="3729397"/>
      <value value="5900336"/>
      <value value="4458825"/>
      <value value="4932081"/>
      <value value="1721225"/>
      <value value="1678336"/>
      <value value="1561475"/>
      <value value="3827984"/>
      <value value="4756542"/>
      <value value="2911282"/>
      <value value="3078529"/>
      <value value="2284337"/>
      <value value="1623905"/>
      <value value="9233989"/>
      <value value="116726"/>
      <value value="1326491"/>
      <value value="4467278"/>
      <value value="5847011"/>
      <value value="3592980"/>
      <value value="593604"/>
      <value value="6003217"/>
      <value value="1940689"/>
      <value value="3882369"/>
      <value value="4514760"/>
      <value value="7442094"/>
      <value value="6276374"/>
      <value value="1932859"/>
      <value value="1843882"/>
      <value value="3685215"/>
      <value value="7573962"/>
      <value value="1518811"/>
      <value value="8177007"/>
      <value value="9191839"/>
      <value value="2418340"/>
      <value value="721953"/>
      <value value="9723914"/>
      <value value="3343200"/>
      <value value="3839185"/>
      <value value="3251944"/>
      <value value="7478550"/>
      <value value="6661986"/>
      <value value="28628"/>
      <value value="3505707"/>
      <value value="4812342"/>
      <value value="9056686"/>
      <value value="9889722"/>
      <value value="3033154"/>
      <value value="342554"/>
      <value value="3881988"/>
      <value value="9402504"/>
      <value value="6242992"/>
      <value value="7022482"/>
      <value value="9541276"/>
      <value value="3887838"/>
      <value value="1157692"/>
      <value value="3562406"/>
      <value value="7091016"/>
      <value value="1226176"/>
      <value value="3742146"/>
      <value value="1950030"/>
      <value value="3641494"/>
      <value value="7918978"/>
      <value value="3550757"/>
      <value value="2113531"/>
      <value value="1583176"/>
      <value value="4463190"/>
      <value value="9944419"/>
      <value value="593392"/>
      <value value="9508258"/>
      <value value="8232708"/>
      <value value="3765334"/>
      <value value="3059104"/>
      <value value="2701304"/>
      <value value="6002494"/>
      <value value="1040514"/>
      <value value="6990410"/>
      <value value="6200237"/>
      <value value="6254124"/>
      <value value="1457799"/>
      <value value="4936839"/>
      <value value="9525047"/>
      <value value="6683315"/>
      <value value="2703738"/>
      <value value="4504095"/>
      <value value="338458"/>
      <value value="6410066"/>
      <value value="8342883"/>
      <value value="5999843"/>
      <value value="6715802"/>
      <value value="8371248"/>
      <value value="3699483"/>
      <value value="9146989"/>
      <value value="7009963"/>
      <value value="9431717"/>
      <value value="8913151"/>
      <value value="9499491"/>
      <value value="5446796"/>
      <value value="9186514"/>
      <value value="4906042"/>
      <value value="779433"/>
      <value value="917540"/>
      <value value="4729113"/>
      <value value="9513101"/>
      <value value="3954544"/>
      <value value="2255418"/>
      <value value="4996890"/>
      <value value="8633029"/>
      <value value="3540214"/>
      <value value="713486"/>
      <value value="9003349"/>
      <value value="5623442"/>
      <value value="4600605"/>
      <value value="89025"/>
      <value value="3720481"/>
      <value value="688960"/>
      <value value="803796"/>
      <value value="369276"/>
      <value value="1876554"/>
      <value value="6835199"/>
      <value value="5975579"/>
      <value value="1495653"/>
      <value value="6240203"/>
      <value value="139522"/>
      <value value="7750026"/>
      <value value="5174300"/>
      <value value="4398617"/>
      <value value="2458084"/>
      <value value="7436915"/>
      <value value="170670"/>
      <value value="4235312"/>
      <value value="7570942"/>
      <value value="4759794"/>
      <value value="6956863"/>
      <value value="8612908"/>
      <value value="5304934"/>
      <value value="8729614"/>
      <value value="7321041"/>
      <value value="154574"/>
      <value value="4763656"/>
      <value value="736717"/>
      <value value="8201001"/>
      <value value="779289"/>
      <value value="5671096"/>
      <value value="7147802"/>
      <value value="3843347"/>
      <value value="8431501"/>
      <value value="4707693"/>
      <value value="3220589"/>
      <value value="635833"/>
      <value value="72213"/>
      <value value="566000"/>
      <value value="8571041"/>
      <value value="5292247"/>
      <value value="5034989"/>
      <value value="5715116"/>
      <value value="6727130"/>
      <value value="4504605"/>
      <value value="5421133"/>
      <value value="280276"/>
      <value value="4841191"/>
      <value value="1517985"/>
      <value value="9030062"/>
      <value value="1483297"/>
      <value value="1532666"/>
      <value value="8760089"/>
      <value value="7076692"/>
      <value value="1073890"/>
      <value value="2284325"/>
      <value value="3308006"/>
      <value value="754348"/>
      <value value="9059162"/>
      <value value="1003806"/>
      <value value="6501491"/>
      <value value="1645081"/>
      <value value="6443166"/>
      <value value="4481341"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;StageCal Test&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.34"/>
      <value value="0.45"/>
      <value value="0.54"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="4200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="88"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="freewheel">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housetotal">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incubation_period">
      <value value="4.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialscale">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="lockdown_off">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxstage">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="os_import_post_proportion">
      <value value="0.68"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="os_import_proportion">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac1_tran_reduct">
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac2_morb_eff">
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac2_tran_reduct">
      <value value="75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake">
      <value value="75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vaceffdays">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
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
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.042"/>
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
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="selfgovern">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="basestage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.01"/>
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
      <value value="2500000000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_r">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tracking">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="8.8"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="MainTest" repetitions="1" runMetricsEveryStep="false">
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
    <metric>dieArray_listOut</metric>
    <metric>age_listOut</metric>
    <metric>atsi_listOut</metric>
    <metric>morbid_listOut</metric>
    <enumeratedValueSet variable="rand_seed">
      <value value="6699865"/>
      <value value="1521703"/>
      <value value="5688133"/>
      <value value="3908791"/>
      <value value="5834657"/>
      <value value="4697072"/>
      <value value="8097542"/>
      <value value="612513"/>
      <value value="9781440"/>
      <value value="2683157"/>
      <value value="6246434"/>
      <value value="15322"/>
      <value value="3977471"/>
      <value value="8136896"/>
      <value value="1229764"/>
      <value value="5306382"/>
      <value value="2264545"/>
      <value value="1082482"/>
      <value value="5929223"/>
      <value value="3150893"/>
      <value value="66842"/>
      <value value="5994165"/>
      <value value="300436"/>
      <value value="8537674"/>
      <value value="3006794"/>
      <value value="8305582"/>
      <value value="1402423"/>
      <value value="8709297"/>
      <value value="5936553"/>
      <value value="115396"/>
      <value value="8511858"/>
      <value value="4505964"/>
      <value value="1808964"/>
      <value value="7943407"/>
      <value value="7115671"/>
      <value value="9706275"/>
      <value value="5116168"/>
      <value value="4465541"/>
      <value value="3526481"/>
      <value value="9979350"/>
      <value value="3516539"/>
      <value value="5909742"/>
      <value value="4402845"/>
      <value value="8544358"/>
      <value value="4097667"/>
      <value value="7838938"/>
      <value value="513708"/>
      <value value="4787071"/>
      <value value="7393000"/>
      <value value="6096960"/>
      <value value="5668885"/>
      <value value="4046046"/>
      <value value="4109818"/>
      <value value="7771215"/>
      <value value="8052606"/>
      <value value="5099572"/>
      <value value="5645524"/>
      <value value="905317"/>
      <value value="2634983"/>
      <value value="5280036"/>
      <value value="1518346"/>
      <value value="329165"/>
      <value value="9863965"/>
      <value value="29293"/>
      <value value="4287520"/>
      <value value="1585570"/>
      <value value="465948"/>
      <value value="9061465"/>
      <value value="5319824"/>
      <value value="5891390"/>
      <value value="9158084"/>
      <value value="9945307"/>
      <value value="7941614"/>
      <value value="5633660"/>
      <value value="633782"/>
      <value value="718571"/>
      <value value="363896"/>
      <value value="6612019"/>
      <value value="4220084"/>
      <value value="6846801"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;AggressElim&quot;"/>
      <value value="&quot;ModerateElim&quot;"/>
      <value value="&quot;TightSupress&quot;"/>
      <value value="&quot;LooseSupress&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.34"/>
      <value value="0.45"/>
      <value value="0.54"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="4200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="365"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="freewheel">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housetotal">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incubation_period">
      <value value="4.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialscale">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="lockdown_off">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="35"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxstage">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="os_import_post_proportion">
      <value value="0.68"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="os_import_proportion">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac1_tran_reduct">
      <value value="50"/>
      <value value="75"/>
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac2_morb_eff">
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac2_tran_reduct">
      <value value="50"/>
      <value value="75"/>
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake">
      <value value="60"/>
      <value value="75"/>
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vaceffdays">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.042"/>
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
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="selfgovern">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="basestage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.01"/>
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
      <value value="6359000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_iso_factor">
      <value value="1"/>
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
    <enumeratedValueSet variable="vaccine_available">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="8.8"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="MainRun" repetitions="1" runMetricsEveryStep="false">
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
      <value value="1011768"/>
      <value value="4574899"/>
      <value value="1760174"/>
      <value value="14375"/>
      <value value="6681382"/>
      <value value="9511502"/>
      <value value="7870895"/>
      <value value="6741435"/>
      <value value="1192223"/>
      <value value="2727143"/>
      <value value="8038291"/>
      <value value="2907904"/>
      <value value="5068623"/>
      <value value="874214"/>
      <value value="2984213"/>
      <value value="4738184"/>
      <value value="9055845"/>
      <value value="2336117"/>
      <value value="9790322"/>
      <value value="9612681"/>
      <value value="3731205"/>
      <value value="6548296"/>
      <value value="8061099"/>
      <value value="8906475"/>
      <value value="3006410"/>
      <value value="2223952"/>
      <value value="6799980"/>
      <value value="7436574"/>
      <value value="6456583"/>
      <value value="8942033"/>
      <value value="2999550"/>
      <value value="5738999"/>
      <value value="6833195"/>
      <value value="1291406"/>
      <value value="8812092"/>
      <value value="5436974"/>
      <value value="1283491"/>
      <value value="3133987"/>
      <value value="409997"/>
      <value value="1862036"/>
      <value value="2480012"/>
      <value value="1908693"/>
      <value value="1292419"/>
      <value value="3314974"/>
      <value value="9001143"/>
      <value value="9186283"/>
      <value value="2792626"/>
      <value value="6083704"/>
      <value value="8251698"/>
      <value value="6558939"/>
      <value value="8135676"/>
      <value value="3891785"/>
      <value value="2012836"/>
      <value value="4373075"/>
      <value value="8407059"/>
      <value value="8015130"/>
      <value value="7429428"/>
      <value value="8101130"/>
      <value value="7331708"/>
      <value value="5657925"/>
      <value value="3449383"/>
      <value value="6296688"/>
      <value value="8036467"/>
      <value value="2226999"/>
      <value value="3228766"/>
      <value value="4741171"/>
      <value value="8458924"/>
      <value value="3423977"/>
      <value value="1203746"/>
      <value value="2296144"/>
      <value value="6709086"/>
      <value value="1017956"/>
      <value value="5756394"/>
      <value value="4811011"/>
      <value value="5980359"/>
      <value value="342834"/>
      <value value="5125183"/>
      <value value="8866457"/>
      <value value="9239059"/>
      <value value="3773297"/>
      <value value="1678384"/>
      <value value="2002312"/>
      <value value="7430118"/>
      <value value="7136901"/>
      <value value="8448000"/>
      <value value="3728104"/>
      <value value="481280"/>
      <value value="5658131"/>
      <value value="8850065"/>
      <value value="3624501"/>
      <value value="859442"/>
      <value value="8680718"/>
      <value value="4940545"/>
      <value value="5299028"/>
      <value value="1693487"/>
      <value value="9340407"/>
      <value value="7927901"/>
      <value value="8943062"/>
      <value value="1037233"/>
      <value value="3499548"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;AggressElim&quot;"/>
      <value value="&quot;ModerateElim&quot;"/>
      <value value="&quot;TightSupress&quot;"/>
      <value value="&quot;LooseSupress&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.34"/>
      <value value="0.43"/>
      <value value="0.54"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="4200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="365"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="freewheel">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housetotal">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incubation_period">
      <value value="4.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialscale">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="lockdown_off">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="35"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxstage">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="os_import_post_proportion">
      <value value="0.68"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="os_import_proportion">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac1_tran_reduct">
      <value value="50"/>
      <value value="75"/>
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac2_morb_eff">
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac2_tran_reduct">
      <value value="50"/>
      <value value="75"/>
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake">
      <value value="60"/>
      <value value="75"/>
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vaceffdays">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.042"/>
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
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="selfgovern">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="basestage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.01"/>
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
      <value value="6359000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_iso_factor">
      <value value="1"/>
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
    <enumeratedValueSet variable="vaccine_available">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="8.8"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="MainCalibrate" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>average_R</metric>
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
      <value value="2713548"/>
      <value value="597442"/>
      <value value="2055037"/>
      <value value="8836292"/>
      <value value="383487"/>
      <value value="2047186"/>
      <value value="6735566"/>
      <value value="9022354"/>
      <value value="2264212"/>
      <value value="4625824"/>
      <value value="1735033"/>
      <value value="6213235"/>
      <value value="3853374"/>
      <value value="3201138"/>
      <value value="2583171"/>
      <value value="1643823"/>
      <value value="530907"/>
      <value value="4183843"/>
      <value value="967046"/>
      <value value="5605018"/>
      <value value="5274904"/>
      <value value="4007749"/>
      <value value="9234099"/>
      <value value="9265943"/>
      <value value="7087254"/>
      <value value="5730198"/>
      <value value="7798698"/>
      <value value="8269270"/>
      <value value="5711198"/>
      <value value="8831671"/>
      <value value="9278713"/>
      <value value="6400960"/>
      <value value="5138980"/>
      <value value="8620581"/>
      <value value="2544119"/>
      <value value="7107975"/>
      <value value="7703641"/>
      <value value="8465801"/>
      <value value="3773657"/>
      <value value="5557896"/>
      <value value="4301616"/>
      <value value="2756111"/>
      <value value="9827046"/>
      <value value="2788038"/>
      <value value="8131497"/>
      <value value="2690657"/>
      <value value="8458305"/>
      <value value="2526899"/>
      <value value="6502851"/>
      <value value="5580398"/>
      <value value="1710941"/>
      <value value="2308982"/>
      <value value="9881969"/>
      <value value="5220198"/>
      <value value="8130156"/>
      <value value="3493941"/>
      <value value="9098424"/>
      <value value="6386758"/>
      <value value="1091803"/>
      <value value="1252167"/>
      <value value="8370690"/>
      <value value="2378783"/>
      <value value="191416"/>
      <value value="2055907"/>
      <value value="9781173"/>
      <value value="6849809"/>
      <value value="6629483"/>
      <value value="1550496"/>
      <value value="7094476"/>
      <value value="2331151"/>
      <value value="822071"/>
      <value value="9454683"/>
      <value value="3068897"/>
      <value value="8514045"/>
      <value value="242057"/>
      <value value="4942579"/>
      <value value="2091369"/>
      <value value="9455387"/>
      <value value="4098419"/>
      <value value="8372916"/>
      <value value="3878748"/>
      <value value="4774732"/>
      <value value="1511379"/>
      <value value="3798732"/>
      <value value="9061737"/>
      <value value="9114134"/>
      <value value="782323"/>
      <value value="4753553"/>
      <value value="9413778"/>
      <value value="9895456"/>
      <value value="5581983"/>
      <value value="8821326"/>
      <value value="7752675"/>
      <value value="6514218"/>
      <value value="8033217"/>
      <value value="9311296"/>
      <value value="7754679"/>
      <value value="9001808"/>
      <value value="7179050"/>
      <value value="7976340"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;StageCal Test&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.34"/>
      <value value="0.43"/>
      <value value="0.54"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
      <value value="55"/>
      <value value="56"/>
      <value value="57"/>
      <value value="58"/>
      <value value="59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="4200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="freewheel">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housetotal">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incubation_period">
      <value value="4.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialscale">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="lockdown_off">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="35"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxstage">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="os_import_post_proportion">
      <value value="0.68"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="os_import_proportion">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac2_morb_eff">
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vaceffdays">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.042"/>
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
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="selfgovern">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="basestage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.01"/>
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
      <value value="2500000000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_iso_factor">
      <value value="1"/>
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
    <enumeratedValueSet variable="vaccine_available">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="8.8"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="MainCalibrateSingle" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>average_R</metric>
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
      <value value="2713548"/>
      <value value="597442"/>
      <value value="2055037"/>
      <value value="8836292"/>
      <value value="383487"/>
      <value value="2047186"/>
      <value value="6735566"/>
      <value value="9022354"/>
      <value value="2264212"/>
      <value value="4625824"/>
      <value value="1735033"/>
      <value value="6213235"/>
      <value value="3853374"/>
      <value value="3201138"/>
      <value value="2583171"/>
      <value value="1643823"/>
      <value value="530907"/>
      <value value="4183843"/>
      <value value="967046"/>
      <value value="5605018"/>
      <value value="5274904"/>
      <value value="4007749"/>
      <value value="9234099"/>
      <value value="9265943"/>
      <value value="7087254"/>
      <value value="5730198"/>
      <value value="7798698"/>
      <value value="8269270"/>
      <value value="5711198"/>
      <value value="8831671"/>
      <value value="9278713"/>
      <value value="6400960"/>
      <value value="5138980"/>
      <value value="8620581"/>
      <value value="2544119"/>
      <value value="7107975"/>
      <value value="7703641"/>
      <value value="8465801"/>
      <value value="3773657"/>
      <value value="5557896"/>
      <value value="4301616"/>
      <value value="2756111"/>
      <value value="9827046"/>
      <value value="2788038"/>
      <value value="8131497"/>
      <value value="2690657"/>
      <value value="8458305"/>
      <value value="2526899"/>
      <value value="6502851"/>
      <value value="5580398"/>
      <value value="1710941"/>
      <value value="2308982"/>
      <value value="9881969"/>
      <value value="5220198"/>
      <value value="8130156"/>
      <value value="3493941"/>
      <value value="9098424"/>
      <value value="6386758"/>
      <value value="1091803"/>
      <value value="1252167"/>
      <value value="8370690"/>
      <value value="2378783"/>
      <value value="191416"/>
      <value value="2055907"/>
      <value value="9781173"/>
      <value value="6849809"/>
      <value value="6629483"/>
      <value value="1550496"/>
      <value value="7094476"/>
      <value value="2331151"/>
      <value value="822071"/>
      <value value="9454683"/>
      <value value="3068897"/>
      <value value="8514045"/>
      <value value="242057"/>
      <value value="4942579"/>
      <value value="2091369"/>
      <value value="9455387"/>
      <value value="4098419"/>
      <value value="8372916"/>
      <value value="3878748"/>
      <value value="4774732"/>
      <value value="1511379"/>
      <value value="3798732"/>
      <value value="9061737"/>
      <value value="9114134"/>
      <value value="782323"/>
      <value value="4753553"/>
      <value value="9413778"/>
      <value value="9895456"/>
      <value value="5581983"/>
      <value value="8821326"/>
      <value value="7752675"/>
      <value value="6514218"/>
      <value value="8033217"/>
      <value value="9311296"/>
      <value value="7754679"/>
      <value value="9001808"/>
      <value value="7179050"/>
      <value value="7976340"/>
      <value value="5560215"/>
      <value value="2189591"/>
      <value value="8909430"/>
      <value value="863796"/>
      <value value="5991401"/>
      <value value="2623047"/>
      <value value="3861171"/>
      <value value="3110654"/>
      <value value="6487591"/>
      <value value="262318"/>
      <value value="1069609"/>
      <value value="1694834"/>
      <value value="9030625"/>
      <value value="1843073"/>
      <value value="8707393"/>
      <value value="5357090"/>
      <value value="9008836"/>
      <value value="3036832"/>
      <value value="6200212"/>
      <value value="7723467"/>
      <value value="5299970"/>
      <value value="971782"/>
      <value value="377584"/>
      <value value="7458122"/>
      <value value="259282"/>
      <value value="9566939"/>
      <value value="8826194"/>
      <value value="4595893"/>
      <value value="6103995"/>
      <value value="4876298"/>
      <value value="9969583"/>
      <value value="7070201"/>
      <value value="149576"/>
      <value value="3012212"/>
      <value value="7369819"/>
      <value value="4292745"/>
      <value value="7208306"/>
      <value value="2965782"/>
      <value value="6699737"/>
      <value value="5869748"/>
      <value value="1051918"/>
      <value value="1725957"/>
      <value value="6617243"/>
      <value value="6081221"/>
      <value value="5669189"/>
      <value value="3820385"/>
      <value value="3211026"/>
      <value value="6004242"/>
      <value value="2448402"/>
      <value value="8666893"/>
      <value value="1571245"/>
      <value value="8036403"/>
      <value value="7518825"/>
      <value value="2535502"/>
      <value value="8556441"/>
      <value value="6710807"/>
      <value value="64099"/>
      <value value="7907237"/>
      <value value="8510094"/>
      <value value="229878"/>
      <value value="9798517"/>
      <value value="6433211"/>
      <value value="3327704"/>
      <value value="4957712"/>
      <value value="8009386"/>
      <value value="9507835"/>
      <value value="6109603"/>
      <value value="4539244"/>
      <value value="3011318"/>
      <value value="4757203"/>
      <value value="2178413"/>
      <value value="2884815"/>
      <value value="9534968"/>
      <value value="8868443"/>
      <value value="5973501"/>
      <value value="5993106"/>
      <value value="2147691"/>
      <value value="721949"/>
      <value value="5689538"/>
      <value value="9568443"/>
      <value value="1190246"/>
      <value value="4498591"/>
      <value value="3123023"/>
      <value value="720214"/>
      <value value="5939004"/>
      <value value="4834005"/>
      <value value="5943943"/>
      <value value="2462748"/>
      <value value="8009860"/>
      <value value="2187484"/>
      <value value="6164156"/>
      <value value="6839908"/>
      <value value="759691"/>
      <value value="2394931"/>
      <value value="5843681"/>
      <value value="3252040"/>
      <value value="5677086"/>
      <value value="1360059"/>
      <value value="2696729"/>
      <value value="307279"/>
      <value value="4689782"/>
      <value value="503522"/>
      <value value="4812634"/>
      <value value="2060744"/>
      <value value="8938304"/>
      <value value="4042017"/>
      <value value="9611050"/>
      <value value="9447799"/>
      <value value="1184504"/>
      <value value="9888929"/>
      <value value="4411129"/>
      <value value="6684010"/>
      <value value="523409"/>
      <value value="767942"/>
      <value value="5581309"/>
      <value value="3538546"/>
      <value value="5888168"/>
      <value value="458233"/>
      <value value="3866964"/>
      <value value="5730762"/>
      <value value="6864061"/>
      <value value="1553665"/>
      <value value="6491822"/>
      <value value="140581"/>
      <value value="8615572"/>
      <value value="5269501"/>
      <value value="5382380"/>
      <value value="165395"/>
      <value value="5413976"/>
      <value value="4469711"/>
      <value value="1289192"/>
      <value value="9245525"/>
      <value value="5861577"/>
      <value value="8375545"/>
      <value value="5537363"/>
      <value value="1967345"/>
      <value value="6000097"/>
      <value value="3725162"/>
      <value value="4301532"/>
      <value value="8253624"/>
      <value value="1120118"/>
      <value value="4708132"/>
      <value value="1480644"/>
      <value value="9076232"/>
      <value value="3293081"/>
      <value value="7825167"/>
      <value value="1816273"/>
      <value value="4275200"/>
      <value value="7334906"/>
      <value value="1699486"/>
      <value value="3689511"/>
      <value value="144606"/>
      <value value="9878031"/>
      <value value="8431572"/>
      <value value="8263157"/>
      <value value="664042"/>
      <value value="621936"/>
      <value value="3336033"/>
      <value value="5421081"/>
      <value value="9720984"/>
      <value value="5208660"/>
      <value value="8344382"/>
      <value value="5778098"/>
      <value value="9323373"/>
      <value value="9632503"/>
      <value value="9711169"/>
      <value value="4524344"/>
      <value value="491364"/>
      <value value="8941968"/>
      <value value="3008524"/>
      <value value="842053"/>
      <value value="9183888"/>
      <value value="7841869"/>
      <value value="2086147"/>
      <value value="3410041"/>
      <value value="197603"/>
      <value value="5003347"/>
      <value value="4386047"/>
      <value value="7416417"/>
      <value value="2519"/>
      <value value="8205454"/>
      <value value="2744364"/>
      <value value="4983625"/>
      <value value="2276682"/>
      <value value="554560"/>
      <value value="6400715"/>
      <value value="7061575"/>
      <value value="2144591"/>
      <value value="5679960"/>
      <value value="1629485"/>
      <value value="2778878"/>
      <value value="7004081"/>
      <value value="4861573"/>
      <value value="8458403"/>
      <value value="7205180"/>
      <value value="2827552"/>
      <value value="8306321"/>
      <value value="7063779"/>
      <value value="912192"/>
      <value value="4372825"/>
      <value value="4010952"/>
      <value value="6016421"/>
      <value value="2041162"/>
      <value value="7010325"/>
      <value value="8607827"/>
      <value value="820077"/>
      <value value="9885649"/>
      <value value="3678907"/>
      <value value="6510443"/>
      <value value="4791099"/>
      <value value="9640396"/>
      <value value="2206144"/>
      <value value="9604838"/>
      <value value="8261373"/>
      <value value="859039"/>
      <value value="5605697"/>
      <value value="9548367"/>
      <value value="4668842"/>
      <value value="8288231"/>
      <value value="5882197"/>
      <value value="7284386"/>
      <value value="1616092"/>
      <value value="1771667"/>
      <value value="1943338"/>
      <value value="4530876"/>
      <value value="1066460"/>
      <value value="1391623"/>
      <value value="7683643"/>
      <value value="3460277"/>
      <value value="4550944"/>
      <value value="91610"/>
      <value value="4904143"/>
      <value value="3919335"/>
      <value value="5515419"/>
      <value value="8807936"/>
      <value value="1279400"/>
      <value value="9793436"/>
      <value value="16972"/>
      <value value="1909042"/>
      <value value="5802581"/>
      <value value="5280163"/>
      <value value="5010911"/>
      <value value="1902377"/>
      <value value="617623"/>
      <value value="7323082"/>
      <value value="212229"/>
      <value value="4904744"/>
      <value value="8303684"/>
      <value value="2343124"/>
      <value value="3886009"/>
      <value value="7367729"/>
      <value value="4236400"/>
      <value value="6915367"/>
      <value value="223203"/>
      <value value="1895208"/>
      <value value="6892732"/>
      <value value="1322677"/>
      <value value="1044121"/>
      <value value="9300824"/>
      <value value="3465820"/>
      <value value="9402385"/>
      <value value="1038837"/>
      <value value="9749525"/>
      <value value="1837127"/>
      <value value="6587596"/>
      <value value="6063679"/>
      <value value="376985"/>
      <value value="5115333"/>
      <value value="2108394"/>
      <value value="5043090"/>
      <value value="2538031"/>
      <value value="2095710"/>
      <value value="132031"/>
      <value value="684372"/>
      <value value="1182629"/>
      <value value="6530127"/>
      <value value="6179952"/>
      <value value="2152806"/>
      <value value="6913473"/>
      <value value="125498"/>
      <value value="4413298"/>
      <value value="4245322"/>
      <value value="6189363"/>
      <value value="5913982"/>
      <value value="8900617"/>
      <value value="1644480"/>
      <value value="2758712"/>
      <value value="9052414"/>
      <value value="9871155"/>
      <value value="1504687"/>
      <value value="3051536"/>
      <value value="3901221"/>
      <value value="4315756"/>
      <value value="3267160"/>
      <value value="6816123"/>
      <value value="9744197"/>
      <value value="917852"/>
      <value value="2039070"/>
      <value value="9569946"/>
      <value value="5606484"/>
      <value value="7564190"/>
      <value value="7705816"/>
      <value value="8285032"/>
      <value value="8268923"/>
      <value value="7492183"/>
      <value value="1446880"/>
      <value value="1375775"/>
      <value value="3889780"/>
      <value value="6563076"/>
      <value value="2993469"/>
      <value value="3138230"/>
      <value value="7501721"/>
      <value value="3822912"/>
      <value value="916937"/>
      <value value="9692423"/>
      <value value="5880101"/>
      <value value="9329277"/>
      <value value="1703635"/>
      <value value="1165912"/>
      <value value="8400029"/>
      <value value="935181"/>
      <value value="8790638"/>
      <value value="11437"/>
      <value value="5524659"/>
      <value value="8077977"/>
      <value value="2852357"/>
      <value value="3356781"/>
      <value value="9181119"/>
      <value value="2562674"/>
      <value value="5450460"/>
      <value value="7859736"/>
      <value value="206455"/>
      <value value="1235748"/>
      <value value="3635854"/>
      <value value="4131781"/>
      <value value="1671817"/>
      <value value="9750722"/>
      <value value="4533417"/>
      <value value="4378426"/>
      <value value="5474485"/>
      <value value="5074927"/>
      <value value="6563592"/>
      <value value="5652244"/>
      <value value="9547554"/>
      <value value="120570"/>
      <value value="8964010"/>
      <value value="6997164"/>
      <value value="1233871"/>
      <value value="5716302"/>
      <value value="6701292"/>
      <value value="999851"/>
      <value value="1482276"/>
      <value value="815551"/>
      <value value="6008502"/>
      <value value="9827366"/>
      <value value="7484308"/>
      <value value="1782888"/>
      <value value="2037603"/>
      <value value="9826152"/>
      <value value="2900994"/>
      <value value="4682261"/>
      <value value="3328907"/>
      <value value="4935413"/>
      <value value="5090865"/>
      <value value="8246460"/>
      <value value="6929488"/>
      <value value="5194189"/>
      <value value="3226423"/>
      <value value="2629557"/>
      <value value="4779481"/>
      <value value="5094854"/>
      <value value="3336289"/>
      <value value="6710296"/>
      <value value="3813911"/>
      <value value="5874399"/>
      <value value="9002006"/>
      <value value="119619"/>
      <value value="1780939"/>
      <value value="3680571"/>
      <value value="5529889"/>
      <value value="4966895"/>
      <value value="2554835"/>
      <value value="2298182"/>
      <value value="941805"/>
      <value value="6084665"/>
      <value value="5352744"/>
      <value value="3197893"/>
      <value value="2766616"/>
      <value value="4743422"/>
      <value value="997221"/>
      <value value="7902958"/>
      <value value="7247879"/>
      <value value="3883235"/>
      <value value="5500385"/>
      <value value="5305335"/>
      <value value="5232094"/>
      <value value="1442083"/>
      <value value="2393822"/>
      <value value="2101763"/>
      <value value="3686721"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;StageCal Test&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.44"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="4200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="freewheel">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housetotal">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incubation_period">
      <value value="4.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialscale">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="lockdown_off">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="35"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxstage">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="os_import_post_proportion">
      <value value="0.68"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="os_import_proportion">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_trace_mult">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac2_morb_eff">
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vaceffdays">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.042"/>
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
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="selfgovern">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="basestage">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.01"/>
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
      <value value="2500000000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_iso_factor">
      <value value="1"/>
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
    <enumeratedValueSet variable="vaccine_available">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="8.8"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="stageTest_Full" repetitions="1" runMetricsEveryStep="false">
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
      <value value="5643"/>
      <value value="2917955"/>
      <value value="8768751"/>
      <value value="9908759"/>
      <value value="1045390"/>
      <value value="2272558"/>
      <value value="6444267"/>
      <value value="3711481"/>
      <value value="8481713"/>
      <value value="1149188"/>
      <value value="9636244"/>
      <value value="7555789"/>
      <value value="7675230"/>
      <value value="8860501"/>
      <value value="3805778"/>
      <value value="8777957"/>
      <value value="7612656"/>
      <value value="7760085"/>
      <value value="9217990"/>
      <value value="4886043"/>
      <value value="1117952"/>
      <value value="1424278"/>
      <value value="5844127"/>
      <value value="2182248"/>
      <value value="3270752"/>
      <value value="4433881"/>
      <value value="7695967"/>
      <value value="8094505"/>
      <value value="6527714"/>
      <value value="9698603"/>
      <value value="4875708"/>
      <value value="2382146"/>
      <value value="7952613"/>
      <value value="1493911"/>
      <value value="6240703"/>
      <value value="4278019"/>
      <value value="2728680"/>
      <value value="5950227"/>
      <value value="474943"/>
      <value value="71747"/>
      <value value="2890740"/>
      <value value="3757096"/>
      <value value="2655941"/>
      <value value="1204480"/>
      <value value="1843087"/>
      <value value="1694046"/>
      <value value="354360"/>
      <value value="9223585"/>
      <value value="9169464"/>
      <value value="3527544"/>
      <value value="1396763"/>
      <value value="9738149"/>
      <value value="3874609"/>
      <value value="7117132"/>
      <value value="1052027"/>
      <value value="3178900"/>
      <value value="4826393"/>
      <value value="4332863"/>
      <value value="2738820"/>
      <value value="8057615"/>
      <value value="3188711"/>
      <value value="522325"/>
      <value value="2782125"/>
      <value value="6982473"/>
      <value value="8304598"/>
      <value value="1527931"/>
      <value value="4849120"/>
      <value value="4507567"/>
      <value value="4252080"/>
      <value value="994198"/>
      <value value="7144398"/>
      <value value="2752146"/>
      <value value="8558277"/>
      <value value="7009761"/>
      <value value="8919490"/>
      <value value="684234"/>
      <value value="9990723"/>
      <value value="1829720"/>
      <value value="4847497"/>
      <value value="5494025"/>
      <value value="5070384"/>
      <value value="5802885"/>
      <value value="666320"/>
      <value value="1121895"/>
      <value value="7459073"/>
      <value value="7205073"/>
      <value value="9930975"/>
      <value value="519907"/>
      <value value="6884943"/>
      <value value="8280627"/>
      <value value="2625185"/>
      <value value="6455880"/>
      <value value="7648404"/>
      <value value="4293228"/>
      <value value="350607"/>
      <value value="7699312"/>
      <value value="6032944"/>
      <value value="1388889"/>
      <value value="7514998"/>
      <value value="1105881"/>
      <value value="7254807"/>
      <value value="3497395"/>
      <value value="5780093"/>
      <value value="8429614"/>
      <value value="2747833"/>
      <value value="7468252"/>
      <value value="3366419"/>
      <value value="2053293"/>
      <value value="4011341"/>
      <value value="7625030"/>
      <value value="899259"/>
      <value value="3942632"/>
      <value value="4143858"/>
      <value value="5155956"/>
      <value value="8055299"/>
      <value value="5031560"/>
      <value value="158392"/>
      <value value="9972854"/>
      <value value="2690853"/>
      <value value="6448047"/>
      <value value="1565227"/>
      <value value="1366488"/>
      <value value="5410496"/>
      <value value="1827703"/>
      <value value="3855497"/>
      <value value="1257330"/>
      <value value="4136617"/>
      <value value="361073"/>
      <value value="8695212"/>
      <value value="9098249"/>
      <value value="9265721"/>
      <value value="3145573"/>
      <value value="9264659"/>
      <value value="2104437"/>
      <value value="3380066"/>
      <value value="1044033"/>
      <value value="2385796"/>
      <value value="2964583"/>
      <value value="5897218"/>
      <value value="4466934"/>
      <value value="1392900"/>
      <value value="5630873"/>
      <value value="6760903"/>
      <value value="2248504"/>
      <value value="1467884"/>
      <value value="6343403"/>
      <value value="4125124"/>
      <value value="3720767"/>
      <value value="2788526"/>
      <value value="831689"/>
      <value value="1102963"/>
      <value value="6385376"/>
      <value value="2706660"/>
      <value value="8841587"/>
      <value value="7104012"/>
      <value value="7634464"/>
      <value value="6536003"/>
      <value value="6166106"/>
      <value value="3235205"/>
      <value value="1346731"/>
      <value value="7204360"/>
      <value value="5010156"/>
      <value value="6600450"/>
      <value value="5139926"/>
      <value value="7440711"/>
      <value value="2211135"/>
      <value value="1300200"/>
      <value value="3934372"/>
      <value value="4568074"/>
      <value value="4823670"/>
      <value value="9744572"/>
      <value value="5947082"/>
      <value value="5070536"/>
      <value value="325379"/>
      <value value="2093413"/>
      <value value="483623"/>
      <value value="6927833"/>
      <value value="3669400"/>
      <value value="5258445"/>
      <value value="7754253"/>
      <value value="2595958"/>
      <value value="2642676"/>
      <value value="1277495"/>
      <value value="1745567"/>
      <value value="4787554"/>
      <value value="2214515"/>
      <value value="1646511"/>
      <value value="2751126"/>
      <value value="6371695"/>
      <value value="9697494"/>
      <value value="5263338"/>
      <value value="9915305"/>
      <value value="7329705"/>
      <value value="5097577"/>
      <value value="5733968"/>
      <value value="7883095"/>
      <value value="1283063"/>
      <value value="19376"/>
      <value value="8893191"/>
      <value value="1040758"/>
      <value value="9266359"/>
      <value value="4200000"/>
      <value value="128514"/>
      <value value="4875651"/>
      <value value="4273410"/>
      <value value="1981091"/>
      <value value="6822181"/>
      <value value="3011921"/>
      <value value="4026209"/>
      <value value="6522627"/>
      <value value="6785400"/>
      <value value="8596319"/>
      <value value="8483658"/>
      <value value="7293654"/>
      <value value="1764981"/>
      <value value="6791193"/>
      <value value="7004191"/>
      <value value="1258217"/>
      <value value="4272609"/>
      <value value="3615563"/>
      <value value="9645870"/>
      <value value="600827"/>
      <value value="4008410"/>
      <value value="6975716"/>
      <value value="8532273"/>
      <value value="1854800"/>
      <value value="8808598"/>
      <value value="2654301"/>
      <value value="1906798"/>
      <value value="3583631"/>
      <value value="56146"/>
      <value value="8868961"/>
      <value value="2580941"/>
      <value value="4017092"/>
      <value value="9244157"/>
      <value value="2117529"/>
      <value value="9944707"/>
      <value value="8475054"/>
      <value value="927488"/>
      <value value="9378463"/>
      <value value="1443919"/>
      <value value="5853046"/>
      <value value="6826101"/>
      <value value="3622616"/>
      <value value="3852822"/>
      <value value="4776757"/>
      <value value="4763859"/>
      <value value="2460583"/>
      <value value="7677556"/>
      <value value="7135738"/>
      <value value="5344698"/>
      <value value="1090343"/>
      <value value="5353405"/>
      <value value="8452068"/>
      <value value="3736436"/>
      <value value="1006927"/>
      <value value="3137132"/>
      <value value="8204679"/>
      <value value="6805760"/>
      <value value="8311252"/>
      <value value="451493"/>
      <value value="8161487"/>
      <value value="5005044"/>
      <value value="498338"/>
      <value value="6148984"/>
      <value value="1619489"/>
      <value value="4944612"/>
      <value value="5170941"/>
      <value value="9735326"/>
      <value value="5608814"/>
      <value value="3738966"/>
      <value value="1489669"/>
      <value value="6427866"/>
      <value value="9197759"/>
      <value value="3100314"/>
      <value value="710282"/>
      <value value="8065023"/>
      <value value="1946219"/>
      <value value="5563633"/>
      <value value="3431081"/>
      <value value="9419743"/>
      <value value="2462306"/>
      <value value="890015"/>
      <value value="4718271"/>
      <value value="9393447"/>
      <value value="4586280"/>
      <value value="1443212"/>
      <value value="8226397"/>
      <value value="9148300"/>
      <value value="7491965"/>
      <value value="6581265"/>
      <value value="5553186"/>
      <value value="5308968"/>
      <value value="7645732"/>
      <value value="9898141"/>
      <value value="1054492"/>
      <value value="465788"/>
      <value value="7388124"/>
      <value value="7856633"/>
      <value value="1177451"/>
      <value value="5567562"/>
      <value value="8681636"/>
      <value value="370069"/>
      <value value="3750450"/>
      <value value="3879706"/>
      <value value="8566956"/>
      <value value="4759517"/>
      <value value="4662829"/>
      <value value="2466547"/>
      <value value="1310710"/>
      <value value="9038648"/>
      <value value="2554107"/>
      <value value="5053365"/>
      <value value="3375320"/>
      <value value="8797266"/>
      <value value="5859290"/>
      <value value="5096868"/>
      <value value="641866"/>
      <value value="2855815"/>
      <value value="8631084"/>
      <value value="7886939"/>
      <value value="873421"/>
      <value value="5710045"/>
      <value value="3613584"/>
      <value value="9852959"/>
      <value value="2352926"/>
      <value value="316017"/>
      <value value="78942"/>
      <value value="2271034"/>
      <value value="5790418"/>
      <value value="7494849"/>
      <value value="360819"/>
      <value value="6269411"/>
      <value value="5266505"/>
      <value value="9506221"/>
      <value value="6425783"/>
      <value value="6139963"/>
      <value value="1754505"/>
      <value value="4810292"/>
      <value value="7704971"/>
      <value value="2382999"/>
      <value value="333752"/>
      <value value="7706397"/>
      <value value="4359689"/>
      <value value="585664"/>
      <value value="7919720"/>
      <value value="1984756"/>
      <value value="1339233"/>
      <value value="6490492"/>
      <value value="9971902"/>
      <value value="3558234"/>
      <value value="4669312"/>
      <value value="9851512"/>
      <value value="6188136"/>
      <value value="3495379"/>
      <value value="2223199"/>
      <value value="7272035"/>
      <value value="5432792"/>
      <value value="2398777"/>
      <value value="6839822"/>
      <value value="1168591"/>
      <value value="9207898"/>
      <value value="1866164"/>
      <value value="8818390"/>
      <value value="8343184"/>
      <value value="6551809"/>
      <value value="4219605"/>
      <value value="6332160"/>
      <value value="3708172"/>
      <value value="9226484"/>
      <value value="9193440"/>
      <value value="509488"/>
      <value value="6941479"/>
      <value value="9844369"/>
      <value value="2226376"/>
      <value value="1316831"/>
      <value value="6158526"/>
      <value value="7618527"/>
      <value value="5366693"/>
      <value value="2568966"/>
      <value value="4551532"/>
      <value value="5889924"/>
      <value value="4735512"/>
      <value value="5619762"/>
      <value value="5118429"/>
      <value value="1439526"/>
      <value value="6430929"/>
      <value value="9066425"/>
      <value value="616464"/>
      <value value="6773208"/>
      <value value="8257322"/>
      <value value="3559385"/>
      <value value="9316889"/>
      <value value="7053581"/>
      <value value="275897"/>
      <value value="8783599"/>
      <value value="1905036"/>
      <value value="3494508"/>
      <value value="6670231"/>
      <value value="2690735"/>
      <value value="2853569"/>
      <value value="3393827"/>
      <value value="1324699"/>
      <value value="8110729"/>
      <value value="6351154"/>
      <value value="326221"/>
      <value value="521915"/>
      <value value="8714200"/>
      <value value="8125286"/>
      <value value="931865"/>
      <value value="1965982"/>
      <value value="3915024"/>
      <value value="3247601"/>
      <value value="6810629"/>
      <value value="5497319"/>
      <value value="171810"/>
      <value value="439443"/>
      <value value="869207"/>
      <value value="1542778"/>
      <value value="7861506"/>
      <value value="9189438"/>
      <value value="8339812"/>
      <value value="9599261"/>
      <value value="4163962"/>
      <value value="7358905"/>
      <value value="6908327"/>
      <value value="1541412"/>
      <value value="685052"/>
      <value value="6137244"/>
      <value value="8419533"/>
      <value value="9449076"/>
      <value value="7559405"/>
      <value value="3311968"/>
      <value value="6535889"/>
      <value value="9213018"/>
      <value value="5280052"/>
      <value value="5462999"/>
      <value value="7106993"/>
      <value value="3952816"/>
      <value value="2801197"/>
      <value value="7024667"/>
      <value value="39923"/>
      <value value="8551344"/>
      <value value="4764741"/>
      <value value="4044460"/>
      <value value="3660251"/>
      <value value="36"/>
      <value value="2481620"/>
      <value value="5275215"/>
      <value value="5707202"/>
      <value value="6341505"/>
      <value value="9591060"/>
      <value value="3722058"/>
      <value value="2136429"/>
      <value value="420607"/>
      <value value="8653765"/>
      <value value="1516380"/>
      <value value="4786687"/>
      <value value="5438827"/>
      <value value="4685260"/>
      <value value="1282651"/>
      <value value="2666366"/>
      <value value="6950321"/>
      <value value="5599170"/>
      <value value="5182798"/>
      <value value="7576444"/>
      <value value="7205413"/>
      <value value="885785"/>
      <value value="6167966"/>
      <value value="773853"/>
      <value value="4226601"/>
      <value value="5175200"/>
      <value value="5367423"/>
      <value value="8678174"/>
      <value value="5701596"/>
      <value value="2726851"/>
      <value value="1289088"/>
      <value value="8479815"/>
      <value value="5481446"/>
      <value value="905283"/>
      <value value="8677289"/>
      <value value="9071121"/>
      <value value="1151928"/>
      <value value="2620162"/>
      <value value="2007687"/>
      <value value="5977148"/>
      <value value="1401144"/>
      <value value="4134205"/>
      <value value="4080053"/>
      <value value="1758137"/>
      <value value="142237"/>
      <value value="7321908"/>
      <value value="9137783"/>
      <value value="3777476"/>
      <value value="1632498"/>
      <value value="3196553"/>
      <value value="7144250"/>
      <value value="1785107"/>
      <value value="9333281"/>
      <value value="562981"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;StageCal Test&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.48"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
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
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housetotal">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="immune_from_prev_variant">
      <value value="0.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="immune_from_reinfect">
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="incubation_period">
      <value value="4.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="infect_iso_factor">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_cases">
      <value value="4000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
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
    <enumeratedValueSet variable="param_virulence_inc">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailycases">
      <value value="1500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.85"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.28"/>
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
      <value value="6000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set_shape">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="18"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.001"/>
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
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_r">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="track_slope">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tracking">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vac_variant_eff_prop">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="variant_transmiss_growth">
      <value value="1.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="yearly_recover_prop_loss">
      <value value="0.14"/>
    </enumeratedValueSet>
  </experiment>
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
      <value value="106232"/>
      <value value="9842968"/>
      <value value="3188671"/>
      <value value="3960479"/>
      <value value="4588301"/>
      <value value="3674674"/>
      <value value="7496657"/>
      <value value="716391"/>
      <value value="4615677"/>
      <value value="1816194"/>
      <value value="910405"/>
      <value value="2891510"/>
      <value value="205086"/>
      <value value="539440"/>
      <value value="4326626"/>
      <value value="9408648"/>
      <value value="680454"/>
      <value value="9281781"/>
      <value value="7130851"/>
      <value value="2949366"/>
      <value value="151719"/>
      <value value="622578"/>
      <value value="23204"/>
      <value value="5622602"/>
      <value value="2618676"/>
      <value value="131198"/>
      <value value="9191996"/>
      <value value="9864746"/>
      <value value="239902"/>
      <value value="5619144"/>
      <value value="9624577"/>
      <value value="8906446"/>
      <value value="8664130"/>
      <value value="6753754"/>
      <value value="6888311"/>
      <value value="5050210"/>
      <value value="8896741"/>
      <value value="4932322"/>
      <value value="9318516"/>
      <value value="3182169"/>
      <value value="4852588"/>
      <value value="5690531"/>
      <value value="3024824"/>
      <value value="1311066"/>
      <value value="3957653"/>
      <value value="3724141"/>
      <value value="1902816"/>
      <value value="1612735"/>
      <value value="8674778"/>
      <value value="8876161"/>
      <value value="6965890"/>
      <value value="4929210"/>
      <value value="3697048"/>
      <value value="3191313"/>
      <value value="516739"/>
      <value value="5992782"/>
      <value value="5025688"/>
      <value value="7542879"/>
      <value value="4147568"/>
      <value value="6359934"/>
      <value value="3049249"/>
      <value value="3568590"/>
      <value value="5365571"/>
      <value value="6237225"/>
      <value value="5080539"/>
      <value value="6913902"/>
      <value value="5934871"/>
      <value value="6030660"/>
      <value value="2448904"/>
      <value value="6608913"/>
      <value value="9592016"/>
      <value value="2563683"/>
      <value value="3486912"/>
      <value value="7726574"/>
      <value value="1435677"/>
      <value value="4190819"/>
      <value value="1314384"/>
      <value value="9554999"/>
      <value value="1183604"/>
      <value value="8823297"/>
      <value value="481817"/>
      <value value="5730210"/>
      <value value="2678659"/>
      <value value="773289"/>
      <value value="1303840"/>
      <value value="5388024"/>
      <value value="4396941"/>
      <value value="2652866"/>
      <value value="3092354"/>
      <value value="6637559"/>
      <value value="9863123"/>
      <value value="7160117"/>
      <value value="4038318"/>
      <value value="3629092"/>
      <value value="3198109"/>
      <value value="7670097"/>
      <value value="4264762"/>
      <value value="1310187"/>
      <value value="8460970"/>
      <value value="3854956"/>
      <value value="9767623"/>
      <value value="4550014"/>
      <value value="3206352"/>
      <value value="4204988"/>
      <value value="7801180"/>
      <value value="4222138"/>
      <value value="9812540"/>
      <value value="636371"/>
      <value value="4009654"/>
      <value value="267422"/>
      <value value="660286"/>
      <value value="72029"/>
      <value value="9040778"/>
      <value value="35540"/>
      <value value="8603785"/>
      <value value="3108814"/>
      <value value="2037222"/>
      <value value="6857710"/>
      <value value="3539799"/>
      <value value="8360116"/>
      <value value="8397088"/>
      <value value="1703392"/>
      <value value="506917"/>
      <value value="3220037"/>
      <value value="1359166"/>
      <value value="3590859"/>
      <value value="9861139"/>
      <value value="2140286"/>
      <value value="2795882"/>
      <value value="8767319"/>
      <value value="9161754"/>
      <value value="8098380"/>
      <value value="7840137"/>
      <value value="8267366"/>
      <value value="5594705"/>
      <value value="2642364"/>
      <value value="743711"/>
      <value value="170884"/>
      <value value="9780734"/>
      <value value="5241748"/>
      <value value="9855158"/>
      <value value="2785014"/>
      <value value="8685426"/>
      <value value="9366157"/>
      <value value="9815980"/>
      <value value="4484000"/>
      <value value="8555502"/>
      <value value="6807872"/>
      <value value="6569894"/>
      <value value="1902506"/>
      <value value="9174483"/>
      <value value="5434528"/>
      <value value="9083514"/>
      <value value="9867487"/>
      <value value="3552777"/>
      <value value="7917058"/>
      <value value="5406113"/>
      <value value="3044440"/>
      <value value="9597520"/>
      <value value="1729238"/>
      <value value="92661"/>
      <value value="5695474"/>
      <value value="3040739"/>
      <value value="7066545"/>
      <value value="7572617"/>
      <value value="3967652"/>
      <value value="1097004"/>
      <value value="8539656"/>
      <value value="9576960"/>
      <value value="5619697"/>
      <value value="7673410"/>
      <value value="164017"/>
      <value value="5465103"/>
      <value value="7396665"/>
      <value value="1593184"/>
      <value value="2281111"/>
      <value value="5556302"/>
      <value value="6691333"/>
      <value value="5934444"/>
      <value value="7162561"/>
      <value value="9730072"/>
      <value value="8008638"/>
      <value value="3213905"/>
      <value value="7733277"/>
      <value value="9411752"/>
      <value value="4490275"/>
      <value value="8961061"/>
      <value value="2746517"/>
      <value value="4960436"/>
      <value value="9234146"/>
      <value value="5042561"/>
      <value value="575470"/>
      <value value="6729631"/>
      <value value="1637236"/>
      <value value="7241920"/>
      <value value="9299867"/>
      <value value="3421696"/>
      <value value="8543273"/>
      <value value="8977003"/>
      <value value="1425349"/>
      <value value="5545927"/>
      <value value="9029729"/>
      <value value="1906903"/>
      <value value="995578"/>
      <value value="3729144"/>
      <value value="9590887"/>
      <value value="7246379"/>
      <value value="774060"/>
      <value value="4148973"/>
      <value value="1309676"/>
      <value value="5871434"/>
      <value value="2139875"/>
      <value value="4211986"/>
      <value value="5667349"/>
      <value value="4211550"/>
      <value value="2739754"/>
      <value value="4332002"/>
      <value value="8504032"/>
      <value value="6780300"/>
      <value value="4249649"/>
      <value value="1598752"/>
      <value value="5634898"/>
      <value value="1244315"/>
      <value value="7637223"/>
      <value value="3964015"/>
      <value value="69360"/>
      <value value="2702940"/>
      <value value="9858843"/>
      <value value="8240136"/>
      <value value="6923078"/>
      <value value="1052282"/>
      <value value="7722364"/>
      <value value="6263603"/>
      <value value="7687312"/>
      <value value="7584386"/>
      <value value="7143565"/>
      <value value="4868655"/>
      <value value="8056909"/>
      <value value="8098907"/>
      <value value="5809688"/>
      <value value="3440897"/>
      <value value="1961304"/>
      <value value="6999959"/>
      <value value="1292394"/>
      <value value="7515265"/>
      <value value="7978016"/>
      <value value="4627948"/>
      <value value="3012675"/>
      <value value="6353979"/>
      <value value="541566"/>
      <value value="3561119"/>
      <value value="2963626"/>
      <value value="5796233"/>
      <value value="3075103"/>
      <value value="3046193"/>
      <value value="669549"/>
      <value value="4196246"/>
      <value value="8465257"/>
      <value value="2340262"/>
      <value value="1718477"/>
      <value value="6938675"/>
      <value value="9332748"/>
      <value value="8859183"/>
      <value value="4925955"/>
      <value value="4196847"/>
      <value value="1891774"/>
      <value value="5444824"/>
      <value value="9356958"/>
      <value value="390380"/>
      <value value="9848746"/>
      <value value="2158910"/>
      <value value="5275844"/>
      <value value="3521322"/>
      <value value="5823773"/>
      <value value="7125496"/>
      <value value="1219631"/>
      <value value="6900667"/>
      <value value="4565930"/>
      <value value="6199625"/>
      <value value="7640916"/>
      <value value="5719471"/>
      <value value="1079967"/>
      <value value="4912476"/>
      <value value="3356352"/>
      <value value="8344306"/>
      <value value="3260965"/>
      <value value="5220493"/>
      <value value="3503302"/>
      <value value="1389756"/>
      <value value="8414129"/>
      <value value="9213796"/>
      <value value="5947305"/>
      <value value="1628890"/>
      <value value="2947368"/>
      <value value="4663483"/>
      <value value="3832792"/>
      <value value="7837821"/>
      <value value="3677690"/>
      <value value="4995568"/>
      <value value="20730"/>
      <value value="1611417"/>
      <value value="1203186"/>
      <value value="2550991"/>
      <value value="8944059"/>
      <value value="2700583"/>
      <value value="6526680"/>
      <value value="646556"/>
      <value value="5244854"/>
      <value value="4596377"/>
      <value value="7332349"/>
      <value value="450352"/>
      <value value="8884484"/>
      <value value="7235278"/>
      <value value="3929994"/>
      <value value="854647"/>
      <value value="8625847"/>
      <value value="6445661"/>
      <value value="577131"/>
      <value value="1262694"/>
      <value value="5197368"/>
      <value value="3987573"/>
      <value value="3999442"/>
      <value value="216435"/>
      <value value="2787208"/>
      <value value="4263457"/>
      <value value="9786998"/>
      <value value="7929938"/>
      <value value="3726999"/>
      <value value="8938651"/>
      <value value="4762448"/>
      <value value="9349638"/>
      <value value="5864917"/>
      <value value="7355927"/>
      <value value="4213450"/>
      <value value="1360088"/>
      <value value="5842485"/>
      <value value="6648581"/>
      <value value="576796"/>
      <value value="5086474"/>
      <value value="6282317"/>
      <value value="971264"/>
      <value value="1348498"/>
      <value value="3464829"/>
      <value value="90050"/>
      <value value="5000097"/>
      <value value="7702589"/>
      <value value="1342919"/>
      <value value="1259398"/>
      <value value="9613370"/>
      <value value="4399323"/>
      <value value="943099"/>
      <value value="6911434"/>
      <value value="3476155"/>
      <value value="5284366"/>
      <value value="1889536"/>
      <value value="9256468"/>
      <value value="1167143"/>
      <value value="3501175"/>
      <value value="8277306"/>
      <value value="1515439"/>
      <value value="9293817"/>
      <value value="1366520"/>
      <value value="9892074"/>
      <value value="6325786"/>
      <value value="7354111"/>
      <value value="2604398"/>
      <value value="1257052"/>
      <value value="1283490"/>
      <value value="5755921"/>
      <value value="6444363"/>
      <value value="1789328"/>
      <value value="121474"/>
      <value value="4266477"/>
      <value value="3403512"/>
      <value value="2738666"/>
      <value value="3538524"/>
      <value value="5602759"/>
      <value value="9696303"/>
      <value value="2249326"/>
      <value value="5241230"/>
      <value value="6301730"/>
      <value value="6860923"/>
      <value value="2273133"/>
      <value value="6108218"/>
      <value value="2337413"/>
      <value value="8754796"/>
      <value value="6447704"/>
      <value value="9410660"/>
      <value value="3556170"/>
      <value value="8542298"/>
      <value value="9571247"/>
      <value value="2499531"/>
      <value value="9885389"/>
      <value value="7427852"/>
      <value value="6765930"/>
      <value value="5690264"/>
      <value value="923202"/>
      <value value="9276905"/>
      <value value="2934378"/>
      <value value="9346877"/>
      <value value="246486"/>
      <value value="969071"/>
      <value value="2431650"/>
      <value value="913876"/>
      <value value="7308029"/>
      <value value="6509599"/>
      <value value="8974526"/>
      <value value="4018738"/>
      <value value="5657659"/>
      <value value="3069599"/>
      <value value="6276795"/>
      <value value="4483093"/>
      <value value="7044284"/>
      <value value="2589312"/>
      <value value="2930000"/>
      <value value="2055533"/>
      <value value="5464338"/>
      <value value="3733615"/>
      <value value="9271205"/>
      <value value="6835586"/>
      <value value="3910273"/>
      <value value="1404535"/>
      <value value="7190217"/>
      <value value="7499338"/>
      <value value="7347872"/>
      <value value="2526590"/>
      <value value="8004255"/>
      <value value="5436982"/>
      <value value="4469935"/>
      <value value="2359821"/>
      <value value="2692776"/>
      <value value="8517210"/>
      <value value="8439958"/>
      <value value="3076724"/>
      <value value="2086823"/>
      <value value="6198667"/>
      <value value="1178759"/>
      <value value="9683616"/>
      <value value="8088474"/>
      <value value="8077109"/>
      <value value="9582422"/>
      <value value="5336296"/>
      <value value="5551082"/>
      <value value="2819327"/>
      <value value="7680327"/>
      <value value="2856552"/>
      <value value="2608548"/>
      <value value="8345629"/>
      <value value="3592067"/>
      <value value="2213720"/>
      <value value="4916351"/>
      <value value="3593327"/>
      <value value="5940478"/>
      <value value="6219579"/>
      <value value="2553135"/>
      <value value="1207171"/>
      <value value="3584060"/>
      <value value="7009838"/>
      <value value="8158966"/>
      <value value="9558557"/>
      <value value="6391474"/>
      <value value="6184514"/>
      <value value="5547274"/>
      <value value="1763585"/>
      <value value="6612145"/>
      <value value="4064523"/>
      <value value="2763490"/>
      <value value="9068035"/>
      <value value="2858820"/>
      <value value="5038949"/>
      <value value="8384253"/>
      <value value="7705392"/>
      <value value="1322943"/>
      <value value="3414731"/>
      <value value="2583226"/>
      <value value="2525236"/>
      <value value="6926221"/>
      <value value="8014668"/>
      <value value="3505870"/>
      <value value="5637977"/>
      <value value="4521926"/>
      <value value="2211809"/>
      <value value="4201140"/>
      <value value="2644190"/>
      <value value="560739"/>
      <value value="4949990"/>
      <value value="5299366"/>
      <value value="3731791"/>
      <value value="7220800"/>
      <value value="7117223"/>
      <value value="4492628"/>
      <value value="2009828"/>
      <value value="8516343"/>
      <value value="9467314"/>
      <value value="6587038"/>
      <value value="6027879"/>
      <value value="6816151"/>
      <value value="4412454"/>
      <value value="7484837"/>
      <value value="103810"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;StageCal Test&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.245"/>
      <value value="0.295"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
      <value value="55"/>
      <value value="57"/>
      <value value="58"/>
      <value value="59"/>
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
      <value value="0.7687977727792483"/>
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
      <value value="0.33"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="25"/>
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
      <value value="0.1"/>
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
      <value value="10000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="29.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="29.5"/>
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
      <value value="234000000000"/>
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
      <value value="0.86"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="variant_transmiss_growth">
      <value value="1.5"/>
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
  <experiment name="stageTest_0and4" repetitions="1" runMetricsEveryStep="false">
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
      <value value="4210554"/>
      <value value="6820004"/>
      <value value="6561455"/>
      <value value="3514143"/>
      <value value="4110561"/>
      <value value="9353419"/>
      <value value="4659592"/>
      <value value="5110864"/>
      <value value="3315004"/>
      <value value="2041511"/>
      <value value="1728551"/>
      <value value="4248593"/>
      <value value="6419780"/>
      <value value="3853993"/>
      <value value="4015590"/>
      <value value="7737515"/>
      <value value="3872110"/>
      <value value="589473"/>
      <value value="4996363"/>
      <value value="7032545"/>
      <value value="8471960"/>
      <value value="4252700"/>
      <value value="3017370"/>
      <value value="108032"/>
      <value value="7680919"/>
      <value value="4790571"/>
      <value value="9990536"/>
      <value value="712390"/>
      <value value="3057503"/>
      <value value="6080771"/>
      <value value="4034620"/>
      <value value="6135779"/>
      <value value="5101028"/>
      <value value="9574266"/>
      <value value="7637934"/>
      <value value="8354627"/>
      <value value="9685495"/>
      <value value="6136421"/>
      <value value="4793923"/>
      <value value="252132"/>
      <value value="6978216"/>
      <value value="9811820"/>
      <value value="8737561"/>
      <value value="5162034"/>
      <value value="3021837"/>
      <value value="9599646"/>
      <value value="5534557"/>
      <value value="7934084"/>
      <value value="5272398"/>
      <value value="4795990"/>
      <value value="4152469"/>
      <value value="4210560"/>
      <value value="1122157"/>
      <value value="1192536"/>
      <value value="1357137"/>
      <value value="1631611"/>
      <value value="4875071"/>
      <value value="7498036"/>
      <value value="1583611"/>
      <value value="6752453"/>
      <value value="4356749"/>
      <value value="5165931"/>
      <value value="1545654"/>
      <value value="2368565"/>
      <value value="8086478"/>
      <value value="5828870"/>
      <value value="2620834"/>
      <value value="1062668"/>
      <value value="4228183"/>
      <value value="2500104"/>
      <value value="5670498"/>
      <value value="7123757"/>
      <value value="5344970"/>
      <value value="9280987"/>
      <value value="131651"/>
      <value value="1585769"/>
      <value value="5329165"/>
      <value value="2096997"/>
      <value value="4924114"/>
      <value value="1708455"/>
      <value value="2189757"/>
      <value value="707139"/>
      <value value="1056484"/>
      <value value="97431"/>
      <value value="622581"/>
      <value value="5000908"/>
      <value value="7686924"/>
      <value value="1639418"/>
      <value value="2950858"/>
      <value value="3127316"/>
      <value value="2797950"/>
      <value value="9113728"/>
      <value value="4347874"/>
      <value value="9325957"/>
      <value value="487624"/>
      <value value="2528184"/>
      <value value="1892792"/>
      <value value="9595620"/>
      <value value="5456233"/>
      <value value="1921555"/>
      <value value="5106610"/>
      <value value="1421372"/>
      <value value="350362"/>
      <value value="1243629"/>
      <value value="6895272"/>
      <value value="4078941"/>
      <value value="9975485"/>
      <value value="4804153"/>
      <value value="9207437"/>
      <value value="6244604"/>
      <value value="8461011"/>
      <value value="579011"/>
      <value value="5427958"/>
      <value value="7058182"/>
      <value value="7201127"/>
      <value value="2586983"/>
      <value value="1204828"/>
      <value value="4340497"/>
      <value value="5833609"/>
      <value value="7003863"/>
      <value value="1641093"/>
      <value value="1224513"/>
      <value value="6326900"/>
      <value value="4832444"/>
      <value value="6111948"/>
      <value value="1888566"/>
      <value value="7250474"/>
      <value value="7436840"/>
      <value value="5688803"/>
      <value value="6630119"/>
      <value value="4158466"/>
      <value value="8872530"/>
      <value value="8149351"/>
      <value value="9407948"/>
      <value value="3529913"/>
      <value value="5538995"/>
      <value value="9652213"/>
      <value value="8601921"/>
      <value value="584671"/>
      <value value="2791879"/>
      <value value="9769841"/>
      <value value="5194839"/>
      <value value="663373"/>
      <value value="1140691"/>
      <value value="5855279"/>
      <value value="4731210"/>
      <value value="4765119"/>
      <value value="6022098"/>
      <value value="6905051"/>
      <value value="1538353"/>
      <value value="2360575"/>
      <value value="9441722"/>
      <value value="4462747"/>
      <value value="4068226"/>
      <value value="9467671"/>
      <value value="1703854"/>
      <value value="542359"/>
      <value value="9936530"/>
      <value value="6323735"/>
      <value value="5571817"/>
      <value value="7841452"/>
      <value value="6827725"/>
      <value value="1152813"/>
      <value value="7875207"/>
      <value value="4114653"/>
      <value value="2994898"/>
      <value value="6475116"/>
      <value value="6259188"/>
      <value value="2766783"/>
      <value value="9474615"/>
      <value value="4718995"/>
      <value value="5876289"/>
      <value value="6650888"/>
      <value value="9964502"/>
      <value value="9193101"/>
      <value value="9985364"/>
      <value value="467329"/>
      <value value="4383924"/>
      <value value="6003141"/>
      <value value="949342"/>
      <value value="3093968"/>
      <value value="4462379"/>
      <value value="6825712"/>
      <value value="9171707"/>
      <value value="2717528"/>
      <value value="609136"/>
      <value value="8531644"/>
      <value value="4558620"/>
      <value value="9240756"/>
      <value value="3995263"/>
      <value value="9780792"/>
      <value value="3668606"/>
      <value value="1981278"/>
      <value value="358909"/>
      <value value="9269437"/>
      <value value="9565511"/>
      <value value="5534559"/>
      <value value="3267864"/>
      <value value="7826049"/>
      <value value="4762342"/>
      <value value="6609982"/>
      <value value="8679201"/>
      <value value="100011"/>
      <value value="8627375"/>
      <value value="4681839"/>
      <value value="7188949"/>
      <value value="8554898"/>
      <value value="9685773"/>
      <value value="9419772"/>
      <value value="7187703"/>
      <value value="4779390"/>
      <value value="6785676"/>
      <value value="346283"/>
      <value value="1424172"/>
      <value value="2681395"/>
      <value value="8779608"/>
      <value value="3267551"/>
      <value value="7891209"/>
      <value value="6654973"/>
      <value value="7272555"/>
      <value value="3792505"/>
      <value value="7829665"/>
      <value value="2327571"/>
      <value value="5847108"/>
      <value value="8085178"/>
      <value value="9396997"/>
      <value value="9638714"/>
      <value value="7708012"/>
      <value value="3485666"/>
      <value value="2657489"/>
      <value value="647549"/>
      <value value="7313812"/>
      <value value="6323355"/>
      <value value="6336874"/>
      <value value="2518565"/>
      <value value="9419411"/>
      <value value="4745172"/>
      <value value="3508672"/>
      <value value="232733"/>
      <value value="4621119"/>
      <value value="9018895"/>
      <value value="2779974"/>
      <value value="5149328"/>
      <value value="661972"/>
      <value value="4789378"/>
      <value value="9490692"/>
      <value value="9448116"/>
      <value value="6835957"/>
      <value value="1462447"/>
      <value value="185463"/>
      <value value="8302770"/>
      <value value="5462221"/>
      <value value="5782127"/>
      <value value="9585636"/>
      <value value="8690392"/>
      <value value="4666987"/>
      <value value="1814373"/>
      <value value="1821389"/>
      <value value="5127750"/>
      <value value="7316102"/>
      <value value="5070875"/>
      <value value="6670980"/>
      <value value="1537478"/>
      <value value="9250523"/>
      <value value="3137596"/>
      <value value="9230757"/>
      <value value="2555125"/>
      <value value="9274598"/>
      <value value="3988594"/>
      <value value="1334137"/>
      <value value="4945278"/>
      <value value="9875347"/>
      <value value="8194482"/>
      <value value="7460948"/>
      <value value="4946945"/>
      <value value="3970217"/>
      <value value="5518602"/>
      <value value="2880541"/>
      <value value="7096732"/>
      <value value="1204868"/>
      <value value="5013452"/>
      <value value="3128393"/>
      <value value="7529298"/>
      <value value="4178027"/>
      <value value="8923385"/>
      <value value="8211186"/>
      <value value="800702"/>
      <value value="4848435"/>
      <value value="2095494"/>
      <value value="3394070"/>
      <value value="3080943"/>
      <value value="1108071"/>
      <value value="3099767"/>
      <value value="4974303"/>
      <value value="8006232"/>
      <value value="8193270"/>
      <value value="5489792"/>
      <value value="6155420"/>
      <value value="2185049"/>
      <value value="4574711"/>
      <value value="919890"/>
      <value value="8068436"/>
      <value value="2211501"/>
      <value value="3983811"/>
      <value value="7408971"/>
      <value value="3091989"/>
      <value value="9596720"/>
      <value value="7524026"/>
      <value value="8997990"/>
      <value value="896179"/>
      <value value="9012676"/>
      <value value="8240290"/>
      <value value="1625736"/>
      <value value="6217055"/>
      <value value="5232580"/>
      <value value="7574321"/>
      <value value="5861659"/>
      <value value="8594290"/>
      <value value="8541746"/>
      <value value="6025859"/>
      <value value="6470853"/>
      <value value="8094415"/>
      <value value="8685191"/>
      <value value="9280657"/>
      <value value="6063851"/>
      <value value="1548911"/>
      <value value="8614552"/>
      <value value="9096232"/>
      <value value="6677430"/>
      <value value="687828"/>
      <value value="6588457"/>
      <value value="5794784"/>
      <value value="734668"/>
      <value value="299704"/>
      <value value="2521190"/>
      <value value="9649626"/>
      <value value="7213933"/>
      <value value="7422145"/>
      <value value="4984183"/>
      <value value="2650082"/>
      <value value="4382861"/>
      <value value="6730661"/>
      <value value="1202003"/>
      <value value="8966855"/>
      <value value="8389929"/>
      <value value="6818938"/>
      <value value="2380317"/>
      <value value="687742"/>
      <value value="7718238"/>
      <value value="6397472"/>
      <value value="8588927"/>
      <value value="3189994"/>
      <value value="5465739"/>
      <value value="8588721"/>
      <value value="4891636"/>
      <value value="3196753"/>
      <value value="1142591"/>
      <value value="4085345"/>
      <value value="5060474"/>
      <value value="1199388"/>
      <value value="1672143"/>
      <value value="7524841"/>
      <value value="9066443"/>
      <value value="4649245"/>
      <value value="6899884"/>
      <value value="7124809"/>
      <value value="3067084"/>
      <value value="7748420"/>
      <value value="408677"/>
      <value value="8902203"/>
      <value value="216016"/>
      <value value="3065925"/>
      <value value="5281008"/>
      <value value="5151811"/>
      <value value="8805449"/>
      <value value="1193905"/>
      <value value="9864055"/>
      <value value="9948604"/>
      <value value="141120"/>
      <value value="8840236"/>
      <value value="5012408"/>
      <value value="9974654"/>
      <value value="7876404"/>
      <value value="4158480"/>
      <value value="4166336"/>
      <value value="9275156"/>
      <value value="8382415"/>
      <value value="6567798"/>
      <value value="332555"/>
      <value value="2600846"/>
      <value value="8850426"/>
      <value value="3798402"/>
      <value value="5676668"/>
      <value value="2012090"/>
      <value value="8912378"/>
      <value value="5969138"/>
      <value value="3695422"/>
      <value value="3674545"/>
      <value value="2118747"/>
      <value value="2306988"/>
      <value value="6542857"/>
      <value value="7076474"/>
      <value value="3340433"/>
      <value value="9876057"/>
      <value value="8310582"/>
      <value value="5948649"/>
      <value value="7698746"/>
      <value value="4476317"/>
      <value value="6822083"/>
      <value value="3498705"/>
      <value value="2231594"/>
      <value value="643181"/>
      <value value="9496232"/>
      <value value="9427797"/>
      <value value="6307348"/>
      <value value="3567507"/>
      <value value="7567136"/>
      <value value="3565049"/>
      <value value="8814650"/>
      <value value="5385859"/>
      <value value="6184847"/>
      <value value="3411156"/>
      <value value="4025177"/>
      <value value="5076297"/>
      <value value="6961476"/>
      <value value="7410818"/>
      <value value="9223682"/>
      <value value="767784"/>
      <value value="4503808"/>
      <value value="5566064"/>
      <value value="1560417"/>
      <value value="1552051"/>
      <value value="6269666"/>
      <value value="3784095"/>
      <value value="8345140"/>
      <value value="5769302"/>
      <value value="4576583"/>
      <value value="3817044"/>
      <value value="6893161"/>
      <value value="2814485"/>
      <value value="4190471"/>
      <value value="8083836"/>
      <value value="7210675"/>
      <value value="7355477"/>
      <value value="6226348"/>
      <value value="8483329"/>
      <value value="6377874"/>
      <value value="8315077"/>
      <value value="1912005"/>
      <value value="7237504"/>
      <value value="3606152"/>
      <value value="5984234"/>
      <value value="6757085"/>
      <value value="8580735"/>
      <value value="20121"/>
      <value value="8123691"/>
      <value value="2066926"/>
      <value value="4598136"/>
      <value value="1772340"/>
      <value value="5079438"/>
      <value value="8162725"/>
      <value value="2934774"/>
      <value value="6523088"/>
      <value value="1794531"/>
      <value value="1859211"/>
      <value value="4199564"/>
      <value value="3369992"/>
      <value value="1457147"/>
      <value value="8808193"/>
      <value value="9543594"/>
      <value value="5833138"/>
      <value value="6743652"/>
      <value value="4573801"/>
      <value value="8023950"/>
      <value value="7972459"/>
      <value value="2464524"/>
      <value value="3838042"/>
      <value value="204284"/>
      <value value="1159090"/>
      <value value="263164"/>
      <value value="3922431"/>
      <value value="9256095"/>
      <value value="2920475"/>
      <value value="6022079"/>
      <value value="3281617"/>
      <value value="7213309"/>
      <value value="5717014"/>
      <value value="4542198"/>
      <value value="6339863"/>
      <value value="3069080"/>
      <value value="9806323"/>
      <value value="6686811"/>
      <value value="1858130"/>
      <value value="8338654"/>
      <value value="1468482"/>
      <value value="4494839"/>
      <value value="4637191"/>
      <value value="5537217"/>
      <value value="2302586"/>
      <value value="4149408"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;StageCal Test&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
      <value value="59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="115"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="household_iso_factor">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="immune_from_prev_variant">
      <value value="0.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="immune_from_reinfect">
      <value value="0.95"/>
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
      <value value="0.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
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
    <enumeratedValueSet variable="param_virulence_inc">
      <value value="0.05"/>
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
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.85"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.28"/>
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
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set_shape">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.05"/>
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
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="yearly_recover_prop_loss">
      <value value="0.14"/>
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
      <value value="4210554"/>
      <value value="6820004"/>
      <value value="6561455"/>
      <value value="3514143"/>
      <value value="4110561"/>
      <value value="9353419"/>
      <value value="4659592"/>
      <value value="5110864"/>
      <value value="3315004"/>
      <value value="2041511"/>
      <value value="1728551"/>
      <value value="4248593"/>
      <value value="6419780"/>
      <value value="3853993"/>
      <value value="4015590"/>
      <value value="7737515"/>
      <value value="3872110"/>
      <value value="589473"/>
      <value value="4996363"/>
      <value value="7032545"/>
      <value value="8471960"/>
      <value value="4252700"/>
      <value value="3017370"/>
      <value value="108032"/>
      <value value="7680919"/>
      <value value="4790571"/>
      <value value="9990536"/>
      <value value="712390"/>
      <value value="3057503"/>
      <value value="6080771"/>
      <value value="4034620"/>
      <value value="6135779"/>
      <value value="5101028"/>
      <value value="9574266"/>
      <value value="7637934"/>
      <value value="8354627"/>
      <value value="9685495"/>
      <value value="6136421"/>
      <value value="4793923"/>
      <value value="252132"/>
      <value value="6978216"/>
      <value value="9811820"/>
      <value value="8737561"/>
      <value value="5162034"/>
      <value value="3021837"/>
      <value value="9599646"/>
      <value value="5534557"/>
      <value value="7934084"/>
      <value value="5272398"/>
      <value value="4795990"/>
      <value value="4152469"/>
      <value value="4210560"/>
      <value value="1122157"/>
      <value value="1192536"/>
      <value value="1357137"/>
      <value value="1631611"/>
      <value value="4875071"/>
      <value value="7498036"/>
      <value value="1583611"/>
      <value value="6752453"/>
      <value value="4356749"/>
      <value value="5165931"/>
      <value value="1545654"/>
      <value value="2368565"/>
      <value value="8086478"/>
      <value value="5828870"/>
      <value value="2620834"/>
      <value value="1062668"/>
      <value value="4228183"/>
      <value value="2500104"/>
      <value value="5670498"/>
      <value value="7123757"/>
      <value value="5344970"/>
      <value value="9280987"/>
      <value value="131651"/>
      <value value="1585769"/>
      <value value="5329165"/>
      <value value="2096997"/>
      <value value="4924114"/>
      <value value="1708455"/>
      <value value="2189757"/>
      <value value="707139"/>
      <value value="1056484"/>
      <value value="97431"/>
      <value value="622581"/>
      <value value="5000908"/>
      <value value="7686924"/>
      <value value="1639418"/>
      <value value="2950858"/>
      <value value="3127316"/>
      <value value="2797950"/>
      <value value="9113728"/>
      <value value="4347874"/>
      <value value="9325957"/>
      <value value="487624"/>
      <value value="2528184"/>
      <value value="1892792"/>
      <value value="9595620"/>
      <value value="5456233"/>
      <value value="1921555"/>
      <value value="5106610"/>
      <value value="1421372"/>
      <value value="350362"/>
      <value value="1243629"/>
      <value value="6895272"/>
      <value value="4078941"/>
      <value value="9975485"/>
      <value value="4804153"/>
      <value value="9207437"/>
      <value value="6244604"/>
      <value value="8461011"/>
      <value value="579011"/>
      <value value="5427958"/>
      <value value="7058182"/>
      <value value="7201127"/>
      <value value="2586983"/>
      <value value="1204828"/>
      <value value="4340497"/>
      <value value="5833609"/>
      <value value="7003863"/>
      <value value="1641093"/>
      <value value="1224513"/>
      <value value="6326900"/>
      <value value="4832444"/>
      <value value="6111948"/>
      <value value="1888566"/>
      <value value="7250474"/>
      <value value="7436840"/>
      <value value="5688803"/>
      <value value="6630119"/>
      <value value="4158466"/>
      <value value="8872530"/>
      <value value="8149351"/>
      <value value="9407948"/>
      <value value="3529913"/>
      <value value="5538995"/>
      <value value="9652213"/>
      <value value="8601921"/>
      <value value="584671"/>
      <value value="2791879"/>
      <value value="9769841"/>
      <value value="5194839"/>
      <value value="663373"/>
      <value value="1140691"/>
      <value value="5855279"/>
      <value value="4731210"/>
      <value value="4765119"/>
      <value value="6022098"/>
      <value value="6905051"/>
      <value value="1538353"/>
      <value value="2360575"/>
      <value value="9441722"/>
      <value value="4462747"/>
      <value value="4068226"/>
      <value value="9467671"/>
      <value value="1703854"/>
      <value value="542359"/>
      <value value="9936530"/>
      <value value="6323735"/>
      <value value="5571817"/>
      <value value="7841452"/>
      <value value="6827725"/>
      <value value="1152813"/>
      <value value="7875207"/>
      <value value="4114653"/>
      <value value="2994898"/>
      <value value="6475116"/>
      <value value="6259188"/>
      <value value="2766783"/>
      <value value="9474615"/>
      <value value="4718995"/>
      <value value="5876289"/>
      <value value="6650888"/>
      <value value="9964502"/>
      <value value="9193101"/>
      <value value="9985364"/>
      <value value="467329"/>
      <value value="4383924"/>
      <value value="6003141"/>
      <value value="949342"/>
      <value value="3093968"/>
      <value value="4462379"/>
      <value value="6825712"/>
      <value value="9171707"/>
      <value value="2717528"/>
      <value value="609136"/>
      <value value="8531644"/>
      <value value="4558620"/>
      <value value="9240756"/>
      <value value="3995263"/>
      <value value="9780792"/>
      <value value="3668606"/>
      <value value="1981278"/>
      <value value="358909"/>
      <value value="9269437"/>
      <value value="9565511"/>
      <value value="5534559"/>
      <value value="3267864"/>
      <value value="7826049"/>
      <value value="4762342"/>
      <value value="6609982"/>
      <value value="8679201"/>
      <value value="100011"/>
      <value value="8627375"/>
      <value value="4681839"/>
      <value value="7188949"/>
      <value value="8554898"/>
      <value value="9685773"/>
      <value value="9419772"/>
      <value value="7187703"/>
      <value value="4779390"/>
      <value value="6785676"/>
      <value value="346283"/>
      <value value="1424172"/>
      <value value="2681395"/>
      <value value="8779608"/>
      <value value="3267551"/>
      <value value="7891209"/>
      <value value="6654973"/>
      <value value="7272555"/>
      <value value="3792505"/>
      <value value="7829665"/>
      <value value="2327571"/>
      <value value="5847108"/>
      <value value="8085178"/>
      <value value="9396997"/>
      <value value="9638714"/>
      <value value="7708012"/>
      <value value="3485666"/>
      <value value="2657489"/>
      <value value="647549"/>
      <value value="7313812"/>
      <value value="6323355"/>
      <value value="6336874"/>
      <value value="2518565"/>
      <value value="9419411"/>
      <value value="4745172"/>
      <value value="3508672"/>
      <value value="232733"/>
      <value value="4621119"/>
      <value value="9018895"/>
      <value value="2779974"/>
      <value value="5149328"/>
      <value value="661972"/>
      <value value="4789378"/>
      <value value="9490692"/>
      <value value="9448116"/>
      <value value="6835957"/>
      <value value="1462447"/>
      <value value="185463"/>
      <value value="8302770"/>
      <value value="5462221"/>
      <value value="5782127"/>
      <value value="9585636"/>
      <value value="8690392"/>
      <value value="4666987"/>
      <value value="1814373"/>
      <value value="1821389"/>
      <value value="5127750"/>
      <value value="7316102"/>
      <value value="5070875"/>
      <value value="6670980"/>
      <value value="1537478"/>
      <value value="9250523"/>
      <value value="3137596"/>
      <value value="9230757"/>
      <value value="2555125"/>
      <value value="9274598"/>
      <value value="3988594"/>
      <value value="1334137"/>
      <value value="4945278"/>
      <value value="9875347"/>
      <value value="8194482"/>
      <value value="7460948"/>
      <value value="4946945"/>
      <value value="3970217"/>
      <value value="5518602"/>
      <value value="2880541"/>
      <value value="7096732"/>
      <value value="1204868"/>
      <value value="5013452"/>
      <value value="3128393"/>
      <value value="7529298"/>
      <value value="4178027"/>
      <value value="8923385"/>
      <value value="8211186"/>
      <value value="800702"/>
      <value value="4848435"/>
      <value value="2095494"/>
      <value value="3394070"/>
      <value value="3080943"/>
      <value value="1108071"/>
      <value value="3099767"/>
      <value value="4974303"/>
      <value value="8006232"/>
      <value value="8193270"/>
      <value value="5489792"/>
      <value value="6155420"/>
      <value value="2185049"/>
      <value value="4574711"/>
      <value value="919890"/>
      <value value="8068436"/>
      <value value="2211501"/>
      <value value="3983811"/>
      <value value="7408971"/>
      <value value="3091989"/>
      <value value="9596720"/>
      <value value="7524026"/>
      <value value="8997990"/>
      <value value="896179"/>
      <value value="9012676"/>
      <value value="8240290"/>
      <value value="1625736"/>
      <value value="6217055"/>
      <value value="5232580"/>
      <value value="7574321"/>
      <value value="5861659"/>
      <value value="8594290"/>
      <value value="8541746"/>
      <value value="6025859"/>
      <value value="6470853"/>
      <value value="8094415"/>
      <value value="8685191"/>
      <value value="9280657"/>
      <value value="6063851"/>
      <value value="1548911"/>
      <value value="8614552"/>
      <value value="9096232"/>
      <value value="6677430"/>
      <value value="687828"/>
      <value value="6588457"/>
      <value value="5794784"/>
      <value value="734668"/>
      <value value="299704"/>
      <value value="2521190"/>
      <value value="9649626"/>
      <value value="7213933"/>
      <value value="7422145"/>
      <value value="4984183"/>
      <value value="2650082"/>
      <value value="4382861"/>
      <value value="6730661"/>
      <value value="1202003"/>
      <value value="8966855"/>
      <value value="8389929"/>
      <value value="6818938"/>
      <value value="2380317"/>
      <value value="687742"/>
      <value value="7718238"/>
      <value value="6397472"/>
      <value value="8588927"/>
      <value value="3189994"/>
      <value value="5465739"/>
      <value value="8588721"/>
      <value value="4891636"/>
      <value value="3196753"/>
      <value value="1142591"/>
      <value value="4085345"/>
      <value value="5060474"/>
      <value value="1199388"/>
      <value value="1672143"/>
      <value value="7524841"/>
      <value value="9066443"/>
      <value value="4649245"/>
      <value value="6899884"/>
      <value value="7124809"/>
      <value value="3067084"/>
      <value value="7748420"/>
      <value value="408677"/>
      <value value="8902203"/>
      <value value="216016"/>
      <value value="3065925"/>
      <value value="5281008"/>
      <value value="5151811"/>
      <value value="8805449"/>
      <value value="1193905"/>
      <value value="9864055"/>
      <value value="9948604"/>
      <value value="141120"/>
      <value value="8840236"/>
      <value value="5012408"/>
      <value value="9974654"/>
      <value value="7876404"/>
      <value value="4158480"/>
      <value value="4166336"/>
      <value value="9275156"/>
      <value value="8382415"/>
      <value value="6567798"/>
      <value value="332555"/>
      <value value="2600846"/>
      <value value="8850426"/>
      <value value="3798402"/>
      <value value="5676668"/>
      <value value="2012090"/>
      <value value="8912378"/>
      <value value="5969138"/>
      <value value="3695422"/>
      <value value="3674545"/>
      <value value="2118747"/>
      <value value="2306988"/>
      <value value="6542857"/>
      <value value="7076474"/>
      <value value="3340433"/>
      <value value="9876057"/>
      <value value="8310582"/>
      <value value="5948649"/>
      <value value="7698746"/>
      <value value="4476317"/>
      <value value="6822083"/>
      <value value="3498705"/>
      <value value="2231594"/>
      <value value="643181"/>
      <value value="9496232"/>
      <value value="9427797"/>
      <value value="6307348"/>
      <value value="3567507"/>
      <value value="7567136"/>
      <value value="3565049"/>
      <value value="8814650"/>
      <value value="5385859"/>
      <value value="6184847"/>
      <value value="3411156"/>
      <value value="4025177"/>
      <value value="5076297"/>
      <value value="6961476"/>
      <value value="7410818"/>
      <value value="9223682"/>
      <value value="767784"/>
      <value value="4503808"/>
      <value value="5566064"/>
      <value value="1560417"/>
      <value value="1552051"/>
      <value value="6269666"/>
      <value value="3784095"/>
      <value value="8345140"/>
      <value value="5769302"/>
      <value value="4576583"/>
      <value value="3817044"/>
      <value value="6893161"/>
      <value value="2814485"/>
      <value value="4190471"/>
      <value value="8083836"/>
      <value value="7210675"/>
      <value value="7355477"/>
      <value value="6226348"/>
      <value value="8483329"/>
      <value value="6377874"/>
      <value value="8315077"/>
      <value value="1912005"/>
      <value value="7237504"/>
      <value value="3606152"/>
      <value value="5984234"/>
      <value value="6757085"/>
      <value value="8580735"/>
      <value value="20121"/>
      <value value="8123691"/>
      <value value="2066926"/>
      <value value="4598136"/>
      <value value="1772340"/>
      <value value="5079438"/>
      <value value="8162725"/>
      <value value="2934774"/>
      <value value="6523088"/>
      <value value="1794531"/>
      <value value="1859211"/>
      <value value="4199564"/>
      <value value="3369992"/>
      <value value="1457147"/>
      <value value="8808193"/>
      <value value="9543594"/>
      <value value="5833138"/>
      <value value="6743652"/>
      <value value="4573801"/>
      <value value="8023950"/>
      <value value="7972459"/>
      <value value="2464524"/>
      <value value="3838042"/>
      <value value="204284"/>
      <value value="1159090"/>
      <value value="263164"/>
      <value value="3922431"/>
      <value value="9256095"/>
      <value value="2920475"/>
      <value value="6022079"/>
      <value value="3281617"/>
      <value value="7213309"/>
      <value value="5717014"/>
      <value value="4542198"/>
      <value value="6339863"/>
      <value value="3069080"/>
      <value value="9806323"/>
      <value value="6686811"/>
      <value value="1858130"/>
      <value value="8338654"/>
      <value value="1468482"/>
      <value value="4494839"/>
      <value value="4637191"/>
      <value value="5537217"/>
      <value value="2302586"/>
      <value value="4149408"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;StageCal Test&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="115"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="100"/>
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
      <value value="10"/>
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
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
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
    <enumeratedValueSet variable="param_virulence_inc">
      <value value="0.05"/>
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
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age_isolation">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.85"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
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
      <value value="true"/>
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
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.05"/>
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
      <value value="0.1428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="25"/>
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
    <enumeratedValueSet variable="param_virulence_inc">
      <value value="0.05"/>
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

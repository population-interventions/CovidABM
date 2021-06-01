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
962
678
-1
-1
9.97
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
60
0
60
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
10.0
1
1
NIL
HORIZONTAL

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

SLIDER
1627
219
1806
252
superspreaders
superspreaders
0
1
0.01
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
0.0
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
0.0
.5
1
NIL
HORIZONTAL

INPUTBOX
220
334
325
395
initial_cases
60.0
1
0
Number

INPUTBOX
217
458
324
520
total_population
6.681E11
1
0
Number

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

SLIDER
348
690
533
723
Global_Transmissibility
Global_Transmissibility
0
1
0.585
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
100.0
1
1
NIL
HORIZONTAL

SLIDER
563
867
760
900
Ess_W_Risk_Reduction
Ess_W_Risk_Reduction
0
100
50.0
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
0.0
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
0
1
-1000

SWITCH
1483
322
1617
355
MaskPolicy
MaskPolicy
1
1
-1000

SLIDER
344
1014
539
1047
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
339
827
537
860
Asymptomatic_Trans
Asymptomatic_Trans
0
1
0.75
.01
1
NIL
HORIZONTAL

SLIDER
1263
1009
1462
1042
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

SLIDER
13
15
290
48
RAND_SEED
RAND_SEED
0
10000000
4624498.0
1
1
NIL
HORIZONTAL

SLIDER
22
180
197
213
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
18
447
196
492
param_policy
param_policy
"AggressElim" "ModerateElim" "TightSupress" "LooseSupress" "TightSupress_No_4" "LooseSupress_No_4" "Stage2infect" "None" "Stage1" "Stage1b" "Stage2" "Stage2b" "Stage3" "Stage4" "StageCal None" "StageCal Test" "StageCal_1" "StageCal_1b" "StageCal_2" "StageCal_3" "StageCal_4"
15

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

SLIDER
342
864
537
897
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
342
905
537
938
Asymptom_Trace_Mult
Asymptom_Trace_Mult
0
1
0.33
0.01
1
NIL
HORIZONTAL

SLIDER
563
827
760
860
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
0.0
1
1
NIL
HORIZONTAL

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
89.0
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
0.5
0.01
1
NIL
HORIZONTAL

SLIDER
344
974
541
1007
Non_Infective_Time
Non_Infective_Time
0
4
2.0
1
1
NIL
HORIZONTAL

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

SLIDER
558
729
761
762
Recovered_Match_Rate
Recovered_Match_Rate
0
0.5
0.04
0.001
1
NIL
HORIZONTAL

SWITCH
18
408
192
441
param_trigger_loosen
param_trigger_loosen
1
1
-1000

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
70
54.0
1
1
NIL
HORIZONTAL

SLIDER
563
935
736
968
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
564
978
737
1011
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
564
1015
737
1048
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
0
1
-1000

SLIDER
785
728
985
761
Household_Iso_Factor
Household_Iso_Factor
0
1
0.0
0.01
1
NIL
HORIZONTAL

SLIDER
787
803
984
836
Infect_Iso_Factor
Infect_Iso_Factor
0
1
0.3
0.01
1
NIL
HORIZONTAL

SLIDER
787
768
985
801
Track_Iso_Factor
Track_Iso_Factor
0
1
0.0
0.05
1
NIL
HORIZONTAL

SWITCH
1609
744
1726
777
track_slope
track_slope
1
1
-1000

SLIDER
20
254
195
287
param_vac_wane
param_vac_wane
0
0.05
0.001
0.001
1
NIL
HORIZONTAL

SLIDER
22
215
197
248
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
22
145
197
178
param_recovered_prop
param_recovered_prop
0
0.5
0.0
0.05
1
NIL
HORIZONTAL

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
788
1003
985
1036
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
347
727
532
760
reinfect_area
reinfect_area
0
1
1.0
0.05
1
NIL
HORIZONTAL

SLIDER
787
924
984
957
prev_var_area
prev_var_area
0
1
0.0
0.05
1
NIL
HORIZONTAL

SLIDER
560
768
758
801
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
689
17
799
50
set_shape
set_shape
0
1
-1000

SLIDER
788
1042
986
1075
vac_variant_eff_prop
vac_variant_eff_prop
0
1
0.86
0.01
1
NIL
HORIZONTAL

SLIDER
560
690
760
723
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
23
108
195
141
param_final_phase
param_final_phase
-1
10
5.0
1
1
NIL
HORIZONTAL

SLIDER
23
70
198
103
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
1044
1005
1254
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
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
787
842
990
875
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
1263
1048
1461
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
785
887
982
920
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

SLIDER
788
964
983
997
prev_var_risk
prev_var_risk
0
1
0.0
0.01
1
NIL
HORIZONTAL

SLIDER
348
764
535
797
reinfect_risk
reinfect_risk
0
1
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
219
399
328
432
initial_primary_prop
initial_primary_prop
0
1
0.6
0.01
1
NIL
HORIZONTAL

SLIDER
18
332
211
365
param_policy_force_days
param_policy_force_days
0
28
7.0
1
1
NIL
HORIZONTAL

SLIDER
17
369
211
402
param_policy_force_stage
param_policy_force_stage
-1
4
4.0
1
1
NIL
HORIZONTAL

SLIDER
18
294
211
327
param_policy_force_preset
param_policy_force_preset
0
3
2.0
1
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
      <value value="4792674"/>
      <value value="9875019"/>
      <value value="1936894"/>
      <value value="4627356"/>
      <value value="7505423"/>
      <value value="9934090"/>
      <value value="8245599"/>
      <value value="6512546"/>
      <value value="5374187"/>
      <value value="2490768"/>
      <value value="5918251"/>
      <value value="2226937"/>
      <value value="5532747"/>
      <value value="108079"/>
      <value value="932169"/>
      <value value="5091591"/>
      <value value="5255471"/>
      <value value="8420214"/>
      <value value="1575686"/>
      <value value="6767756"/>
      <value value="2117021"/>
      <value value="4797044"/>
      <value value="1737187"/>
      <value value="2842337"/>
      <value value="3945509"/>
      <value value="7752085"/>
      <value value="9843879"/>
      <value value="2187915"/>
      <value value="7153260"/>
      <value value="8627753"/>
      <value value="4253347"/>
      <value value="9415101"/>
      <value value="3801722"/>
      <value value="3901479"/>
      <value value="4219251"/>
      <value value="5741131"/>
      <value value="688959"/>
      <value value="8126745"/>
      <value value="2670571"/>
      <value value="575205"/>
      <value value="8764752"/>
      <value value="8919367"/>
      <value value="752645"/>
      <value value="2101987"/>
      <value value="6287397"/>
      <value value="3191610"/>
      <value value="658325"/>
      <value value="6278613"/>
      <value value="1223584"/>
      <value value="2135061"/>
      <value value="4959120"/>
      <value value="1987236"/>
      <value value="555729"/>
      <value value="4265061"/>
      <value value="4458931"/>
      <value value="2109085"/>
      <value value="4707565"/>
      <value value="9206817"/>
      <value value="1567836"/>
      <value value="8742766"/>
      <value value="3780459"/>
      <value value="6004678"/>
      <value value="5855031"/>
      <value value="4262536"/>
      <value value="3794783"/>
      <value value="3060955"/>
      <value value="6271428"/>
      <value value="6109276"/>
      <value value="8358407"/>
      <value value="1670745"/>
      <value value="2770724"/>
      <value value="7636895"/>
      <value value="8327535"/>
      <value value="4378851"/>
      <value value="6590675"/>
      <value value="6998590"/>
      <value value="9738291"/>
      <value value="9861785"/>
      <value value="2543004"/>
      <value value="5500848"/>
      <value value="6687877"/>
      <value value="2748589"/>
      <value value="7932572"/>
      <value value="6026716"/>
      <value value="2291111"/>
      <value value="2482395"/>
      <value value="5419741"/>
      <value value="8042890"/>
      <value value="5757891"/>
      <value value="4249245"/>
      <value value="209300"/>
      <value value="8195784"/>
      <value value="4090160"/>
      <value value="4396428"/>
      <value value="8383072"/>
      <value value="3210581"/>
      <value value="7647695"/>
      <value value="4294955"/>
      <value value="1703711"/>
      <value value="7959192"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;ModerateElim&quot;"/>
      <value value="&quot;TightSupress&quot;"/>
      <value value="&quot;LooseSupress&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.278"/>
      <value value="0.333"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="730"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="35"/>
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
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
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
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_variant_2_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_final_phase">
      <value value="2"/>
      <value value="3"/>
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
    <enumeratedValueSet variable="param_vac_area">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_rate_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_risk">
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake">
      <value value="0.5"/>
      <value value="0.7"/>
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_wane">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vaceffdays">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailycases">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prev_var_area">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prev_var_risk">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.042"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reinfect_area">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reinfect_risk">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="1"/>
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
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set_shape">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.008"/>
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
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="yearly_recover_prop_loss">
      <value value="0"/>
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
      <value value="1389332"/>
      <value value="3529352"/>
      <value value="1854862"/>
      <value value="9587888"/>
      <value value="6744289"/>
      <value value="2739279"/>
      <value value="4735443"/>
      <value value="7117472"/>
      <value value="704311"/>
      <value value="5704512"/>
      <value value="6128934"/>
      <value value="4892643"/>
      <value value="1506095"/>
      <value value="7669944"/>
      <value value="2918141"/>
      <value value="3635504"/>
      <value value="5342143"/>
      <value value="4374269"/>
      <value value="2149750"/>
      <value value="7067696"/>
      <value value="7716433"/>
      <value value="7539924"/>
      <value value="4899496"/>
      <value value="2120961"/>
      <value value="3216630"/>
      <value value="5900308"/>
      <value value="8769226"/>
      <value value="1943113"/>
      <value value="6508535"/>
      <value value="4188006"/>
      <value value="1087151"/>
      <value value="8596344"/>
      <value value="7306348"/>
      <value value="1074961"/>
      <value value="6924868"/>
      <value value="5585637"/>
      <value value="7835060"/>
      <value value="704822"/>
      <value value="5461147"/>
      <value value="4526048"/>
      <value value="5432974"/>
      <value value="4728659"/>
      <value value="1753188"/>
      <value value="8902965"/>
      <value value="6316957"/>
      <value value="9034077"/>
      <value value="3016699"/>
      <value value="684348"/>
      <value value="6254085"/>
      <value value="2877089"/>
      <value value="7442792"/>
      <value value="3982754"/>
      <value value="2090564"/>
      <value value="6356402"/>
      <value value="7936494"/>
      <value value="4795626"/>
      <value value="9158149"/>
      <value value="958314"/>
      <value value="5938754"/>
      <value value="1254255"/>
      <value value="9970958"/>
      <value value="869401"/>
      <value value="979904"/>
      <value value="791626"/>
      <value value="5189907"/>
      <value value="4142024"/>
      <value value="3834554"/>
      <value value="5200952"/>
      <value value="8873565"/>
      <value value="4328612"/>
      <value value="7679634"/>
      <value value="8046717"/>
      <value value="453432"/>
      <value value="7086387"/>
      <value value="1433544"/>
      <value value="6623244"/>
      <value value="3232896"/>
      <value value="231100"/>
      <value value="1170653"/>
      <value value="231587"/>
      <value value="9725455"/>
      <value value="7765951"/>
      <value value="4581473"/>
      <value value="4400275"/>
      <value value="6017062"/>
      <value value="946790"/>
      <value value="187241"/>
      <value value="2479032"/>
      <value value="2506917"/>
      <value value="6111586"/>
      <value value="3505753"/>
      <value value="2293051"/>
      <value value="591703"/>
      <value value="4188871"/>
      <value value="3325392"/>
      <value value="257260"/>
      <value value="1103287"/>
      <value value="3129849"/>
      <value value="4774359"/>
      <value value="882516"/>
      <value value="8874805"/>
      <value value="1156115"/>
      <value value="7519157"/>
      <value value="2333229"/>
      <value value="1813088"/>
      <value value="441"/>
      <value value="4990170"/>
      <value value="1344299"/>
      <value value="3523845"/>
      <value value="6180011"/>
      <value value="4772487"/>
      <value value="5844830"/>
      <value value="3049248"/>
      <value value="4784749"/>
      <value value="3674787"/>
      <value value="2623433"/>
      <value value="2184647"/>
      <value value="6281748"/>
      <value value="1014087"/>
      <value value="994523"/>
      <value value="8118698"/>
      <value value="2237360"/>
      <value value="3477704"/>
      <value value="7012758"/>
      <value value="4868970"/>
      <value value="1964533"/>
      <value value="102740"/>
      <value value="9343056"/>
      <value value="5746321"/>
      <value value="8411815"/>
      <value value="23945"/>
      <value value="6212724"/>
      <value value="7726581"/>
      <value value="3807229"/>
      <value value="389577"/>
      <value value="4793694"/>
      <value value="7005653"/>
      <value value="3877915"/>
      <value value="6784482"/>
      <value value="3427879"/>
      <value value="3126324"/>
      <value value="530689"/>
      <value value="249024"/>
      <value value="4477868"/>
      <value value="1803249"/>
      <value value="6938195"/>
      <value value="3798545"/>
      <value value="9299886"/>
      <value value="2687928"/>
      <value value="810655"/>
      <value value="9057"/>
      <value value="8778238"/>
      <value value="1440857"/>
      <value value="6078655"/>
      <value value="1011751"/>
      <value value="8870241"/>
      <value value="5623301"/>
      <value value="6396922"/>
      <value value="4349107"/>
      <value value="4313982"/>
      <value value="3952810"/>
      <value value="6996481"/>
      <value value="2222767"/>
      <value value="9335766"/>
      <value value="5508056"/>
      <value value="1081973"/>
      <value value="8195650"/>
      <value value="8440720"/>
      <value value="8838500"/>
      <value value="1352424"/>
      <value value="9568079"/>
      <value value="1612928"/>
      <value value="8823636"/>
      <value value="3751795"/>
      <value value="4320223"/>
      <value value="7092040"/>
      <value value="6720342"/>
      <value value="1002209"/>
      <value value="5241503"/>
      <value value="3219895"/>
      <value value="5547581"/>
      <value value="7016413"/>
      <value value="7730026"/>
      <value value="9709781"/>
      <value value="216970"/>
      <value value="4532979"/>
      <value value="5157375"/>
      <value value="2664399"/>
      <value value="4066739"/>
      <value value="409260"/>
      <value value="3996766"/>
      <value value="3770229"/>
      <value value="2345780"/>
      <value value="5278251"/>
      <value value="4442899"/>
      <value value="5492841"/>
      <value value="2330161"/>
      <value value="512558"/>
      <value value="8694348"/>
      <value value="4854875"/>
      <value value="8260531"/>
      <value value="6243347"/>
      <value value="3694846"/>
      <value value="2168729"/>
      <value value="2119167"/>
      <value value="2986854"/>
      <value value="6227334"/>
      <value value="2063336"/>
      <value value="5093874"/>
      <value value="3670066"/>
      <value value="8292250"/>
      <value value="4457002"/>
      <value value="6162741"/>
      <value value="1448164"/>
      <value value="9675254"/>
      <value value="7356412"/>
      <value value="1587591"/>
      <value value="4265282"/>
      <value value="7648625"/>
      <value value="5733120"/>
      <value value="5506831"/>
      <value value="8917286"/>
      <value value="9843205"/>
      <value value="8491879"/>
      <value value="9899779"/>
      <value value="2786859"/>
      <value value="5557537"/>
      <value value="951537"/>
      <value value="6329881"/>
      <value value="8743608"/>
      <value value="496799"/>
      <value value="3871913"/>
      <value value="6869499"/>
      <value value="5372866"/>
      <value value="4889276"/>
      <value value="6800588"/>
      <value value="294410"/>
      <value value="6790856"/>
      <value value="9688831"/>
      <value value="5557841"/>
      <value value="9931739"/>
      <value value="6437847"/>
      <value value="7552060"/>
      <value value="9394872"/>
      <value value="9042730"/>
      <value value="371103"/>
      <value value="757375"/>
      <value value="3504534"/>
      <value value="543043"/>
      <value value="6967301"/>
      <value value="7749499"/>
      <value value="2361102"/>
      <value value="6648061"/>
      <value value="5821157"/>
      <value value="8050824"/>
      <value value="5858260"/>
      <value value="1206309"/>
      <value value="9980016"/>
      <value value="7459148"/>
      <value value="6892499"/>
      <value value="4768021"/>
      <value value="170801"/>
      <value value="3378667"/>
      <value value="8745020"/>
      <value value="6076288"/>
      <value value="1252842"/>
      <value value="3671164"/>
      <value value="9394057"/>
      <value value="1940992"/>
      <value value="8585410"/>
      <value value="6310769"/>
      <value value="549533"/>
      <value value="9961810"/>
      <value value="4938232"/>
      <value value="8657199"/>
      <value value="7376248"/>
      <value value="2401860"/>
      <value value="2480235"/>
      <value value="2395895"/>
      <value value="9747832"/>
      <value value="712163"/>
      <value value="5604142"/>
      <value value="482660"/>
      <value value="585451"/>
      <value value="3856245"/>
      <value value="24121"/>
      <value value="859560"/>
      <value value="3083289"/>
      <value value="7947580"/>
      <value value="5579607"/>
      <value value="6654554"/>
      <value value="2672008"/>
      <value value="3327231"/>
      <value value="434882"/>
      <value value="3957668"/>
      <value value="2739404"/>
      <value value="2016896"/>
      <value value="6653267"/>
      <value value="9818758"/>
      <value value="2898145"/>
      <value value="2417685"/>
      <value value="9408165"/>
      <value value="34459"/>
      <value value="555360"/>
      <value value="6450187"/>
      <value value="5843755"/>
      <value value="4927567"/>
      <value value="351600"/>
      <value value="2533030"/>
      <value value="7350861"/>
      <value value="8429423"/>
      <value value="2518463"/>
      <value value="3725553"/>
      <value value="4053948"/>
      <value value="385305"/>
      <value value="591051"/>
      <value value="7812200"/>
      <value value="4098467"/>
      <value value="6630864"/>
      <value value="4264918"/>
      <value value="9382946"/>
      <value value="2956817"/>
      <value value="1281128"/>
      <value value="9599148"/>
      <value value="9531990"/>
      <value value="1037961"/>
      <value value="2013167"/>
      <value value="6399638"/>
      <value value="1091993"/>
      <value value="3659933"/>
      <value value="9799280"/>
      <value value="6137253"/>
      <value value="6724002"/>
      <value value="2716124"/>
      <value value="330045"/>
      <value value="7336007"/>
      <value value="385508"/>
      <value value="4624498"/>
      <value value="349137"/>
      <value value="1556062"/>
      <value value="4587982"/>
      <value value="1230810"/>
      <value value="9936730"/>
      <value value="4744740"/>
      <value value="5052373"/>
      <value value="5827272"/>
      <value value="4495706"/>
      <value value="6125974"/>
      <value value="6169027"/>
      <value value="6182257"/>
      <value value="10678"/>
      <value value="4732509"/>
      <value value="8423598"/>
      <value value="8046734"/>
      <value value="2161465"/>
      <value value="9252649"/>
      <value value="2036934"/>
      <value value="1115273"/>
      <value value="5107530"/>
      <value value="3899303"/>
      <value value="4319901"/>
      <value value="8572346"/>
      <value value="6080173"/>
      <value value="1087477"/>
      <value value="5706265"/>
      <value value="3293461"/>
      <value value="5693299"/>
      <value value="9072714"/>
      <value value="5374420"/>
      <value value="4179129"/>
      <value value="9320899"/>
      <value value="3670876"/>
      <value value="5814700"/>
      <value value="7806972"/>
      <value value="190538"/>
      <value value="3517640"/>
      <value value="6751166"/>
      <value value="6576757"/>
      <value value="6736425"/>
      <value value="4534164"/>
      <value value="7440744"/>
      <value value="9368211"/>
      <value value="368398"/>
      <value value="9028328"/>
      <value value="5570086"/>
      <value value="2563328"/>
      <value value="654135"/>
      <value value="5881033"/>
      <value value="1346435"/>
      <value value="2056843"/>
      <value value="6738130"/>
      <value value="4870144"/>
      <value value="6802998"/>
      <value value="40195"/>
      <value value="5772133"/>
      <value value="5694389"/>
      <value value="804455"/>
      <value value="876768"/>
      <value value="9496360"/>
      <value value="609155"/>
      <value value="650978"/>
      <value value="5183123"/>
      <value value="8127431"/>
      <value value="1466818"/>
      <value value="5579188"/>
      <value value="1157084"/>
      <value value="573748"/>
      <value value="8613793"/>
      <value value="8966096"/>
      <value value="427581"/>
      <value value="111589"/>
      <value value="4265546"/>
      <value value="1714491"/>
      <value value="3312188"/>
      <value value="4827058"/>
      <value value="7837724"/>
      <value value="7649264"/>
      <value value="5445794"/>
      <value value="8002732"/>
      <value value="6385718"/>
      <value value="1906093"/>
      <value value="9959611"/>
      <value value="8387100"/>
      <value value="7283845"/>
      <value value="8487594"/>
      <value value="3363789"/>
      <value value="2804966"/>
      <value value="4915475"/>
      <value value="9045275"/>
      <value value="5588706"/>
      <value value="7310943"/>
      <value value="3287933"/>
      <value value="3044429"/>
      <value value="8689541"/>
      <value value="5568241"/>
      <value value="6651679"/>
      <value value="4866495"/>
      <value value="4732529"/>
      <value value="730178"/>
      <value value="8684024"/>
      <value value="39606"/>
      <value value="7607534"/>
      <value value="2440960"/>
      <value value="8566397"/>
      <value value="2800730"/>
      <value value="8780176"/>
      <value value="7679491"/>
      <value value="2990764"/>
      <value value="1831897"/>
      <value value="5082890"/>
      <value value="4723224"/>
      <value value="6039295"/>
      <value value="9816623"/>
      <value value="2010557"/>
      <value value="8927565"/>
      <value value="5268806"/>
      <value value="9252822"/>
      <value value="4223040"/>
      <value value="7775020"/>
      <value value="8649116"/>
      <value value="39483"/>
      <value value="8959495"/>
      <value value="3674712"/>
      <value value="3129609"/>
      <value value="824173"/>
      <value value="7144369"/>
      <value value="3241504"/>
      <value value="1027681"/>
      <value value="7945939"/>
      <value value="4703103"/>
      <value value="3080411"/>
      <value value="9916903"/>
      <value value="5974155"/>
      <value value="292745"/>
      <value value="2810545"/>
      <value value="1269320"/>
      <value value="2229648"/>
      <value value="22664"/>
      <value value="4258085"/>
      <value value="3274583"/>
      <value value="5961074"/>
      <value value="5897012"/>
      <value value="9600518"/>
      <value value="5630746"/>
      <value value="286045"/>
      <value value="807712"/>
      <value value="2621315"/>
      <value value="9102606"/>
      <value value="2040976"/>
      <value value="6418817"/>
      <value value="9032239"/>
      <value value="6677345"/>
      <value value="3996200"/>
      <value value="2506603"/>
      <value value="7927568"/>
      <value value="4108196"/>
      <value value="4915790"/>
      <value value="9985051"/>
      <value value="8957551"/>
      <value value="7181200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;StageCal Test&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.505"/>
      <value value="0.585"/>
      <value value="0.655"/>
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
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="50"/>
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
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="illness_period">
      <value value="21.2"/>
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
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_primary_prop">
      <value value="0.6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_variant_2_prop">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolate_on_inf_notice">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="isolation_transmission">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_efficacy_mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mask_wearing">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="non_infective_time">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_final_phase">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incur_phase_limit">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_days">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_preset">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy_force_stage">
      <value value="4"/>
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
    <enumeratedValueSet variable="param_vac_uptake">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_wane">
      <value value="0.001"/>
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
    <enumeratedValueSet variable="prev_var_area">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prev_var_risk">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="32"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="32"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.04"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reinfect_area">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reinfect_risk">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="1"/>
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
    <enumeratedValueSet variable="set_shape">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.75"/>
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
      <value value="668100000000"/>
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
      <value value="6.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="yearly_recover_prop_loss">
      <value value="0"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Stage2_infect" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>days</metric>
    <metric>stage_listOut</metric>
    <metric>scalephase</metric>
    <metric>cumulativeInfected</metric>
    <metric>casesReportedToday</metric>
    <metric>Deathcount</metric>
    <metric>average_R_region_1</metric>
    <metric>average_R_region_2</metric>
    <metric>average_R_all_regions</metric>
    <metric>totalOverseasIncursions</metric>
    <metric>infectNoVacArray_listOut</metric>
    <metric>infectVacArray_listOut</metric>
    <metric>age_listOut</metric>
    <metric>atsi_listOut</metric>
    <metric>morbid_listOut</metric>
    <enumeratedValueSet variable="rand_seed">
      <value value="9120966"/>
      <value value="8163596"/>
      <value value="1002287"/>
      <value value="4692611"/>
      <value value="8773572"/>
      <value value="2398472"/>
      <value value="6510030"/>
      <value value="9017942"/>
      <value value="9653981"/>
      <value value="2680401"/>
      <value value="5921119"/>
      <value value="9822161"/>
      <value value="2390664"/>
      <value value="1140117"/>
      <value value="5357145"/>
      <value value="1625776"/>
      <value value="9518376"/>
      <value value="4667533"/>
      <value value="4704957"/>
      <value value="5324087"/>
      <value value="7966551"/>
      <value value="8794801"/>
      <value value="6441672"/>
      <value value="9279899"/>
      <value value="4989224"/>
      <value value="9649407"/>
      <value value="7782028"/>
      <value value="8090666"/>
      <value value="4174912"/>
      <value value="7858694"/>
      <value value="9055342"/>
      <value value="5859986"/>
      <value value="905247"/>
      <value value="7458430"/>
      <value value="2175435"/>
      <value value="1181491"/>
      <value value="9668857"/>
      <value value="5521518"/>
      <value value="7947262"/>
      <value value="3931645"/>
      <value value="235681"/>
      <value value="8940566"/>
      <value value="4513890"/>
      <value value="6730824"/>
      <value value="3090337"/>
      <value value="979204"/>
      <value value="167116"/>
      <value value="4933674"/>
      <value value="6130472"/>
      <value value="2378407"/>
      <value value="7066381"/>
      <value value="9279526"/>
      <value value="9888186"/>
      <value value="2073091"/>
      <value value="1520790"/>
      <value value="1804174"/>
      <value value="4832687"/>
      <value value="1196828"/>
      <value value="2999479"/>
      <value value="4897529"/>
      <value value="6717427"/>
      <value value="4647848"/>
      <value value="6853553"/>
      <value value="2972638"/>
      <value value="6200001"/>
      <value value="5699253"/>
      <value value="8854303"/>
      <value value="981375"/>
      <value value="6068688"/>
      <value value="3250805"/>
      <value value="5413660"/>
      <value value="7514799"/>
      <value value="7532173"/>
      <value value="427448"/>
      <value value="4156316"/>
      <value value="1390062"/>
      <value value="236876"/>
      <value value="3420505"/>
      <value value="5238288"/>
      <value value="7277239"/>
      <value value="6983409"/>
      <value value="63708"/>
      <value value="8174773"/>
      <value value="7317998"/>
      <value value="6847769"/>
      <value value="4786530"/>
      <value value="4982078"/>
      <value value="2283019"/>
      <value value="969151"/>
      <value value="9352337"/>
      <value value="5735597"/>
      <value value="9740098"/>
      <value value="6453022"/>
      <value value="8306779"/>
      <value value="8715316"/>
      <value value="9522523"/>
      <value value="9657738"/>
      <value value="9908211"/>
      <value value="2654944"/>
      <value value="8559222"/>
      <value value="6567362"/>
      <value value="2751769"/>
      <value value="396621"/>
      <value value="1483581"/>
      <value value="32402"/>
      <value value="3822247"/>
      <value value="8958221"/>
      <value value="937188"/>
      <value value="1039059"/>
      <value value="5097786"/>
      <value value="6278951"/>
      <value value="1309600"/>
      <value value="6703196"/>
      <value value="8939261"/>
      <value value="4821767"/>
      <value value="2471097"/>
      <value value="6537095"/>
      <value value="3667384"/>
      <value value="8028515"/>
      <value value="8340866"/>
      <value value="5934440"/>
      <value value="3253208"/>
      <value value="777066"/>
      <value value="5723836"/>
      <value value="2428532"/>
      <value value="8121916"/>
      <value value="3701025"/>
      <value value="5041625"/>
      <value value="9335052"/>
      <value value="5434794"/>
      <value value="5189972"/>
      <value value="4836322"/>
      <value value="6066927"/>
      <value value="7640580"/>
      <value value="5486069"/>
      <value value="8389908"/>
      <value value="2823544"/>
      <value value="5585871"/>
      <value value="6228543"/>
      <value value="1609473"/>
      <value value="8579159"/>
      <value value="5688294"/>
      <value value="8240993"/>
      <value value="6594060"/>
      <value value="6992555"/>
      <value value="9741072"/>
      <value value="1941678"/>
      <value value="555757"/>
      <value value="1844553"/>
      <value value="6754280"/>
      <value value="8881561"/>
      <value value="4817142"/>
      <value value="9891754"/>
      <value value="1658446"/>
      <value value="2543258"/>
      <value value="8924713"/>
      <value value="7855251"/>
      <value value="6869314"/>
      <value value="7418197"/>
      <value value="1675210"/>
      <value value="2573097"/>
      <value value="51843"/>
      <value value="7907833"/>
      <value value="2813145"/>
      <value value="5396420"/>
      <value value="4681786"/>
      <value value="2150578"/>
      <value value="4593924"/>
      <value value="1584362"/>
      <value value="5177277"/>
      <value value="3887527"/>
      <value value="5452223"/>
      <value value="6254341"/>
      <value value="3802872"/>
      <value value="833284"/>
      <value value="8521913"/>
      <value value="2857270"/>
      <value value="9620423"/>
      <value value="1048171"/>
      <value value="1103079"/>
      <value value="1419223"/>
      <value value="3464447"/>
      <value value="4438869"/>
      <value value="2589894"/>
      <value value="3044964"/>
      <value value="2756327"/>
      <value value="9862885"/>
      <value value="214424"/>
      <value value="8480340"/>
      <value value="7457935"/>
      <value value="9604190"/>
      <value value="8041181"/>
      <value value="9800830"/>
      <value value="4315272"/>
      <value value="333784"/>
      <value value="7866179"/>
      <value value="9512530"/>
      <value value="8072626"/>
      <value value="8987686"/>
      <value value="20390"/>
      <value value="1918602"/>
      <value value="2825998"/>
      <value value="1501811"/>
      <value value="3401517"/>
      <value value="2197776"/>
      <value value="5482746"/>
      <value value="9693541"/>
      <value value="7804111"/>
      <value value="1138145"/>
      <value value="5762583"/>
      <value value="4086393"/>
      <value value="1329028"/>
      <value value="5263797"/>
      <value value="9161100"/>
      <value value="4166651"/>
      <value value="8826243"/>
      <value value="6502438"/>
      <value value="3556381"/>
      <value value="2785446"/>
      <value value="5252943"/>
      <value value="9799763"/>
      <value value="1553469"/>
      <value value="5625654"/>
      <value value="9865393"/>
      <value value="8338723"/>
      <value value="1130643"/>
      <value value="9455605"/>
      <value value="3997935"/>
      <value value="467633"/>
      <value value="7677036"/>
      <value value="6968866"/>
      <value value="8390103"/>
      <value value="8215427"/>
      <value value="7667677"/>
      <value value="5963232"/>
      <value value="8880711"/>
      <value value="6582769"/>
      <value value="3909877"/>
      <value value="5092173"/>
      <value value="6040331"/>
      <value value="4072880"/>
      <value value="8118637"/>
      <value value="6997672"/>
      <value value="1505179"/>
      <value value="9881676"/>
      <value value="6559721"/>
      <value value="5306299"/>
      <value value="8673459"/>
      <value value="3875134"/>
      <value value="2991769"/>
      <value value="224207"/>
      <value value="9272403"/>
      <value value="1722328"/>
      <value value="8952295"/>
      <value value="3756505"/>
      <value value="276236"/>
      <value value="4273195"/>
      <value value="379304"/>
      <value value="9920132"/>
      <value value="1816437"/>
      <value value="7908771"/>
      <value value="3819354"/>
      <value value="3564609"/>
      <value value="544211"/>
      <value value="6063788"/>
      <value value="6701781"/>
      <value value="9665418"/>
      <value value="7232875"/>
      <value value="8458436"/>
      <value value="6361362"/>
      <value value="3469469"/>
      <value value="6344534"/>
      <value value="8299269"/>
      <value value="3392714"/>
      <value value="2685186"/>
      <value value="6752641"/>
      <value value="2491995"/>
      <value value="3507810"/>
      <value value="1354323"/>
      <value value="7787557"/>
      <value value="1027633"/>
      <value value="2033872"/>
      <value value="5570386"/>
      <value value="2420017"/>
      <value value="8672624"/>
      <value value="2670679"/>
      <value value="730547"/>
      <value value="3740497"/>
      <value value="7173947"/>
      <value value="699165"/>
      <value value="9256578"/>
      <value value="1269915"/>
      <value value="733328"/>
      <value value="8463350"/>
      <value value="6892291"/>
      <value value="5419464"/>
      <value value="3444333"/>
      <value value="1663332"/>
      <value value="149452"/>
      <value value="2909465"/>
      <value value="1712800"/>
      <value value="4122150"/>
      <value value="1093354"/>
      <value value="5083443"/>
      <value value="3452301"/>
      <value value="9572617"/>
      <value value="4594874"/>
      <value value="952027"/>
      <value value="5496299"/>
      <value value="4926110"/>
      <value value="5330973"/>
      <value value="3267010"/>
      <value value="1144897"/>
      <value value="208674"/>
      <value value="3033160"/>
      <value value="5555300"/>
      <value value="2469175"/>
      <value value="4635854"/>
      <value value="3136727"/>
      <value value="5820732"/>
      <value value="921067"/>
      <value value="9111926"/>
      <value value="7624419"/>
      <value value="1820936"/>
      <value value="2207716"/>
      <value value="1218010"/>
      <value value="9686095"/>
      <value value="1983582"/>
      <value value="566301"/>
      <value value="4609596"/>
      <value value="2835552"/>
      <value value="3488190"/>
      <value value="513251"/>
      <value value="5093606"/>
      <value value="4499152"/>
      <value value="5365188"/>
      <value value="7192387"/>
      <value value="6181862"/>
      <value value="2450864"/>
      <value value="9588471"/>
      <value value="9151460"/>
      <value value="8156780"/>
      <value value="1581792"/>
      <value value="7097750"/>
      <value value="575297"/>
      <value value="8408679"/>
      <value value="9202163"/>
      <value value="5933907"/>
      <value value="8839579"/>
      <value value="464971"/>
      <value value="3407571"/>
      <value value="8835900"/>
      <value value="5091286"/>
      <value value="6838277"/>
      <value value="3417860"/>
      <value value="2019813"/>
      <value value="7851191"/>
      <value value="5476933"/>
      <value value="3316918"/>
      <value value="1273478"/>
      <value value="3742623"/>
      <value value="8028460"/>
      <value value="4401309"/>
      <value value="8547199"/>
      <value value="6473306"/>
      <value value="1297949"/>
      <value value="4496255"/>
      <value value="688575"/>
      <value value="9962042"/>
      <value value="8776978"/>
      <value value="1224500"/>
      <value value="8758295"/>
      <value value="9285011"/>
      <value value="2533224"/>
      <value value="3427388"/>
      <value value="5907290"/>
      <value value="135931"/>
      <value value="3757367"/>
      <value value="1205005"/>
      <value value="2676542"/>
      <value value="4712341"/>
      <value value="6968716"/>
      <value value="2888953"/>
      <value value="4107470"/>
      <value value="2323682"/>
      <value value="1108231"/>
      <value value="7310922"/>
      <value value="9096579"/>
      <value value="3064909"/>
      <value value="7442193"/>
      <value value="7116257"/>
      <value value="8108329"/>
      <value value="3849541"/>
      <value value="8700594"/>
      <value value="6623878"/>
      <value value="2097038"/>
      <value value="9266462"/>
      <value value="5833474"/>
      <value value="8795463"/>
      <value value="1416495"/>
      <value value="3028845"/>
      <value value="7879839"/>
      <value value="8308939"/>
      <value value="8586849"/>
      <value value="4548199"/>
      <value value="6095155"/>
      <value value="3188540"/>
      <value value="5024480"/>
      <value value="3315482"/>
      <value value="1039853"/>
      <value value="377225"/>
      <value value="6628637"/>
      <value value="1424582"/>
      <value value="8610725"/>
      <value value="7974062"/>
      <value value="1089980"/>
      <value value="5003535"/>
      <value value="3478741"/>
      <value value="6739651"/>
      <value value="4834940"/>
      <value value="1287519"/>
      <value value="9207544"/>
      <value value="3097503"/>
      <value value="9098799"/>
      <value value="8309480"/>
      <value value="7476219"/>
      <value value="6555306"/>
      <value value="4856804"/>
      <value value="9399078"/>
      <value value="2019999"/>
      <value value="3973755"/>
      <value value="7445491"/>
      <value value="3266073"/>
      <value value="8458820"/>
      <value value="9975364"/>
      <value value="3876309"/>
      <value value="4115797"/>
      <value value="373800"/>
      <value value="409262"/>
      <value value="248003"/>
      <value value="8233166"/>
      <value value="434680"/>
      <value value="1756013"/>
      <value value="3572076"/>
      <value value="1230686"/>
      <value value="7586669"/>
      <value value="3071941"/>
      <value value="7898896"/>
      <value value="1646608"/>
      <value value="3913952"/>
      <value value="6048972"/>
      <value value="5610138"/>
      <value value="2022074"/>
      <value value="2413147"/>
      <value value="4980986"/>
      <value value="9907742"/>
      <value value="298524"/>
      <value value="722838"/>
      <value value="301945"/>
      <value value="1781720"/>
      <value value="4968101"/>
      <value value="8929229"/>
      <value value="2758235"/>
      <value value="1435177"/>
      <value value="9555928"/>
      <value value="2770910"/>
      <value value="2845784"/>
      <value value="4498938"/>
      <value value="7632291"/>
      <value value="2712511"/>
      <value value="5474329"/>
      <value value="1700131"/>
      <value value="5001211"/>
      <value value="4670960"/>
      <value value="3147362"/>
      <value value="9014411"/>
      <value value="8049593"/>
      <value value="6736952"/>
      <value value="3019836"/>
      <value value="4271814"/>
      <value value="488941"/>
      <value value="6995644"/>
      <value value="2042327"/>
      <value value="2391282"/>
      <value value="589683"/>
      <value value="9650446"/>
      <value value="5625440"/>
      <value value="7471937"/>
      <value value="6734515"/>
      <value value="2800805"/>
      <value value="6350422"/>
      <value value="5581228"/>
      <value value="3762410"/>
      <value value="1040605"/>
      <value value="7886180"/>
      <value value="3006050"/>
      <value value="1951454"/>
      <value value="2428897"/>
      <value value="5871721"/>
      <value value="5759472"/>
      <value value="3115908"/>
      <value value="8132069"/>
      <value value="6142266"/>
      <value value="7525842"/>
      <value value="4426406"/>
      <value value="197135"/>
      <value value="4367492"/>
      <value value="5738801"/>
      <value value="6155191"/>
      <value value="1777202"/>
      <value value="9344268"/>
      <value value="4994128"/>
      <value value="6027065"/>
      <value value="4767272"/>
      <value value="9397340"/>
      <value value="7953998"/>
      <value value="2734736"/>
      <value value="4919590"/>
      <value value="9038476"/>
      <value value="1824937"/>
      <value value="8541553"/>
      <value value="8145837"/>
      <value value="9313562"/>
      <value value="3476999"/>
      <value value="9688716"/>
      <value value="9237216"/>
      <value value="6718677"/>
      <value value="5732463"/>
      <value value="5194456"/>
      <value value="986760"/>
      <value value="4883931"/>
      <value value="2170052"/>
      <value value="7934305"/>
      <value value="7882690"/>
      <value value="4908441"/>
      <value value="6264591"/>
      <value value="1067283"/>
      <value value="4316148"/>
      <value value="7557135"/>
      <value value="18416"/>
      <value value="1214213"/>
      <value value="1803405"/>
      <value value="9385301"/>
      <value value="6807789"/>
      <value value="5577785"/>
      <value value="5522773"/>
      <value value="1872292"/>
      <value value="3953210"/>
      <value value="8367907"/>
      <value value="9554285"/>
      <value value="329948"/>
      <value value="4112293"/>
      <value value="4908429"/>
      <value value="9495592"/>
      <value value="5542536"/>
      <value value="2175137"/>
      <value value="1289637"/>
      <value value="5713522"/>
      <value value="3517433"/>
      <value value="5437182"/>
      <value value="8926141"/>
      <value value="8652058"/>
      <value value="7012122"/>
      <value value="7038975"/>
      <value value="9835989"/>
      <value value="7131489"/>
      <value value="5618799"/>
      <value value="5075411"/>
      <value value="4466420"/>
      <value value="5832253"/>
      <value value="3110458"/>
      <value value="9115675"/>
      <value value="1112980"/>
      <value value="3028339"/>
      <value value="75700"/>
      <value value="6825245"/>
      <value value="8130359"/>
      <value value="3606721"/>
      <value value="2965267"/>
      <value value="2016461"/>
      <value value="9043943"/>
      <value value="3399014"/>
      <value value="6439771"/>
      <value value="6466210"/>
      <value value="1100199"/>
      <value value="6752984"/>
      <value value="8551007"/>
      <value value="8049786"/>
      <value value="7308780"/>
      <value value="6874433"/>
      <value value="8964114"/>
      <value value="7994761"/>
      <value value="571264"/>
      <value value="8904921"/>
      <value value="6811249"/>
      <value value="562264"/>
      <value value="3691314"/>
      <value value="1314549"/>
      <value value="6423773"/>
      <value value="5021399"/>
      <value value="4968657"/>
      <value value="396758"/>
      <value value="7853368"/>
      <value value="3592655"/>
      <value value="3156551"/>
      <value value="1684171"/>
      <value value="9901220"/>
      <value value="4270840"/>
      <value value="1497998"/>
      <value value="9207061"/>
      <value value="4255310"/>
      <value value="7935897"/>
      <value value="5952303"/>
      <value value="9705267"/>
      <value value="2227283"/>
      <value value="5610369"/>
      <value value="9767365"/>
      <value value="5927268"/>
      <value value="8371983"/>
      <value value="885479"/>
      <value value="8949750"/>
      <value value="5442782"/>
      <value value="925399"/>
      <value value="7271288"/>
      <value value="5563765"/>
      <value value="6153298"/>
      <value value="6145049"/>
      <value value="1397183"/>
      <value value="6607269"/>
      <value value="96198"/>
      <value value="1830421"/>
      <value value="3898353"/>
      <value value="1871187"/>
      <value value="7848173"/>
      <value value="5006847"/>
      <value value="7231956"/>
      <value value="1291334"/>
      <value value="8594172"/>
      <value value="9828517"/>
      <value value="8848278"/>
      <value value="1247968"/>
      <value value="7332478"/>
      <value value="3304128"/>
      <value value="3904881"/>
      <value value="1486397"/>
      <value value="7227616"/>
      <value value="2643906"/>
      <value value="898026"/>
      <value value="5985083"/>
      <value value="1146540"/>
      <value value="291111"/>
      <value value="6327995"/>
      <value value="4346615"/>
      <value value="4900153"/>
      <value value="442621"/>
      <value value="1761541"/>
      <value value="1196326"/>
      <value value="2195338"/>
      <value value="161217"/>
      <value value="5327762"/>
      <value value="8154894"/>
      <value value="6693828"/>
      <value value="9198478"/>
      <value value="5148639"/>
      <value value="3514796"/>
      <value value="4954368"/>
      <value value="7618737"/>
      <value value="1023459"/>
      <value value="7103606"/>
      <value value="7250347"/>
      <value value="6215359"/>
      <value value="4349350"/>
      <value value="5763220"/>
      <value value="2882392"/>
      <value value="7742573"/>
      <value value="7301932"/>
      <value value="8738541"/>
      <value value="6968301"/>
      <value value="8915584"/>
      <value value="2474163"/>
      <value value="4022147"/>
      <value value="6657600"/>
      <value value="4355215"/>
      <value value="4377084"/>
      <value value="3315632"/>
      <value value="1578781"/>
      <value value="9910480"/>
      <value value="5346159"/>
      <value value="8989815"/>
      <value value="3497735"/>
      <value value="8935951"/>
      <value value="7421329"/>
      <value value="5084836"/>
      <value value="142488"/>
      <value value="5373072"/>
      <value value="4155445"/>
      <value value="7703351"/>
      <value value="1646616"/>
      <value value="5601535"/>
      <value value="9085160"/>
      <value value="9838639"/>
      <value value="1403920"/>
      <value value="6196720"/>
      <value value="5170427"/>
      <value value="5310150"/>
      <value value="6416521"/>
      <value value="6034347"/>
      <value value="5671388"/>
      <value value="7520672"/>
      <value value="7036222"/>
      <value value="4512536"/>
      <value value="5642779"/>
      <value value="2904780"/>
      <value value="1935148"/>
      <value value="9692605"/>
      <value value="9476230"/>
      <value value="1638103"/>
      <value value="1775989"/>
      <value value="3583722"/>
      <value value="2696237"/>
      <value value="9419816"/>
      <value value="159670"/>
      <value value="4556681"/>
      <value value="6798159"/>
      <value value="2080300"/>
      <value value="6771815"/>
      <value value="6871182"/>
      <value value="5862473"/>
      <value value="4849364"/>
      <value value="917246"/>
      <value value="5467704"/>
      <value value="3949862"/>
      <value value="9377840"/>
      <value value="4139347"/>
      <value value="8346271"/>
      <value value="5306370"/>
      <value value="4453834"/>
      <value value="7541791"/>
      <value value="2072313"/>
      <value value="8262665"/>
      <value value="333524"/>
      <value value="7800597"/>
      <value value="1488738"/>
      <value value="178297"/>
      <value value="4159146"/>
      <value value="2239863"/>
      <value value="6473974"/>
      <value value="8243989"/>
      <value value="9865258"/>
      <value value="1522610"/>
      <value value="6026409"/>
      <value value="4991511"/>
      <value value="1806774"/>
      <value value="9277217"/>
      <value value="6746685"/>
      <value value="8679400"/>
      <value value="3714211"/>
      <value value="5873020"/>
      <value value="5801649"/>
      <value value="767707"/>
      <value value="5893529"/>
      <value value="9635601"/>
      <value value="9325266"/>
      <value value="209095"/>
      <value value="1902866"/>
      <value value="5761065"/>
      <value value="4806893"/>
      <value value="6897711"/>
      <value value="9486226"/>
      <value value="9140788"/>
      <value value="6617195"/>
      <value value="4135982"/>
      <value value="2974096"/>
      <value value="6140481"/>
      <value value="4290300"/>
      <value value="5187731"/>
      <value value="8927758"/>
      <value value="8007482"/>
      <value value="1473820"/>
      <value value="6761269"/>
      <value value="6004787"/>
      <value value="9889288"/>
      <value value="6938783"/>
      <value value="6775848"/>
      <value value="4994828"/>
      <value value="2424475"/>
      <value value="7620948"/>
      <value value="2134892"/>
      <value value="3499755"/>
      <value value="7786360"/>
      <value value="7932489"/>
      <value value="6484955"/>
      <value value="1633020"/>
      <value value="1874121"/>
      <value value="8225333"/>
      <value value="2396858"/>
      <value value="5509256"/>
      <value value="7451767"/>
      <value value="571950"/>
      <value value="9632219"/>
      <value value="4385726"/>
      <value value="7541170"/>
      <value value="2998697"/>
      <value value="8843358"/>
      <value value="1015907"/>
      <value value="9049465"/>
      <value value="6771118"/>
      <value value="2434786"/>
      <value value="1048136"/>
      <value value="8622868"/>
      <value value="9190038"/>
      <value value="4057847"/>
      <value value="6307174"/>
      <value value="6062684"/>
      <value value="5791543"/>
      <value value="8805369"/>
      <value value="8298230"/>
      <value value="7600280"/>
      <value value="7430720"/>
      <value value="5541407"/>
      <value value="9901337"/>
      <value value="566501"/>
      <value value="3107923"/>
      <value value="2273773"/>
      <value value="8476944"/>
      <value value="3324364"/>
      <value value="7318130"/>
      <value value="5896119"/>
      <value value="3787201"/>
      <value value="7320127"/>
      <value value="3014359"/>
      <value value="3583572"/>
      <value value="5513070"/>
      <value value="3102515"/>
      <value value="5025043"/>
      <value value="8622135"/>
      <value value="9896666"/>
      <value value="3609868"/>
      <value value="2058580"/>
      <value value="5521025"/>
      <value value="4520068"/>
      <value value="8811621"/>
      <value value="9591849"/>
      <value value="518913"/>
      <value value="9373406"/>
      <value value="2696392"/>
      <value value="2692652"/>
      <value value="1760345"/>
      <value value="6479022"/>
      <value value="9834694"/>
      <value value="1192537"/>
      <value value="9982296"/>
      <value value="9212942"/>
      <value value="5071300"/>
      <value value="5218451"/>
      <value value="4761012"/>
      <value value="8828573"/>
      <value value="5943323"/>
      <value value="8691229"/>
      <value value="5932862"/>
      <value value="1082354"/>
      <value value="7438216"/>
      <value value="5521650"/>
      <value value="1403212"/>
      <value value="2109495"/>
      <value value="1385290"/>
      <value value="8096592"/>
      <value value="7125928"/>
      <value value="3658003"/>
      <value value="5474869"/>
      <value value="5095159"/>
      <value value="5294954"/>
      <value value="1352911"/>
      <value value="9588303"/>
      <value value="7854247"/>
      <value value="7436114"/>
      <value value="1502574"/>
      <value value="5669460"/>
      <value value="4618107"/>
      <value value="5127652"/>
      <value value="7210507"/>
      <value value="9201827"/>
      <value value="6332217"/>
      <value value="5815775"/>
      <value value="7559172"/>
      <value value="7683237"/>
      <value value="757664"/>
      <value value="4431427"/>
      <value value="6231956"/>
      <value value="592873"/>
      <value value="4440905"/>
      <value value="6829317"/>
      <value value="2752473"/>
      <value value="8230684"/>
      <value value="5806305"/>
      <value value="508848"/>
      <value value="3260509"/>
      <value value="5168333"/>
      <value value="3268966"/>
      <value value="4100988"/>
      <value value="5984226"/>
      <value value="7425996"/>
      <value value="3669197"/>
      <value value="1230127"/>
      <value value="7816285"/>
      <value value="9170598"/>
      <value value="2405187"/>
      <value value="9207946"/>
      <value value="7052959"/>
      <value value="1692463"/>
      <value value="8604249"/>
      <value value="1839870"/>
      <value value="3968926"/>
      <value value="3703732"/>
      <value value="5595939"/>
      <value value="3064392"/>
      <value value="6103773"/>
      <value value="904346"/>
      <value value="1408212"/>
      <value value="305875"/>
      <value value="8337098"/>
      <value value="2746838"/>
      <value value="5273021"/>
      <value value="2308988"/>
      <value value="5476962"/>
      <value value="6607721"/>
      <value value="6007265"/>
      <value value="2852569"/>
      <value value="435831"/>
      <value value="4013550"/>
      <value value="2879984"/>
      <value value="7465164"/>
      <value value="3599076"/>
      <value value="2746661"/>
      <value value="3748023"/>
      <value value="170382"/>
      <value value="9541598"/>
      <value value="7619769"/>
      <value value="8378723"/>
      <value value="9620451"/>
      <value value="8027254"/>
      <value value="6165559"/>
      <value value="6906440"/>
      <value value="5744991"/>
      <value value="5590033"/>
      <value value="8589488"/>
      <value value="785769"/>
      <value value="3704796"/>
      <value value="603499"/>
      <value value="4710574"/>
      <value value="5813702"/>
      <value value="2360904"/>
      <value value="7428562"/>
      <value value="9540417"/>
      <value value="7669055"/>
      <value value="3161272"/>
      <value value="5046263"/>
      <value value="4088707"/>
      <value value="989471"/>
      <value value="6744286"/>
      <value value="7039877"/>
      <value value="8312717"/>
      <value value="9189351"/>
      <value value="6675318"/>
      <value value="8820267"/>
      <value value="2907488"/>
      <value value="343483"/>
      <value value="1107610"/>
      <value value="9365220"/>
      <value value="9518233"/>
      <value value="1785349"/>
      <value value="9506784"/>
      <value value="9540777"/>
      <value value="5216468"/>
      <value value="5585708"/>
      <value value="1195000"/>
      <value value="1784184"/>
      <value value="8077132"/>
      <value value="8800924"/>
      <value value="9463601"/>
      <value value="6284550"/>
      <value value="9105149"/>
      <value value="7591593"/>
      <value value="3202862"/>
      <value value="6576424"/>
      <value value="2703588"/>
      <value value="1018282"/>
      <value value="652919"/>
      <value value="4895207"/>
      <value value="479851"/>
      <value value="9230839"/>
      <value value="5104171"/>
      <value value="6881167"/>
      <value value="1593439"/>
      <value value="5566756"/>
      <value value="4005406"/>
      <value value="4995069"/>
      <value value="528355"/>
      <value value="9398629"/>
      <value value="8272266"/>
      <value value="6049698"/>
      <value value="6259526"/>
      <value value="6405254"/>
      <value value="9005327"/>
      <value value="3712749"/>
      <value value="1014105"/>
      <value value="1424936"/>
      <value value="8673935"/>
      <value value="6546150"/>
      <value value="4736335"/>
      <value value="6352394"/>
      <value value="9805449"/>
      <value value="5831417"/>
      <value value="2754506"/>
      <value value="1699297"/>
      <value value="6334411"/>
      <value value="2392690"/>
      <value value="3684541"/>
      <value value="8115764"/>
      <value value="7555956"/>
      <value value="1546678"/>
      <value value="4467947"/>
      <value value="2045679"/>
      <value value="9405152"/>
      <value value="4600960"/>
      <value value="7411504"/>
      <value value="3992229"/>
      <value value="1892256"/>
      <value value="4126375"/>
      <value value="1104794"/>
      <value value="1636986"/>
      <value value="3080828"/>
      <value value="3251916"/>
      <value value="431826"/>
      <value value="252078"/>
      <value value="4836969"/>
      <value value="2590283"/>
      <value value="3969997"/>
      <value value="2660140"/>
      <value value="998157"/>
      <value value="2135857"/>
      <value value="5458543"/>
      <value value="864091"/>
      <value value="9853930"/>
      <value value="4866884"/>
      <value value="4541267"/>
      <value value="5566217"/>
      <value value="7772266"/>
      <value value="4011093"/>
      <value value="110603"/>
      <value value="5422612"/>
      <value value="1312189"/>
      <value value="9282210"/>
      <value value="4220969"/>
      <value value="968772"/>
      <value value="8452132"/>
      <value value="7542042"/>
      <value value="3443812"/>
      <value value="5339273"/>
      <value value="1674037"/>
      <value value="6502752"/>
      <value value="3192604"/>
      <value value="9097053"/>
      <value value="9061978"/>
      <value value="6812347"/>
      <value value="5187979"/>
      <value value="7219614"/>
      <value value="7255105"/>
      <value value="5524337"/>
      <value value="84917"/>
      <value value="2019300"/>
      <value value="1085523"/>
      <value value="8051726"/>
      <value value="4538099"/>
      <value value="5074030"/>
      <value value="2019813"/>
      <value value="468233"/>
      <value value="94284"/>
      <value value="3640696"/>
      <value value="4424076"/>
      <value value="563707"/>
      <value value="2016405"/>
      <value value="7842687"/>
      <value value="1346751"/>
      <value value="6904179"/>
      <value value="5683719"/>
      <value value="7736546"/>
      <value value="3230955"/>
      <value value="2934985"/>
      <value value="528782"/>
      <value value="3183511"/>
      <value value="5791671"/>
      <value value="1590034"/>
      <value value="1404892"/>
      <value value="9203009"/>
      <value value="336753"/>
      <value value="4840644"/>
      <value value="1057393"/>
      <value value="6315539"/>
      <value value="3312737"/>
      <value value="8403987"/>
      <value value="2416348"/>
      <value value="5553803"/>
      <value value="1319129"/>
      <value value="2252286"/>
      <value value="6044962"/>
      <value value="6635969"/>
      <value value="3354327"/>
      <value value="2234598"/>
      <value value="2801976"/>
      <value value="3204659"/>
      <value value="6125401"/>
      <value value="142602"/>
      <value value="887938"/>
      <value value="5837231"/>
      <value value="6244826"/>
      <value value="1759799"/>
      <value value="862988"/>
      <value value="2795004"/>
      <value value="4568716"/>
      <value value="6528130"/>
      <value value="5992272"/>
      <value value="246877"/>
      <value value="7439886"/>
      <value value="1289891"/>
      <value value="4250162"/>
      <value value="5977749"/>
      <value value="4258296"/>
      <value value="8815699"/>
      <value value="7512984"/>
      <value value="9524177"/>
      <value value="9184668"/>
      <value value="6292089"/>
      <value value="2833128"/>
      <value value="198803"/>
      <value value="5579034"/>
      <value value="3220057"/>
      <value value="1561161"/>
      <value value="2732222"/>
      <value value="4260458"/>
      <value value="6346916"/>
      <value value="8373138"/>
      <value value="5508271"/>
      <value value="3705426"/>
      <value value="6982686"/>
      <value value="934896"/>
      <value value="3400642"/>
      <value value="8259350"/>
      <value value="8396309"/>
      <value value="4666127"/>
      <value value="3871951"/>
      <value value="9814973"/>
      <value value="2042165"/>
      <value value="2243520"/>
      <value value="984212"/>
      <value value="5544106"/>
      <value value="5978675"/>
      <value value="806979"/>
      <value value="6082692"/>
      <value value="5004622"/>
      <value value="1655662"/>
      <value value="6728379"/>
      <value value="3279636"/>
      <value value="486824"/>
      <value value="8478145"/>
      <value value="5873890"/>
      <value value="2320349"/>
      <value value="4490126"/>
      <value value="4032799"/>
      <value value="6804474"/>
      <value value="7216637"/>
      <value value="1027108"/>
      <value value="6561875"/>
      <value value="1853794"/>
      <value value="3998243"/>
      <value value="945239"/>
      <value value="566153"/>
      <value value="3031700"/>
      <value value="2426080"/>
      <value value="557452"/>
      <value value="5017043"/>
      <value value="1363236"/>
      <value value="2710503"/>
      <value value="6483263"/>
      <value value="7500033"/>
      <value value="1294236"/>
      <value value="2175902"/>
      <value value="3086926"/>
      <value value="5856542"/>
      <value value="2491316"/>
      <value value="2751618"/>
      <value value="3660756"/>
      <value value="9346514"/>
      <value value="4548729"/>
      <value value="3443221"/>
      <value value="6722593"/>
      <value value="7638656"/>
      <value value="7963599"/>
      <value value="2480119"/>
      <value value="2928699"/>
      <value value="5881401"/>
      <value value="4186916"/>
      <value value="2084297"/>
      <value value="2883511"/>
      <value value="7443490"/>
      <value value="2473195"/>
      <value value="1373914"/>
      <value value="7458064"/>
      <value value="6776351"/>
      <value value="8253550"/>
      <value value="4825127"/>
      <value value="8159742"/>
      <value value="6659831"/>
      <value value="6857120"/>
      <value value="3308766"/>
      <value value="9350949"/>
      <value value="5619938"/>
      <value value="5491968"/>
      <value value="8401947"/>
      <value value="9128755"/>
      <value value="2673975"/>
      <value value="1230810"/>
      <value value="5779703"/>
      <value value="4820224"/>
      <value value="2577278"/>
      <value value="9089679"/>
      <value value="2906798"/>
      <value value="9671977"/>
      <value value="9821560"/>
      <value value="6143800"/>
      <value value="6343309"/>
      <value value="6812065"/>
      <value value="3233587"/>
      <value value="494111"/>
      <value value="8260286"/>
      <value value="9449967"/>
      <value value="9751730"/>
      <value value="4539902"/>
      <value value="2969757"/>
      <value value="6438160"/>
      <value value="575520"/>
      <value value="3372157"/>
      <value value="3718106"/>
      <value value="7436255"/>
      <value value="1898722"/>
      <value value="1145843"/>
      <value value="1630448"/>
      <value value="537324"/>
      <value value="5512198"/>
      <value value="3040366"/>
      <value value="3538097"/>
      <value value="3516910"/>
      <value value="6568536"/>
      <value value="16026"/>
      <value value="7481582"/>
      <value value="2335207"/>
      <value value="891287"/>
      <value value="7044810"/>
      <value value="8211846"/>
      <value value="9937276"/>
      <value value="5055440"/>
      <value value="4619070"/>
      <value value="489086"/>
      <value value="4613096"/>
      <value value="5284796"/>
      <value value="8562559"/>
      <value value="6157659"/>
      <value value="5842385"/>
      <value value="9212997"/>
      <value value="7350256"/>
      <value value="7203912"/>
      <value value="9615901"/>
      <value value="5880868"/>
      <value value="5291745"/>
      <value value="6213349"/>
      <value value="3085664"/>
      <value value="8388013"/>
      <value value="2557898"/>
      <value value="4618959"/>
      <value value="3285854"/>
      <value value="5560206"/>
      <value value="7841926"/>
      <value value="708262"/>
      <value value="706862"/>
      <value value="182019"/>
      <value value="9848018"/>
      <value value="4170400"/>
      <value value="1999271"/>
      <value value="9735192"/>
      <value value="6446446"/>
      <value value="7366531"/>
      <value value="5905961"/>
      <value value="6089201"/>
      <value value="6220118"/>
      <value value="6844667"/>
      <value value="1253678"/>
      <value value="8759961"/>
      <value value="4004913"/>
      <value value="7706964"/>
      <value value="2323394"/>
      <value value="3689280"/>
      <value value="488753"/>
      <value value="3102259"/>
      <value value="8775321"/>
      <value value="1413296"/>
      <value value="4621222"/>
      <value value="6671814"/>
      <value value="427500"/>
      <value value="2369909"/>
      <value value="1005099"/>
      <value value="1935616"/>
      <value value="9529334"/>
      <value value="2011023"/>
      <value value="5176926"/>
      <value value="4764166"/>
      <value value="8192091"/>
      <value value="3369256"/>
      <value value="1872784"/>
      <value value="397826"/>
      <value value="174589"/>
      <value value="6948498"/>
      <value value="2593736"/>
      <value value="3160818"/>
      <value value="5325402"/>
      <value value="519195"/>
      <value value="5560643"/>
      <value value="260695"/>
      <value value="1902293"/>
      <value value="4648290"/>
      <value value="9047887"/>
      <value value="1243388"/>
      <value value="7425017"/>
      <value value="3385026"/>
      <value value="4007451"/>
      <value value="8304304"/>
      <value value="4096747"/>
      <value value="828803"/>
      <value value="8520142"/>
      <value value="9071525"/>
      <value value="6003522"/>
      <value value="2031274"/>
      <value value="2022905"/>
      <value value="2237064"/>
      <value value="4846799"/>
      <value value="1863753"/>
      <value value="1053807"/>
      <value value="8255307"/>
      <value value="378616"/>
      <value value="3234390"/>
      <value value="2730857"/>
      <value value="1516011"/>
      <value value="4517192"/>
      <value value="7542966"/>
      <value value="4553040"/>
      <value value="6178437"/>
      <value value="4263025"/>
      <value value="9728187"/>
      <value value="3232180"/>
      <value value="6130293"/>
      <value value="9370684"/>
      <value value="7223840"/>
      <value value="696092"/>
      <value value="6921731"/>
      <value value="9946039"/>
      <value value="7958734"/>
      <value value="5461803"/>
      <value value="4956467"/>
      <value value="4543294"/>
      <value value="4522408"/>
      <value value="2595874"/>
      <value value="7766673"/>
      <value value="877302"/>
      <value value="5449579"/>
      <value value="4377067"/>
      <value value="912774"/>
      <value value="3112757"/>
      <value value="2985561"/>
      <value value="5449627"/>
      <value value="1414875"/>
      <value value="2386732"/>
      <value value="9167080"/>
      <value value="8126435"/>
      <value value="9627639"/>
      <value value="4005038"/>
      <value value="2106328"/>
      <value value="1129674"/>
      <value value="1130925"/>
      <value value="6169929"/>
      <value value="9682653"/>
      <value value="6420165"/>
      <value value="1545330"/>
      <value value="7071562"/>
      <value value="1788595"/>
      <value value="8527212"/>
      <value value="4659679"/>
      <value value="502376"/>
      <value value="4508745"/>
      <value value="2241968"/>
      <value value="8248467"/>
      <value value="2664430"/>
      <value value="1512310"/>
      <value value="5631646"/>
      <value value="6955190"/>
      <value value="3814894"/>
      <value value="9465166"/>
      <value value="4069998"/>
      <value value="1853714"/>
      <value value="9374981"/>
      <value value="4023849"/>
      <value value="9122283"/>
      <value value="2407836"/>
      <value value="5020780"/>
      <value value="728949"/>
      <value value="4477785"/>
      <value value="9170009"/>
      <value value="9679924"/>
      <value value="6261169"/>
      <value value="9252701"/>
      <value value="5054629"/>
      <value value="4463159"/>
      <value value="8286481"/>
      <value value="1124215"/>
      <value value="4455239"/>
      <value value="9764547"/>
      <value value="9720686"/>
      <value value="2461146"/>
      <value value="2332175"/>
      <value value="9388888"/>
      <value value="8593457"/>
      <value value="3623395"/>
      <value value="1410368"/>
      <value value="7857675"/>
      <value value="7569054"/>
      <value value="4300120"/>
      <value value="2294620"/>
      <value value="649741"/>
      <value value="393614"/>
      <value value="9418770"/>
      <value value="1578443"/>
      <value value="5857512"/>
      <value value="1599729"/>
      <value value="3041485"/>
      <value value="1953276"/>
      <value value="1692453"/>
      <value value="6752403"/>
      <value value="7919179"/>
      <value value="8750268"/>
      <value value="7047048"/>
      <value value="2334835"/>
      <value value="19440"/>
      <value value="1481641"/>
      <value value="4944779"/>
      <value value="7774919"/>
      <value value="6582246"/>
      <value value="9209062"/>
      <value value="2695089"/>
      <value value="9270444"/>
      <value value="9931371"/>
      <value value="6535742"/>
      <value value="8876432"/>
      <value value="5829291"/>
      <value value="3697776"/>
      <value value="7419258"/>
      <value value="7982427"/>
      <value value="9146732"/>
      <value value="8072893"/>
      <value value="8193315"/>
      <value value="3747426"/>
      <value value="8790691"/>
      <value value="1215057"/>
      <value value="2703320"/>
      <value value="8492536"/>
      <value value="4290980"/>
      <value value="7871124"/>
      <value value="8053596"/>
      <value value="1477934"/>
      <value value="4092429"/>
      <value value="5817968"/>
      <value value="831253"/>
      <value value="6211722"/>
      <value value="254875"/>
      <value value="7989096"/>
      <value value="9146513"/>
      <value value="7717374"/>
      <value value="1678677"/>
      <value value="8555270"/>
      <value value="7853475"/>
      <value value="2233875"/>
      <value value="805568"/>
      <value value="8816001"/>
      <value value="9761037"/>
      <value value="1306087"/>
      <value value="783434"/>
      <value value="4227567"/>
      <value value="4175600"/>
      <value value="1247261"/>
      <value value="6441589"/>
      <value value="8372028"/>
      <value value="3619706"/>
      <value value="3360592"/>
      <value value="592932"/>
      <value value="2845308"/>
      <value value="784488"/>
      <value value="2604191"/>
      <value value="4080629"/>
      <value value="9616814"/>
      <value value="6670905"/>
      <value value="6559381"/>
      <value value="7468275"/>
      <value value="4612264"/>
      <value value="8812111"/>
      <value value="6018088"/>
      <value value="6199929"/>
      <value value="4470096"/>
      <value value="1117711"/>
      <value value="6938639"/>
      <value value="4420703"/>
      <value value="1462854"/>
      <value value="15660"/>
      <value value="8968075"/>
      <value value="5053056"/>
      <value value="3244074"/>
      <value value="4167285"/>
      <value value="1469268"/>
      <value value="5830563"/>
      <value value="5717652"/>
      <value value="7400863"/>
      <value value="8907975"/>
      <value value="9633041"/>
      <value value="433930"/>
      <value value="8872809"/>
      <value value="975969"/>
      <value value="660423"/>
      <value value="2796465"/>
      <value value="5931511"/>
      <value value="8381684"/>
      <value value="9703208"/>
      <value value="2197819"/>
      <value value="9890387"/>
      <value value="7217108"/>
      <value value="4873492"/>
      <value value="4617493"/>
      <value value="8190395"/>
      <value value="9196892"/>
      <value value="5396205"/>
      <value value="9775945"/>
      <value value="9751271"/>
      <value value="6240286"/>
      <value value="2037194"/>
      <value value="3722198"/>
      <value value="7501692"/>
      <value value="938505"/>
      <value value="1262809"/>
      <value value="1421988"/>
      <value value="2504484"/>
      <value value="8559745"/>
      <value value="7092017"/>
      <value value="9400472"/>
      <value value="3949195"/>
      <value value="1623163"/>
      <value value="3317736"/>
      <value value="9493174"/>
      <value value="711036"/>
      <value value="6101867"/>
      <value value="7736256"/>
      <value value="9848910"/>
      <value value="306434"/>
      <value value="4450147"/>
      <value value="3527255"/>
      <value value="5572281"/>
      <value value="7718828"/>
      <value value="3845920"/>
      <value value="432260"/>
      <value value="6506340"/>
      <value value="240499"/>
      <value value="994329"/>
      <value value="6690058"/>
      <value value="7141476"/>
      <value value="1115602"/>
      <value value="9540706"/>
      <value value="1819344"/>
      <value value="9673593"/>
      <value value="5732712"/>
      <value value="2119917"/>
      <value value="2637514"/>
      <value value="7894328"/>
      <value value="7898463"/>
      <value value="212862"/>
      <value value="4937080"/>
      <value value="3614944"/>
      <value value="2082892"/>
      <value value="2126500"/>
      <value value="8656364"/>
      <value value="9272027"/>
      <value value="6812178"/>
      <value value="911506"/>
      <value value="8299028"/>
      <value value="8325825"/>
      <value value="6096238"/>
      <value value="6197598"/>
      <value value="6475675"/>
      <value value="1760804"/>
      <value value="5104444"/>
      <value value="415805"/>
      <value value="1517345"/>
      <value value="3759681"/>
      <value value="7257594"/>
      <value value="4707022"/>
      <value value="8853583"/>
      <value value="9475041"/>
      <value value="3451894"/>
      <value value="8659416"/>
      <value value="9252329"/>
      <value value="3930127"/>
      <value value="150118"/>
      <value value="8212641"/>
      <value value="5436260"/>
      <value value="7631309"/>
      <value value="2834427"/>
      <value value="1059331"/>
      <value value="2517440"/>
      <value value="6931306"/>
      <value value="5342264"/>
      <value value="1041113"/>
      <value value="970130"/>
      <value value="9579767"/>
      <value value="4417155"/>
      <value value="5454475"/>
      <value value="6687357"/>
      <value value="8501212"/>
      <value value="693971"/>
      <value value="6686936"/>
      <value value="8754612"/>
      <value value="8978210"/>
      <value value="1238861"/>
      <value value="7275430"/>
      <value value="8922926"/>
      <value value="5365240"/>
      <value value="6021011"/>
      <value value="890665"/>
      <value value="2514792"/>
      <value value="6206859"/>
      <value value="5949872"/>
      <value value="2851097"/>
      <value value="2891568"/>
      <value value="2340219"/>
      <value value="8211030"/>
      <value value="4019891"/>
      <value value="1967390"/>
      <value value="8046899"/>
      <value value="171532"/>
      <value value="3559960"/>
      <value value="7716934"/>
      <value value="6948469"/>
      <value value="4110467"/>
      <value value="6671908"/>
      <value value="8796575"/>
      <value value="4278825"/>
      <value value="7307018"/>
      <value value="7785285"/>
      <value value="325785"/>
      <value value="2301135"/>
      <value value="1066634"/>
      <value value="3542683"/>
      <value value="7796515"/>
      <value value="2757066"/>
      <value value="335044"/>
      <value value="6307204"/>
      <value value="6310144"/>
      <value value="5041716"/>
      <value value="4585661"/>
      <value value="8656303"/>
      <value value="9249498"/>
      <value value="9081534"/>
      <value value="9708459"/>
      <value value="8279643"/>
      <value value="9997333"/>
      <value value="4566733"/>
      <value value="4503617"/>
      <value value="9838964"/>
      <value value="5354564"/>
      <value value="1399811"/>
      <value value="3338165"/>
      <value value="6252953"/>
      <value value="6812386"/>
      <value value="8567944"/>
      <value value="4131056"/>
      <value value="4154767"/>
      <value value="7411203"/>
      <value value="1016425"/>
      <value value="2383629"/>
      <value value="7121582"/>
      <value value="7559988"/>
      <value value="8444424"/>
      <value value="9881065"/>
      <value value="1169320"/>
      <value value="7085014"/>
      <value value="7775009"/>
      <value value="9702299"/>
      <value value="3991035"/>
      <value value="5949507"/>
      <value value="1978157"/>
      <value value="2123619"/>
      <value value="6719162"/>
      <value value="2583078"/>
      <value value="1947292"/>
      <value value="2700299"/>
      <value value="5149685"/>
      <value value="3032261"/>
      <value value="8964603"/>
      <value value="5245108"/>
      <value value="6641286"/>
      <value value="8398444"/>
      <value value="9209503"/>
      <value value="8435862"/>
      <value value="7163274"/>
      <value value="1206008"/>
      <value value="3093359"/>
      <value value="4637454"/>
      <value value="6490546"/>
      <value value="9314234"/>
      <value value="4687897"/>
      <value value="1663468"/>
      <value value="7197411"/>
      <value value="7374717"/>
      <value value="9368001"/>
      <value value="6993196"/>
      <value value="4006491"/>
      <value value="2049463"/>
      <value value="6455944"/>
      <value value="2271671"/>
      <value value="9655846"/>
      <value value="7607614"/>
      <value value="6089249"/>
      <value value="4303797"/>
      <value value="5424654"/>
      <value value="4358712"/>
      <value value="3893760"/>
      <value value="7457718"/>
      <value value="4495925"/>
      <value value="4385166"/>
      <value value="8734253"/>
      <value value="1738669"/>
      <value value="9071077"/>
      <value value="7890907"/>
      <value value="9712034"/>
      <value value="2591801"/>
      <value value="9535485"/>
      <value value="2159663"/>
      <value value="2526161"/>
      <value value="8304871"/>
      <value value="3377806"/>
      <value value="1250196"/>
      <value value="3788924"/>
      <value value="5843617"/>
      <value value="84053"/>
      <value value="8807652"/>
      <value value="5016374"/>
      <value value="5099415"/>
      <value value="4297228"/>
      <value value="4074826"/>
      <value value="568578"/>
      <value value="1781984"/>
      <value value="3004406"/>
      <value value="113542"/>
      <value value="5761842"/>
      <value value="3961379"/>
      <value value="2466258"/>
      <value value="6231536"/>
      <value value="6910786"/>
      <value value="1609871"/>
      <value value="7822755"/>
      <value value="6442296"/>
      <value value="5273416"/>
      <value value="9758941"/>
      <value value="5827078"/>
      <value value="8297044"/>
      <value value="8014315"/>
      <value value="3634964"/>
      <value value="2947770"/>
      <value value="2038818"/>
      <value value="7078885"/>
      <value value="8835998"/>
      <value value="7763202"/>
      <value value="2189800"/>
      <value value="3985413"/>
      <value value="9044704"/>
      <value value="5600500"/>
      <value value="1181979"/>
      <value value="2301873"/>
      <value value="3026652"/>
      <value value="9729426"/>
      <value value="7831486"/>
      <value value="5483738"/>
      <value value="9472026"/>
      <value value="6925249"/>
      <value value="1335368"/>
      <value value="2699881"/>
      <value value="1919853"/>
      <value value="6189103"/>
      <value value="7826039"/>
      <value value="8338168"/>
      <value value="4047859"/>
      <value value="8984789"/>
      <value value="6236249"/>
      <value value="6544214"/>
      <value value="6813014"/>
      <value value="6358411"/>
      <value value="9729901"/>
      <value value="3921362"/>
      <value value="9265244"/>
      <value value="1493689"/>
      <value value="7580023"/>
      <value value="3896215"/>
      <value value="4148985"/>
      <value value="861635"/>
      <value value="6752220"/>
      <value value="6457920"/>
      <value value="8066980"/>
      <value value="2722875"/>
      <value value="703149"/>
      <value value="4576253"/>
      <value value="5086669"/>
      <value value="3705749"/>
      <value value="6876208"/>
      <value value="3902678"/>
      <value value="3617090"/>
      <value value="472020"/>
      <value value="9118954"/>
      <value value="9866550"/>
      <value value="9410110"/>
      <value value="804670"/>
      <value value="4460873"/>
      <value value="1404080"/>
      <value value="5420959"/>
      <value value="9511461"/>
      <value value="6057816"/>
      <value value="8973668"/>
      <value value="5571464"/>
      <value value="4357447"/>
      <value value="2991071"/>
      <value value="7029209"/>
      <value value="2625967"/>
      <value value="6344905"/>
      <value value="2233752"/>
      <value value="9740908"/>
      <value value="600986"/>
      <value value="169"/>
      <value value="6283228"/>
      <value value="2930551"/>
      <value value="2169524"/>
      <value value="613594"/>
      <value value="9679341"/>
      <value value="6579876"/>
      <value value="12491"/>
      <value value="1983312"/>
      <value value="4134506"/>
      <value value="7164128"/>
      <value value="7779785"/>
      <value value="6966690"/>
      <value value="9521938"/>
      <value value="3155108"/>
      <value value="6102336"/>
      <value value="7200865"/>
      <value value="6968017"/>
      <value value="4340600"/>
      <value value="6291248"/>
      <value value="3668148"/>
      <value value="6038213"/>
      <value value="6635793"/>
      <value value="9504135"/>
      <value value="9544159"/>
      <value value="3123266"/>
      <value value="718977"/>
      <value value="5574887"/>
      <value value="7698607"/>
      <value value="9567657"/>
      <value value="3348665"/>
      <value value="7146894"/>
      <value value="4001148"/>
      <value value="7680941"/>
      <value value="5600165"/>
      <value value="9746998"/>
      <value value="1958127"/>
      <value value="8144396"/>
      <value value="7246740"/>
      <value value="4018336"/>
      <value value="9863285"/>
      <value value="3507976"/>
      <value value="7150737"/>
      <value value="9846294"/>
      <value value="6181654"/>
      <value value="2900528"/>
      <value value="9845971"/>
      <value value="4810039"/>
      <value value="2419203"/>
      <value value="9971043"/>
      <value value="570304"/>
      <value value="1711399"/>
      <value value="3665431"/>
      <value value="663288"/>
      <value value="6195435"/>
      <value value="655434"/>
      <value value="8852358"/>
      <value value="3596448"/>
      <value value="8024697"/>
      <value value="9576807"/>
      <value value="9218874"/>
      <value value="9475989"/>
      <value value="1086803"/>
      <value value="5146401"/>
      <value value="6901353"/>
      <value value="6790517"/>
      <value value="3567846"/>
      <value value="4423004"/>
      <value value="4779748"/>
      <value value="3153798"/>
      <value value="3927621"/>
      <value value="2523497"/>
      <value value="9979915"/>
      <value value="4621278"/>
      <value value="190720"/>
      <value value="5398823"/>
      <value value="6199603"/>
      <value value="9340530"/>
      <value value="683763"/>
      <value value="7244586"/>
      <value value="1735589"/>
      <value value="8028056"/>
      <value value="8800789"/>
      <value value="944069"/>
      <value value="8135031"/>
      <value value="7704361"/>
      <value value="2722603"/>
      <value value="7025294"/>
      <value value="5871577"/>
      <value value="8935770"/>
      <value value="8311395"/>
      <value value="7795440"/>
      <value value="440749"/>
      <value value="3601381"/>
      <value value="6628523"/>
      <value value="6443502"/>
      <value value="9261191"/>
      <value value="2602856"/>
      <value value="6286699"/>
      <value value="374269"/>
      <value value="424848"/>
      <value value="4763160"/>
      <value value="2507733"/>
      <value value="8413903"/>
      <value value="7949580"/>
      <value value="4185729"/>
      <value value="3408635"/>
      <value value="465442"/>
      <value value="9357342"/>
      <value value="397817"/>
      <value value="776975"/>
      <value value="4494527"/>
      <value value="6424030"/>
      <value value="2393873"/>
      <value value="2746174"/>
      <value value="4413423"/>
      <value value="3229568"/>
      <value value="2593191"/>
      <value value="3105785"/>
      <value value="9725558"/>
      <value value="5534013"/>
      <value value="1357764"/>
      <value value="3005770"/>
      <value value="7791989"/>
      <value value="1446899"/>
      <value value="3072906"/>
      <value value="3946222"/>
      <value value="5224313"/>
      <value value="371188"/>
      <value value="5619329"/>
      <value value="5466483"/>
      <value value="2771707"/>
      <value value="1027098"/>
      <value value="8857802"/>
      <value value="1911133"/>
      <value value="6105681"/>
      <value value="6689014"/>
      <value value="4860814"/>
      <value value="6152501"/>
      <value value="7244663"/>
      <value value="4646655"/>
      <value value="7107589"/>
      <value value="4214189"/>
      <value value="8679154"/>
      <value value="3774423"/>
      <value value="4000282"/>
      <value value="1290823"/>
      <value value="731828"/>
      <value value="2015708"/>
      <value value="546356"/>
      <value value="7784225"/>
      <value value="5139273"/>
      <value value="453101"/>
      <value value="8425558"/>
      <value value="3295487"/>
      <value value="7695497"/>
      <value value="6910402"/>
      <value value="1659412"/>
      <value value="8682437"/>
      <value value="2127428"/>
      <value value="9488748"/>
      <value value="5035741"/>
      <value value="3059630"/>
      <value value="5366712"/>
      <value value="9138671"/>
      <value value="8109798"/>
      <value value="791253"/>
      <value value="1777138"/>
      <value value="7886465"/>
      <value value="2302634"/>
      <value value="246053"/>
      <value value="7095347"/>
      <value value="6118117"/>
      <value value="4397940"/>
      <value value="3579833"/>
      <value value="8760889"/>
      <value value="8226290"/>
      <value value="1684689"/>
      <value value="1296064"/>
      <value value="6291744"/>
      <value value="3558563"/>
      <value value="7781652"/>
      <value value="4838378"/>
      <value value="1776562"/>
      <value value="3588852"/>
      <value value="2266106"/>
      <value value="7319264"/>
      <value value="6392506"/>
      <value value="3339200"/>
      <value value="1121989"/>
      <value value="7765397"/>
      <value value="4933429"/>
      <value value="5809805"/>
      <value value="59041"/>
      <value value="5056702"/>
      <value value="1432192"/>
      <value value="2097055"/>
      <value value="5837899"/>
      <value value="5313361"/>
      <value value="3835588"/>
      <value value="7510463"/>
      <value value="7999872"/>
      <value value="9176004"/>
      <value value="5580702"/>
      <value value="4689003"/>
      <value value="1317098"/>
      <value value="9100882"/>
      <value value="8236132"/>
      <value value="7029073"/>
      <value value="9220088"/>
      <value value="5666377"/>
      <value value="2357721"/>
      <value value="6729309"/>
      <value value="1175147"/>
      <value value="5700393"/>
      <value value="8700915"/>
      <value value="3790667"/>
      <value value="7274619"/>
      <value value="4297932"/>
      <value value="9889081"/>
      <value value="8970194"/>
      <value value="2442871"/>
      <value value="7454300"/>
      <value value="3475286"/>
      <value value="1650587"/>
      <value value="3567207"/>
      <value value="3581357"/>
      <value value="4337552"/>
      <value value="9206824"/>
      <value value="1231869"/>
      <value value="8610716"/>
      <value value="993866"/>
      <value value="4628149"/>
      <value value="8571908"/>
      <value value="3922291"/>
      <value value="7568794"/>
      <value value="8176393"/>
      <value value="5192604"/>
      <value value="3785511"/>
      <value value="7214438"/>
      <value value="4828519"/>
      <value value="9989635"/>
      <value value="4616821"/>
      <value value="9506804"/>
      <value value="3794237"/>
      <value value="4345469"/>
      <value value="5909450"/>
      <value value="8786351"/>
      <value value="4880888"/>
      <value value="2946947"/>
      <value value="5631205"/>
      <value value="543412"/>
      <value value="1243078"/>
      <value value="8919105"/>
      <value value="7732690"/>
      <value value="9520974"/>
      <value value="3073103"/>
      <value value="2828274"/>
      <value value="381947"/>
      <value value="8628600"/>
      <value value="8378021"/>
      <value value="6850333"/>
      <value value="2501749"/>
      <value value="9903551"/>
      <value value="4642740"/>
      <value value="756185"/>
      <value value="3477021"/>
      <value value="6528721"/>
      <value value="5472704"/>
      <value value="6703314"/>
      <value value="622356"/>
      <value value="7216138"/>
      <value value="76982"/>
      <value value="1037290"/>
      <value value="3843098"/>
      <value value="5394552"/>
      <value value="8366412"/>
      <value value="5848892"/>
      <value value="7341623"/>
      <value value="3205055"/>
      <value value="2197117"/>
      <value value="7735895"/>
      <value value="4366733"/>
      <value value="4018621"/>
      <value value="6514862"/>
      <value value="8755543"/>
      <value value="8086716"/>
      <value value="972289"/>
      <value value="6258172"/>
      <value value="4533560"/>
      <value value="5095816"/>
      <value value="3069780"/>
      <value value="9483698"/>
      <value value="9413637"/>
      <value value="6373173"/>
      <value value="3469338"/>
      <value value="2772916"/>
      <value value="5546228"/>
      <value value="3309777"/>
      <value value="3771786"/>
      <value value="5010286"/>
      <value value="2116396"/>
      <value value="3088565"/>
      <value value="5834816"/>
      <value value="8340634"/>
      <value value="3952467"/>
      <value value="719749"/>
      <value value="4056486"/>
      <value value="1902425"/>
      <value value="9639797"/>
      <value value="6766766"/>
      <value value="2159614"/>
      <value value="3128192"/>
      <value value="1957593"/>
      <value value="5581477"/>
      <value value="7013879"/>
      <value value="4107476"/>
      <value value="1471118"/>
      <value value="7342022"/>
      <value value="3557102"/>
      <value value="8402132"/>
      <value value="8525148"/>
      <value value="673696"/>
      <value value="8298541"/>
      <value value="5404316"/>
      <value value="5855519"/>
      <value value="6757519"/>
      <value value="8251140"/>
      <value value="499754"/>
      <value value="8654875"/>
      <value value="9772860"/>
      <value value="1404297"/>
      <value value="5772470"/>
      <value value="5831520"/>
      <value value="2038572"/>
      <value value="4986865"/>
      <value value="1063725"/>
      <value value="354487"/>
      <value value="1844326"/>
      <value value="438928"/>
      <value value="8727005"/>
      <value value="8846494"/>
      <value value="2280764"/>
      <value value="2215072"/>
      <value value="319800"/>
      <value value="5988360"/>
      <value value="7728998"/>
      <value value="6823931"/>
      <value value="7698055"/>
      <value value="3806254"/>
      <value value="430094"/>
      <value value="5838428"/>
      <value value="2425269"/>
      <value value="6526208"/>
      <value value="2283583"/>
      <value value="7451319"/>
      <value value="9165360"/>
      <value value="1990132"/>
      <value value="5317835"/>
      <value value="878030"/>
      <value value="3571541"/>
      <value value="757652"/>
      <value value="5844262"/>
      <value value="9831830"/>
      <value value="1485894"/>
      <value value="1000515"/>
      <value value="5348005"/>
      <value value="3827734"/>
      <value value="522529"/>
      <value value="2048958"/>
      <value value="4857238"/>
      <value value="4814371"/>
      <value value="494067"/>
      <value value="3014634"/>
      <value value="4386179"/>
      <value value="2242924"/>
      <value value="679470"/>
      <value value="4541859"/>
      <value value="5322059"/>
      <value value="5448109"/>
      <value value="3306108"/>
      <value value="3410804"/>
      <value value="5874143"/>
      <value value="5198002"/>
      <value value="7698544"/>
      <value value="2309599"/>
      <value value="1818086"/>
      <value value="854404"/>
      <value value="4137683"/>
      <value value="5887131"/>
      <value value="3777099"/>
      <value value="6697094"/>
      <value value="4394629"/>
      <value value="691007"/>
      <value value="288138"/>
      <value value="6044967"/>
      <value value="2791841"/>
      <value value="266207"/>
      <value value="6163601"/>
      <value value="6182491"/>
      <value value="4199651"/>
      <value value="4068355"/>
      <value value="6508203"/>
      <value value="8712399"/>
      <value value="6469805"/>
      <value value="2844836"/>
      <value value="3765783"/>
      <value value="4394747"/>
      <value value="9072279"/>
      <value value="1281154"/>
      <value value="7270460"/>
      <value value="6292854"/>
      <value value="3038988"/>
      <value value="226257"/>
      <value value="8391212"/>
      <value value="3315723"/>
      <value value="3027109"/>
      <value value="1745541"/>
      <value value="6971577"/>
      <value value="9196848"/>
      <value value="7567688"/>
      <value value="1057245"/>
      <value value="7163824"/>
      <value value="579149"/>
      <value value="5874398"/>
      <value value="7134833"/>
      <value value="7429820"/>
      <value value="3456588"/>
      <value value="6145965"/>
      <value value="7816649"/>
      <value value="6352041"/>
      <value value="8050118"/>
      <value value="5812813"/>
      <value value="6636800"/>
      <value value="5441111"/>
      <value value="1631053"/>
      <value value="1758083"/>
      <value value="5643740"/>
      <value value="4328007"/>
      <value value="5304952"/>
      <value value="4992125"/>
      <value value="2253780"/>
      <value value="7022886"/>
      <value value="8091670"/>
      <value value="6662196"/>
      <value value="6744235"/>
      <value value="4951234"/>
      <value value="3449476"/>
      <value value="453064"/>
      <value value="7597892"/>
      <value value="6816843"/>
      <value value="1854320"/>
      <value value="9800457"/>
      <value value="3927467"/>
      <value value="3772493"/>
      <value value="6933434"/>
      <value value="561195"/>
      <value value="9856285"/>
      <value value="4042342"/>
      <value value="9747846"/>
      <value value="4946140"/>
      <value value="4594562"/>
      <value value="236695"/>
      <value value="369185"/>
      <value value="3486775"/>
      <value value="9573270"/>
      <value value="594477"/>
      <value value="6017621"/>
      <value value="8447489"/>
      <value value="2306746"/>
      <value value="581842"/>
      <value value="4728760"/>
      <value value="9473478"/>
      <value value="9841740"/>
      <value value="7003125"/>
      <value value="6312239"/>
      <value value="342823"/>
      <value value="1764387"/>
      <value value="4711271"/>
      <value value="8793119"/>
      <value value="8557158"/>
      <value value="2604784"/>
      <value value="4882623"/>
      <value value="2119195"/>
      <value value="8442283"/>
      <value value="4216285"/>
      <value value="7799170"/>
      <value value="2686965"/>
      <value value="970150"/>
      <value value="628964"/>
      <value value="4188432"/>
      <value value="7658821"/>
      <value value="1503427"/>
      <value value="886616"/>
      <value value="1668384"/>
      <value value="7255078"/>
      <value value="5074823"/>
      <value value="2507972"/>
      <value value="5189152"/>
      <value value="549156"/>
      <value value="196655"/>
      <value value="1602494"/>
      <value value="1805360"/>
      <value value="9112157"/>
      <value value="1459233"/>
      <value value="333049"/>
      <value value="9610364"/>
      <value value="2658984"/>
      <value value="1158284"/>
      <value value="6805742"/>
      <value value="627336"/>
      <value value="4076655"/>
      <value value="1971677"/>
      <value value="3380491"/>
      <value value="5309316"/>
      <value value="5484195"/>
      <value value="5337631"/>
      <value value="2632678"/>
      <value value="3975262"/>
      <value value="1300781"/>
      <value value="7934677"/>
      <value value="9647480"/>
      <value value="9988924"/>
      <value value="2583933"/>
      <value value="9443180"/>
      <value value="8989204"/>
      <value value="6472732"/>
      <value value="554477"/>
      <value value="3253174"/>
      <value value="3028389"/>
      <value value="9487808"/>
      <value value="3044889"/>
      <value value="8782938"/>
      <value value="5435453"/>
      <value value="5171626"/>
      <value value="6835282"/>
      <value value="9197254"/>
      <value value="8617674"/>
      <value value="5992859"/>
      <value value="4821658"/>
      <value value="8081720"/>
      <value value="2451841"/>
      <value value="3276495"/>
      <value value="4023916"/>
      <value value="6159605"/>
      <value value="7170875"/>
      <value value="1203468"/>
      <value value="6478290"/>
      <value value="9616356"/>
      <value value="2224753"/>
      <value value="7416544"/>
      <value value="4455432"/>
      <value value="5318780"/>
      <value value="3875565"/>
      <value value="7521533"/>
      <value value="8487364"/>
      <value value="4039537"/>
      <value value="7961309"/>
      <value value="7654865"/>
      <value value="4352046"/>
      <value value="2053957"/>
      <value value="4516334"/>
      <value value="3215498"/>
      <value value="6496083"/>
      <value value="7940140"/>
      <value value="5161690"/>
      <value value="5039030"/>
      <value value="7639620"/>
      <value value="2898148"/>
      <value value="5941336"/>
      <value value="8070596"/>
      <value value="9002616"/>
      <value value="8933268"/>
      <value value="9932791"/>
      <value value="2324895"/>
      <value value="3630827"/>
      <value value="3543682"/>
      <value value="3668278"/>
      <value value="9594972"/>
      <value value="4262134"/>
      <value value="3154825"/>
      <value value="6867215"/>
      <value value="6827808"/>
      <value value="1709846"/>
      <value value="4544959"/>
      <value value="333860"/>
      <value value="2021308"/>
      <value value="906083"/>
      <value value="2000216"/>
      <value value="1194344"/>
      <value value="5281020"/>
      <value value="4775687"/>
      <value value="2832085"/>
      <value value="9954227"/>
      <value value="5092148"/>
      <value value="8544876"/>
      <value value="1023402"/>
      <value value="6263383"/>
      <value value="9401225"/>
      <value value="8510104"/>
      <value value="1126270"/>
      <value value="9843180"/>
      <value value="5654702"/>
      <value value="3608626"/>
      <value value="9715345"/>
      <value value="1367862"/>
      <value value="2807316"/>
      <value value="5737841"/>
      <value value="6177386"/>
      <value value="7486114"/>
      <value value="7755419"/>
      <value value="5672724"/>
      <value value="8797321"/>
      <value value="6947174"/>
      <value value="4866694"/>
      <value value="6896713"/>
      <value value="1319949"/>
      <value value="2177062"/>
      <value value="4331045"/>
      <value value="8451133"/>
      <value value="7679782"/>
      <value value="9804831"/>
      <value value="274508"/>
      <value value="3507797"/>
      <value value="6614415"/>
      <value value="3589558"/>
      <value value="650114"/>
      <value value="6738893"/>
      <value value="8274934"/>
      <value value="3812897"/>
      <value value="1231425"/>
      <value value="889158"/>
      <value value="9298041"/>
      <value value="6706313"/>
      <value value="7451573"/>
      <value value="7757474"/>
      <value value="5809841"/>
      <value value="9288900"/>
      <value value="4986594"/>
      <value value="2767185"/>
      <value value="2233223"/>
      <value value="3023399"/>
      <value value="1270541"/>
      <value value="1614421"/>
      <value value="9652776"/>
      <value value="4972939"/>
      <value value="200277"/>
      <value value="4781447"/>
      <value value="2210335"/>
      <value value="8699232"/>
      <value value="3602195"/>
      <value value="7820011"/>
      <value value="3372558"/>
      <value value="8551528"/>
      <value value="9239790"/>
      <value value="8738086"/>
      <value value="5496807"/>
      <value value="1903552"/>
      <value value="5561911"/>
      <value value="2961977"/>
      <value value="5359300"/>
      <value value="573815"/>
      <value value="3021464"/>
      <value value="5910871"/>
      <value value="2567767"/>
      <value value="12420"/>
      <value value="9076409"/>
      <value value="3325904"/>
      <value value="2535948"/>
      <value value="7824749"/>
      <value value="2141710"/>
      <value value="4879578"/>
      <value value="9125912"/>
      <value value="5878148"/>
      <value value="8264924"/>
      <value value="4107879"/>
      <value value="63032"/>
      <value value="4870085"/>
      <value value="5187325"/>
      <value value="1676985"/>
      <value value="1102498"/>
      <value value="1280732"/>
      <value value="6620843"/>
      <value value="3355825"/>
      <value value="4713721"/>
      <value value="2347928"/>
      <value value="8140851"/>
      <value value="481973"/>
      <value value="2614879"/>
      <value value="2834335"/>
      <value value="7458286"/>
      <value value="7933604"/>
      <value value="5108962"/>
      <value value="7539660"/>
      <value value="9858848"/>
      <value value="7206133"/>
      <value value="4746504"/>
      <value value="457741"/>
      <value value="1812430"/>
      <value value="8900338"/>
      <value value="7932801"/>
      <value value="312997"/>
      <value value="8665970"/>
      <value value="6561341"/>
      <value value="3348523"/>
      <value value="8397968"/>
      <value value="6360571"/>
      <value value="2532095"/>
      <value value="7111600"/>
      <value value="4958622"/>
      <value value="7272781"/>
      <value value="2864225"/>
      <value value="8944706"/>
      <value value="8597255"/>
      <value value="4204672"/>
      <value value="5242762"/>
      <value value="3566237"/>
      <value value="817867"/>
      <value value="2184981"/>
      <value value="326244"/>
      <value value="4382194"/>
      <value value="6882853"/>
      <value value="2950678"/>
      <value value="3250861"/>
      <value value="8934586"/>
      <value value="1966398"/>
      <value value="8862145"/>
      <value value="8449087"/>
      <value value="2184884"/>
      <value value="6918878"/>
      <value value="7357403"/>
      <value value="4415884"/>
      <value value="1095548"/>
      <value value="2745594"/>
      <value value="4110570"/>
      <value value="331687"/>
      <value value="1046553"/>
      <value value="4310471"/>
      <value value="2575832"/>
      <value value="6690676"/>
      <value value="4639179"/>
      <value value="5212426"/>
      <value value="238922"/>
      <value value="9085199"/>
      <value value="5565741"/>
      <value value="3195219"/>
      <value value="7395409"/>
      <value value="2798539"/>
      <value value="2840839"/>
      <value value="9370868"/>
      <value value="980371"/>
      <value value="199896"/>
      <value value="2584068"/>
      <value value="3085460"/>
      <value value="7222407"/>
      <value value="3188715"/>
      <value value="9432485"/>
      <value value="2769384"/>
      <value value="645586"/>
      <value value="2424302"/>
      <value value="2794535"/>
      <value value="111713"/>
      <value value="9041665"/>
      <value value="5052832"/>
      <value value="5653951"/>
      <value value="5082621"/>
      <value value="3886199"/>
      <value value="2064567"/>
      <value value="6232657"/>
      <value value="5340114"/>
      <value value="1226552"/>
      <value value="3459929"/>
      <value value="6210602"/>
      <value value="8693578"/>
      <value value="2571069"/>
      <value value="8901189"/>
      <value value="2756857"/>
      <value value="2933416"/>
      <value value="5746577"/>
      <value value="5180124"/>
      <value value="4786531"/>
      <value value="6652294"/>
      <value value="4327683"/>
      <value value="1097074"/>
      <value value="6476214"/>
      <value value="9705534"/>
      <value value="3943829"/>
      <value value="4464732"/>
      <value value="3423209"/>
      <value value="5277988"/>
      <value value="1516390"/>
      <value value="3631523"/>
      <value value="8592491"/>
      <value value="6260708"/>
      <value value="4923513"/>
      <value value="8731875"/>
      <value value="8365648"/>
      <value value="6248879"/>
      <value value="7286124"/>
      <value value="9378365"/>
      <value value="8765137"/>
      <value value="9596257"/>
      <value value="1013956"/>
      <value value="3257531"/>
      <value value="6886140"/>
      <value value="4764844"/>
      <value value="2980905"/>
      <value value="1408970"/>
      <value value="3504361"/>
      <value value="8307095"/>
      <value value="7119122"/>
      <value value="7772134"/>
      <value value="1162486"/>
      <value value="3261971"/>
      <value value="6811630"/>
      <value value="4980853"/>
      <value value="7013940"/>
      <value value="3507900"/>
      <value value="6483198"/>
      <value value="9395921"/>
      <value value="1853430"/>
      <value value="7844826"/>
      <value value="9421105"/>
      <value value="4221524"/>
      <value value="4817271"/>
      <value value="7316399"/>
      <value value="8101175"/>
      <value value="4745924"/>
      <value value="2681753"/>
      <value value="1660722"/>
      <value value="9079590"/>
      <value value="6260778"/>
      <value value="187338"/>
      <value value="3046096"/>
      <value value="385960"/>
      <value value="6272471"/>
      <value value="633137"/>
      <value value="6449944"/>
      <value value="9224167"/>
      <value value="7833701"/>
      <value value="7031249"/>
      <value value="6098461"/>
      <value value="2602511"/>
      <value value="5834597"/>
      <value value="8822510"/>
      <value value="5477138"/>
      <value value="4713664"/>
      <value value="1645154"/>
      <value value="2953390"/>
      <value value="2552386"/>
      <value value="6040600"/>
      <value value="1464854"/>
      <value value="5379379"/>
      <value value="5325518"/>
      <value value="9471255"/>
      <value value="8476482"/>
      <value value="6734821"/>
      <value value="1796199"/>
      <value value="671078"/>
      <value value="2383100"/>
      <value value="939303"/>
      <value value="3242443"/>
      <value value="5670838"/>
      <value value="4577846"/>
      <value value="6702438"/>
      <value value="3432904"/>
      <value value="5567994"/>
      <value value="608241"/>
      <value value="279759"/>
      <value value="163581"/>
      <value value="1528230"/>
      <value value="3836331"/>
      <value value="2321005"/>
      <value value="8483193"/>
      <value value="7722353"/>
      <value value="8114389"/>
      <value value="5436638"/>
      <value value="1940316"/>
      <value value="9733281"/>
      <value value="5408875"/>
      <value value="1580088"/>
      <value value="9136341"/>
      <value value="6135886"/>
      <value value="7454161"/>
      <value value="4875222"/>
      <value value="3013242"/>
      <value value="9241758"/>
      <value value="2658690"/>
      <value value="4273241"/>
      <value value="6621987"/>
      <value value="7459878"/>
      <value value="9137987"/>
      <value value="2217864"/>
      <value value="9149468"/>
      <value value="1857413"/>
      <value value="7148111"/>
      <value value="9174499"/>
      <value value="896424"/>
      <value value="4777495"/>
      <value value="6950824"/>
      <value value="4647296"/>
      <value value="4259703"/>
      <value value="8441591"/>
      <value value="8640594"/>
      <value value="8912872"/>
      <value value="3901432"/>
      <value value="4051084"/>
      <value value="9717026"/>
      <value value="8795926"/>
      <value value="1943175"/>
      <value value="1035"/>
      <value value="7685606"/>
      <value value="2456070"/>
      <value value="7730941"/>
      <value value="767000"/>
      <value value="8307735"/>
      <value value="3941881"/>
      <value value="2348239"/>
      <value value="9694563"/>
      <value value="3420606"/>
      <value value="316219"/>
      <value value="2918284"/>
      <value value="7459608"/>
      <value value="3461606"/>
      <value value="8834312"/>
      <value value="4062903"/>
      <value value="5816679"/>
      <value value="561257"/>
      <value value="4352351"/>
      <value value="1425844"/>
      <value value="17991"/>
      <value value="2827844"/>
      <value value="9288815"/>
      <value value="7440108"/>
      <value value="9639036"/>
      <value value="2437444"/>
      <value value="4727336"/>
      <value value="7417436"/>
      <value value="9579988"/>
      <value value="7470692"/>
      <value value="478628"/>
      <value value="3324071"/>
      <value value="2274240"/>
      <value value="1904563"/>
      <value value="3428799"/>
      <value value="863057"/>
      <value value="8115127"/>
      <value value="3452300"/>
      <value value="4503744"/>
      <value value="4318166"/>
      <value value="6348586"/>
      <value value="1235739"/>
      <value value="9967209"/>
      <value value="8093136"/>
      <value value="5905108"/>
      <value value="6224485"/>
      <value value="5386298"/>
      <value value="9530251"/>
      <value value="1986557"/>
      <value value="8829844"/>
      <value value="2000135"/>
      <value value="222202"/>
      <value value="5953911"/>
      <value value="3520222"/>
      <value value="430167"/>
      <value value="1885195"/>
      <value value="9920351"/>
      <value value="7268463"/>
      <value value="894763"/>
      <value value="3749610"/>
      <value value="9466869"/>
      <value value="2579333"/>
      <value value="3885920"/>
      <value value="7537692"/>
      <value value="8950896"/>
      <value value="9766720"/>
      <value value="653095"/>
      <value value="7557252"/>
      <value value="2060476"/>
      <value value="6115943"/>
      <value value="400927"/>
      <value value="8494242"/>
      <value value="3994188"/>
      <value value="284373"/>
      <value value="7753939"/>
      <value value="9429779"/>
      <value value="4166530"/>
      <value value="4696903"/>
      <value value="3945232"/>
      <value value="6434171"/>
      <value value="3411045"/>
      <value value="746973"/>
      <value value="9613341"/>
      <value value="8718597"/>
      <value value="9716778"/>
      <value value="7815214"/>
      <value value="1841874"/>
      <value value="744827"/>
      <value value="3203710"/>
      <value value="8366126"/>
      <value value="736201"/>
      <value value="6742338"/>
      <value value="8729669"/>
      <value value="9364930"/>
      <value value="783764"/>
      <value value="1201953"/>
      <value value="2974675"/>
      <value value="1366589"/>
      <value value="2616980"/>
      <value value="5393847"/>
      <value value="3557901"/>
      <value value="3679390"/>
      <value value="2482962"/>
      <value value="1445678"/>
      <value value="1118077"/>
      <value value="2038135"/>
      <value value="3576942"/>
      <value value="8102166"/>
      <value value="6792259"/>
      <value value="3176411"/>
      <value value="2095050"/>
      <value value="9072799"/>
      <value value="3375575"/>
      <value value="4280740"/>
      <value value="4808917"/>
      <value value="9711966"/>
      <value value="5344571"/>
      <value value="7599554"/>
      <value value="6986491"/>
      <value value="3703139"/>
      <value value="2959854"/>
      <value value="9952322"/>
      <value value="222592"/>
      <value value="7311021"/>
      <value value="9665323"/>
      <value value="3602954"/>
      <value value="1195015"/>
      <value value="3878370"/>
      <value value="4164917"/>
      <value value="3318085"/>
      <value value="8019624"/>
      <value value="272309"/>
      <value value="4916216"/>
      <value value="1944681"/>
      <value value="9535899"/>
      <value value="3257125"/>
      <value value="9937168"/>
      <value value="2753161"/>
      <value value="1603502"/>
      <value value="5341448"/>
      <value value="1072125"/>
      <value value="8306689"/>
      <value value="6741627"/>
      <value value="1143718"/>
      <value value="9815797"/>
      <value value="2637269"/>
      <value value="6934911"/>
      <value value="6313240"/>
      <value value="5952754"/>
      <value value="7241865"/>
      <value value="5173621"/>
      <value value="2471677"/>
      <value value="605545"/>
      <value value="2629885"/>
      <value value="8211306"/>
      <value value="3194439"/>
      <value value="2856458"/>
      <value value="8999624"/>
      <value value="2287673"/>
      <value value="4536973"/>
      <value value="4304932"/>
      <value value="9664407"/>
      <value value="2140378"/>
      <value value="1813599"/>
      <value value="1291394"/>
      <value value="1893259"/>
      <value value="2642250"/>
      <value value="6313630"/>
      <value value="7306533"/>
      <value value="5792831"/>
      <value value="7072043"/>
      <value value="2031324"/>
      <value value="1876678"/>
      <value value="2717085"/>
      <value value="6968639"/>
      <value value="9934917"/>
      <value value="501974"/>
      <value value="556925"/>
      <value value="7586002"/>
      <value value="9322888"/>
      <value value="6773380"/>
      <value value="8069831"/>
      <value value="5894920"/>
      <value value="5348477"/>
      <value value="6469189"/>
      <value value="105254"/>
      <value value="2128047"/>
      <value value="6503749"/>
      <value value="2372668"/>
      <value value="7393162"/>
      <value value="6943726"/>
      <value value="2727511"/>
      <value value="3356868"/>
      <value value="4114056"/>
      <value value="1784429"/>
      <value value="4650526"/>
      <value value="286185"/>
      <value value="2769306"/>
      <value value="5079162"/>
      <value value="3534855"/>
      <value value="5327682"/>
      <value value="8817320"/>
      <value value="6014171"/>
      <value value="4571138"/>
      <value value="6771037"/>
      <value value="3716440"/>
      <value value="2730366"/>
      <value value="6179112"/>
      <value value="518479"/>
      <value value="9984575"/>
      <value value="8469776"/>
      <value value="7768038"/>
      <value value="8080521"/>
      <value value="7115591"/>
      <value value="4669491"/>
      <value value="6464426"/>
      <value value="8526705"/>
      <value value="1601274"/>
      <value value="9060592"/>
      <value value="978400"/>
      <value value="1666576"/>
      <value value="8848910"/>
      <value value="9489574"/>
      <value value="2255488"/>
      <value value="3140891"/>
      <value value="4412570"/>
      <value value="7760556"/>
      <value value="5148007"/>
      <value value="4390150"/>
      <value value="4886152"/>
      <value value="4976634"/>
      <value value="1635689"/>
      <value value="6892369"/>
      <value value="3037968"/>
      <value value="6130783"/>
      <value value="8829391"/>
      <value value="2066173"/>
      <value value="7652227"/>
      <value value="6557316"/>
      <value value="9484661"/>
      <value value="5025048"/>
      <value value="7315157"/>
      <value value="5358811"/>
      <value value="8258243"/>
      <value value="8170930"/>
      <value value="3901385"/>
      <value value="9707816"/>
      <value value="7763130"/>
      <value value="6242051"/>
      <value value="8972871"/>
      <value value="8193072"/>
      <value value="9885336"/>
      <value value="2749324"/>
      <value value="3040023"/>
      <value value="9458315"/>
      <value value="522354"/>
      <value value="5276458"/>
      <value value="745324"/>
      <value value="2507724"/>
      <value value="7587522"/>
      <value value="5198194"/>
      <value value="2134548"/>
      <value value="6772110"/>
      <value value="2864875"/>
      <value value="6637193"/>
      <value value="1146481"/>
      <value value="4452873"/>
      <value value="1079124"/>
      <value value="8290819"/>
      <value value="3115306"/>
      <value value="1339420"/>
      <value value="4490401"/>
      <value value="2295784"/>
      <value value="7891181"/>
      <value value="3321647"/>
      <value value="1227812"/>
      <value value="5149450"/>
      <value value="5808127"/>
      <value value="1325692"/>
      <value value="7765653"/>
      <value value="1066495"/>
      <value value="8203933"/>
      <value value="9155813"/>
      <value value="5594183"/>
      <value value="3421024"/>
      <value value="337245"/>
      <value value="5279946"/>
      <value value="1522092"/>
      <value value="2314929"/>
      <value value="5046524"/>
      <value value="7313220"/>
      <value value="7566228"/>
      <value value="8570111"/>
      <value value="4690588"/>
      <value value="9750238"/>
      <value value="6254699"/>
      <value value="9823343"/>
      <value value="2604262"/>
      <value value="6036848"/>
      <value value="6121395"/>
      <value value="2735252"/>
      <value value="4022950"/>
      <value value="3341396"/>
      <value value="1594986"/>
      <value value="8865217"/>
      <value value="5281426"/>
      <value value="6126891"/>
      <value value="820004"/>
      <value value="7250446"/>
      <value value="4164577"/>
      <value value="2267629"/>
      <value value="6856684"/>
      <value value="8112788"/>
      <value value="2682917"/>
      <value value="8945379"/>
      <value value="8162484"/>
      <value value="5859755"/>
      <value value="4518023"/>
      <value value="9649513"/>
      <value value="5298618"/>
      <value value="4515772"/>
      <value value="4280246"/>
      <value value="3512491"/>
      <value value="138365"/>
      <value value="4314516"/>
      <value value="6689539"/>
      <value value="2541115"/>
      <value value="1347950"/>
      <value value="1394823"/>
      <value value="9014825"/>
      <value value="7277721"/>
      <value value="5433797"/>
      <value value="4118699"/>
      <value value="1420221"/>
      <value value="9887368"/>
      <value value="959503"/>
      <value value="7776431"/>
      <value value="498478"/>
      <value value="6834967"/>
      <value value="5572128"/>
      <value value="6858568"/>
      <value value="3952766"/>
      <value value="3058027"/>
      <value value="818801"/>
      <value value="9544964"/>
      <value value="7735579"/>
      <value value="2406288"/>
      <value value="5079448"/>
      <value value="3391813"/>
      <value value="2911030"/>
      <value value="3225957"/>
      <value value="1548931"/>
      <value value="3408617"/>
      <value value="1565962"/>
      <value value="8794645"/>
      <value value="4210393"/>
      <value value="866276"/>
      <value value="5493312"/>
      <value value="1478593"/>
      <value value="2119724"/>
      <value value="3807623"/>
      <value value="4272430"/>
      <value value="7477615"/>
      <value value="4908286"/>
      <value value="2432708"/>
      <value value="6989006"/>
      <value value="249059"/>
      <value value="1980666"/>
      <value value="8524974"/>
      <value value="1989761"/>
      <value value="5567459"/>
      <value value="9051723"/>
      <value value="5670535"/>
      <value value="2599020"/>
      <value value="2404025"/>
      <value value="8965539"/>
      <value value="2055534"/>
      <value value="5341047"/>
      <value value="9044583"/>
      <value value="9127397"/>
      <value value="5745430"/>
      <value value="5414550"/>
      <value value="3401429"/>
      <value value="3277700"/>
      <value value="4560004"/>
      <value value="2307475"/>
      <value value="5000293"/>
      <value value="6664023"/>
      <value value="418671"/>
      <value value="5670131"/>
      <value value="8406398"/>
      <value value="2710659"/>
      <value value="87864"/>
      <value value="9775507"/>
      <value value="7791721"/>
      <value value="7399191"/>
      <value value="9914776"/>
      <value value="7044358"/>
      <value value="3391297"/>
      <value value="7882646"/>
      <value value="833025"/>
      <value value="7598783"/>
      <value value="8563874"/>
      <value value="4854011"/>
      <value value="7546500"/>
      <value value="7598880"/>
      <value value="4609569"/>
      <value value="2766483"/>
      <value value="3242633"/>
      <value value="8569972"/>
      <value value="6869977"/>
      <value value="3440149"/>
      <value value="1648539"/>
      <value value="4363961"/>
      <value value="1547453"/>
      <value value="3681548"/>
      <value value="33585"/>
      <value value="1869267"/>
      <value value="8228838"/>
      <value value="6346335"/>
      <value value="1358123"/>
      <value value="4983698"/>
      <value value="4936983"/>
      <value value="3397395"/>
      <value value="9988679"/>
      <value value="9271884"/>
      <value value="9716955"/>
      <value value="143904"/>
      <value value="1781644"/>
      <value value="7171212"/>
      <value value="4346300"/>
      <value value="8930363"/>
      <value value="7695188"/>
      <value value="9378775"/>
      <value value="7757812"/>
      <value value="3559439"/>
      <value value="2405895"/>
      <value value="2214742"/>
      <value value="6591288"/>
      <value value="6468223"/>
      <value value="496626"/>
      <value value="2414790"/>
      <value value="560464"/>
      <value value="5405198"/>
      <value value="162551"/>
      <value value="5916326"/>
      <value value="8338319"/>
      <value value="5902580"/>
      <value value="4171437"/>
      <value value="6636010"/>
      <value value="6305765"/>
      <value value="214788"/>
      <value value="563744"/>
      <value value="2111400"/>
      <value value="8322685"/>
      <value value="3293704"/>
      <value value="4594926"/>
      <value value="1036312"/>
      <value value="8281271"/>
      <value value="317277"/>
      <value value="7295175"/>
      <value value="7048442"/>
      <value value="4512471"/>
      <value value="8294589"/>
      <value value="4331807"/>
      <value value="9283659"/>
      <value value="442568"/>
      <value value="806701"/>
      <value value="1969856"/>
      <value value="2470029"/>
      <value value="7907887"/>
      <value value="7345749"/>
      <value value="6655801"/>
      <value value="7662098"/>
      <value value="3225181"/>
      <value value="3077363"/>
      <value value="2371322"/>
      <value value="9024117"/>
      <value value="6265886"/>
      <value value="3541204"/>
      <value value="1027767"/>
      <value value="9891034"/>
      <value value="1742038"/>
      <value value="1617592"/>
      <value value="7140116"/>
      <value value="4756960"/>
      <value value="1708803"/>
      <value value="1700588"/>
      <value value="6709260"/>
      <value value="5450935"/>
      <value value="1023367"/>
      <value value="2909015"/>
      <value value="6497813"/>
      <value value="2292680"/>
      <value value="773872"/>
      <value value="1583565"/>
      <value value="8830578"/>
      <value value="1496679"/>
      <value value="3361348"/>
      <value value="4839363"/>
      <value value="7364131"/>
      <value value="9591755"/>
      <value value="3549760"/>
      <value value="4454156"/>
      <value value="4744056"/>
      <value value="9280304"/>
      <value value="1356575"/>
      <value value="2747893"/>
      <value value="3609945"/>
      <value value="9560609"/>
      <value value="8155709"/>
      <value value="4098745"/>
      <value value="9748365"/>
      <value value="1772823"/>
      <value value="8384553"/>
      <value value="7876264"/>
      <value value="4365833"/>
      <value value="495141"/>
      <value value="6559075"/>
      <value value="5794036"/>
      <value value="5633432"/>
      <value value="7912655"/>
      <value value="7274571"/>
      <value value="4524695"/>
      <value value="3125173"/>
      <value value="7230637"/>
      <value value="8922097"/>
      <value value="4812893"/>
      <value value="5512358"/>
      <value value="5120990"/>
      <value value="8898447"/>
      <value value="8985969"/>
      <value value="5673095"/>
      <value value="5050349"/>
      <value value="1407423"/>
      <value value="9013542"/>
      <value value="6283845"/>
      <value value="9745358"/>
      <value value="960885"/>
      <value value="2114771"/>
      <value value="564084"/>
      <value value="9373798"/>
      <value value="3323208"/>
      <value value="1966892"/>
      <value value="1872167"/>
      <value value="7958565"/>
      <value value="1547238"/>
      <value value="8855727"/>
      <value value="6956376"/>
      <value value="6520170"/>
      <value value="6393945"/>
      <value value="6792966"/>
      <value value="4256838"/>
      <value value="4907341"/>
      <value value="6855250"/>
      <value value="8402704"/>
      <value value="5121419"/>
      <value value="2782258"/>
      <value value="550370"/>
      <value value="3503555"/>
      <value value="6030980"/>
      <value value="8300293"/>
      <value value="2339994"/>
      <value value="4177710"/>
      <value value="2917452"/>
      <value value="2290335"/>
      <value value="9496716"/>
      <value value="6452229"/>
      <value value="8382459"/>
      <value value="6835589"/>
      <value value="4766132"/>
      <value value="6590036"/>
      <value value="5457685"/>
      <value value="7823393"/>
      <value value="2312731"/>
      <value value="7270620"/>
      <value value="1786277"/>
      <value value="3893295"/>
      <value value="6918896"/>
      <value value="7454370"/>
      <value value="8323587"/>
      <value value="7685586"/>
      <value value="2615611"/>
      <value value="1483015"/>
      <value value="9996381"/>
      <value value="4834949"/>
      <value value="3216723"/>
      <value value="4933265"/>
      <value value="6898833"/>
      <value value="1263391"/>
      <value value="7833524"/>
      <value value="68995"/>
      <value value="6035737"/>
      <value value="2375592"/>
      <value value="6052831"/>
      <value value="2122720"/>
      <value value="4058469"/>
      <value value="8905032"/>
      <value value="3980526"/>
      <value value="1441671"/>
      <value value="4860212"/>
      <value value="7903379"/>
      <value value="4908562"/>
      <value value="1639450"/>
      <value value="6446374"/>
      <value value="2933642"/>
      <value value="9623573"/>
      <value value="4158598"/>
      <value value="6836777"/>
      <value value="5441076"/>
      <value value="9355290"/>
      <value value="9894411"/>
      <value value="7285952"/>
      <value value="8271043"/>
      <value value="470697"/>
      <value value="4179988"/>
      <value value="133676"/>
      <value value="6819470"/>
      <value value="5113739"/>
      <value value="8224149"/>
      <value value="9957368"/>
      <value value="9836689"/>
      <value value="4159026"/>
      <value value="3203189"/>
      <value value="3895714"/>
      <value value="8919642"/>
      <value value="3499978"/>
      <value value="1765401"/>
      <value value="6207758"/>
      <value value="9518673"/>
      <value value="6701490"/>
      <value value="7376673"/>
      <value value="7483818"/>
      <value value="766902"/>
      <value value="6226155"/>
      <value value="5652953"/>
      <value value="4804121"/>
      <value value="9923714"/>
      <value value="5775342"/>
      <value value="8685084"/>
      <value value="2574746"/>
      <value value="8353665"/>
      <value value="8922569"/>
      <value value="4414783"/>
      <value value="2476033"/>
      <value value="7564948"/>
      <value value="4931486"/>
      <value value="1051011"/>
      <value value="3240460"/>
      <value value="5553326"/>
      <value value="4154028"/>
      <value value="4153318"/>
      <value value="7114423"/>
      <value value="1165317"/>
      <value value="3564211"/>
      <value value="90315"/>
      <value value="9146329"/>
      <value value="2765180"/>
      <value value="4008113"/>
      <value value="2580138"/>
      <value value="5437428"/>
      <value value="1421346"/>
      <value value="7853436"/>
      <value value="3037800"/>
      <value value="8355098"/>
      <value value="4476308"/>
      <value value="2090835"/>
      <value value="8538278"/>
      <value value="2364161"/>
      <value value="9350935"/>
      <value value="701022"/>
      <value value="1096210"/>
      <value value="6475873"/>
      <value value="9503411"/>
      <value value="8763882"/>
      <value value="2080074"/>
      <value value="7295528"/>
      <value value="4557904"/>
      <value value="2597341"/>
      <value value="4216562"/>
      <value value="6543612"/>
      <value value="7248269"/>
      <value value="9730529"/>
      <value value="2158517"/>
      <value value="1786484"/>
      <value value="7125668"/>
      <value value="2196296"/>
      <value value="6541175"/>
      <value value="9727191"/>
      <value value="1029144"/>
      <value value="5434728"/>
      <value value="9189143"/>
      <value value="1553607"/>
      <value value="491047"/>
      <value value="5868509"/>
      <value value="2522292"/>
      <value value="2925680"/>
      <value value="3774931"/>
      <value value="7428468"/>
      <value value="3324984"/>
      <value value="1481463"/>
      <value value="1846707"/>
      <value value="2803711"/>
      <value value="5385269"/>
      <value value="6198493"/>
      <value value="193600"/>
      <value value="8765745"/>
      <value value="4684896"/>
      <value value="2881294"/>
      <value value="149343"/>
      <value value="7603810"/>
      <value value="3952128"/>
      <value value="4942103"/>
      <value value="7322642"/>
      <value value="569058"/>
      <value value="494625"/>
      <value value="6043398"/>
      <value value="5492518"/>
      <value value="4798954"/>
      <value value="7301736"/>
      <value value="1432590"/>
      <value value="3287360"/>
      <value value="8859710"/>
      <value value="85770"/>
      <value value="5010036"/>
      <value value="3227083"/>
      <value value="5135378"/>
      <value value="1454444"/>
      <value value="3362642"/>
      <value value="2179335"/>
      <value value="7410497"/>
      <value value="6303338"/>
      <value value="150153"/>
      <value value="5071036"/>
      <value value="768785"/>
      <value value="6045294"/>
      <value value="4836348"/>
      <value value="1425763"/>
      <value value="4259393"/>
      <value value="2643326"/>
      <value value="7652012"/>
      <value value="2897361"/>
      <value value="2288069"/>
      <value value="2445288"/>
      <value value="2152116"/>
      <value value="1062983"/>
      <value value="597755"/>
      <value value="9917156"/>
      <value value="8561510"/>
      <value value="536514"/>
      <value value="6734367"/>
      <value value="7386871"/>
      <value value="8646654"/>
      <value value="925395"/>
      <value value="3031345"/>
      <value value="3129096"/>
      <value value="2511095"/>
      <value value="2675511"/>
      <value value="8779630"/>
      <value value="4474300"/>
      <value value="5099480"/>
      <value value="6790272"/>
      <value value="5865227"/>
      <value value="4031995"/>
      <value value="3317519"/>
      <value value="6166536"/>
      <value value="2980141"/>
      <value value="5643814"/>
      <value value="7411397"/>
      <value value="1986308"/>
      <value value="3751227"/>
      <value value="4038732"/>
      <value value="5562880"/>
      <value value="7279477"/>
      <value value="7227490"/>
      <value value="66829"/>
      <value value="4979355"/>
      <value value="6081663"/>
      <value value="8881778"/>
      <value value="6340335"/>
      <value value="5275486"/>
      <value value="6209626"/>
      <value value="5362345"/>
      <value value="2705916"/>
      <value value="7857056"/>
      <value value="4671708"/>
      <value value="6334989"/>
      <value value="5989453"/>
      <value value="353088"/>
      <value value="3924510"/>
      <value value="361150"/>
      <value value="3277880"/>
      <value value="561931"/>
      <value value="432359"/>
      <value value="125759"/>
      <value value="6275794"/>
      <value value="64962"/>
      <value value="2849174"/>
      <value value="3587523"/>
      <value value="2400954"/>
      <value value="5980425"/>
      <value value="6337454"/>
      <value value="4914041"/>
      <value value="6999376"/>
      <value value="6567056"/>
      <value value="1421900"/>
      <value value="9306248"/>
      <value value="3825559"/>
      <value value="6847820"/>
      <value value="9484267"/>
      <value value="9337812"/>
      <value value="9139953"/>
      <value value="3131824"/>
      <value value="8655279"/>
      <value value="8847018"/>
      <value value="9099425"/>
      <value value="2282846"/>
      <value value="6636518"/>
      <value value="3623933"/>
      <value value="3456138"/>
      <value value="172674"/>
      <value value="6380706"/>
      <value value="2047671"/>
      <value value="6180409"/>
      <value value="5628773"/>
      <value value="9637305"/>
      <value value="191185"/>
      <value value="2974337"/>
      <value value="5027241"/>
      <value value="48632"/>
      <value value="1620766"/>
      <value value="1310438"/>
      <value value="9023534"/>
      <value value="6175321"/>
      <value value="1347346"/>
      <value value="1317957"/>
      <value value="6101893"/>
      <value value="3974166"/>
      <value value="5880009"/>
      <value value="2190836"/>
      <value value="8705547"/>
      <value value="1854620"/>
      <value value="2781430"/>
      <value value="5523167"/>
      <value value="4817833"/>
      <value value="3287077"/>
      <value value="8109678"/>
      <value value="5847495"/>
      <value value="1332708"/>
      <value value="5964944"/>
      <value value="2414845"/>
      <value value="528130"/>
      <value value="3835246"/>
      <value value="6007703"/>
      <value value="5928302"/>
      <value value="5292488"/>
      <value value="1726221"/>
      <value value="902968"/>
      <value value="1170213"/>
      <value value="2687884"/>
      <value value="1082608"/>
      <value value="3988771"/>
      <value value="4952958"/>
      <value value="8617702"/>
      <value value="5206489"/>
      <value value="9362465"/>
      <value value="5643234"/>
      <value value="5830686"/>
      <value value="3654159"/>
      <value value="1992891"/>
      <value value="3388010"/>
      <value value="7572890"/>
      <value value="9161951"/>
      <value value="6292694"/>
      <value value="7428263"/>
      <value value="3755247"/>
      <value value="5475619"/>
      <value value="9448126"/>
      <value value="2183558"/>
      <value value="8521873"/>
      <value value="5346010"/>
      <value value="6672973"/>
      <value value="5978148"/>
      <value value="8300792"/>
      <value value="8950083"/>
      <value value="4714863"/>
      <value value="9987484"/>
      <value value="6674678"/>
      <value value="2792350"/>
      <value value="5506835"/>
      <value value="3098241"/>
      <value value="9693771"/>
      <value value="5196826"/>
      <value value="1303937"/>
      <value value="3940110"/>
      <value value="9137386"/>
      <value value="2065867"/>
      <value value="8578858"/>
      <value value="4031941"/>
      <value value="8074623"/>
      <value value="1059208"/>
      <value value="783161"/>
      <value value="4264952"/>
      <value value="1498093"/>
      <value value="3254946"/>
      <value value="6677674"/>
      <value value="3504070"/>
      <value value="5444022"/>
      <value value="1898476"/>
      <value value="1700827"/>
      <value value="3529950"/>
      <value value="4823042"/>
      <value value="4895554"/>
      <value value="8732619"/>
      <value value="4219289"/>
      <value value="4811811"/>
      <value value="3846278"/>
      <value value="1161766"/>
      <value value="9666490"/>
      <value value="307196"/>
      <value value="9561135"/>
      <value value="3830320"/>
      <value value="6799924"/>
      <value value="9235108"/>
      <value value="8425997"/>
      <value value="5110361"/>
      <value value="3142247"/>
      <value value="88748"/>
      <value value="5334314"/>
      <value value="3328262"/>
      <value value="8261767"/>
      <value value="391671"/>
      <value value="3304491"/>
      <value value="3772340"/>
      <value value="9957297"/>
      <value value="9054915"/>
      <value value="1065626"/>
      <value value="1101242"/>
      <value value="1133533"/>
      <value value="1439135"/>
      <value value="5561571"/>
      <value value="6551241"/>
      <value value="9800643"/>
      <value value="3554131"/>
      <value value="6526571"/>
      <value value="4727736"/>
      <value value="6702392"/>
      <value value="1592136"/>
      <value value="1010534"/>
      <value value="3006413"/>
      <value value="5840086"/>
      <value value="7148712"/>
      <value value="3908282"/>
      <value value="6605338"/>
      <value value="3462017"/>
      <value value="4729555"/>
      <value value="1911537"/>
      <value value="1533834"/>
      <value value="5443258"/>
      <value value="9674763"/>
      <value value="4725121"/>
      <value value="2215491"/>
      <value value="7810362"/>
      <value value="8622167"/>
      <value value="7523647"/>
      <value value="5548765"/>
      <value value="6513347"/>
      <value value="6830472"/>
      <value value="2732013"/>
      <value value="2883406"/>
      <value value="6450249"/>
      <value value="1324129"/>
      <value value="7652783"/>
      <value value="6914820"/>
      <value value="4370076"/>
      <value value="2600874"/>
      <value value="1536354"/>
      <value value="9099531"/>
      <value value="3320321"/>
      <value value="7324441"/>
      <value value="6326274"/>
      <value value="658244"/>
      <value value="9979570"/>
      <value value="8841601"/>
      <value value="3226692"/>
      <value value="9514623"/>
      <value value="8727365"/>
      <value value="6797051"/>
      <value value="3174523"/>
      <value value="6229211"/>
      <value value="6514253"/>
      <value value="3193350"/>
      <value value="8182734"/>
      <value value="5148356"/>
      <value value="2366818"/>
      <value value="5124490"/>
      <value value="2668814"/>
      <value value="6443132"/>
      <value value="4213782"/>
      <value value="4323261"/>
      <value value="8631750"/>
      <value value="4198189"/>
      <value value="2387208"/>
      <value value="3539922"/>
      <value value="5782768"/>
      <value value="8507608"/>
      <value value="2500030"/>
      <value value="3324733"/>
      <value value="2807026"/>
      <value value="8155468"/>
      <value value="5340142"/>
      <value value="7088661"/>
      <value value="3051386"/>
      <value value="4340583"/>
      <value value="458291"/>
      <value value="289166"/>
      <value value="3555730"/>
      <value value="4093164"/>
      <value value="314023"/>
      <value value="1517497"/>
      <value value="8436439"/>
      <value value="4525719"/>
      <value value="6046303"/>
      <value value="1159825"/>
      <value value="5652037"/>
      <value value="1698040"/>
      <value value="958288"/>
      <value value="8759631"/>
      <value value="2334639"/>
      <value value="848231"/>
      <value value="2294338"/>
      <value value="7936397"/>
      <value value="5228497"/>
      <value value="6944219"/>
      <value value="822853"/>
      <value value="3609703"/>
      <value value="8148993"/>
      <value value="7276352"/>
      <value value="9059983"/>
      <value value="7934560"/>
      <value value="4474805"/>
      <value value="7240946"/>
      <value value="4259950"/>
      <value value="7216826"/>
      <value value="9551270"/>
      <value value="7321014"/>
      <value value="7628836"/>
      <value value="154949"/>
      <value value="5619212"/>
      <value value="2191387"/>
      <value value="7340245"/>
      <value value="2441903"/>
      <value value="4515291"/>
      <value value="4616705"/>
      <value value="5237139"/>
      <value value="5398319"/>
      <value value="8315578"/>
      <value value="9480711"/>
      <value value="2849045"/>
      <value value="7103140"/>
      <value value="327309"/>
      <value value="927989"/>
      <value value="5592198"/>
      <value value="4664701"/>
      <value value="3074900"/>
      <value value="2559161"/>
      <value value="3223539"/>
      <value value="2056652"/>
      <value value="7258260"/>
      <value value="8917719"/>
      <value value="3454075"/>
      <value value="350314"/>
      <value value="3905009"/>
      <value value="4917646"/>
      <value value="8622593"/>
      <value value="1291697"/>
      <value value="6647927"/>
      <value value="570988"/>
      <value value="2418467"/>
      <value value="1558808"/>
      <value value="4416357"/>
      <value value="5514890"/>
      <value value="1911625"/>
      <value value="2937259"/>
      <value value="1044700"/>
      <value value="5295985"/>
      <value value="4272514"/>
      <value value="9215330"/>
      <value value="5926784"/>
      <value value="6726721"/>
      <value value="7194593"/>
      <value value="9242442"/>
      <value value="3559532"/>
      <value value="6273469"/>
      <value value="3977914"/>
      <value value="9567067"/>
      <value value="3597834"/>
      <value value="5087206"/>
      <value value="1751233"/>
      <value value="4303714"/>
      <value value="8961678"/>
      <value value="7255887"/>
      <value value="7392715"/>
      <value value="2562214"/>
      <value value="7580218"/>
      <value value="5698612"/>
      <value value="7713229"/>
      <value value="3895341"/>
      <value value="6369914"/>
      <value value="717741"/>
      <value value="8934019"/>
      <value value="4463519"/>
      <value value="382284"/>
      <value value="2132579"/>
      <value value="8773617"/>
      <value value="5269524"/>
      <value value="5596154"/>
      <value value="2960147"/>
      <value value="1996089"/>
      <value value="8131944"/>
      <value value="8752306"/>
      <value value="156081"/>
      <value value="8953701"/>
      <value value="9910494"/>
      <value value="5507632"/>
      <value value="97132"/>
      <value value="6358863"/>
      <value value="8640607"/>
      <value value="1690035"/>
      <value value="1677487"/>
      <value value="9948031"/>
      <value value="1609510"/>
      <value value="7050972"/>
      <value value="5442374"/>
      <value value="8677737"/>
      <value value="2078023"/>
      <value value="9524833"/>
      <value value="9517807"/>
      <value value="2297389"/>
      <value value="3770536"/>
      <value value="6772503"/>
      <value value="1793291"/>
      <value value="9774824"/>
      <value value="8185170"/>
      <value value="1777073"/>
      <value value="9519849"/>
      <value value="3536389"/>
      <value value="9970595"/>
      <value value="4880844"/>
      <value value="9604775"/>
      <value value="2983135"/>
      <value value="1817177"/>
      <value value="2176496"/>
      <value value="8861517"/>
      <value value="3613996"/>
      <value value="5625333"/>
      <value value="2804434"/>
      <value value="3908403"/>
      <value value="5446109"/>
      <value value="9569864"/>
      <value value="5990797"/>
      <value value="2660041"/>
      <value value="9229485"/>
      <value value="3707755"/>
      <value value="6547223"/>
      <value value="5436138"/>
      <value value="8649042"/>
      <value value="9890728"/>
      <value value="5581856"/>
      <value value="9128720"/>
      <value value="1983499"/>
      <value value="4284421"/>
      <value value="396583"/>
      <value value="8532208"/>
      <value value="8436568"/>
      <value value="7610062"/>
      <value value="9013862"/>
      <value value="2674722"/>
      <value value="6578916"/>
      <value value="1398797"/>
      <value value="5580496"/>
      <value value="1047859"/>
      <value value="7887910"/>
      <value value="6610590"/>
      <value value="5767398"/>
      <value value="3309462"/>
      <value value="4477692"/>
      <value value="6088247"/>
      <value value="1533435"/>
      <value value="5634846"/>
      <value value="4951767"/>
      <value value="6136703"/>
      <value value="7960928"/>
      <value value="7755158"/>
      <value value="1216984"/>
      <value value="4609590"/>
      <value value="1371419"/>
      <value value="7013226"/>
      <value value="8728400"/>
      <value value="29874"/>
      <value value="6917185"/>
      <value value="8374385"/>
      <value value="1673803"/>
      <value value="4931162"/>
      <value value="2670431"/>
      <value value="3775256"/>
      <value value="6686502"/>
      <value value="4651878"/>
      <value value="6783393"/>
      <value value="4689501"/>
      <value value="965341"/>
      <value value="3775312"/>
      <value value="9474709"/>
      <value value="2817876"/>
      <value value="8264695"/>
      <value value="7847185"/>
      <value value="2661413"/>
      <value value="8953200"/>
      <value value="2306854"/>
      <value value="8767042"/>
      <value value="5661839"/>
      <value value="5415350"/>
      <value value="153374"/>
      <value value="3449423"/>
      <value value="5235671"/>
      <value value="624922"/>
      <value value="6621079"/>
      <value value="2291256"/>
      <value value="7190682"/>
      <value value="3938207"/>
      <value value="2201026"/>
      <value value="1228734"/>
      <value value="541130"/>
      <value value="1774816"/>
      <value value="3748537"/>
      <value value="1465424"/>
      <value value="9384736"/>
      <value value="4672326"/>
      <value value="3528380"/>
      <value value="6392690"/>
      <value value="8180065"/>
      <value value="5680476"/>
      <value value="5876380"/>
      <value value="3438064"/>
      <value value="7393306"/>
      <value value="4046242"/>
      <value value="1960138"/>
      <value value="7779864"/>
      <value value="3278794"/>
      <value value="853840"/>
      <value value="8290739"/>
      <value value="8654351"/>
      <value value="8248665"/>
      <value value="5444865"/>
      <value value="6525131"/>
      <value value="7175012"/>
      <value value="293648"/>
      <value value="612489"/>
      <value value="2734576"/>
      <value value="5283609"/>
      <value value="7805533"/>
      <value value="4781330"/>
      <value value="1564146"/>
      <value value="565174"/>
      <value value="7903506"/>
      <value value="9889055"/>
      <value value="1861631"/>
      <value value="3307806"/>
      <value value="9006917"/>
      <value value="9450761"/>
      <value value="4834136"/>
      <value value="540665"/>
      <value value="2395667"/>
      <value value="3205013"/>
      <value value="1943244"/>
      <value value="5759031"/>
      <value value="6548415"/>
      <value value="1577110"/>
      <value value="8100233"/>
      <value value="9055954"/>
      <value value="2692768"/>
      <value value="4563011"/>
      <value value="1272151"/>
      <value value="8114736"/>
      <value value="3653104"/>
      <value value="6376536"/>
      <value value="4204762"/>
      <value value="7937682"/>
      <value value="6926206"/>
      <value value="4528316"/>
      <value value="5439415"/>
      <value value="8609037"/>
      <value value="8458447"/>
      <value value="5746936"/>
      <value value="9383742"/>
      <value value="7312588"/>
      <value value="4780874"/>
      <value value="9229965"/>
      <value value="7663985"/>
      <value value="4807630"/>
      <value value="6585199"/>
      <value value="5750892"/>
      <value value="7501539"/>
      <value value="9682649"/>
      <value value="5860327"/>
      <value value="6737094"/>
      <value value="9675652"/>
      <value value="7100555"/>
      <value value="3336396"/>
      <value value="4486791"/>
      <value value="7124378"/>
      <value value="4303860"/>
      <value value="3556074"/>
      <value value="1332739"/>
      <value value="3425077"/>
      <value value="1912806"/>
      <value value="375004"/>
      <value value="8443781"/>
      <value value="7249666"/>
      <value value="7605448"/>
      <value value="3403881"/>
      <value value="9605773"/>
      <value value="2153078"/>
      <value value="2703411"/>
      <value value="3193071"/>
      <value value="2545033"/>
      <value value="4564687"/>
      <value value="6487321"/>
      <value value="4189504"/>
      <value value="8033955"/>
      <value value="4300472"/>
      <value value="1440263"/>
      <value value="7094718"/>
      <value value="2772281"/>
      <value value="3026311"/>
      <value value="7639347"/>
      <value value="4931817"/>
      <value value="90578"/>
      <value value="4944351"/>
      <value value="3268903"/>
      <value value="4815318"/>
      <value value="5147594"/>
      <value value="1498824"/>
      <value value="5636450"/>
      <value value="3164231"/>
      <value value="1988376"/>
      <value value="5927909"/>
      <value value="1839023"/>
      <value value="425415"/>
      <value value="5528381"/>
      <value value="2524067"/>
      <value value="525988"/>
      <value value="4546329"/>
      <value value="4310589"/>
      <value value="9244871"/>
      <value value="563273"/>
      <value value="3163351"/>
      <value value="9145559"/>
      <value value="1200427"/>
      <value value="724502"/>
      <value value="5710059"/>
      <value value="2608841"/>
      <value value="6455113"/>
      <value value="8984756"/>
      <value value="9439372"/>
      <value value="7171698"/>
      <value value="7153531"/>
      <value value="2019181"/>
      <value value="4714088"/>
      <value value="4889592"/>
      <value value="8400905"/>
      <value value="8999257"/>
      <value value="1900330"/>
      <value value="3392300"/>
      <value value="3955365"/>
      <value value="9071334"/>
      <value value="7904076"/>
      <value value="6919851"/>
      <value value="309641"/>
      <value value="505726"/>
      <value value="5992469"/>
      <value value="4825776"/>
      <value value="6873102"/>
      <value value="7230885"/>
      <value value="3720272"/>
      <value value="5011150"/>
      <value value="2621734"/>
      <value value="743158"/>
      <value value="8514335"/>
      <value value="1409763"/>
      <value value="1693806"/>
      <value value="1340945"/>
      <value value="3164170"/>
      <value value="9109201"/>
      <value value="5185764"/>
      <value value="4993125"/>
      <value value="5110272"/>
      <value value="7435843"/>
      <value value="4324596"/>
      <value value="5485756"/>
      <value value="6544682"/>
      <value value="810604"/>
      <value value="9392009"/>
      <value value="6448375"/>
      <value value="9588848"/>
      <value value="629378"/>
      <value value="9105875"/>
      <value value="779464"/>
      <value value="1558709"/>
      <value value="1830138"/>
      <value value="309974"/>
      <value value="3993437"/>
      <value value="1523640"/>
      <value value="340059"/>
      <value value="4502682"/>
      <value value="677084"/>
      <value value="4550932"/>
      <value value="2614825"/>
      <value value="1124383"/>
      <value value="2463628"/>
      <value value="9781667"/>
      <value value="9848890"/>
      <value value="9509855"/>
      <value value="5972855"/>
      <value value="847124"/>
      <value value="3987607"/>
      <value value="3611909"/>
      <value value="3796680"/>
      <value value="2588071"/>
      <value value="4541421"/>
      <value value="9404696"/>
      <value value="9084213"/>
      <value value="9939139"/>
      <value value="5901786"/>
      <value value="4390368"/>
      <value value="1118342"/>
      <value value="3433227"/>
      <value value="1342620"/>
      <value value="2291707"/>
      <value value="6390864"/>
      <value value="2879948"/>
      <value value="4463957"/>
      <value value="9641902"/>
      <value value="2149935"/>
      <value value="3213410"/>
      <value value="2113709"/>
      <value value="9589079"/>
      <value value="3354758"/>
      <value value="1875581"/>
      <value value="259728"/>
      <value value="9264116"/>
      <value value="4457801"/>
      <value value="6606011"/>
      <value value="6702148"/>
      <value value="1508912"/>
      <value value="4060554"/>
      <value value="5177362"/>
      <value value="1406400"/>
      <value value="4258046"/>
      <value value="805740"/>
      <value value="9905071"/>
      <value value="5210611"/>
      <value value="9870016"/>
      <value value="5790244"/>
      <value value="6381983"/>
      <value value="7761652"/>
      <value value="882574"/>
      <value value="9038107"/>
      <value value="184740"/>
      <value value="5879266"/>
      <value value="7595689"/>
      <value value="8778141"/>
      <value value="2352434"/>
      <value value="6310081"/>
      <value value="7492633"/>
      <value value="9222201"/>
      <value value="633004"/>
      <value value="2308911"/>
      <value value="161724"/>
      <value value="2543819"/>
      <value value="1091728"/>
      <value value="546149"/>
      <value value="9466240"/>
      <value value="8065403"/>
      <value value="8191074"/>
      <value value="2986269"/>
      <value value="5973943"/>
      <value value="1595426"/>
      <value value="6666335"/>
      <value value="6120371"/>
      <value value="2568241"/>
      <value value="6470692"/>
      <value value="6978213"/>
      <value value="184122"/>
      <value value="9033103"/>
      <value value="4838025"/>
      <value value="999837"/>
      <value value="7849547"/>
      <value value="8974286"/>
      <value value="9164549"/>
      <value value="1842574"/>
      <value value="3208023"/>
      <value value="5748283"/>
      <value value="1125563"/>
      <value value="3106259"/>
      <value value="1085886"/>
      <value value="9299460"/>
      <value value="9794350"/>
      <value value="432164"/>
      <value value="3200650"/>
      <value value="290792"/>
      <value value="6593019"/>
      <value value="6017114"/>
      <value value="8616226"/>
      <value value="2245339"/>
      <value value="4601331"/>
      <value value="6235477"/>
      <value value="5457704"/>
      <value value="8040633"/>
      <value value="5385109"/>
      <value value="4566770"/>
      <value value="5166587"/>
      <value value="3982546"/>
      <value value="227130"/>
      <value value="539217"/>
      <value value="5841478"/>
      <value value="6592481"/>
      <value value="6202320"/>
      <value value="766713"/>
      <value value="9064536"/>
      <value value="2047211"/>
      <value value="3453596"/>
      <value value="428177"/>
      <value value="7209653"/>
      <value value="1991380"/>
      <value value="4473057"/>
      <value value="6643361"/>
      <value value="2702578"/>
      <value value="8327043"/>
      <value value="76738"/>
      <value value="1524043"/>
      <value value="6017341"/>
      <value value="4046877"/>
      <value value="3080973"/>
      <value value="163435"/>
      <value value="4451777"/>
      <value value="7117410"/>
      <value value="3481805"/>
      <value value="5885608"/>
      <value value="3129612"/>
      <value value="695670"/>
      <value value="3240161"/>
      <value value="9343565"/>
      <value value="6302631"/>
      <value value="509633"/>
      <value value="4979306"/>
      <value value="3298058"/>
      <value value="5211217"/>
      <value value="3628201"/>
      <value value="1966958"/>
      <value value="9573947"/>
      <value value="124708"/>
      <value value="5428949"/>
      <value value="4810298"/>
      <value value="2389863"/>
      <value value="7550372"/>
      <value value="4000911"/>
      <value value="4210409"/>
      <value value="3896804"/>
      <value value="5721744"/>
      <value value="8888392"/>
      <value value="8689691"/>
      <value value="407911"/>
      <value value="6311585"/>
      <value value="8909212"/>
      <value value="6125956"/>
      <value value="5763800"/>
      <value value="903391"/>
      <value value="3781065"/>
      <value value="4348808"/>
      <value value="5671786"/>
      <value value="7780641"/>
      <value value="1297211"/>
      <value value="9577993"/>
      <value value="3155192"/>
      <value value="6212880"/>
      <value value="356961"/>
      <value value="572349"/>
      <value value="7352762"/>
      <value value="898949"/>
      <value value="9176054"/>
      <value value="5746164"/>
      <value value="7904995"/>
      <value value="3966305"/>
      <value value="7216568"/>
      <value value="9417034"/>
      <value value="4618948"/>
      <value value="2707549"/>
      <value value="1304637"/>
      <value value="9933195"/>
      <value value="7477789"/>
      <value value="6800405"/>
      <value value="1739571"/>
      <value value="2328539"/>
      <value value="8490446"/>
      <value value="953101"/>
      <value value="9229187"/>
      <value value="5077081"/>
      <value value="9263440"/>
      <value value="6658619"/>
      <value value="3099693"/>
      <value value="954984"/>
      <value value="8867928"/>
      <value value="3238241"/>
      <value value="9601050"/>
      <value value="364735"/>
      <value value="9094889"/>
      <value value="9128358"/>
      <value value="2881470"/>
      <value value="4969856"/>
      <value value="1045644"/>
      <value value="6997635"/>
      <value value="2372509"/>
      <value value="2364544"/>
      <value value="6969324"/>
      <value value="7480050"/>
      <value value="4330478"/>
      <value value="2203356"/>
      <value value="1233030"/>
      <value value="3416280"/>
      <value value="9830290"/>
      <value value="6642191"/>
      <value value="9443740"/>
      <value value="2665727"/>
      <value value="1317327"/>
      <value value="5452563"/>
      <value value="9699134"/>
      <value value="5669507"/>
      <value value="4431917"/>
      <value value="4092435"/>
      <value value="7154905"/>
      <value value="4800931"/>
      <value value="6889592"/>
      <value value="3738118"/>
      <value value="7181554"/>
      <value value="4572950"/>
      <value value="8543866"/>
      <value value="4031934"/>
      <value value="5470688"/>
      <value value="9828832"/>
      <value value="9646941"/>
      <value value="8494734"/>
      <value value="991645"/>
      <value value="8054259"/>
      <value value="8839065"/>
      <value value="197089"/>
      <value value="7177542"/>
      <value value="6817961"/>
      <value value="9659740"/>
      <value value="2081419"/>
      <value value="2155698"/>
      <value value="3219099"/>
      <value value="8549591"/>
      <value value="5364247"/>
      <value value="9807442"/>
      <value value="7026236"/>
      <value value="6971336"/>
      <value value="2631166"/>
      <value value="4908235"/>
      <value value="6297035"/>
      <value value="1574910"/>
      <value value="7991758"/>
      <value value="3576778"/>
      <value value="4455319"/>
      <value value="6065910"/>
      <value value="6436039"/>
      <value value="4261781"/>
      <value value="1761505"/>
      <value value="2829857"/>
      <value value="7076734"/>
      <value value="2030868"/>
      <value value="8943476"/>
      <value value="2822481"/>
      <value value="9387441"/>
      <value value="4409811"/>
      <value value="9171443"/>
      <value value="4981133"/>
      <value value="9736038"/>
      <value value="5929265"/>
      <value value="9182460"/>
      <value value="4826328"/>
      <value value="9838678"/>
      <value value="6229855"/>
      <value value="4727294"/>
      <value value="6700079"/>
      <value value="2579404"/>
      <value value="9092108"/>
      <value value="3883625"/>
      <value value="7681467"/>
      <value value="2380324"/>
      <value value="4134932"/>
      <value value="3255714"/>
      <value value="1417369"/>
      <value value="3579770"/>
      <value value="7760713"/>
      <value value="1589875"/>
      <value value="4950952"/>
      <value value="2227247"/>
      <value value="4922704"/>
      <value value="2003001"/>
      <value value="2323399"/>
      <value value="8379679"/>
      <value value="9235703"/>
      <value value="7372231"/>
      <value value="5941446"/>
      <value value="9156801"/>
      <value value="4329178"/>
      <value value="4090515"/>
      <value value="8076870"/>
      <value value="5790223"/>
      <value value="5150878"/>
      <value value="5777666"/>
      <value value="7437671"/>
      <value value="1116111"/>
      <value value="6189614"/>
      <value value="6068026"/>
      <value value="6532584"/>
      <value value="5435564"/>
      <value value="8391950"/>
      <value value="9670860"/>
      <value value="6181055"/>
      <value value="3246788"/>
      <value value="5449399"/>
      <value value="3673656"/>
      <value value="4234079"/>
      <value value="2733463"/>
      <value value="969413"/>
      <value value="4021770"/>
      <value value="7043559"/>
      <value value="7580962"/>
      <value value="9991367"/>
      <value value="1681413"/>
      <value value="1531449"/>
      <value value="2241237"/>
      <value value="8227731"/>
      <value value="4976517"/>
      <value value="3857788"/>
      <value value="6078770"/>
      <value value="6016780"/>
      <value value="4633165"/>
      <value value="7344802"/>
      <value value="4933014"/>
      <value value="9299018"/>
      <value value="4014089"/>
      <value value="7475872"/>
      <value value="2868223"/>
      <value value="3479673"/>
      <value value="141063"/>
      <value value="4488103"/>
      <value value="2392536"/>
      <value value="5151508"/>
      <value value="291993"/>
      <value value="5606398"/>
      <value value="9281912"/>
      <value value="8211794"/>
      <value value="6084838"/>
      <value value="7192981"/>
      <value value="5242597"/>
      <value value="1917839"/>
      <value value="3748377"/>
      <value value="6516047"/>
      <value value="7694944"/>
      <value value="6433594"/>
      <value value="5839501"/>
      <value value="8028482"/>
      <value value="9959738"/>
      <value value="9147310"/>
      <value value="201066"/>
      <value value="9492421"/>
      <value value="28412"/>
      <value value="6792127"/>
      <value value="1594543"/>
      <value value="6526157"/>
      <value value="4012295"/>
      <value value="2912411"/>
      <value value="5703234"/>
      <value value="1444047"/>
      <value value="5318157"/>
      <value value="81778"/>
      <value value="7612962"/>
      <value value="5720562"/>
      <value value="1588753"/>
      <value value="5434398"/>
      <value value="4062572"/>
      <value value="224695"/>
      <value value="1478524"/>
      <value value="2442999"/>
      <value value="4848097"/>
      <value value="6907026"/>
      <value value="3929035"/>
      <value value="9818842"/>
      <value value="7111077"/>
      <value value="5807152"/>
      <value value="8809679"/>
      <value value="5362182"/>
      <value value="7075012"/>
      <value value="9271231"/>
      <value value="6919792"/>
      <value value="9284545"/>
      <value value="8419165"/>
      <value value="1362908"/>
      <value value="1293670"/>
      <value value="6675367"/>
      <value value="7774663"/>
      <value value="4402068"/>
      <value value="9460247"/>
      <value value="5156729"/>
      <value value="7399914"/>
      <value value="7461746"/>
      <value value="7259588"/>
      <value value="2521592"/>
      <value value="9949223"/>
      <value value="8856834"/>
      <value value="4027978"/>
      <value value="3737784"/>
      <value value="5267861"/>
      <value value="8095605"/>
      <value value="4487499"/>
      <value value="7275788"/>
      <value value="553488"/>
      <value value="1652715"/>
      <value value="8471722"/>
      <value value="1071737"/>
      <value value="8970359"/>
      <value value="8165179"/>
      <value value="7803061"/>
      <value value="5843801"/>
      <value value="8028498"/>
      <value value="3488163"/>
      <value value="1091608"/>
      <value value="1846550"/>
      <value value="4816772"/>
      <value value="3996702"/>
      <value value="7198229"/>
      <value value="8449609"/>
      <value value="2125494"/>
      <value value="3447"/>
      <value value="3400079"/>
      <value value="9744873"/>
      <value value="5671379"/>
      <value value="7504548"/>
      <value value="1522086"/>
      <value value="7111163"/>
      <value value="8248096"/>
      <value value="3335244"/>
      <value value="6932699"/>
      <value value="1303256"/>
      <value value="5809495"/>
      <value value="6796687"/>
      <value value="685428"/>
      <value value="3393821"/>
      <value value="7734973"/>
      <value value="2031604"/>
      <value value="9680600"/>
      <value value="5287737"/>
      <value value="4172729"/>
      <value value="2501342"/>
      <value value="7835765"/>
      <value value="2598826"/>
      <value value="641459"/>
      <value value="9170450"/>
      <value value="8800077"/>
      <value value="7218863"/>
      <value value="499128"/>
      <value value="1227011"/>
      <value value="6243317"/>
      <value value="6404288"/>
      <value value="6466562"/>
      <value value="507091"/>
      <value value="6955046"/>
      <value value="9326311"/>
      <value value="7049420"/>
      <value value="4355798"/>
      <value value="5824981"/>
      <value value="2836912"/>
      <value value="9393055"/>
      <value value="2841815"/>
      <value value="8433156"/>
      <value value="8006464"/>
      <value value="7185522"/>
      <value value="5482086"/>
      <value value="4649420"/>
      <value value="5409885"/>
      <value value="5246010"/>
      <value value="7229142"/>
      <value value="4762416"/>
      <value value="4780480"/>
      <value value="4030229"/>
      <value value="8781851"/>
      <value value="282829"/>
      <value value="5509029"/>
      <value value="457854"/>
      <value value="2800140"/>
      <value value="8285463"/>
      <value value="1362670"/>
      <value value="7109783"/>
      <value value="2464802"/>
      <value value="4232947"/>
      <value value="7083782"/>
      <value value="1677921"/>
      <value value="1124208"/>
      <value value="2924313"/>
      <value value="8678366"/>
      <value value="2218937"/>
      <value value="8050560"/>
      <value value="9136989"/>
      <value value="3374349"/>
      <value value="3751256"/>
      <value value="3639954"/>
      <value value="3402727"/>
      <value value="6909208"/>
      <value value="810145"/>
      <value value="2282372"/>
      <value value="4545135"/>
      <value value="104586"/>
      <value value="3225127"/>
      <value value="4599313"/>
      <value value="7826337"/>
      <value value="3935291"/>
      <value value="4379065"/>
      <value value="1733665"/>
      <value value="3917344"/>
      <value value="1694907"/>
      <value value="550071"/>
      <value value="5169965"/>
      <value value="3426889"/>
      <value value="5276601"/>
      <value value="7990079"/>
      <value value="7207861"/>
      <value value="7895835"/>
      <value value="2562839"/>
      <value value="9825086"/>
      <value value="598541"/>
      <value value="5012246"/>
      <value value="7114704"/>
      <value value="6555969"/>
      <value value="9181076"/>
      <value value="6536677"/>
      <value value="7882875"/>
      <value value="8938298"/>
      <value value="1107025"/>
      <value value="4541852"/>
      <value value="3760522"/>
      <value value="4715569"/>
      <value value="500861"/>
      <value value="3713683"/>
      <value value="317223"/>
      <value value="5545603"/>
      <value value="6921454"/>
      <value value="3959064"/>
      <value value="5898610"/>
      <value value="5718619"/>
      <value value="5198941"/>
      <value value="4535317"/>
      <value value="458639"/>
      <value value="4436393"/>
      <value value="117355"/>
      <value value="5521486"/>
      <value value="6263463"/>
      <value value="6819205"/>
      <value value="4660544"/>
      <value value="296855"/>
      <value value="5618205"/>
      <value value="58865"/>
      <value value="8083933"/>
      <value value="3315195"/>
      <value value="4639577"/>
      <value value="8098151"/>
      <value value="9104386"/>
      <value value="8228251"/>
      <value value="4998793"/>
      <value value="7871816"/>
      <value value="2209078"/>
      <value value="6055903"/>
      <value value="6738671"/>
      <value value="2306922"/>
      <value value="4974357"/>
      <value value="2173944"/>
      <value value="1901964"/>
      <value value="2926522"/>
      <value value="5795713"/>
      <value value="4591954"/>
      <value value="537614"/>
      <value value="4268446"/>
      <value value="168246"/>
      <value value="9183589"/>
      <value value="3405875"/>
      <value value="7783797"/>
      <value value="5833404"/>
      <value value="2256402"/>
      <value value="5750823"/>
      <value value="8348018"/>
      <value value="650128"/>
      <value value="3390308"/>
      <value value="6835248"/>
      <value value="6953296"/>
      <value value="7416178"/>
      <value value="6251681"/>
      <value value="6700271"/>
      <value value="5916645"/>
      <value value="3552015"/>
      <value value="3890580"/>
      <value value="5345387"/>
      <value value="7093999"/>
      <value value="1028226"/>
      <value value="5829465"/>
      <value value="27029"/>
      <value value="9412684"/>
      <value value="3878212"/>
      <value value="9395009"/>
      <value value="8763005"/>
      <value value="3437287"/>
      <value value="7276471"/>
      <value value="2002435"/>
      <value value="1379746"/>
      <value value="875367"/>
      <value value="602263"/>
      <value value="276990"/>
      <value value="2119705"/>
      <value value="9853545"/>
      <value value="2885961"/>
      <value value="5699996"/>
      <value value="5988464"/>
      <value value="6512813"/>
      <value value="6398481"/>
      <value value="200423"/>
      <value value="7579406"/>
      <value value="3172923"/>
      <value value="3731311"/>
      <value value="4628927"/>
      <value value="7177123"/>
      <value value="1101712"/>
      <value value="1874855"/>
      <value value="4617380"/>
      <value value="8127841"/>
      <value value="648367"/>
      <value value="9787607"/>
      <value value="3243140"/>
      <value value="9692782"/>
      <value value="528012"/>
      <value value="3817579"/>
      <value value="5009405"/>
      <value value="3506389"/>
      <value value="9675224"/>
      <value value="6604565"/>
      <value value="9238496"/>
      <value value="9401531"/>
      <value value="3303168"/>
      <value value="392832"/>
      <value value="5526858"/>
      <value value="2404760"/>
      <value value="3735117"/>
      <value value="6254610"/>
      <value value="1564349"/>
      <value value="8949154"/>
      <value value="777350"/>
      <value value="227734"/>
      <value value="1751961"/>
      <value value="7380202"/>
      <value value="8432230"/>
      <value value="8479384"/>
      <value value="8468307"/>
      <value value="6950813"/>
      <value value="6938268"/>
      <value value="5548128"/>
      <value value="1357746"/>
      <value value="9283022"/>
      <value value="4281440"/>
      <value value="2670792"/>
      <value value="6581989"/>
      <value value="1060279"/>
      <value value="5220212"/>
      <value value="4152689"/>
      <value value="9719614"/>
      <value value="2009914"/>
      <value value="4306403"/>
      <value value="156213"/>
      <value value="8803067"/>
      <value value="4658869"/>
      <value value="5798010"/>
      <value value="9109011"/>
      <value value="4660476"/>
      <value value="8103947"/>
      <value value="7215411"/>
      <value value="8066956"/>
      <value value="4916035"/>
      <value value="6316356"/>
      <value value="6306565"/>
      <value value="3926187"/>
      <value value="4418352"/>
      <value value="2333039"/>
      <value value="6989269"/>
      <value value="723429"/>
      <value value="4393665"/>
      <value value="6304800"/>
      <value value="633136"/>
      <value value="5364584"/>
      <value value="7610305"/>
      <value value="8486448"/>
      <value value="8274965"/>
      <value value="620760"/>
      <value value="1531978"/>
      <value value="9535371"/>
      <value value="8676186"/>
      <value value="5788884"/>
      <value value="394431"/>
      <value value="4623065"/>
      <value value="9804249"/>
      <value value="9137020"/>
      <value value="1157676"/>
      <value value="1510878"/>
      <value value="3964480"/>
      <value value="7584526"/>
      <value value="5666488"/>
      <value value="3272189"/>
      <value value="7699986"/>
      <value value="1498496"/>
      <value value="5886439"/>
      <value value="5948753"/>
      <value value="5979673"/>
      <value value="6935101"/>
      <value value="9503299"/>
      <value value="5604989"/>
      <value value="2869151"/>
      <value value="9666085"/>
      <value value="4486307"/>
      <value value="7269157"/>
      <value value="7125977"/>
      <value value="8762824"/>
      <value value="6227006"/>
      <value value="8533837"/>
      <value value="971518"/>
      <value value="768566"/>
      <value value="5215304"/>
      <value value="4038690"/>
      <value value="3174931"/>
      <value value="1888383"/>
      <value value="1851602"/>
      <value value="6789787"/>
      <value value="2169914"/>
      <value value="1824466"/>
      <value value="6111461"/>
      <value value="4296576"/>
      <value value="6015339"/>
      <value value="8395333"/>
      <value value="2617820"/>
      <value value="9121991"/>
      <value value="8958643"/>
      <value value="5286367"/>
      <value value="8718923"/>
      <value value="7747741"/>
      <value value="6550086"/>
      <value value="1975219"/>
      <value value="2587872"/>
      <value value="6298950"/>
      <value value="608380"/>
      <value value="9736033"/>
      <value value="3571320"/>
      <value value="6117358"/>
      <value value="870488"/>
      <value value="1536528"/>
      <value value="4075215"/>
      <value value="7078060"/>
      <value value="6096705"/>
      <value value="867781"/>
      <value value="8405345"/>
      <value value="6941924"/>
      <value value="2733207"/>
      <value value="7974308"/>
      <value value="8781775"/>
      <value value="1352915"/>
      <value value="6282283"/>
      <value value="1484477"/>
      <value value="7639006"/>
      <value value="7465600"/>
      <value value="1376091"/>
      <value value="1657593"/>
      <value value="4096530"/>
      <value value="2908170"/>
      <value value="3192351"/>
      <value value="3702437"/>
      <value value="273375"/>
      <value value="7219606"/>
      <value value="5018524"/>
      <value value="3765524"/>
      <value value="44669"/>
      <value value="9658158"/>
      <value value="166099"/>
      <value value="7746665"/>
      <value value="9892609"/>
      <value value="2406503"/>
      <value value="5071014"/>
      <value value="9868726"/>
      <value value="6484170"/>
      <value value="7762863"/>
      <value value="5813241"/>
      <value value="9509059"/>
      <value value="212465"/>
      <value value="3659986"/>
      <value value="3454987"/>
      <value value="9152346"/>
      <value value="1670059"/>
      <value value="4429940"/>
      <value value="7287698"/>
      <value value="7160561"/>
      <value value="485559"/>
      <value value="8846716"/>
      <value value="980820"/>
      <value value="309536"/>
      <value value="1520511"/>
      <value value="6020916"/>
      <value value="9617025"/>
      <value value="6103833"/>
      <value value="2554026"/>
      <value value="1809989"/>
      <value value="2166839"/>
      <value value="6611696"/>
      <value value="3289358"/>
      <value value="1670853"/>
      <value value="8291803"/>
      <value value="5430175"/>
      <value value="9255332"/>
      <value value="5561696"/>
      <value value="7264948"/>
      <value value="6648473"/>
      <value value="5387046"/>
      <value value="5220998"/>
      <value value="1843401"/>
      <value value="298073"/>
      <value value="8732282"/>
      <value value="8188228"/>
      <value value="8210181"/>
      <value value="3388826"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;Stage2infect&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.278"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
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
      <value value="54"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="331"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_r_reported">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ess_w_risk_reduction">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="essential_workers">
      <value value="54"/>
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
      <value value="0.7105950548248887"/>
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
      <value value="20"/>
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
      <value value="50"/>
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
      <value value="6.098064691227867E-4"/>
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
      <value value="54"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="54"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="0.5325472264917275"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.85"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="0.07"/>
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
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set_shape">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="superspreaders">
      <value value="0.0075"/>
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
      <value value="0.14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="yearly_recover_prop_loss">
      <value value="0"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Stage2_PK" repetitions="1" runMetricsEveryStep="false">
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
      <value value="6352613"/>
      <value value="2428091"/>
      <value value="9902052"/>
      <value value="7352207"/>
      <value value="7819096"/>
      <value value="3505142"/>
      <value value="1314294"/>
      <value value="9161346"/>
      <value value="7296398"/>
      <value value="6632173"/>
      <value value="8141586"/>
      <value value="8042954"/>
      <value value="3525135"/>
      <value value="4932182"/>
      <value value="4892937"/>
      <value value="8400204"/>
      <value value="3804953"/>
      <value value="7168846"/>
      <value value="508457"/>
      <value value="1148186"/>
      <value value="825538"/>
      <value value="6944173"/>
      <value value="30731"/>
      <value value="1213823"/>
      <value value="6301890"/>
      <value value="1305783"/>
      <value value="5446436"/>
      <value value="5661121"/>
      <value value="4193997"/>
      <value value="7111146"/>
      <value value="7688177"/>
      <value value="5251534"/>
      <value value="72632"/>
      <value value="3929068"/>
      <value value="4367688"/>
      <value value="4382893"/>
      <value value="1487768"/>
      <value value="6495647"/>
      <value value="6811604"/>
      <value value="5858275"/>
      <value value="3241384"/>
      <value value="7170992"/>
      <value value="1600173"/>
      <value value="2939918"/>
      <value value="2510029"/>
      <value value="4996556"/>
      <value value="191278"/>
      <value value="1985412"/>
      <value value="6624991"/>
      <value value="804995"/>
      <value value="2948312"/>
      <value value="9655697"/>
      <value value="1205215"/>
      <value value="9620961"/>
      <value value="8172725"/>
      <value value="909300"/>
      <value value="9850929"/>
      <value value="9856074"/>
      <value value="7585748"/>
      <value value="7930328"/>
      <value value="7232469"/>
      <value value="4575561"/>
      <value value="2307003"/>
      <value value="4904450"/>
      <value value="9216730"/>
      <value value="9889717"/>
      <value value="4604471"/>
      <value value="8931686"/>
      <value value="7207299"/>
      <value value="6009112"/>
      <value value="3172899"/>
      <value value="3402841"/>
      <value value="2254912"/>
      <value value="3428214"/>
      <value value="3742910"/>
      <value value="929476"/>
      <value value="7638783"/>
      <value value="5576238"/>
      <value value="8990799"/>
      <value value="2218962"/>
      <value value="1701443"/>
      <value value="996383"/>
      <value value="1256454"/>
      <value value="2021965"/>
      <value value="2030172"/>
      <value value="6206344"/>
      <value value="9561635"/>
      <value value="7082071"/>
      <value value="4746673"/>
      <value value="9984889"/>
      <value value="2671966"/>
      <value value="4676712"/>
      <value value="7264151"/>
      <value value="7665296"/>
      <value value="9020410"/>
      <value value="172700"/>
      <value value="5233268"/>
      <value value="2347719"/>
      <value value="5247906"/>
      <value value="5056005"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;Stage2&quot;"/>
      <value value="&quot;Stage2b&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.278"/>
      <value value="0.333"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="86"/>
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
      <value value="0.7061902729853853"/>
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
      <value value="800000"/>
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
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incur_phase_limit">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_recovered_prop">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_rate_mult">
      <value value="1"/>
      <value value="0"/>
      <value value="1.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_tran_reduct">
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_wane">
      <value value="2.1651530990907109E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vaceffdays">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailycases">
      <value value="5000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="86"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="86"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="0.5446625318069637"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.85"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="0.07"/>
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
      <value value="400000"/>
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
      <value value="2.5E-4"/>
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
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="variant_transmiss_growth">
      <value value="1.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_radius">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="yearly_recover_prop_loss">
      <value value="0"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Stage0_PK" repetitions="1" runMetricsEveryStep="false">
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
      <value value="3667632"/>
      <value value="6380500"/>
      <value value="3041976"/>
      <value value="1501689"/>
      <value value="7285035"/>
      <value value="7048014"/>
      <value value="5766311"/>
      <value value="8758952"/>
      <value value="228878"/>
      <value value="5758089"/>
      <value value="5317775"/>
      <value value="1807341"/>
      <value value="3745515"/>
      <value value="5690740"/>
      <value value="1895863"/>
      <value value="6218729"/>
      <value value="9778553"/>
      <value value="2489185"/>
      <value value="6093113"/>
      <value value="1822987"/>
      <value value="5601946"/>
      <value value="1378969"/>
      <value value="611220"/>
      <value value="2939393"/>
      <value value="5507881"/>
      <value value="9959199"/>
      <value value="1322658"/>
      <value value="8983203"/>
      <value value="2119286"/>
      <value value="6376405"/>
      <value value="414113"/>
      <value value="3905340"/>
      <value value="3111763"/>
      <value value="5804440"/>
      <value value="1470987"/>
      <value value="289365"/>
      <value value="7010446"/>
      <value value="4514619"/>
      <value value="5141569"/>
      <value value="5548050"/>
      <value value="1140630"/>
      <value value="2886742"/>
      <value value="6480151"/>
      <value value="7288130"/>
      <value value="88642"/>
      <value value="4367041"/>
      <value value="9983327"/>
      <value value="4614713"/>
      <value value="8625681"/>
      <value value="386748"/>
      <value value="4959780"/>
      <value value="5565312"/>
      <value value="9021582"/>
      <value value="6204496"/>
      <value value="5871950"/>
      <value value="9764191"/>
      <value value="3143818"/>
      <value value="7979887"/>
      <value value="8201889"/>
      <value value="9659003"/>
      <value value="5671494"/>
      <value value="2075005"/>
      <value value="5633"/>
      <value value="6313129"/>
      <value value="4792626"/>
      <value value="9854799"/>
      <value value="3277288"/>
      <value value="896651"/>
      <value value="6000347"/>
      <value value="6894939"/>
      <value value="4982909"/>
      <value value="5847877"/>
      <value value="2055454"/>
      <value value="1569828"/>
      <value value="4463111"/>
      <value value="1388088"/>
      <value value="6612645"/>
      <value value="261499"/>
      <value value="9217918"/>
      <value value="3037905"/>
      <value value="9253642"/>
      <value value="9189361"/>
      <value value="5811340"/>
      <value value="7005938"/>
      <value value="8839521"/>
      <value value="755056"/>
      <value value="9662391"/>
      <value value="1652937"/>
      <value value="5239306"/>
      <value value="379103"/>
      <value value="363711"/>
      <value value="4629403"/>
      <value value="6088911"/>
      <value value="8699519"/>
      <value value="7383138"/>
      <value value="9317928"/>
      <value value="9760099"/>
      <value value="1859641"/>
      <value value="7367493"/>
      <value value="5856826"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;None&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.278"/>
      <value value="0.333"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
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
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="365"/>
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
      <value value="0.8777083226180689"/>
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
      <value value="80"/>
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
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maskpolicy">
      <value value="false"/>
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
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_tran_reduct">
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_wane">
      <value value="1.6654183697917269E-4"/>
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
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="0.4143362383886424"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.85"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="0.07"/>
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
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set_shape">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="span">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptomatic_trans">
      <value value="0.75"/>
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
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="variant_transmiss_growth">
      <value value="1.3"/>
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
  <experiment name="Sensitivity_PK" repetitions="1" runMetricsEveryStep="false">
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
      <value value="6352613"/>
      <value value="2428091"/>
      <value value="9902052"/>
      <value value="7352207"/>
      <value value="7819096"/>
      <value value="3505142"/>
      <value value="1314294"/>
      <value value="9161346"/>
      <value value="7296398"/>
      <value value="6632173"/>
      <value value="8141586"/>
      <value value="8042954"/>
      <value value="3525135"/>
      <value value="4932182"/>
      <value value="4892937"/>
      <value value="8400204"/>
      <value value="3804953"/>
      <value value="7168846"/>
      <value value="508457"/>
      <value value="1148186"/>
      <value value="825538"/>
      <value value="6944173"/>
      <value value="30731"/>
      <value value="1213823"/>
      <value value="6301890"/>
      <value value="1305783"/>
      <value value="5446436"/>
      <value value="5661121"/>
      <value value="4193997"/>
      <value value="7111146"/>
      <value value="7688177"/>
      <value value="5251534"/>
      <value value="72632"/>
      <value value="3929068"/>
      <value value="4367688"/>
      <value value="4382893"/>
      <value value="1487768"/>
      <value value="6495647"/>
      <value value="6811604"/>
      <value value="5858275"/>
      <value value="3241384"/>
      <value value="7170992"/>
      <value value="1600173"/>
      <value value="2939918"/>
      <value value="2510029"/>
      <value value="4996556"/>
      <value value="191278"/>
      <value value="1985412"/>
      <value value="6624991"/>
      <value value="804995"/>
      <value value="2948312"/>
      <value value="9655697"/>
      <value value="1205215"/>
      <value value="9620961"/>
      <value value="8172725"/>
      <value value="909300"/>
      <value value="9850929"/>
      <value value="9856074"/>
      <value value="7585748"/>
      <value value="7930328"/>
      <value value="7232469"/>
      <value value="4575561"/>
      <value value="2307003"/>
      <value value="4904450"/>
      <value value="9216730"/>
      <value value="9889717"/>
      <value value="4604471"/>
      <value value="8931686"/>
      <value value="7207299"/>
      <value value="6009112"/>
      <value value="3172899"/>
      <value value="3402841"/>
      <value value="2254912"/>
      <value value="3428214"/>
      <value value="3742910"/>
      <value value="929476"/>
      <value value="7638783"/>
      <value value="5576238"/>
      <value value="8990799"/>
      <value value="2218962"/>
      <value value="1701443"/>
      <value value="996383"/>
      <value value="1256454"/>
      <value value="2021965"/>
      <value value="2030172"/>
      <value value="6206344"/>
      <value value="9561635"/>
      <value value="7082071"/>
      <value value="4746673"/>
      <value value="9984889"/>
      <value value="2671966"/>
      <value value="4676712"/>
      <value value="7264151"/>
      <value value="7665296"/>
      <value value="9020410"/>
      <value value="172700"/>
      <value value="5233268"/>
      <value value="2347719"/>
      <value value="5247906"/>
      <value value="5056005"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="gather_location_count">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_policy">
      <value value="&quot;ModerateSupress&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="global_transmissibility">
      <value value="0.278"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stage_test_index">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate_stage_switch">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="case_reporting_delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_bound">
      <value value="86"/>
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
      <value value="0.7061902729853853"/>
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
      <value value="800000"/>
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
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_incur_phase_limit">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="asymptom_prop">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_recovered_prop">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_trigger_loosen">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_rate_mult">
      <value value="1.5"/>
      <value value="1"/>
      <value value="0.75"/>
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_tran_reduct">
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_uptake">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vac_wane">
      <value value="2.1651530990907109E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="param_vaceffdays">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="population">
      <value value="2500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="presimdailycases">
      <value value="5000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="profile_on">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_people_avoid">
      <value value="86"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion_time_avoid">
      <value value="86"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="accept_isolation_prop">
      <value value="0.5446625318069637"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recov_var_match_rate">
      <value value="0.85"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recovered_match_rate">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="report_proportion">
      <value value="0.07"/>
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
      <value value="400000"/>
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
      <value value="2.5E-4"/>
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
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="variant_transmiss_growth">
      <value value="1.45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="visit_frequency">
      <value value="0.03"/>
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
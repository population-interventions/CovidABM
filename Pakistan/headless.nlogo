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
12.0
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
0.002
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
28.5
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
28.5
.5
1
NIL
HORIZONTAL





INPUTBOX
217
325
322
386
initial_cases
800000.0
1
0
Number

INPUTBOX
217
458
324
520
total_population
2.34E8
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
14
450
199
483
Global_Transmissibility
Global_Transmissibility
0
1
0.278
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
75.0
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
25.0
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
8.0
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








SLIDER
1268
1004
1475
1037
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
0
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
5056005.0
1
1
NIL
HORIZONTAL



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
197
362
param_vac_tran_reduct
param_vac_tran_reduct
0.5
1
0.75
0.005
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

INPUTBOX
217
390
322
450
secondary_cases
400000.0
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
3

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
25.0
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
730.0
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



SWITCH
1470
751
1574
784
track_R
track_R
1
1
-1000






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
0.0
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
2.9844761380326545E-4
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
1.5
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
0.05
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
5000.0
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
1.3
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
0.7484634195823882
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


SLIDER
303
850
534
883
vac_variant_eff_prop
vac_variant_eff_prop
0
1
0.8
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
0.5
0.1
1
NIL
HORIZONTAL


SLIDER
19
147
191
180
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
19
109
194
142
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
0.07
0.01
1
NIL
HORIZONTAL


SLIDER
775
1020
1023
1053
accept_isolation_prop
accept_isolation_prop
0
1
0.2514081206119717
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
0.021674705343927902
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
1
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
      <value value="&quot;ModerateSupress_No_4&quot;"/>
      <value value="&quot;ModerateSupress&quot;"/>
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
      <value value="5"/>
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
      <value value="0.8"/>
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccine_available">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="variant_transmiss_growth">
      <value value="1.3"/>
      <value value="1.45"/>
      <value value="1.6"/>
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
      <value value="0.28"/>
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
      <value value="82"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="complacency_loss">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="calibrate">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="end_day">
      <value value="121"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_variant_2_prop">
      <value value="0"/>
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
      <value value="20"/>
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
      <value value="40"/>
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

Note that dose_rate.csv, population.csv and vaccine_rollout.csv are now variables in the model so may have different names.
Also, population.csv and vaccine_rollout.csv can be paired with suffixes.

=== population.csv ===
This file defines the characteristics of the agents in the model. There are always 2500 agents, which scale to each represent 10^n people in the population for n \in {0, 1, 2, 3, 4}. Each row is a cohort of agents that have the same basic characteristics.

Many parameters are a boolean, which should be indicated by a value of 1 or 0.

 - totalAgents       sets the size of the cohort. This column must sum to 2500
 - age               sets the singular age of the cohort.
 - atsi              sets whether the cohort are aborigional or torris strait islanders.
 - disability        sets whether the cohort has a disability.
 - essentialCount    is how many workers in the cohort are the most essential workers.
 - workerCount       is how many agents for the cohort are considered to be working age.
 - phase             is the phase in which the cohort is vacinated.
 - subPhase          is the sub phase of vaccination. Ie the 'a' or 'b' after 1a or 1b
 - spanMult          is a multiplier to the speed of the cohort.
 - gatherFreqMult    is a multiplier to how often the cohort gathers at central locations.
 - region            is the region index of the cohort. See region.csv
 - succeptibleMult   is a multiplier for the chance of being infected.
 - asymptomPropMult  is a multiplier to the base proportion of the population that is asymptomatic.
 - vaccinatedCount   is the number of members of the cohort that start vaccinated.
 - doseProgressMin   defines a uniform distribution of dose progression in combination with doseProgressMax.
 - doseProgressMax   as above, and described below. Should be at least doseProgressMin.
 - ignoreUptakeBoost ignores the effect of uptakeBoost. See vaccination.
 - studentCount      is how many members of the cohort are students.
 - vaccineType       the name of the vaccine availible to this cohort. This should match the names in vaccine_params.csv.
 - vaccineBranch     the name of the parallel vaccine rollout branch. Matches branch in vaccine_rollout.csv.

Use doseProgressMin and doseProgressMax to define a range [doseProgressMin, doseProgressMax] from which pre-model vaccinated simulants draw their vacWaitDays. A simulant which draws a doseProgress <= 0 has just received their vaccination so must wait the full dose period for their vaccine. Likewise, a simulant with doseProgress >= 1 is assumed to have their second dose when the model starts. Draws between 0 and 1 set vacWaitDays between zero and maximum.

A uniform distribution on a subset of . A simulant that draws 0 has to wait the full duration for a second dose, a simulant with a draw of 1 already had its second dose. A simulant that draws 0.5 is halfway until its second dose.

A worker being essential causes the cohort to have the highest priority for going to work during a lockdown. For example, say we are in a lockdown where the policy sets 25% of workers to be regarded as essential. If only 15% of the total workers are in an 'essential' cohort, then all of the essential cohort works, with the remaining 10% made up of other workers.

alreadyVaccinated does nothing for the moment, but will be used to set the number of initially vacciated members of the cohort.
The comment column does nothing in the model.

=== region.csv ===
This file configures the properties of cohorts from different regions. Simulants only live together if they are from the same region.

 - region            the region index. Corresponds to the value in population.csv.
 - start             lower y coordinate for the region position. Simulants only set their houses within this band.
 - end               upper y coordinate for the band within which simulants of the region have houses.
 - houseSize         mean house size for this region.
 - houseSizeRange    distance to the upper and lower bounds from the mean for house size in this region.

Note that regions can overlap so this could be used to control the house sizes for cohorts. As with cohorts, try to avoid creating too many regions as the approximations required to squeeze the 2500 simulants into appropriate fractions become increasingly questionable.

=== vaccine_rollout.csv ===
This file configures the phase structure of the simulation. Currently the population in the D column had better match the sums of the populations in each corresponding phase and subPhase in population.csv.

 - branch            the branch of the rollout. Multiple rollouts can happen to different cohorts in parallel.
 - phase             is the phase.
 - subPhase          is the letter after the phase, but as a number.
 - rateMult          multiplier for the speed of vaccination in this phase.
 - uptake            multiplier for the vaccine uptake in this phase.
 - firstDosePriority set to 1 to spend the phase issuing first doses, otherwise prefer second doses over first.

The order of the rows within each branch is the order of the steps in each parallel rollout.

=== dose_rate.csv ===
Each column corresponds to a parallel branch defined by the branch column in vaccine_rollout.csv.
Each row is a day, starting at day 0. 
Each entry is the number of agent-doses added to a parallel branch on each day.
Note that these doses are used for first and second shots, and that each agent requires two doses to be fully vaccinated.

=== vaccine_params.csv ===
This file configures the effectiveness of each of the vaccine types.

 - name              this is the name of the vaccine. It is used to match cohorts to vaccine types via vaccineType in population.csv.
 - reductTrans_a     alpha in the beta distribution for transmission risk reduction - ie for catching the virus.
 - reductTrans_b     beta in the beta distribution for transmission risk reduction.
 - reductArea_a      alpha in the beta distribution for infectivity area.
 - reductArea_b      beta in the beta distribution for infectivity area.
 - partialDays       minimum days between first and second doses. May be higher in practise if a dose is not availible.
 - partialTransMult  multiplier to transmission risk reduction for only having one dose.
 - partialAreaMult   multiplier to infectivity area reduction for only having one dose.
 - vacEffectDays     days of delay for a dose to take effect.

Infectivity area is the product of peak infectivity reduction and illness duration reduction.

Each vaccine has a global draw for its beta in each simulation, so all simulants with the same vaccine have the same vaccine effectiveness. 

=== incursion.csv ===
This file sets the rate of incursions.

 - days              is how long this phase of incursion settings lasts
 - unVaccArrive      is how many unvaccinated people arrive.
 - unVaccRisk        is the chance of an unvaccinated arrival making it to the community.
 - vaccArrive        is how many vaccinated people arrive.
 - vaccRisk          is the chance of a vaccinated person making it to the community.
 - vaccineType       is the vaccine type of vaccinated people.
 - variant           is the variant (a number 1, 2 etc) that is brought in by incursions.
 - varReplaceChance  is the probability of the new variant being spontaneously created when a simulant infects another simulant.
 - present_a         alpha value for symptomatic present proportion override draw when the phase is entered. Set to 0 to not override.
 - present_b         beta value for symptomatic present proportion override draw when the phase is entered.

The purpose of varReplaceChance is to introduce the new variant at a set time without worrying about the scale issues around incursions.

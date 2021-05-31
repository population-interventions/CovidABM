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
 - ignoreUptakeBoost ignores the effect of uptakeBoost. See vaccination.
 - studentCount      is how many members of the cohort are students.
 - vaccineType       the name of the vaccine availible to this cohort. This should match the names in vaccine_params.csv.

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

 - phase             is the phase.
 - subPhase          is the letter after the phase, but as a number.
 - days              is the number of days spent in this phase.
 - fixedSpeed        can be set to 1 to make the phase ignore param_vac_rate_mult. Otherwise set to 0.
 - uptakeBoost       overrides uptake and vaccinates previous vaccine refusers.

The parameter uptakeBoost ofen only makes sense near the end of the rollout. It gives cohorts a chance to boost their vaccination rate, unless the cohort has (ignoreUptakeBoost = 1). To do this it overrides param_vac_uptake (if higher) and adds simulants with (vaccinated = 0 and vaccineOffered = 1 and sm_vac_uptake < global_vaccineUptakeOverride) to the population to be vaccinated by this phase by giving them (vaccineOffered = 0). Cohorts in this phase use global_vaccineUptakeOverride as their uptake (if higher), unless they have (ignoreUptakeBoost = 1).

The comment column is for human consumption. It does nothing in the model.

The rate of vaccination is calculated by the model, and is simply set to population/days. This many vaccines will be offered to agents each day. This value does not need to be an integer, as fractional vaccine is carried between days, avoiding the issues that may arise with small intergers.

=== vaccine_params.csv ===
This file configures the effectiveness of each of the vaccine types.

 - name              this is the name of the vaccine. It is used to match cohorts to vaccine types via vaccineType in population.csv.
 - reductTrans_a     alpha in the beta distribution for transmission risk reduction - ie for catching the virus.
 - reductTrans_b     beta in the beta distribution for transmission risk reduction.
 - reductArea_a      alpha in the beta distribution for infectivity area.
 - reductArea_b      beta in the beta distribution for infectivity area.

Infectivity area is the product of peak infectivity reduction and illness duration reduction.

Each vaccine has a global draw for its beta in each simulation, so all simulants with the same vaccine have the same vaccine effectiveness. 

=== incursion.csv ===
This file sets the rate of incursions.

 - days              is how long this phase of incursion settings lasts
 - incursionScale    is a multiplier for the probability of any given infected arrival infecting someone in the community.
 - infectedArrivals  is the number of oppotunities availible to infect a member of the community, per day.
 - variant           is the variant (a number 1, 2 etc) that is brought in by incursions.
 - varReplaceChance  is the probability of the new variant being spontaneously created when a simulant infects another simulant.

The purpose of varReplaceChance is to introduce the new variant at a set time without worrying about the scale issues around incursions.

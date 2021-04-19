=== population.csv ===
This file defines the characteristics of the agents in the model. There are always 2500 agents, which scale to each represent 10^n people in the population for n \in {0, 1, 2, 3, 4}. Each row is a cohort of agents that have the same basic characteristics.

Many parameters are a boolean, which should be indicated by a value of 1 or 0.

 - totalAgents      sets the size of the cohort. This column must sum to 2500
 - age              sets the singular age of the cohort.
 - atsi             sets whether the cohort are aborigional or torris strait islanders.
 - disability       sets whether the cohort has a disability.
 - essential        sets whether the workers in the cohort are the most essential workers.
 - workerCount      is how many agents for the cohort are considered to be working age.
 - phase            is the phase in which the cohort is vacinated.
 - subPhase         is the sub phase of vaccination. Ie the 'a' or 'b' after 1a or 1b
 - spanMult         is a multiplier to the speed of the cohort.
 - gatherFreqMult   is a multiplier to how often the cohort gathers at central locations.
 - region           is the region index of the cohort. See region.csv
 - succeptibleMult  is a multiplier for the chance of being infected.
 - asymptomPropMult is a multiplier to the base proportion of the population that is asymptomatic.

A worker being essential causes the cohort to have the highest priority for going to work during a lockdown. For example, say we are in a lockdown where the policy sets 25% of workers to be regarded as essential. If only 15% of the total workers are in an 'essential' cohort, then all of the essential cohort works, with the remaining 10% made up of other workers.

alreadyVaccinated does nothing for the moment, but will be used to set the number of initially vacciated members of the cohort.
The comment column does nothing in the model.

=== region.csv ===
This file configures the properties of cohorts from different regions. Simulants only live together if they are from the same region.

 - region           the region index. Corresponds to the value in population.csv.
 - start            lower y coordinate for the region position. Simulants only set their houses within this band.
 - end              upper y coordinate for the band within which simulants of the region have houses.
 - houseSize        occupants-per-house for simulants in this region.

Note that regions can overlap so this could be used to control the house sizes for cohorts. As with cohorts, try to avoid creating too many regions as the approximations required to squeeze the 2500 simulants into appropriate fractions become increasingly questionable.

=== vaccine.csv ===
This file configures the phase structure of the simulation. Currently the population in the D column had better match the sums of the populations in each corresponding phase and subPhase in population.csv.

 - phase            is the phase.
 - subPhase         is the letter after the phase, but as a number.
 - days             is the number of days spent in this phase.
 - name             is the name of the vaccine in this phase. It is used by the model to change the non-static parameters in the model.

The comment column is for human consumption. It does nothing in the model.

The rate of vaccination is calculated by the model, and is simply set to population/days. This many vaccines will be offered to agents each day. This value does not need to be an integer, as fractional vaccine is carried between days, avoiding the issues that may arise with small intergers.

=== incursion.csv ===
This file sets the rate of incursions.

 - days             is how long this phase of incursion settings lasts
 - incursionScale   is a multiplier for the probability of any given infected arrival infecting someone in the community.
 - infectedArrivals is the number of oppotunities availible to infect a member of the community, per day.

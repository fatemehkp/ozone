srun --partition=short  --nodes 1 --ntasks 1 --cpus-per-task 2 --pty --export=ALL --mem=200G --time=24:00:00 /bin/bash
/shared/centos7/r-project/3.6.1/bin/R

library(tidyverse)
library(here)
library(survival)
library(stringi)

load(here('data','analysis','ndi-ozone-race.RDa'))


cuz1 <- c("allcuz","cvd","ihd")
dt.ndi.ozone.race <- dt.ndi.ozone.race %>% 
  mutate(race = as.factor(case_when(race != "H" ~ "O",
                                    T ~ as.character(race))),
         StrID = stri_replace_all_regex(StrID,
                                        pattern = c('A', 'B', 'W'),
                                        replacement = c('O'), vectorize = F),
         race = relevel(race, ref = "H"))

race.H = matrix(nrow = 1, ncol = 5, byrow = T) 
colnames(race.H) <- c("race_Cat","Outcome","O3_B","O3_SE","pValue")

for (Y in cuz1){
  glm_model <- glm(dt.ndi.ozone.race[ ,paste0('no_death_', Y, sep = "")] ~ 
                     O3maxh*race + PM + State + ses + strata(StrID), 
                   offset = (log(no_enrollee)), 
                   data = dt.ndi.ozone.race, family = poisson(link = "log"))
  out = matrix(nrow = 1, ncol = 5, byrow = T) 
  colnames(out) <- c("race_Cat","Outcome","O3_B","O3_SE","pValue")
  out[1,1]<- "Hispanic" 
  out[1,2]<- Y
  # Ozone
  out[1,3] <- coef(glm_model)['O3maxh']
  out[1,4] <- summary(glm_model)$coefficients['O3maxh',2]
  out[1,5] <- summary(glm_model)$coefficients['O3maxh:raceO',4]
  race.H <- rbind(race.H, out)
}

save(race.H, file = here('output', 'analysis', 'out-raceH-1.RDa'))


cuz2 <- c("chf","cbv", "resp","copd","pneu")
dt.ndi.ozone.race <- dt.ndi.ozone.race %>% 
  mutate(race = as.factor(case_when(race != "H" ~ "O",
                                    T ~ as.character(race))),
         StrID = stri_replace_all_regex(StrID,
                                        pattern = c('A', 'B', 'W'),
                                        replacement = c('O'), vectorize = F),
         race = relevel(race, ref = "H"))

race.H = matrix(nrow = 1, ncol = 5, byrow = T) 
colnames(race.H) <- c("race_Cat","Outcome","O3_B","O3_SE","pValue")

for (Y in cuz2){
  glm_model <- glm(dt.ndi.ozone.race[ ,paste0('no_death_', Y, sep = "")] ~ 
                     O3maxh*race + PM + State + ses + strata(StrID), 
                   offset = (log(no_enrollee)), 
                   data = dt.ndi.ozone.race, family = poisson(link = "log"))
  out = matrix(nrow = 1, ncol = 5, byrow = T) 
  colnames(out) <- c("race_Cat","Outcome","O3_B","O3_SE","pValue")
  out[1,1]<- "Hispanic" 
  out[1,2]<- Y
  # Ozone
  out[1,3] <- coef(glm_model)['O3maxh']
  out[1,4] <- summary(glm_model)$coefficients['O3maxh',2]
  out[1,5] <- summary(glm_model)$coefficients['O3maxh:raceO',4]
  race.H <- rbind(race.H, out)
}

save(race.H, file = here('output', 'analysis', 'out-raceH-2.RDa'))


cuz3 <- c("canc","lungc", "seps", "VaD","AD")
dt.ndi.ozone.race <- dt.ndi.ozone.race %>% 
  mutate(race = as.factor(case_when(race != "H" ~ "O",
                                    T ~ as.character(race))),
         StrID = stri_replace_all_regex(StrID,
                                        pattern = c('A', 'B', 'W'),
                                        replacement = c('O'), vectorize = F),
         race = relevel(race, ref = "H"))

race.H = matrix(nrow = 1, ncol = 5, byrow = T) 
colnames(race.H) <- c("race_Cat","Outcome","O3_B","O3_SE","pValue")

for (Y in cuz3){
  glm_model <- glm(dt.ndi.ozone.race[ ,paste0('no_death_', Y, sep = "")] ~ 
                     O3maxh*race + PM + State + ses + strata(StrID), 
                   offset = (log(no_enrollee)), 
                   data = dt.ndi.ozone.race, family = poisson(link = "log"))
  out = matrix(nrow = 1, ncol = 5, byrow = T) 
  colnames(out) <- c("race_Cat","Outcome","O3_B","O3_SE","pValue")
  out[1,1]<- "Hispanic" 
  out[1,2]<- Y
  # Ozone
  out[1,3] <- coef(glm_model)['O3maxh']
  out[1,4] <- summary(glm_model)$coefficients['O3maxh',2]
  out[1,5] <- summary(glm_model)$coefficients['O3maxh:raceO',4]
  race.H <- rbind(race.H, out)
}

save(race.H, file = here('output', 'analysis', 'out-raceH-3.RDa'))


cuz4 <- c("UsD", "diabt1", "diabt2", "diab", "kidn")
dt.ndi.ozone.race <- dt.ndi.ozone.race %>% 
  mutate(race = as.factor(case_when(race != "H" ~ "O",
                                    T ~ as.character(race))),
         StrID = stri_replace_all_regex(StrID,
                                        pattern = c('A', 'B', 'W'),
                                        replacement = c('O'), vectorize = F),
         race = relevel(race, ref = "H"))

race.H = matrix(nrow = 1, ncol = 5, byrow = T) 
colnames(race.H) <- c("race_Cat","Outcome","O3_B","O3_SE","pValue")

for (Y in cuz4){
  glm_model <- glm(dt.ndi.ozone.race[ ,paste0('no_death_', Y, sep = "")] ~ 
                     O3maxh*race + PM + State + ses + strata(StrID), 
                   offset = (log(no_enrollee)), 
                   data = dt.ndi.ozone.race, family = poisson(link = "log"))
  out = matrix(nrow = 1, ncol = 5, byrow = T) 
  colnames(out) <- c("race_Cat","Outcome","O3_B","O3_SE","pValue")
  out[1,1]<- "Hispanic" 
  out[1,2]<- Y
  # Ozone
  out[1,3] <- coef(glm_model)['O3maxh']
  out[1,4] <- summary(glm_model)$coefficients['O3maxh',2]
  out[1,5] <- summary(glm_model)$coefficients['O3maxh:raceO',4]
  race.H <- rbind(race.H, out)
}

save(race.H, file = here('output', 'analysis', 'out-raceH-4.RDa'))

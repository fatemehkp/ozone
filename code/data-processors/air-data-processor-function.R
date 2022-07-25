### Author: Fatemeh Kazemi - 01-01-2021

library(tidyverse)
library(lubridate)

# Air_Hourly_Process function
### Function *** Air_Hourly_Process ***
### Processes Hourly data 
### Chooses a subset of monitors on the basis of: 
### ... A minimum for number of :
### ... Hourly measurements per Day,
### ... Daily measurements per Month,
### ... Months with minimum daily measurements per Year
### ... Years with minimum Month and Day

# Function Arguments: 
# m1 : start month ( m1= 4(warm season) & 1(whole year))
# m2 : end month   ( m2= 9(warm season) & 12(whole year))
# h : minimum number of hours per day
# d : minimum number of days per month
# m : minimum numbers of month per year
# y : minimum numbers of years per period
# Packages: tidyverse; lubridate

Air.Hourly.Process <- function(dt, m1, m2, h, d, m, y) {
  # identify qualified monitors and merged it with dt (hourly dataset)
  dt.c <- dt %>%
    mutate(Year = year(Date),
           Month = month(Date),
           Day = day(Date)) %>% 
    filter(between(Month, m1, m2)) %>% 
    group_by(Monitor.ID, Year, Month, Day) %>%
    summarize(n_Hour = length(unique(Time))) %>%
    filter(n_Hour >= h
    ) %>% #monitors wt at least -h- hours each day
    group_by(Monitor.ID, Year, Month) %>%
    summarize(n_Day = length(unique(Day))) %>%
    filter(n_Day >= d
    ) %>% #monitors wt at least -d- days each month 
    group_by(Monitor.ID, Year) %>%
    summarize(n_Month = length(unique(Month))) %>%
    filter(n_Month >= m
    ) %>% #monitors wt at least -m- month each year
    group_by(Monitor.ID) %>%
    summarize(n_Year = length(unique(Year))) %>%
    filter(n_Year >= y
    ) %>% #monitors wt at least -y- year in start-end period
    merge(dt
    ) %>% 
    select(-n_Year)
  return(dt.c)
}

### Author: Fatemeh Kazemi - 01-15-2021

# Function that Downloads and cleans air quality data measured by EPA 
# https://aqs.epa.gov/aqsweb/airdata/download_files.html

# EPA.AQS.download.h Function
# Function Arguments: 
# period : hourly
# Index : list of file index to download
# start : start year 
# end : end year
# Packages: tidyverse, lubridate

library(tidyverse)
library(lubridate)

EPA.AQS.download.h <- function(period, Index, start, end) {
  
  dt = data.frame()
  for (i in Index) {
    for (t in start:end) {
      temp <- tempfile()
      download.file(paste("https://aqs.epa.gov/aqsweb/airdata/",period,"_",i,"_",t
                          ,".zip",sep = ""),temp)
      dt0 <- read.csv(unz(temp, paste(period,"_",i,"_",t,".csv", sep = "")))
      dt <- rbind(dt, dt0)
    }
  }
  
  dt <- dt %>% 
    filter(!State.Name %in% c("Alaska","Hawaii","Puerto Rico","Virgin Islands",
                              "Country Of Mexico","Canada") #remove nonCONUS
    ) %>%
    transmute(
      #unique ID for each Site: ss-ccc-nnnn
      Site.ID = as.factor(sprintf("%02d-%03d-%04d",
                                  as.numeric(as.character(State.Code)),
                                  County.Code, Site.Num)),
      POC,
      #unique ID for each Monitor: ss-ccc-nnnn-pp
      Monitor.ID = as.factor(sprintf("%02d-%03d-%04d-%02d",
                                     as.numeric(as.character(State.Code)),
                                     County.Code, Site.Num, POC)),
      Parameter.Code,
      Parameter.Name,
      Date = ymd(Date.Local),
      Time = Time.Local,
      Sample.Measurement
    ) %>%
    select(Site.ID, POC, Monitor.ID, Parameter.Code, Parameter.Name, Date, Time,
           Sample.Measurement) %>% 
    arrange(Site.ID, POC, Date, Time) 
  return(dt)
}




# EPA.AQS.download.8h Function
# Function Arguments: 
# period : 8hour
# Index : list of file index to download
# start : start year 
# end : end year
# Packages: tidyverse, lubridate

EPA.AQS.download.8h <- function(period, Index, start, end) {
  
  dt = data.frame()
  for (i in Index) {
    for (t in start:end) {
      temp <- tempfile()
      download.file(paste("https://aqs.epa.gov/aqsweb/airdata/",period,"_",i,"_",t
                          ,".zip",sep = ""),temp)
      dt0 <- read.csv(unz(temp, paste(period,"_",i,"_",t,".csv", sep = ""))) %>% 
        mutate(State.Code = as.factor(State.Code))
      dt <- rbind(dt, dt0)
    }
  }
  
  dt <- dt %>% 
    filter(!State.Code %in% c("02","15","72","78","80","CC") #remove nonCONUS
    ) %>%
    transmute(
      #unique ID for each Site: ss-ccc-nnnn
      Site.ID = as.factor(sprintf("%02d-%03d-%04d",
                                  as.numeric(as.character(State.Code)),
                                  County.Code, Site.Num)),
      POC,
      #unique ID for each Monitor: ss-ccc-nnnn-pp
      Monitor.ID = as.factor(sprintf("%02d-%03d-%04d-%02d",
                                     as.numeric(as.character(State.Code)),
                                     County.Code, Site.Num, POC)),
      Parameter.Code,
      Parameter.Name,
      Date = ymd(Date.Local),
      Time = Time.Local,
      Mean.Including.All.Data
    ) %>%
    select(Site.ID, POC, Monitor.ID, Parameter.Code, Parameter.Name, Date, Time,
           Mean.Including.All.Data) %>% 
    arrange(Site.ID, POC, Date, Time) 
  return(dt)
}


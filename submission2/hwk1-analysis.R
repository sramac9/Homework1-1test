
# Meta --------------------------------------------------------------------

## Title:         Econ/HLTH 470 Homework 1 Answers
## Author:        Sammy Ramacher
## Date Created:  1/29/2025
## Date Edited:   1/31/2025
## Description:   This file renders/runs all relevant R code for the assignment


# Preliminaries -----------------------------------------------------------

if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stringr, readxl, data.table, gdata, scales)


# Read data and set workspace for knitr -------------------------------
full.ma.data <- readRDS('data/output/final_ma_data.rds')
contract.service.area <- readRDS('data/output/servicearea_data2015')

# Create objects for markdown ---------------------------------------------

plan.type.table <- full.ma.data %>% group_by(plan_type) %>% count() %>% arrange(-n)
tot.obs <- as.numeric(count(full.ma.data %>% ungroup()))
plan.type.year1 <- full.ma.data %>% group_by(plan_type) %>% count() %>% arrange(-n) %>% filter(plan_type!="NA")

final.plans <- full.ma.data %>%
  filter(snp == "No" & eghp == "No" &
           (planid < 800 | planid >= 900))
plan.type.year2 <- final.plans %>% group_by(plan_type) %>% count() %>% arrange(-n)

plan.type.enroll <- final.plans %>% group_by(plan_type) %>% summarize(n=n(), enollment=mean(enrollment, na.rm=TRUE)) %>% arrange(-n)

final.data <- final.plans %>%
  inner_join(contract.service.area %>% 
               select(contractid, fips, year), 
             by=c("contractid", "fips", "year")) %>%
  filter(!is.na(enrollment))

rm(list=c("full.ma.data", "contract.service.area", "final.data"))
save.image("submission2/Hwk1_workspace.Rdata")

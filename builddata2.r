
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stringr, readxl, data.table, gdata)


# service area data

    service.area=read_csv("data/input/MA_Cnty_SA_2015_01.csv",skip=1,
                          col_names=c("contractid","org_name","org_type","plan_type","partial","eghp",
                                      "ssa","fips","county","state","notes"),
                          col_types = cols(
                            contractid = col_character(),
                            org_name = col_character(),
                            org_type = col_character(),
                            plan_type = col_character(),
                            partial = col_logical(),
                            eghp = col_character(),
                            ssa = col_double(),
                            fips = col_double(),
                            county = col_character(),
                            notes = col_character()
                          ), na='*')

service.area = service.area %>%
  mutate(month = 01, year = 2015)

# Fill missing fips codes (by state and county)
service.area = service.area %>%
  group_by(state, county) %>%
  fill(fips)

# Fill missing values for plan type, org info, partial status, and eghp status (by contractid)
service.area = service.area %>%
  group_by(contractid) %>%
  fill(plan_type, partial, eghp, org_type, org_name)

saveRDS(service.area, file = "data/output/servicearea_data2015")
    
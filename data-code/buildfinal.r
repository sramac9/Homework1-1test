

#read in data

full.ma.data <- read_rds("data/output/ma_data2015")
contract.service.area <- read_rds("data/output/servicearea_data2015")


#join dataset
final.data <- full.ma.data %>%
  inner_join(contract.service.area %>% 
               select(contractid, fips, year), 
             by=c("contractid", "fips", "year")) %>%
  filter(!state %in% c("VI","PR","MP","GU","AS","") &
           snp == "No" &
           (planid < 800 | planid >= 900) &
           !is.na(planid) & !is.na(fips))

saveRDS(final.data, file = "data/output/final_ma_data.rds")


# Meta --------------------------------------------------------------------
# Author:        Ian McCarthy
# Date Created:  7/8/2019
# Date Edited:   1/24/2022
# Notes:         R file to build Medicare Advantage dataset



# Preliminaries -----------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stringr, readxl, data.table, gdata)



# Call individual scripts -------------------------------------------------

source("data-code/1_Plan_Data.R")
source("data-code/2_Plan_Characteristics.R")
source("data-code/3_Service_Areas.R")
source("data-code/4_Penetration_Files.R")


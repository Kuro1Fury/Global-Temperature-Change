library(dplyr)
# Read in the data
global<-read.csv("data/GlobalTemperatures.csv")

summary_info <- list()

summary_info$num_observations <- nrow(global)

summary_info$max_land_temp <- global %>%
  filter(LandMaxTemperature==max(LandMaxTemperature, na.rm=TRUE)) %>%
  pull(LandMaxTemperature)

summary_info$min_land_temp <- global %>%
  filter(LandMinTemperature==min(LandMinTemperature, na.rm=TRUE)) %>%
  pull(LandMinTemperature)

summary_info$average_land_temp <- 
  mean(global$LandAverageTemperature, na.rm=TRUE)

summary_info$average_land_ocean_temp <- 
  mean(global$LandAndOceanAverageTemperature, na.rm=TRUE)

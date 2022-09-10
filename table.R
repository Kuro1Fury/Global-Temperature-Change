library(dplyr)
library(knitr)
# Read in the data
global<-read.csv("data/GlobalTemperatures.csv")

# The average land temperature each year
average_land_by_year <- kable(tail(global %>%
  mutate(year=format(as.Date(dt), "%Y")) %>%
  group_by(year) %>%
  summarize(average = mean(LandAverageTemperature, na.rm=TRUE)), n = 10))

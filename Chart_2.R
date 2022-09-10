global_temp <- read.csv("data/GlobalTemperatures.csv")

library(tidyverse)
library(dplyr)
library(ggplot2)

temp_change <- global_temp %>% 
  drop_na(LandAverageTemperature) %>%
  mutate(dt = as.Date(dt)) %>%
  mutate(year = format(dt, "%Y")) %>%
  group_by(year) %>%
  mutate(year = as.numeric(year)) %>%
  mutate(year = as.integer(year / 10) * 10) %>%
  mutate(yearstr = paste0(year, "s")) %>%
  filter(year >= 1900, na.rm = TRUE) %>%
  filter(year <= 2010, na.rm = TRUE) %>%
  group_by(yearstr) %>%
  summarize(avg_temp = mean(LandAverageTemperature, na.rm = TRUE))


chart2 <- ggplot(temp_change, aes(x = yearstr, y = avg_temp, group = 1)) + 
  geom_line() + 
  geom_point() +
  xlab("Year(1900s to 2010s)") +
  ylab("Average Global Temperatures in Celsius") +
  ggtitle("Average Global Temperature each Decades from 1900 to 2010") +
  theme(plot.title = element_text(size = 12,face = "bold"))

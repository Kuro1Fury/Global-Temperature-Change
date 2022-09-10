data <- read.csv("data/GlobalTemperatures.csv")

library(dplyr)
library(tidyverse)
library(ggplot2)

filted_data <- data %>% 
  drop_na(LandMaxTemperature) %>%
  mutate(dt = as.Date(dt)) %>%
  mutate(year = format(dt, "%Y")) %>%
  group_by(year) %>%
  summarize(diff = max(LandMaxTemperature) - min(LandMinTemperature)) %>%
  mutate(year = as.numeric(year)) %>%
  mutate(year = as.integer(year / 10) * 10) %>%
  mutate(yearstr = paste0(year, "s")) %>%
  group_by(yearstr) %>%
  summarize(avgdiff = mean(diff))
  

chart3 <- ggplot(filted_data, aes(x = yearstr, y = avgdiff)) + 
  geom_bar(stat = "identity") + 
  xlab("Year(1850s to 2010s)") +
  ylab("Average temperature difference in Celsius") +
  ggtitle("Average Global Temperature Difference of Each Year along Decades from 1850s to 2010s") +
  theme(axis.text = element_text(size = 8),
        plot.title = element_text(size = 11,face = "bold"))
  

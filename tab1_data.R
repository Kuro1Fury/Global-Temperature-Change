library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)
library(leaflet)
library(RColorBrewer)
library(maps)
library(mapproj)
library(patchwork)

data_by_country <- read.csv("data/GlobalLandTemperaturesByCountry.csv")

data_by_country[data_by_country$Country == "United States", "Country"] <- "USA"

chosen_year_data <- function(chosen_year) {
  
  year_average_temperature <- data_by_country %>%
  mutate(dt = as.Date(dt)) %>%
  mutate(year = format(dt, "%Y")) %>%
  filter(year == chosen_year) %>%
  group_by(Country) %>%
  summarise(YearAverageTemperature = 
              mean(AverageTemperature, na.rm = T)) %>%
  filter(!is.na(YearAverageTemperature))
  
  
  global_temperature_map_data <- map_data("world") %>%
  rename(Country = region) %>%
  inner_join(year_average_temperature, by = "Country")
  
  return(global_temperature_map_data)
}

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        # remove axis lines
    axis.text = element_blank(),        # remove axis labels
    axis.ticks = element_blank(),       # remove axis ticks
    axis.title = element_blank(),       # remove axis titles
    plot.background = element_blank(),  # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank(),     # remove border around plot
    plot.title = element_text(size = 10,face = "bold")
  )


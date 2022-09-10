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

data_by_country_in_1900 <- data_by_country %>% 
  filter(dt >= "1900-01-01" & dt <= "1900-12-31") %>%
  filter(!is.na(Country)) %>% 
  filter(!is.na(AverageTemperature)) %>% 
  group_by(Country) %>% 
  summarise(average_temperature_in_1900 = mean(AverageTemperature))


data_by_country_in_2000 <- data_by_country %>% 
  filter(dt >= "2000-01-01" & dt <= "2000-12-31") %>%
  filter(!is.na(Country)) %>% 
  filter(!is.na(AverageTemperature)) %>% 
  group_by(Country) %>% 
  summarise(average_temperature_in_2000 = mean(AverageTemperature))


diff_by_country <- data_by_country_in_1900 %>% 
  inner_join(data_by_country_in_2000, by = "Country") %>% 
  mutate(diff_by_country = average_temperature_in_2000 - average_temperature_in_1900)

diff_by_country[diff_by_country$Country == "United States", "Country"] <- "USA"

global_map_data <- map_data("world") %>% 
  rename(Country = region) %>% 
  left_join(diff_by_country, by = "Country")

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        # remove axis lines
    axis.text = element_blank(),        # remove axis labels
    axis.ticks = element_blank(),       # remove axis ticks
    axis.title = element_blank(),       # remove axis titles
    plot.background = element_blank(),  # remove gray background
    panel.grid.major = element_blank(), # remosve major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank(),     # remove border around plot
    plot.title = element_text(size = 10,face = "bold")
  )


global_temperatures <- ggplot(global_map_data) +
  geom_polygon(mapping = aes(x = long, y = lat, group = group, fill = diff_by_country),
               color = "grey",
               size = .005) +
  coord_map(xlim=c(-180,180), ylim=c(-60, 90)) +
  scale_fill_continuous(low = "#132B43", high = "Red") +
  labs(fill = "Temperature Difference in Celsius") + 
  blank_theme +
  ggtitle("The Global Map of Average Temperature Difference in Celsius bewtween 1900 and 2000") +
  theme(plot.title = element_text(size = 11, face = "bold"))

# dat <- data.frame( time = factor(c("Lunch","Dinner"),
#                                  levels=c("Lunch","Dinner")),
#                    total_bill = c(14.89, 17.23) )
# 
# p <- ggplot(data=dat, aes(x=time, y=total_bill)) + 
#   geom_bar(stat="identity")
# 
# fig <- ggplotly(p)


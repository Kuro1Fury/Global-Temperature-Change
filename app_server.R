library("shiny")
library("ggplot2")
library("plotly")
library("tidyverse")
library("lintr")
library('rsconnect')
data2 <- read.csv("data/GlobalTemperatures.csv")


server <- function(input, output) {
  source("tab1_data.R")
  
  # ---------------tab 1---------------------------
  output$map <- renderPlotly({
    map <- ggplot(chosen_year_data(input$year)) +
      geom_polygon(mapping = aes(x = long,
                                 y = lat,
                                 group = group,
                                 fill = YearAverageTemperature,
                                 Country = Country),
                   color = "grey",
                   size = .01) +
      coord_map(xlim=c(-180,180), ylim=c(-60, 90)) +
      scale_fill_continuous(low = "#132B43", high = "Red") +
      labs(fill = "Average Temperature(C)") +
      blank_theme +
      ggtitle(paste("The Global Map of Average Temperature(C) of Year",
                    input$year)) +
      theme(plot.title = element_text(size = 18, face = "bold"))

    return(ggplotly(map, tooltip = c("YearAverageTemperature", "Country")))

   })
  
  # ---------------tab 2---------------------------
  output$scatter <- renderPlotly({
    filtered_data2 <- data2 %>%
      mutate(dt = as.Date(dt)) %>%
      mutate(year = format(dt, "%Y")) %>%
      mutate(year = as.numeric(year)) %>%
      filter(year >= input$starting_year) %>%
      group_by(year) %>%
      summarize(avg_temp = mean(LandAverageTemperature, na.rm = TRUE),
                avg_max = mean(LandMaxTemperature, na.rm = TRUE),
                avg_min = mean(LandMinTemperature, na.rm = TRUE))
    p2 <- ggplot(filtered_data2, aes_string(x = "year", y = input$y_var)) +
      geom_point() +
      xlab("Year") +
      ylab("World Average Temperature(in Celsius)") +
      ggtitle(paste0("World Change of ", input$y_var, " from ", input$starting_year, " to 2010s")) +
      coord_cartesian(ylim=c(0, 16))
    return(ggplotly(p2))
  })
  
  # ---------------tab 3---------------------------
  ## From Allan Ji
  output$TemperaturePlot <- renderPlotly({
    data3 <- read.csv("data/GlobalLandTemperaturesByCountry.csv")
    # data3$Country[data$Country == "脜land"] <- "Åland"
    # data3$Country[data$Country == "C么te D\'Ivoire"] <- "Côte D'Ivoire"
    # data3$Country[data$Country == "Cura莽ao"] <- "Curaçao"
    # data3$Country[data$Country == "Saint Barth茅lemy"] <- "Saint Barthélemy"
    data_by_year <- data3 %>%
      filter(Country == input$country3) %>%
      mutate(dt = as.Date(dt)) %>%
      mutate(year = format(dt, "%Y")) %>%
      group_by(year) %>%
      summarize(avg_temperature = mean(AverageTemperature, na.rm = TRUE)) %>%
      mutate(year = as.numeric(year)) %>%
      mutate(year = as.integer(year / 10) * 10) %>%
      group_by(year) %>%
      summarize(avg_temperature = mean(avg_temperature, na.rm = TRUE))
    filted_data <- data_by_year %>%
      filter(year >= input$year3[1], year <= input$year3[2])
    filted_data[is.na(filted_data)] = 0
    min <- input$year3[1]
    if(min < min(filted_data$year)) {
      min <- min(filted_data$year)
    }
    min_T <- min(filted_data$avg_temperature)
    max_T <- max(filted_data$avg_temperature)
    my_plot <- ggplot(filted_data, aes(x = year, y = avg_temperature)) +
      geom_bar(stat = "identity") +
      xlab("Year") +
      ylab("Average Temperature(in Celsius)") +
      ggtitle(paste0("Average Temperature in ",input$country, " from ", min, "s ", "to ", input$year3[2], "s")) +
      coord_cartesian(ylim=c(min_T,max_T))
    return(ggplotly(my_plot))
  })
  
  # ---------------summary-------------------------
  
  data4 <- read.csv("data/GlobalTemperatures.csv")
  temp_change <- data4 %>% 
    drop_na(LandAverageTemperature) %>%
    mutate(dt = as.Date(dt)) %>%
    mutate(year = format(dt, "%Y")) %>%
    group_by(year) %>%
    summarize(avg_temp = mean(LandAverageTemperature, na.rm = TRUE))
  
  year1850 <- temp_change %>%
    filter(year==1850) %>%
    pull(avg_temp) %>%
    round(2)
  
  year2010 <- temp_change %>%
    filter(year==2010) %>%
    pull(avg_temp) %>%
    round(2)
  
  temp_country_old <- data3 %>% 
    drop_na(AverageTemperature) %>%
    mutate(dt = as.Date(dt)) %>%
    mutate(year = format(dt, "%Y")) %>%
    filter(year == 1850) %>%
    group_by(Country) %>%
    summarize(avg_temp = mean(AverageTemperature, na.rm = TRUE))
  
  temp_country_new <- data3 %>% 
    drop_na(AverageTemperature) %>%
    mutate(dt = as.Date(dt)) %>%
    mutate(year = format(dt, "%Y")) %>%
    filter(year == 2010) %>%
    group_by(Country) %>%
    summarize(avg_temp_new = mean(AverageTemperature, na.rm = TRUE))
  
  temp_country<-left_join(temp_country_new, temp_country_old, by="Country")
  
  temp_diff <- temp_country %>%
    filter(!is.na(avg_temp)) %>%
    summarize(Country, diff=round(avg_temp_new-avg_temp, 2))
  
  max_diff <- temp_diff %>%
    filter(diff==max(diff))
  
  min_diff <- temp_diff %>%
    filter(diff==min(diff))
  
  min_temp_2010 <-temp_country_new %>%
    filter(avg_temp_new== min(avg_temp_new))
  
  min_temp_1850 <-temp_country_old %>%
    filter(avg_temp== min(avg_temp))
  
  max_temp_2010 <-temp_country_new %>%
    filter(avg_temp_new== max(avg_temp_new))
  
  max_temp_1850 <-temp_country_old%>%
    filter(avg_temp== max(avg_temp))
  
  output$finding1 <- renderText({
    msg <- paste0("From our first visual analysis on the world's global average temperature, 
                  we can clearly see that the temperature are largely depending onthe latitude
                  of each country, with ",
                  max_temp_2010[1,1],
                  " having the highest temperature of ",
                  round(max_temp_2010[1,2],2),
                  " Celsius in year 2010, ",
                  round(max_temp_1850[1,2],2),
                  " Celsius in year 1850, and ",
                  min_temp_2010[1,1],
                  " having the lowest temperature of ",
                  round(min_temp_2010[1,2],2),
                  " Celsius in year 2010, ",
                  round(min_temp_1850[1,2],2),
                  " Celsius in year 1850.")
    
    return(msg)
  })
  
  output$finding2 <- renderText({
    msg <- paste0("The global land temperature is increasing over the years. The average land temperature in 1850 is ",
                  year1850,
                  " Celcius, but it is risen to ",
                  year2010,
                  " Celcius in year 2010. We can see the increasing trend clearly in our world temperature change trend analysis.")
    
    return(msg)
  })
  
  output$finding3 <- renderText({
    msg <- paste0("With our average temperature in different country visual analysis, we can see that ",
                  max_diff[1,1],
                  " has the largest increase in temperature from 1850 to 2010, with an increase of ",
                  max_diff[1,2],
                  " Celcius. ",
                  min_diff[1,1],
                  " on the other hand, has the lowest increase(decrease) in temperature, with an increase of ",
                  min_diff[1,2],
                  " Celcius.")

    return(msg)
  })
}


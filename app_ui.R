library("shiny")
library("ggplot2")
library("plotly")
library("lintr")
library('rsconnect')
includeCSS("style.css")

#lint("app_ui.R")

# table needed for the 3rd page -- Allan Ji
data3 <- read.csv("data/GlobalLandTemperaturesByCountry.csv")
distinct_countries <- data3 %>%
  distinct(Country)

# --------------------intro---------------------

intro_tab <- tabPanel(
  "Introduction",
  verticalLayout(
    fluidPage(
      div(img(src = "image_environment.jpg", 
              height = "65%", width = "65%", 
              align = "center"),
          style="text-align: center;")
    ),
    
    p(),
    p(),
    p(),
   
    tags$p(id = "intro", "Some say climate change is the biggest threat of our  
           age while others say it's a myth based on dodgy science. With the
           data sets of average and min/max land temperature collected 
           by Berkeley Earth starting from the year 1750, we are able to 
           answer many related questions through these interactive visual 
           analysis, such as when the average tempereture in each country
           increase or decrease, which country have the largest avergae
           temperature in a specfic year. The analysis include the global map
           of average temperature throughout the year, the changes in average 
           temperature of the country of your choice, and the changes 
           in min/max average temperature.",
          style = "font-size:18px;")
  )
  
)

# ---------------tab 1---------------------------
tab1 <- tabPanel(
  "Global Map",

  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "year",
        label = "Choose the Year",
        value = 1900,
        min = 1850,
        max = 2010

      ),

      p("( The graph needs some time to load. 
        Please wait for a while. Thank you!)")

    ),

    mainPanel(
      plotlyOutput(
        outputId = "map"
      )
    )
  ),

  fluidPage(
    h2(strong("Description")),
    tags$p(id = "paragraph1", "This page helps you generate a global map which 
           displays the average temperature in each country. In this map, the 
           global average tempertature are largely depend on the latitude of 
           each country. You could move the slider to view the map of differnt 
           years and hover the mouse on the map to see the exact temperature 
           values and the country names.",
           style = "font-size:28px;")
  )
)

# ---------------tab 2---------------------------
sidebar2 <- sidebarPanel(
  selectInput(
    "y_var",
    label = "Choose the Data",
    choices = list(
      "Average Land Temperature" = "avg_temp",
      "Average Land Max Temperature" = "avg_max",
      "Average Land Min Temperature" = "avg_min"
    ),
    selected = "Average Land Temperature"
  ),
  sliderInput(
    "starting_year",
    label = "Choose the Starting Year",
    min = 1850,
    max = 2010,
    value = 1900
  ),
  p("( The graph needs some time to load. 
        Please wait for a while. Thank you!)")
)

descrip2 <- fluidPage(
  h2(strong("Description")),
  tags$p(id = "paragraph1","This helps you generate a scartter plot showing the
          world temperature change from a certain year to 2015. You can use the
          list to choose the data you want to draw, including average land 
          temperature, average land max temperature, and average land min 
          temperature. And you can use the slider to choose the starting year 
          that you are interested to see.",
         style = "font-size:28px;")
)

main2 <- mainPanel(
  plotlyOutput(outputId = "scatter")
)

tab2 <- tabPanel(
  "World Temperature Change Trend",
  sidebarLayout(
    sidebar2,
    main2
  ),
  descrip2
)


# -------------------------Page 3----------------------------- 

plot_sidebar3 <- sidebarPanel(
  selectInput(
    inputId = "country3",
    label = "Country",
    choices = distinct_countries,
    selected = "Africa"
  ),
  sliderInput(
    "year3",
    "Year",
    min = 1750,
    max = 2010,
    value = c("1750", "2010"),
    step = 10
  ),
  p("( The graph needs some time to load. 
        Please wait for a while. Thank you!)")
)

plot_main3 <- mainPanel(
  plotlyOutput(outputId = "TemperaturePlot")
)

text3 <- fluidPage(
  includeCSS("style.css"),
  h2(strong("Description")),
  
  tags$p(id = "paragraph1","You can use the list and the slider to choose how
          the pattern of average temperature looks like in a particular country 
          and time interval. Therefore you can easily observe the temperature 
          change and some interesting points, like the year with maximum 
          temperature or the year with maximum change of temperature. Feel free 
          to try putting the cursor on the graph for looking at specific data",
          style = "font-size:28px;"),
  
  tags$p(id = "paragraph1", class = "redborder", "Special Notice: If you change 
         starter year from the slider but the x axis does not change, 
         or if the plot is blank, then there is insufficient data to show.",
         style = "font-size:20px;")
)

tab3 <- tabPanel(
  "Average Temperature in different country",
  sidebarLayout(
    plot_sidebar3,
    plot_main3
  ),
  text3
)

# ------------------------------------------------------------
summary <- tabPanel(
  "Summary",
  
  fluidPage(
    div(img(src = "summary_img.jpg", 
              height = "55%", width = "55%", 
              align = "center"),
          style="text-align: center;"
    ),
    
    tags$p("Please wait for all the text loading. Thank you!",
           align = "center",
           style = "font-size:13px;"),
    
    p(),
    p(),
    p(),
    textOutput(
      outputId = "finding1",
     ),
    tags$head(tags$style("#finding1{font-size: 17px;}")),
    
    p(),
    textOutput(
      outputId = "finding2"
    ),
    tags$head(tags$style("#finding2{font-size: 17px;}")),
    
    p(),
    textOutput(
      outputId = "finding3"
    ),
    tags$head(tags$style("#finding3{font-size: 17px;}")),
    
    p(),
    tags$p("In sum, the average land temperture incresed throughtout the years
           is largely related to the development of the countries. The rising 
           temperature would damage the ecosystem and affect humans' daily life.
           We hope this report would make you aware of the temperature increase
           on Earth and start taking some small actions to protect our 
           environment. Thank you!",
           style = "font-size: 17px;"),
    
    tags$p("Created by Allan Ji, Jenny Guo, Jiaqi Su, Jun Chao.",
           align = "right",
           style = "font-size:15px;"),
    
    tags$p("December 9th, 2021",
           align = "right",
           style = "font-size:15px;")
    
  )
)


# ---------------ui-------------------------
ui <- navbarPage(
 "Global Temperature Change", 
  intro_tab,
  tab1,
  tab2,
  tab3,
  summary
)

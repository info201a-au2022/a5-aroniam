# For a5

library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

emissions <- read.csv("./owid-co2-data.csv") # set session to source file location 
#View(emissions)
# DPLYR wrangling for introduction page

# Where are ghg emissions the highest per capita?
highestghg_percapita <- emissions %>%
  filter(ghg_per_capita == max(ghg_per_capita, na.rm = TRUE)) %>%
  pull(country)
print(highestghg_percapita) # outputs "Solomon Islands"

# What is the average greenhouse co2 emissions in the U.S.?
avg2021_us_co2 <- emissions %>%
  filter(year == 2021) %>%
  filter(country == "United States") %>%
  summarize(co2 = mean(co2, na.rm = T)) %>%
  round(digits = 2) %>%
  pull(co2)
print(avg2021_us_co2) # outputs 5007.34

# Which country has the highest energy use per gdp?
highest_energyuse <- emissions %>%
  filter(energy_per_gdp == max(energy_per_gdp, na.rm = TRUE)) %>%
  pull(country)
print(highest_energyuse)

# Server code
server <- (function(input, output) {
  output$countrywidget <- renderUI({
    selectInput("country", "Choose a country:", choices = unique(emissions$country), multiple = TRUE, 
                selected = c("United States", "China"))
  })
  output$yearwidget <- renderUI({
    numericInput("year", "Choose a year:", value = 2000, min = 1850, max = 2021, step = 10)
  })
  
  # Plot
  output$countryPlot <- renderPlotly({
    # Making the scatter plot
    
    plotData <- emissions %>%
      filter(year >= input$year) %>% # filtering for after pre-industrial times end 
      filter(country %in% input$country)
    
    # adding aesthetics 
    ggplot(plotData) +
      geom_point(mapping = aes(x = year, y = ghg_per_capita, color = country)) +
      labs(x = "year",
           y = "total ghg emissions per capita",
           title = paste("per capita ghgh emissions in", input$country))
  })
  # DPLYR outputs 
  output$value <- renderText({
    paste("GHG emissions are the highest per capita (measured in tonnes of CO2 equivalents per capita) in", highestghg_percapita, ".")
  })
  output$secondvalue <- renderText({
    paste("The average CO2 emissions in the U.S. in 2021 were", avg2021_us_co2, "million tonnes.")
  })
  output$thirdvalue <- renderText({
    paste("The country with the highest energy use per GDP (measured in kilowatt-hours per international $) is", highest_energyuse, ".")
  })
})




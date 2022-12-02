#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# For a5

library(shiny)
library(tidyverse)
library(ggplot2)
#?write.csv # ask how to use this for p3 

emissions <- read.csv("./owid-co2-data.csv") # set session to source file location 
#View(emissions)
# DPLYR wrangling for introduction page
# What is the average co2 emissions in the U.S.?
avg2021_us_co2 <- emissions %>%
  filter(year == 2021) %>%
  filter(country == "United States") %>%
  summarize(co2 = mean(co2, na.rm = T)) %>%
  round(digits = 2) %>%
  pull(co2)
# print(avg2021_us_co2) # outputs 5007.34

# To create an input, you need to call upon the output and create some variable 
# Define server logic required to draw a histogram

#?renderUI # lets you render text, plots, etc 
# renderUI({}) # parentheses and brackets lets your write multiple lines of code with it
#?sliderInput
# Define server logic required to draw a histogram 
server <- (function(input, output) {
  output$countrywidget <- renderUI({
    selectInput("country", "Choose a country:", choices = unique(emissions$country))
  })
  #output$yearwidget <- renderPrint({
    #sliderInput("slider1", label = h3("Slider"), min = 2000, 
                                 #  max = 2021, value = 2021)
  #output$yearwidget <- renderPrint({
    #sliderInput(inputId = "year", "Choose a year:", min = 2000, max = 2021, value = 2021,
                #round = FALSE, format = "#,##0.#####", locale = "us", ticks = TRUE, animate = FALSE)
  #})
  # First plot 
  output$countryPlot <- renderPlotly({
    # Making the scatter plot
    
    plotData <- emissions %>%
      filter(year >= input$year) %>% # filtering for after pre-industrial times end 
      filter(country %in% input$country)
    
    # adding aesthetics 
    ggplot(plotData) +
      geom_point(mapping = aes(x = year, y = co2, color = country)) +
      labs(x = "year",
           y = "total co2 emissions",
           title = paste("co2 emissions in", input$country))
  })
  output$value <- renderText({
    paste("this value is", avg2021_us_co2, ".")
  })
})

# Note: reactive lets the computer know that you want it to change from an input 
# (reactive updates frequently whenever the input is changed)
# Note: to get all the countries, use unique to remove duplicates and then call upon
# the data set (emissions)

# plotData <- emissions %>%
 # filter(country == "Afghanistan")

# adding aesthetics 
# ggplot(plotData, aes(x = year, y = co2)) +
  #geom_point(aes(color = country)) +
  #labs(x = "year",
   #    y = "total co2 emissions",
    #   title = paste("co2 emissions in", "Afghanistan"))



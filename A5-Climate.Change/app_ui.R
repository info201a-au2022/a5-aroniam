#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# For a5

library(shiny)
library(plotly)
library(tidyverse)
library(ggplot2)
?tabPanel
?plotlyOutput
# How do i add my selectCountry 
#output$selectCountry <- renderUI({
#  selectInput("country", "Choose a country:", choices = unique(emissions$country)) # choices you want within the select input widget
  
#})
first_page <- tabPanel(
  "Introduction",
  h1("Global Carbon Dioxide Emissions", align = "center"),
  textOutput("value"),
  p("The average CO2 emissions in the U.S. in 2021 were", em("avg2021_us_co2"), "which were 5007.34 million tonnes.")
)

# code from darren's demo = works but i'm still getting disconneced from server error
# Define UI for application that draws a histogram
second_page <- tabPanel(
  "Interactive Visualization",
  h1("Visualization of Global Carbon Dioxide Emissions", align = "center"),
  sidebarLayout(
    sidebarPanel(
      uiOutput("countrywidget"),
      sliderInput("year", "Choose a year:",
                  min = 2000, max = 2021,
                  value = 2010),
      #uiOutput("yearwidget"),
      #choose_year_widget
    ),
    mainPanel(
      plotlyOutput("countryPlot"),
      p("This is my paragraph"))
  ))

# link to create widget for sliderInput: https://shiny.rstudio.com/articles/sliders.html 
# Making a widget
#choose_country_widget <- selectInput(
#  inputId = "country",
#  label = "Choose_a_country",
#  choices = unique(emissions$country),
#  selected = (c("United States")
#  )
#)
# Making a second widget 
#choose_year_widget <- selectInput(
#  inputId = "year",
#  label = "Choose_a_year",
#  choices = unique(emissions$year)
#)


ui <- navbarPage(
  "INFO 201 A5",
  first_page,
  second_page
)

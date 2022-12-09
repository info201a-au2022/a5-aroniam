# For a5

library(shiny)
library(plotly)
library(tidyverse)
library(ggplot2)

# Page 1
first_page <- tabPanel(
  "Home",
  h1("Global Carbon Dioxide Emissions", align = "center"),
  img(src = "ghg.png", height = 350, width = 780),
  tags$div(
    tags$a(href = " https://www.nbcnews.com/politics/supreme-court/supreme-court-takes-epas-power-limit-greenhouse-gas-emissions-rcna17356", "Image citation")),
  h3("Aronia Mclean"),
  h4("12/9/2022"),
  p("This website explores greenhouse gas emissions worldwide. As our population continues to grow, it's important to understand
    how our habits and practices impact our Earth. We're in a position where our current decisions will affect those negatively or positively
    just a few years later. It's important to understand our emission patterns and the steps needed to decrease our current emissions. This report
    will focus particularly on understanding greenhouse gas emissions per capita. Some questions that arise are where are GHG emissions the highest per capita? 
    What is the average greenhouse CO2 emissions in the U.S.? Lastly, which country has the highest energy use per GDP? Below is some data exploration to better understand the world's emissions 
    and answer the questions posed."),
  textOutput("value"),
  textOutput("secondvalue"),
  textOutput("thirdvalue")
)

# Page 2
second_page <- tabPanel(
  "GHG Emissions",
  h2("Global GHG Emissions Per Capita", align = "center"),
  sidebarLayout(
    sidebarPanel(
      uiOutput("countrywidget"),
      uiOutput("yearwidget"),
    ),
    mainPanel(
      plotlyOutput("countryPlot"),
      p("Caption: This chart presents an interactive visualization of the global greenhouse gas emissions
        per capita. The first options shown are the United States and China, this is because these are two countries
        that are known to have among the highest contributions to greenhouse gas emissions. The chart shows that 
        the United States has been having a downward trend in greenhouse gas emissions over the past twenty years. On the other hand, 
        China has had an upward trend in greenhouse gas emissions. Ultimately, understanding these emissions and their patterns
        is very important to understanding what policy suggestions can and should be made. Additionally, this provides insight into
        how countries can split the burden of reducing emissions in a manner that reflects financial disparities and doesn't unfairly 
        burden developing countries."))
  ))
# UI to put pages together
ui <- navbarPage(
  "INFO 201 A5",
  first_page,
  second_page
)

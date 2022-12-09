# For a5

library(shiny)
library(plotly)
library(ggplot2)
library(tidyverse)

source("app_ui.R") # runs other files inside of this environment 
source("app_server.R")

shinyApp(ui = ui, server = server)
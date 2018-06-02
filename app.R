#setwd("C:/Users/mbrackenrig/Documents/Stateplus Distance Matrix")
####CORE Innovation Hub#####

library(shiny)
library(shinydashboard)
library(readr)
library(shinyjs)
#####Shiny app####
library(leaflet)
library(htmltools)
library(tidyr)
library(plotly)

data <- read_csv("App Data/Time_data.csv")

levels(as.factor(data$destination))
data$destination[data$destination=="14+Darling+Dr+Sydney"] <- "ICC"
data$destination[data$destination=="macquarie+park+train+station+nsw"] <- "Macquarie Park"
data$destination[data$destination=="parramatta+nsw"] <- "Parramatta"

data$destination <- as.factor(data$destination)
data$mode[data$mode=="transit"] <- "Public Transport"
data$mode[data$mode=="driving"] <- "Driving"
listings <- read_csv("App Data/listings.csv")
listings <- subset(listings, listings$is_business_travel_ready=='t')
# Friss dashboard header
FrissHeader <- function(){tags$head(
  tags$link(rel = "stylesheet", type = "text/css", href = "app.css"),
  tags$head(tags$link(rel="shortcut icon", href="logo.png")),
  tags$img(href="logo.png" , id = "FrissLogo",style = "position: absolute; display: none;"),
  singleton(includeCSS("www/app.css")),
  tags$title("Template")
)}

  
ui  <-  dashboardPage(title = "Airbnb locations",
                      
  dashboardHeader(title = NULL, titleWidth = 188, disable = TRUE
         
  ), dashboardSidebar(disable = TRUE,
    
    sidebarMenu(id = "tabs",
                
                menuItem("Dashboard", tabName = "first", icon = icon("map fa-lg"))
    )
  ),

  source(file.path("UI", "oldUI.R"), local = TRUE)$value

)





server <- function(input, output,session) {
  
  #Begin the serve
  
  rv <- reactiveValues()
  #source(file.path("Server", "charts.R"), local = TRUE)$value
  source(file.path("Server", "Map.R"), local = TRUE)$value
  #source(file.path("Server", "valuebox.R"), local = TRUE)$value
  
  session$onSessionEnded(stopApp)
}
shinyApp(ui = ui, server = server)

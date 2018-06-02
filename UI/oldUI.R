dashboardBody(  FrissHeader(),
              tabItems(
                tabItem(tabName= "first",
                        
                        fluidRow(box(leafletOutput("plotmapbox",height = 500),  width = 8), column(box(selectizeInput(inputId = "officefilter",label ="Where are you going?" ,choices = c("ICC","Macquarie Park", "Parramatta")), width = 12, style = "min-height: 100px;"),
                                                                                                   box(selectizeInput(inputId = "clientfilter",label ="Driving or Public Transport" ,choices = c("Driving", "Public Transport")), width = 12, style = "min-height: 100px;"),
                                                                                                   box(sliderInput(inputId = "slide",label ="Records" ,min = 0, max =1077,value = 1077,step = 1), width = 12, style = "min-height: 100px;"),width=4))
                        
                  
              )
))
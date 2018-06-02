dashboardBody(FrissHeader(),
              
              tabItems(
                tabItem(tabName= "first",
                        
column(box(leafletOutput("plotmapbox",height = 840),  width = 12),  width = 8), column(box(selectizeInput(inputId = "officefilter",label ="Office" ,choices = c("Gymea", "Chatswood")), width = 12, style = "min-height: 100px;"),
                                                                                                   box(sliderInput(inputId = "slide",label ="minimum FUM" ,min = 0, max =1000000,value = 0,step = 10000), width = 12, style = "min-height: 100px;"),
                                                                                                   box(selectizeInput(inputId = "clientfilter",label ="FUM or Number of Clients" ,choices = c("FUM", "Number of Clients")), width = 12, style = "min-height: 100px;"),
                                                                                                   box(selectizeInput(inputId = "plannerfilter",label ="Planner" ,choices = levels(data$Planner)), width = 12, style = "min-height: 100px;"),
                                                                                                   valueBoxOutput("valuebox1", width = 12),valueBoxOutput("valuebox2", width = 12),valueBoxOutput("valuebox3", width = 12), width = 4))
                        
                        
                  
              )
)
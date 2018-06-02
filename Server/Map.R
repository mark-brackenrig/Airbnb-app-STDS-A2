initial_lat = -33.9
initial_lng = 151.18
initial_zoom = 10


output$plotmapbox <- renderLeaflet({
  
data <- subset(data, data$destination==input$officefilter)
data <- subset(data, data$mode==input$clientfilter)
data <- data[sample(nrow(data),input$slide),]
data <- merge(data, subset(listings, select = c("id", "neighbourhood")), by= "id")
  data$color <- data$Time/60
data <- merge(data, subset(listings, select = c("id", "price")), by = "id")
  pal <-  colorNumeric(c("green","red","red2", "red2") , c(0,20,40,200))
  
leaflet(data) %>% addProviderTiles(providers$CartoDB.Positron,
                                     options = providerTileOptions(noWrap = TRUE)
 )%>%
    setView(lat = initial_lat, lng = initial_lng, zoom = initial_zoom) %>%
clearMarkers() %>%
  addCircleMarkers(
    radius = 3,
    color = ~pal(data$color),
    stroke = FALSE, fillOpacity = 0.5,
    label = ~paste0("Price: ",price ,"\nTime to ",input$officefilter,": ", round(Time/60), " Minutes", "\n Suburb: ", neighbourhood),
    labelOptions= labelOptions(style = list("white-space"= "pre", "font-size"= "14px"))) %>%
  addLegend("bottomright", pal = pal, values = ~c(10,30,50,70),
  title = paste0("Time to ",input$officefilter, "\nby ", tolower(input$clientfilter)),
  labFormat = labelFormat(suffix = "min"),
  opacity = 1) 
  


})








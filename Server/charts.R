###Charts

output$mainplot <- renderPlotly({
  data <- subset(data, data$Planner == input$plannerfilter)
  data$timediff <-(data$gymeatimedistance-data$chatswoodtimedistance)

    if(input$officefilter=="Chatswood"){data$timediff <- (data$chatswoodtimedistance-data$gymeatimedistance)}
  
  data$timebands <- ifelse( data$timediff>900,"Longer than 15 mins", "Less than 15 mins")
  
  data$Fumbands <- factor(ifelse(data$`Total Fum`<100001, "Less than $100,000",
                                 ifelse(data$`Total Fum`<250001, "$100,001-$250,000",
                                        ifelse(data$`Total Fum`<350001, "$250,001-$350,000",  
                                               ifelse(data$`Total Fum`<500001, "$350,001-$500,000",  
                                                      ifelse(data$`Total Fum`<750001, "$500,001-$750,000",
                                                             ifelse(data$`Total Fum`<1000001, "$750,001-$1,000,000","More than $1,000,000"  
                                                             )
                                                      ))
                                        ))), levels = c( "Less than $100,000","$100,001-$250,000", "$250,001-$350,000","$350,001-$500,000","$500,001-$750,000","$750,001-$1,000,000","More than $1,000,000" ), ordered = T )
  
  plotdata <- as.data.frame(prop.table(table(data$Fumbands, data$timebands), 1))
  colnames(plotdata) <- c("Fumbands", "timebands", "Proportion")
  
  plot_ly(subset(plotdata, plotdata$timebands=="Longer than 15 mins"), x=~Fumbands,y=~Proportion*100, type = "bar", marker = list(color = "#C61B42"), hoverinfo = 'text', text = ~paste0("Proportion of members<br>travelling an additional 15 minutes:",round(Proportion*100), "%")) %>%
    layout(title = "Proportion of members negatively affected",margin =list(b= 100),yaxis = list(range = c(0,75),showgrid = F, zeroline = F, showticklabels = T, title = "%"), xaxis = list(tickfont = list(size = 8), title = "Client FUM"))%>%
    config(displayModeBar = F)
  
  
  
  
})

#Second Plot

output$newplot <- renderPlotly({
  data <- subset(data, data$Planner == input$plannerfilter)
  #data <- subset(data, data$`Total Fum`>=input$slide)
  data$preferredoffice <- ifelse(data$gymeatimedistance - data$chatswoodtimedistance>0, "Chatswood", "Gymea")
  data$Fumbands <- factor(ifelse(data$`Total Fum`<100001, "Less than <br> $100,000",
                                 ifelse(data$`Total Fum`<250001, "$100,001-<br>$250,000",
                                        ifelse(data$`Total Fum`<350001, "$250,001-<br>$350,000",  
                                               ifelse(data$`Total Fum`<500001, "$350,001-<br>$500,000",  
                                                      ifelse(data$`Total Fum`<750001, "$500,001-<br>$750,000",
                                                             ifelse(data$`Total Fum`<1000001, "$750,001-<br>$1,000,000","More than<br> $1,000,000"  
                                                             )
                                                      ))
                                        ))), levels = c( "Less than <br> $100,000","$100,001-<br>$250,000", "$250,001-<br>$350,000","$350,001-<br>$500,000","$500,001-<br>$750,000","$750,001-<br>$1,000,000","More than<br> $1,000,000" ), ordered = T )
  
  
  plotdata <- as.data.frame(prop.table(table(data$preferredoffice, data$Fumbands),2))
  plotdata <- spread(plotdata, Var1, Freq)
  
  plot_ly(data= plotdata, x=~Var2, y=~Chatswood*100, type = "bar", name = "Chatswood", marker = list(color = "#218ECD"),hoverinfo = 'text', text = ~paste0('Proportion of clients with <br>',Var2, " FUM:",round(Chatswood*100,1 ),"%")) %>%
    add_trace(y=~Gymea*100 , name = "Gymea", marker = list(color = "#C61B42"), hoverinfo = 'text', text = ~paste0('Proportion of clients with <br> ',Var2, " FUM:",round(Gymea*100,1),"%" )) %>%
    layout(margin = c(b=20, t = 0, l=10, r = 10) ,title = "Closest office by FUM", xaxis = list(title = "FUM"), yaxis = list(title = "%", showgrid = F))
})
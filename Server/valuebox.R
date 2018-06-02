##Value box


output$valuebox1 <- renderValueBox({
  data <- subset(data, data$Planner == input$plannerfilter)
  data <- subset(data, data$`Total Fum`>=input$slide)
  if(input$officefilter=="Gymea"){
    data$timedifference <- data$gymeatimedistance-data$time.pitt
  }else{
    data$timedifference <- data$chatswoodtimedistance-data$time.pitt
  }
data$timediffbands <- ifelse(data$timedifference/60>15, "15 mins extra", ifelse(
  data$timedifference/60<(-15), "15 mins less", "within 15 mins"
))  
prop <- as.data.frame(prop.table(table(data$timediffbands)))
prop$Freq <- prop$Freq*100

agg <- aggregate(data$`Total Fum`, by = list(data$timediffbands),sum)
agg <- spread(agg,key = Group.1,value = x)

aggsum <- sum(agg) 

agg <- agg/aggsum
agg<-agg*100
if(input$officefilter=="Pitt Street"){
  valueBox(paste0("0%"), subtitle = "Additional Travel Time",icon = icon("thumbs-down"), color = "red")  
}else{
 if(input$clientfilter =="Number of Clients"){ valueBox(paste0(round(ifelse(length(prop$Freq[prop$Var1=="15 mins extra"])>0,prop$Freq[prop$Var1=="15 mins extra"],0)), "%"), subtitle = "Travelling more than 15 minutes extra",icon = icon("thumbs-down"), color = "red")
 }else{
   valueBox(paste0(round(ifelse(length(agg$`15 mins extra`)>0,agg$`15 mins extra`,0)), "%"), subtitle = "of FUM travelling more than 15 minutes extra",icon = icon("thumbs-down"), color = "red")  
 }
}
})


output$valuebox2 <- renderValueBox({
  data <- subset(data, data$Planner == input$plannerfilter)
  data <- subset(data, data$`Total Fum`>=input$slide)
  if(input$officefilter=="Gymea"){
    data$timedifference <- data$gymeatimedistance-data$time.pitt
  }else{
    data$timedifference <- data$chatswoodtimedistance-data$time.pitt
  }
  
  
  data$FUMweight <- data$`Total Fum`/sum(data$`Total Fum`)
data$Fumtimedifference <- data$timedifference*data$FUMweight
  
if(input$officefilter=="Pitt Street"){
  valueBox(paste0("0 mins"), subtitle = "Average Additional Travel Time",icon = icon("map"), color = "blue")
  }else{
if(input$clientfilter =="Number of Clients"){  valueBox(paste0(round(abs(mean(data$timedifference))/60), " mins"), subtitle = paste0("Average ",ifelse(mean(data$timedifference)>0,"additional ","decrease in "), "travel time to new office" ),icon = icon("map"), color = "blue")
}else{
  valueBox(paste0(round(abs(sum(data$Fumtimedifference))/60), " mins"), subtitle = paste0("Average ",ifelse(mean(data$Fumtimedifference)>0,"additional ","decrease in "), "travel time to new office, weighted by FUM" ),icon = icon("map"), color = "blue")
}
}
})


output$valuebox3 <- renderValueBox({
  data <- subset(data, data$Planner == input$plannerfilter)
  data <- subset(data, data$`Total Fum`>=input$slide)
  if(input$officefilter=="Gymea"){
    data$timedifference <- data$gymeatimedistance-data$time.pitt
  }else{
    data$timedifference <- data$chatswoodtimedistance-data$time.pitt
  }
  data$timediffbands <- ifelse(data$timedifference/60>15, "15 mins extra", ifelse(
    data$timedifference/60<(-15), "15 mins less", "within 15 mins"
  ))  
  prop <- as.data.frame(prop.table(table(data$timediffbands)))
  prop$Freq <- prop$Freq*100
  
  
  agg <- aggregate(data$`Total Fum`, by = list(data$timediffbands),sum)
  agg <- spread(agg,key = Group.1,value = x)
  
  aggsum <- sum(agg) 
  
  agg <- agg/aggsum
  agg<-agg*100
  
  if(input$officefilter=="Pitt Street"){
    valueBox("0%", subtitle = "Improvement in Travel Time",icon = icon("thumbs-up"), color = "green")  }else{
  if(input$clientfilter =="Number of Clients"){   valueBox(paste0(round(ifelse(length(prop$Freq[prop$Var1=="15 mins less"])>0,prop$Freq[prop$Var1=="15 mins less"],0)), "%"), subtitle = "of clients travelling at least 15 minutes less",icon = icon("thumbs-up"), color = "green")
  }else{
    valueBox(paste0(round(ifelse(length(agg$`15 mins less`)>0,agg$`15 mins less`,0)), "%"), subtitle = "of FUM travelling at least 15 minutes less",icon = icon("thumbs-up"), color = "green")  
  }
  }
})



  

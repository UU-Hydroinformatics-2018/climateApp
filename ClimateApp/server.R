
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


shinyServer(function(input, output) {
  output$SLIDER<- renderPrint({ input$slider1 })
  futureavg <- reactive({
    futuredata <- subset(prcp_proj, Station==input$site &
                           Date >= input$dates[1] &
                           Date <= input$dates[2])
    futuremean<- mean(futuredata[,input$rcp])
    return(futuremean)
  })
  observedavg <- reactive({
    observeddata <- subset(snoteldata,Station==input$site)
    observedmean <- mean(observeddata[,"DailyPrecip"],na.rm=TRUE)
    return(observedmean)
  })
  output$summaryresults <- renderText({
    paste("Average Observed Precipitation:",observedavg(),"Average Future Precipitation:",futureavg())
  })
  
  output$selected_rcp <- renderText(paste('Viewing climate data at',input$site,'between',          
                                          input$futuredates[1],'and',input$futuredates[2],'for',input$rcp)
)
  
  output$futureplot <- renderPlot({
    plotdata <- subset(prcp_proj,Station==input$site &
                         Date >= input$dates[1] &
                         Date<= input$dates[2])
    
    if(input$checkbox==TRUE){
      
      ggplot() +
        geom_line(data=plotdata,aes(x=plotdata$Date,y=plotdata[,input$rcp]),color='black') +    
        geom_line(data=snoteldata,aes(x=Date,y=DailyPrecip),color='blue') +
        xlab("Date") +
        ylab("Precipitation") 
        
      
    }else{
      
      ggplot() + 
        geom_line(data=plotdata,aes(x=plotdata$Date,y=plotdata[,input$rcp])) +    
        xlab("Date") +
        ylab("Precipitation")
    }
  })
  ########## NEW PLOT #######
  ########## NEW PLOT #######
  ########## NEW PLOT #######
  ########## NEW PLOT #######
  ########## NEW PLOT #######
  output$futureplot2 <- renderPlot({
    plotdata2 <- subset(tmax_proj,Station==input$site &
                         Date >= input$dates[1] &
                         Date<= input$dates[2])
    plotdata3 <- subset(tmin_proj,Station==input$site &
                          Date >= input$dates[1] &
                          Date<= input$dates[2])
    
    if(input$checkbox==TRUE){
      
      ggplot() +
        geom_line(data=plotdata2,aes(x=plotdata2$Date,y=plotdata2[,input$rcp]),color='red') +    
        geom_line(data=tmax_proj,aes(x=Date,y=MaxTemp),color='red') +
       geom_line(data=plotdata3,aes(x=plotdata3$Date,y=plotdata3[,input$rcp]),color='blue') +    
        geom_line(data=tmin_proj,aes(x=Date,y=MinTemp),color='blue') +
        ylab("Temp C") +
        xlab("Date") +
        scale_color_discrete("Temperature", labels=c("Minimum","Maximum"))
    }else{
      
      ggplot() + 
        geom_line(data=plotdata2,aes(x=plotdata2$Date,y=plotdata2[,input$rcp]),color='red') +
        geom_line(data=plotdata3,aes(x=plotdata3$Date,y=plotdata3[,input$rcp]),color='blue') +
        ylab("Temp C")+
        xlab("Date") +
        scale_color_discrete("Temperature", labels=c("Minimum","Maximum"))
    }
    
  })
  output$GRADE <- renderText(paste('You have given Rajendra and Mickey a score of',input$GRADE,'
                                     for this assignment. Your generosity is greatly appreciated.')
  )
})

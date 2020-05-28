library(RSocrata)
library(shiny)
library(dplyr)
library(ggplot2)


shinyServer(function(input, output, session) {

  dat <- function()
  {
      x <- read.socrata  ("https://data.cityofchicago.org/api/views/ygr5-vcbg/rows.csv?")
    return (x)
  }
  
  dat1 <- dat()
  
  tvstyle<-subset(dat1,
                     dat1$Style == "VN" | dat1$Style == "PK")
  
  
  
  tvpstate <- subset(dat1,
                dat1$State == "IL" | dat1$State == "IA"|
                  dat1$State == "IN" | dat1$State == "MO"|
                  dat1$State == "MS" |
                  dat1$State == "VA" | dat1$State == "WI"|
                  dat1$State == "GA" | dat1$State == "CA"|
                  dat1$State == "MN" | dat1$State == "TX"|
                  dat1$State == "KY" | dat1$State == "MA"|
                  dat1$State == "FL" | dat1$State == "AZ"|
                  dat1$State == "OH" | dat1$State == "NY" |
                dat1$State== "OK" | dat1$State== "CT"|
                dat1$State == "NV" | dat1$State == "NC"|
                  dat1$State == "NJ" | dat1$State == "PA"|
                  dat1$State == "TN" | dat1$State == "MD"|
                  dat1$State == "LA" | dat1$State == "NB"|
                  dat1$State == "NM" | dat1$State == "OR"|
                dat1$State == "AR" | dat1$State == "SC")

  
  output$vstyle <- renderPlot({
    
    ######Graph 1 #####  
    
    ##Chart showing if Van of Pic Up vehicle gets towed the most
    tvstyle_temp <- filter(tvstyle, tvstyle[1]>=format(input$dates[1]) & tvstyle[1]<=format(input$dates[2]))
    ggplot(tvstyle_temp, aes(x=as.factor(tvstyle_temp$Style), fill=as.factor(tvstyle_temp$Style) )) +
      geom_bar(width=2)+ labs(x = "Van vs Pic Up", y = "Number of Vehicles") +
      ggtitle("The Frequency of Vehicles by Style")+ theme(legend.position = "right", ) 
    
     })
 
  

  
  ####
  output$vstate <- renderPlot({
    
    
    tvpstate_temp <- filter(tvpstate, tvpstate[1]>=format(input$dates[1]) & tvpstate[1]<=format(input$dates[2]))
    bar <- ggplot(tvpstate_temp, aes(x=as.factor(1), fill=as.factor(tvpstate_temp$State) )) +
      geom_bar(width=0.5)+ labs(x = "Van vs Pic Up", y = "Number of Vehicles") +
      ggtitle("The Frequency of Van vs Frequency of Pic Up vehicles")+ theme(legend.position = "right") 
    
   
    
    # Plotting the pie
    
    
    pie <- bar + coord_polar(theta = "y") + theme_void()
    pie
  
  })
  
  ##Raw Data
  output$rdt <- renderText({
    paste("Table by date range")
  })
 
  
  
  output$RawTable <- renderDataTable({
    tv_temp <- filter(dat1, dat1[1]>=format(input$dates[1]) & dat1[1]<=format(input$dates[2]))
    tv_temp
    })
})

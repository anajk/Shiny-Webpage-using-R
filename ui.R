
shinyUI(fluidPage(
  
  # title
  titlePanel("Towed Vehicles in Chicago"),
  
  #sidebar 
  sidebarLayout(
    sidebarPanel (

      dateRangeInput("dates", 
                     "Insert the Date Range",
                     start = "2017-06-10", 
                     end = as.character(Sys.Date())),
      br()
      
      # selectInput("sp", label="State of License Plate",
      #             choices = c("All", sort(unique(as.character(tv$State)))),
      #             selected = "All",
      #             multiple = T) 
  
    ),
      
  #main panel    
  mainPanel(
    tabsetPanel(
      tabPanel("Is it Van or is it Pic Up more likely to be towed?",
               plotOutput("vstyle")
     
      ),
      tabPanel("Which Vehicles are most towed by state?",
               plotOutput("vstate")
      ),        
      
      tabPanel("Rendered Data Table",verbatimTextOutput("rdt"),  
               dataTableOutput("RawTable")
      )
    )
  ))
))
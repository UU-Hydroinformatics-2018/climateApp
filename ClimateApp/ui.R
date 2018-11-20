
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


shinyUI(fluidPage(

  # Application title
  titlePanel("Climate Projections for SNOTEL Sites"),

  # Sidebar with user input controls
  sidebarLayout( 
    sidebarPanel(

      selectInput(inputId='site', 
                  label="Choose SNOTEL Site:", 
                  choices=unique(snoteldata$Station), 
                  selected = NULL, 
                  multiple = FALSE,
                  selectize = TRUE, 
                  width = NULL, 
                  size = NULL),
      selectInput(inputId='rcp', 
                  label="Choose RCP:", 
                  choices=c('RCP2_6','RCP4_5','RCP6_0','RCP8_5'), 
                  selected = NULL, 
                  multiple = FALSE,
                  selectize = TRUE, 
                  width = NULL, 
                  size = NULL),

      dateRangeInput("dates", label = h3("Date range"),
                     start = "2044-01-01",
                     end = "2055-12-21"
                     ),
  
      checkboxInput("checkbox",label="Display Observed Data*",value=FALSE),
      
      h6("*NOTE: Observed Data is available for precipitation only. Temperature plot not appear if the above box is checked.")
      ),
    
  
      # Show outputs, text, etc. in the main panel
    mainPanel(
    textOutput("selected_rcp"),
    plotOutput("futureplot"),
    textOutput("summaryresults"),
    plotOutput("futureplot2"),
    
    sliderInput("GRADE", label = h3("Grade our homework"), min = 100, 
                max = 105, value = 103),
    textOutput("GRADE")
    )
  )

))

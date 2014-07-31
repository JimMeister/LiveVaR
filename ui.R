library(quantmod)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Live value-at-risk calculator"),
  
  # Left Sidebar
  sidebarPanel(
    textInput("stock","Please enter the stock's symbol:","AAPL"),
    dateRangeInput("dates", 
                   "Date range",
                   start = as.character(Sys.Date()-365), 
                   end = as.character(Sys.Date())),
    br(),
    actionButton("get", "Refresh Stock"),
    br(),
    br(),
    helpText("Data extracted from Yahoo! Finance"),
    br()
    #helpText("Live Stock Information"),
    #verbatimTextOutput("livedata")
  ),
  
  # Main Panel with five tabs
  mainPanel(
    
    verbatimTextOutput("livedata"),
    
    tabsetPanel(
        
      # Codes for tab1 var-covar method
      tabPanel("Variance-Covariance Method",
               #p("Live Datafeed:"),
               #tableOutput("livedata"),
               verbatimTextOutput("summary"),
               numericInput("mean","Please enter the mean (copy the number on the left)",1),
               numericInput("sd","Please enter the standard deviation",0),
               tableOutput("varVaR")               
               ),
      
      # Codes for tab2 hist simulation
      tabPanel("Historical Simulation",
               checkboxInput("hist99","Show 99% Value-at-risk (red)",value=FALSE),
               checkboxInput("hist95","Show 95% Value-at-risk (blue)",value=FALSE),
               verbatimTextOutput("histVaR"),
               plotOutput("histogram")
               ),
      
      tabPanel("Monte Carlo Simulation",
               h3("In Construction")  
               ),
      
      # Tab4: Showing the raw data of the calculations
      tabPanel("Historical Data",
              tableOutput("histdata")
               ),
      
      # Tab5: Help and Manuals
      tabPanel("Help",
               h4("Introduction"),
               p("This shinny apps provide a instant calculation of value-at-risk using the 
                 financial data available at Yahoo! Finance. Due to time constraint of the 
                 Coursea project, I can only complete the VaR as the quantile of the distribution
                 and two methods of calculating VaR."),
               p("For more detailed introduction of value-at-risk, please visit the following Wikipedia page:"),
               p("http://en.wikipedia.org/wiki/Value_at_risk"),
               p("After the coursea project, I will continue to add more features to help people understand
                 the concept of value-at-risk. Possible expansion like including more assets and expected shortfall
                 as a risk measure."),
               hr(" "),
               h5("5/7/2014 - v0.6 Beta Version"),
               p("- Improved UI"),
               h5("22/6/2014 - v0.4 Coursea project"),
               p("- include VaR as quantile"),
               p(" ")
               )
    )
  )
  
))

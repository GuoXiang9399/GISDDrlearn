###############################################################################
#                                                                             #
# This is the user-interface definition of a Shiny web application. You can   #
# run the application by clicking 'Run App' above.                            #
#                                                                             #
# Find out more about building applications with Shiny here:                  #
#                                                                             #
#    https://shiny.posit.co/                                                  #
#                                                                             #
###############################################################################
#loading package
  library(shiny)
###############################################################################
# Shiny UI
  fluidPage(
    theme = "bootstrap.css",
    includeCSS("www/styles.css"),
    
    navbarPage(
      "GISDDrlearn",
     # 
      tabPanel(
        "Usage"
      ),
     #
      tabPanel(
        "Import data",
         sidebarLayout(
          
          # Sidebar panel for inputs ----
          sidebarPanel(
            
            # Input: Select a file ----
            fileInput("file1", "Choose CSV File",
                      multiple = FALSE,
                      accept = c("text/csv",
                                 "text/comma-separated-values,text/plain",
                                 ".csv")),
            
            # Horizontal line ----
            tags$hr(),
            
            # Input: Checkbox if file has header ----
            checkboxInput("header", "Header", TRUE),
            
            # Input: Select separator ----
            radioButtons("sep", "Separator",
                         choices = c(Comma = ",",
                                     Semicolon = ";",
                                     Tab = "\t"),
                         selected = ","),
            
            # Input: Select quotes ----
            radioButtons("quote", "Quote",
                         choices = c(None = "",
                                     "Double Quote" = '"',
                                     "Single Quote" = "'"),
                         selected = '"'),
            
            # Horizontal line ----
            tags$hr(),
            
            # Input: Select number of rows to display ----
            radioButtons("disp", "Display",
                         choices = c(Head = "head",
                                     All = "all"),
                         selected = "head")
            
          ),
          
          # Main panel for displaying outputs ----
          mainPanel(
            
            # Output: Data file ----
            tableOutput("contents")
            
          )
          
        )
        
        
      ),
     #
      tabPanel(
        "Genotyping",
         sidebarLayout(
          sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)  ),
          # Show a plot of the generated distribution
          mainPanel(
            plotOutput("distPlot")
          )
        )
        
      ),
     # 
     tabPanel(
       "Result download"
     )
     #
   )
  )
    


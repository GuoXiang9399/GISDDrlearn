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
# Define server logic required to draw a histogram
  function(input, output, session) {


    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    }) 
    
    output$contents <- renderTable({
      
      # input$file1 will be NULL initially. After the user selects
      # and uploads a file, head of that data file by default,
      # or all rows if selected, will be shown.
      
      req(input$file1)
      
      # when reading semicolon separated files,
      # having a comma separator causes `read.csv` to error
      tryCatch(
        {
          df <- read.csv(input$file1$datapath,
                         header = input$header,
                         sep = input$sep,
                         quote = input$quote)
        },
        error = function(e) {
          # return a safeError if a parsing error occurs
          stop(safeError(e))
        }
      )
      
      if(input$disp == "head") {
        return(head(df))
      }
      else {
        return(df)
      }
      
    })
    
  }

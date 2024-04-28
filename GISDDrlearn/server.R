###############################################################################
###############################################################################
###############################################################################
#loading package
  library(shiny)
  library(tidyr)
  library(ape)
  library(caret)
###############################################################################
# Define server logic required to draw a histogram
  function(input, output, session) {
    #######################################################################
    output$image2 <- renderImage({
        if (is.null(input$picture))
          return(NULL)
        if (input$picture == "structure") {
          return(list(
            src = "www/structure.png",
            contentType = "image/png",
            alt = "GISDD genotyping structure"
          ))
        } else if (input$picture == "frame") {
          return(list(
            src = "www/frame.png",
            filetype = "image/png",
            alt = "GISDD genotyping frame"
          ))
        }
      }, deleteFile = FALSE)  
    #######################################################################
    output$downloadData <- downloadHandler(
      filename = function() {
        paste(input$dataset, ".csv", sep = "")
      },
      content = function(file) {
        write.csv(datasetInput(), file, row.names = FALSE)
      })
    #######################################################################
    output$contents <- renderTable({  
      load("model/rffit2.rda")   
      if (exists("rffit2") && !is.character(rffit2)) {  
        req(input$file1)  
        dfraw <- read.dna(input$file1$datapath, format = "fasta", as.character = TRUE)  
        df <- as.data.frame(dfraw, row.names = NULL)  
        predictions <- predict(rffit2, df)  
        predictionResult <- data.frame(
          Sequence=labels.DNAbin(dfraw),
          Pred_Subgenotype=predictions,
          model=c("rffit.v20240405"))
        predictionResult <- separate(predictionResult,Pred_Subgenotype,
            into=c("Serotype","Subgenotype"),sep="_")
        return(predictionResult)
      } else {  
        stop("The model object is not loaded correctly or does not exist.")  
      }  
    })
    #######################################################################
  }
    



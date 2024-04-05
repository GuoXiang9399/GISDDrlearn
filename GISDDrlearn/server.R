###############################################################################
###############################################################################
###############################################################################
#loading package
  library(shiny)
  library(readxl)
  library(ape)
  library(ggplot2)
  #library(caret)
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
        req(input$file1)
        rffit2 <- load("model/rffit2.rda")
        #df <- read.dna("test.fas",format="fasta")
        df <- read.dna(input$file1$datapath,format="fasta")
        library(ape)
        df <- as.character(df)  
        df <- as.data.frame(df)    
        Prediction <- predict(rffit2,type = 'class',
                              newdata = as.data.frame(df)  )
        predictionResult <- data.frame(
            SequenceName=labels.DNAbin(dfraw),
            Pred_Subgenotype=Prediction,
            model=c("rffit.v20240405"))
        tryCatch(
          predictionResult
        )
      })
    #######################################################################
  }
    



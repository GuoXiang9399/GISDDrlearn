###############################################################################
###############################################################################
###############################################################################
#loading package
  library(shiny)
  library(tidyr)
  library(ape)
  library(caret)
  library(ranger)
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
    load_model <- function(model_path) {  
      load(model_path)  
      model_name <- tools::file_path_sans_ext(basename(model_path))  
      get(model_name)  
    }  
    datasetInput1 <- reactive({  
      paste0("model/", input$dataset1, ".rda")  
    })  
    datasetInput2 <- reactive({  
      paste0("model/", input$dataset2, ".rda")  
    })  
    #######################################################################
    output$contents <- renderTable({  
      req(input$file1, datasetInput1())  
      model_path1 <- datasetInput1()  
      model1 <- load_model(model_path1)  
      model_path2 <- datasetInput2()  
      model2 <- load_model(model_path2)  
      if (exists("model1") && !is.character(model1)) {  
        dfraw <- read.dna(input$file1$datapath, format = "fasta", as.character = TRUE)  
        df <- as.data.frame(dfraw, row.names = NULL) 
        #subgenotype
         predictions1 <- predict(model1, df)  
         predictionResult1 <- data.frame(
           Sequence=labels.DNAbin(dfraw),
           Pred_Subgenotype=predictions1,
           model=c("rffit_GISDD.1.3.2_Subgenotype"))
         predictionResult1 <- separate(
           predictionResult1,Pred_Subgenotype,
           into=c("Serotype","Subgenotype"),sep="_")
        #clade
         predictions2 <- predict(model2, df)  
         predictionResult2 <- data.frame(
           Sequence=labels.DNAbin(dfraw),
           Pred_Subgenotype=predictions2,
           model=c("rffit_GISDD.1.3.2_Clade"))
         predictionResult2 <- separate(
           predictionResult2,Pred_Subgenotype,
           into=c("Serotype","Clade"),sep="_")
        #Merge
         predictionResult <- cbind(predictionResult1[,c("Sequence","Serotype","Subgenotype","model")],
          predictionResult2[,c("Clade","model")])
        return(predictionResult)
      } else {  
        stop("The model object is not loaded correctly or does not exist.")  
      }  
    })
    #######################################################################
  }
    


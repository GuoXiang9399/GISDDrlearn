###############################################################################
###############################################################################
###############################################################################
#loading package
  library(shiny)
  library(readxl)
  library(ape)
  library(caret)
  library(shinythemes)
###############################################################################
# Shiny UI
  fluidPage(
    #theme = "bootstrap.css",
    #includeCSS("www/styles.css"),
    #######################################################################
    navbarPage(
      HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#"> GISDDrlearn </a>'), id="nav",
      windowTitle = "GISDDrlearn",
      theme = shinytheme("flatly"), collapsible = TRUE,
     ######################################################################
      tabPanel(
        "Introduction & Usage",
        h4("Introduction"),
        h5("The rapid expansion in virus genome data production has necessitated development of novel analytical methods capable of handling more genomes than previously accessible."),
        h5("As an important machine learning model, Random Forest is an ensemble of decision trees, each constructed using a subset of the training sample. The structural analogy reveals an intriguing connection between Random Forest and evolution trees."),
        h5("With this concept, we developed GISDDrlearn, an user-friendly R Shiny application, for assigning DENV sequences to serotype, genotype, subgenotype, and clade based on the Random Forest."),
        h5("Due to accessibility and affordability of the E gene of DENV, our high-resolution genotyping with GISDDrlearn can bridge classical E-gene-based genotyping methods with emerging genomic epidemiology."),
        h5("All GISDDrlearn models trained with complete E sequences of DENV and their designated serotypes, genotypes, subgenotyps, and clades can assign 1000 E sequences in approximately 30 seconds."),
        hr(),
        h4("Demo file"),
        a(href = "https://www.smu.edu.cn/rdyjs/index.htm",
          "file download",
          target = "_blank"),
        hr(),
        h4("Usage"),
        img(src = "Usage.png", alt = "D1 Genome Image", style = "width:75%;height:auto;"),
        h5("(1). Click the Genotyping TabPanel"),
        h5("(2). Check the GISDD version"),
        h5("(3). Choose subgenotype & clade model"),
        h5("(4). Import fasta files (NOTE: must Complete E gene)"),
        h5("(5). Click the Submit bottom"),
        h5("(6). Check the genotyping results"),
        hr()
      ),
     ######################################################################
      tabPanel(
        "Model",
        h4("Training process"),
        h5("Developed to enhance the classification of DENV genotypes, the GISDDrlearn employed a random forest classification algorithm to predict serotype, genotype, subgenotype, and clade of DENV genotypes."),
        h5("The model was crafted using the R language with the ‘caret’ (version 6.094) and ‘randomForest’ (version 4.71.1) r-package, employing the optimal model (parameters of mtry and splitrule) were selected based on the value of accuracy."),
        h5("The model’s performance was validated through receiver operating characteristic (ROC) analysis with ten-fold cross-validation, calculating the area under the curve (AUC) for each sequence's serotype, genotype, subgenotype, and clade predictions in the training set."),
        h5("The trained GISDDrlearn model along with header files, metadata and detailed notes on genotype, subgenotype, and clade, are accessible on GitHub repository."),
        a(href = "https://github.com/GuoXiang9399/GISDDrlearn-training",
          "GISDDrlearn-training (https://github.com/GuoXiang9399/GISDDrlearn-training)",
          target = "_blank"),
        hr(),
        h4("Model"),
        h5("Current models were trained separately on subgenotypes and clades across various serotypes on June 2020."),
        a(href = "https://github.com/GuoXiang9399/GISDDrlearn-training/tree/main/Result",
          "Model list:",
          target = "_blank"),
        h5("(1) rffit_GISDD.1.3.2_D1_Subgenotype & rffit_GISDD.1.3.2_D1_Clade"),
        h5("(2) rffit_GISDD.1.3.2_D2_Subgenotype & rffit_GISDD.1.3.2_D2_Clade"),
        h5("(3) rffit_GISDD.1.3.2_D3_Subgenotype & rffit_GISDD.1.3.2_D3_Clade"),
        h5("(4) rffit_GISDD.1.3.2_D4_Subgenotype & rffit_GISDD.1.3.2_D4_Clade")
      ),
     ######################################################################
      tabPanel(
        "Genotyping",
         sidebarLayout(
          sidebarPanel(
            h4("Current GISDD version:"),
            h3("v1.3.2"),
            tags$hr(),
            selectInput("dataset1", "Choose a subgenotype model:",
                        choices = c("rffit_GISDD.1.3.2_D1_Subgenotype", 
                                    "rffit_GISDD.1.3.2_D2_Subgenotype",
                                    "rffit_GISDD.1.3.2_D3_Subgenotype", 
                                    "rffit_GISDD.1.3.2_D4_Subgenotype")),
            selectInput("dataset2", "Choose a clade model:",
                        choices = c("rffit_GISDD.1.3.2_D1_Clade", 
                                    "rffit_GISDD.1.3.2_D2_Clade", 
                                    "rffit_GISDD.1.3.2_D3_Clade", 
                                    "rffit_GISDD.1.3.2_D4_Clade")),
            tags$hr(),
            fileInput("file1", "Choose fasta/fas File:",
                      multiple = FALSE,
                      accept = c("text/csv",".csv",".fas",".fasta",".fa",
                                 "text/comma-separated-values,text/plain")),
            tags$hr(),
            radioButtons("disp", "Display",
                         choices = c(Head = "head",
                                     All = "all"),
                         selected = "head") ,
            #downloadButton("downloadData", "Download")
            submitButton("Submit")
            ),
          mainPanel(
            # Output: Data file ----
            tableOutput("contents")
          )
        )
      ),
     ######################################################################
     tabPanel(
       "About",
       h4("Contact"),
       a(href = "https://www.smu.edu.cn/rdyjs/info/1003/1355.htm",
         "Xiang Guo  Institutes of Tropical Medicine, Southern Medical University, China",
         target = "_blank"),
       hr(),
       h4("Sources"),
       a(href = "http://www.bic.ac.cn/GISDD/#/",
         "GISDD (http://www.bic.ac.cn/GISDD/#/)",
         target = "_blank"),
       hr(),
       h4("References"),
       h5("(1). DENV genotyping framework"),
       h5("Infectious Diseases of Poverty (2022) 11:107"),
       a(href = "https://doi.org/10.1186/s40249-022-01024-5",
         "A unifed global genotyping framework of dengue virus serotype-1 for a stratifed coordinated surveillance strategy of dengue epidemics",
         target = "_blank"),
       h5("(2). Molecular epidemiology in China"),
       h5("Infectious Diseases of Poverty (2024)"),
       a(href = "https://doi.org/10.1186/s40249-024-01211-6",
         "Phylodynamics unveils invading and diffusing patterns of dengue virus serotype-1 in Guangdong China from 1990 to 2019 under a global genotyping framework",
         target = "_blank")
     )
     #######################################################################
    )
  )
    


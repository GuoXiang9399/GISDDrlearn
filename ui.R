###############################################################################
###############################################################################
###############################################################################
#loading package
  library(shiny)
  library(readxl)
  library(ape)
  library(caret)
###############################################################################
# Shiny UI
  fluidPage(
    theme = "bootstrap.css",
    includeCSS("www/styles.css"),
    #######################################################################
    navbarPage(
      " GISDDrlearn ",
     ######################################################################
      tabPanel(
        "About/Usage 简介",
        h2("GISDDrlearn"),
        h5("Our study has established a reproduceable and comparable global genotyping framework of DENV with contextualizing spatiotemporal epidemiological information before. The defned framework was discriminated with three hierarchical layers of genotype, subgenotype and clade with respective mean pairwise distances 2–6%, 0.8–2%, and ≤0.8%. This framework reveals that the persisting traditional endemic sourcing, the emerging epidemic difusing, and the probably hidden epidemics are the crucial drivers of the rapid global spread of dengue. "),
        h5("GISDDrlearn is a easy-used R Shiny app for assigning DENV sequences to serotype, genotype, subgenotype, and clade based on Random Forest method. As one of the import machine learning model, random forest is an ensemble of secision trees, each built using a subset of the training sample. The structural from show a interesting connection between Random Forest and evolution tree."),
        h5("Due to the accessibility and afordability of E gene, our highresolution genotyping can be employed as a transitional or linkage scheme reconciling the classical E gene genotyping with the emerging genomic epidemiology. For all GISDDrlearn models, the model was trained using DENV complete E sequences and their designated serotypes, genotypes, subgenotyps, and clades. GISDDrlearn can assign 1000 E sequences in ~30 seconds."),
        hr(),
        h2("Usage"),
        h5("(1) Import fasta files (Complete E gene 1485bp)"),
        h5("(2) Genotyping based on Random Forest"),
        h5("(3) Result check"),
        hr(),
        h2("Data source"),
        a(href = "http://www.bic.ac.cn/GISDD/#/",
          "GISDD (http://www.bic.ac.cn/GISDD/#/)",
          target = "_blank"),
        hr(),
        h2("Contact"),
        a(href = "https://www.smu.edu.cn/rdyjs/info/1003/1355.htm",
          "Xiang Guo",
          target = "_blank"),
        h5("Institutes of Tropical Medicine, Southern Medical University, China"),
        hr(),
        h2("References"),
        h5("1. DENV genotyping framework: Infectious Diseases of Poverty (2022) 11:107"),
        a(href = "https://doi.org/10.1186/s40249-022-01024-5",
          "A unifed global genotyping framework of dengue virus serotype-1 for a stratifed coordinated surveillance strategy of dengue epidemics",
          target = "_blank"),
        h5("2. Epidemiology study:"),
        a(href = "https://doi.org/10.21203/rs.3.rs-3902313/v1",
          "Phylodynamics unveils invading and diffusing patterns of dengue virus serotype-1 in Guangdong China from 1990 to 2019 under a global genotyping framework",
          target = "_blank"),
      ),
     ######################################################################
     tabPanel(
       "GISDD frame 分型框架",
       sidebarLayout(
         sidebarPanel(
           radioButtons("picture", "Picture:",
                        c("structure", "frame"))
         ),
         mainPanel(
           imageOutput("image2")
         )
       )
     ),
     ######################################################################
      tabPanel(
        "Genotyping 分型工具",
         sidebarLayout(
          sidebarPanel(
            h4("Current GISDD version:"),
            h1("v1.3.2"),
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
            checkboxInput("header", "Header", TRUE),
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
    #######################################################################
    )
  )
    


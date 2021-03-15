# Import R packages needed for the app here:
library(shiny)
library(DT)
library(RColorBrewer)
library(readr)
library(dplyr)
data <- read_csv("data.csv")

# Define any Python packages needed for the app here:
PYTHON_DEPENDENCIES = c('pip', 'numpy')

# Begin app server
shinyServer(function(input, output) {
  
  # ------------------ App virtualenv setup (Do not edit) ------------------- #
  
  virtualenv_dir = Sys.getenv('VIRTUALENV_NAME')
  python_path = Sys.getenv('PYTHON_PATH')
  
  # Create virtual env and install dependencies
  #reticulate::virtualenv_create(envname = virtualenv_dir, python = python_path)
  reticulate::virtualenv_install(virtualenv_dir, packages = PYTHON_DEPENDENCIES, ignore_installed=TRUE)
  reticulate::use_virtualenv(virtualenv_dir, required = T)
  
  # ------------------ App server logic (Edit anything below) --------------- #
  
  plot_cols <- brewer.pal(11, 'Spectral')
  
  # Import python functions to R
  reticulate::source_python('python_functions.py')
  
  # Generate the requested distribution
  d <- reactive({
    dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   lnorm = rlnorm,
                   exp = rexp,
                   rnorm)
    
    return(dist(input$n))
  })
  
  # Affichage


  output$data <- renderDataTable(datatable({data}))
  
  output$message <- renderDataTable(datatable({
    rech <- recherche(input$str,input$limite)
    var <- input$variable
    return(data%>%filter(id %in% rech)%>%select(var))
           
    
    }))

    output$txt <- renderText({
      icons <- paste(input$variable, collapse = ", ")
      return(paste("You chose", icons))
    
  })

  
})
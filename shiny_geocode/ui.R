# Import R packages needed for the UI
library(shiny)
library(shinycssloaders)
library(DT)
library(dplyr)

# Begin UI for the R + reticulate example app
ui <- fluidPage(
  
  titlePanel('Explorer Spotify avec Shiny'),
  
  sidebarLayout(
    
    # ---------------- Sidebar panel with changeable inputs ----------------- #
    sidebarPanel(
      textInput('str',
                'Recherche sur Spotify',
                value = 'Ariana Grande'),
      
      sliderInput('limite',
                  'Nombre de resultats affiches',
                  value = 20,
                  min = 1,
                  max = 50),
      checkboxGroupInput("variable", "Variables a afficher :",
                         c("Artiste" = "artists",
                           "Titre" = "name",
                           "Duree" = "duration_ms",
                           "acousticness"="acousticness",
                           "danceability"="danceability",
                           "energy"="energy",
                           "explicit"="explicit",
                           "id"="id",
                           "instumentalness"="instrumentalness",
                           "key"="key",
                           "liveness"="liveness",
                           "loudness"="loudness",
                           "mode"="mode",
                           "popularity"="popularity",
                           "release_date"="release_date",
                           "speechiness"="speechiness",
                           "tempo"="tempo",
                           "valence"="valence"),
                         selected=c("artists","name"))

    ),
    
    # ---------------- Sidebar panel with changeable inputs ----------------- #
    mainPanel(
              h3('Details des musiques affichees'),
              dataTableOutput('message')
      

  )
))
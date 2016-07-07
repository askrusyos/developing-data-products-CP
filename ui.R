library(shiny)
library(DT)

shinyUI
(
tabsetPanel(
    tabPanel("Fish catches",
        fixedPage
        (          
            fixedRow
            (
                  # the species table
                  column(width=8, h1("Annual fish catches in the North-East Atlantic"), h3("Select a species"),
                  DT::dataTableOutput('x11'),verbatimTextOutput('y11')),
                  tags$style(type='text/css', 'h1 {background-color: rgba(255,255,0,0.40); color: blue}'),
                  tags$style(type='text/css', 'h3 {color: green}')
            ),
          mainPanel
          (
            # css tags for formatting the output of the result
            tags$style(type='text/css', '#ospecies {background-color: rgba(255,255,0,0.40); color: blue; font-size:22pt}'), 
            fixedRow
            (
              width = 4,
              # radio buttons for the years selection
              radioButtons("years", label = h3("Select a year"), c("2006" = "06", "2007" = "07", 
                                                               "2008" = "08", "2009" = "09",
                                                               "2010" = "10", "2011" = "11",
                                                               "2012" = "12", "2013" = "13",
                                                               "2014" = "14"), 
                                                                selected = "14", inline=TRUE),
              h4("Catches in tons of live weight:"),
              textOutput(outputId = "ospecies")  # result output
              )
            
            
          )  #close mainPanel

      
        
  ) #close fixedPage
    ), #close tabpanel
  tabPanel("Instructions", h2("How to use this app"), h3("The data"), 
           h4("This app shows the data about annual fish catches in the North Atlantic, classified by species of fish. "), 
           h4("The data used derive from the submissions by the International Council for the Exploration of the Sea (ICES) member countries from 2006 to 2014."),
           h4("The dataset, along with the species table, are available at Kaggle website at the following address:https://www.kaggle.com/victorgenin/ices-fish-catch"),
           h3("Selecting the fish species and the year"),
           h4("The use of this app is fairly intuitive: you just have to select a species of fish and a year from 2006 to 2014 and the annual catches for that species will be displayed in the cell at the bottom of the page."),
           h4("You can also choose to calculate the total annual catches by leaving the species table without selection."),
           h4("(Click on a selected species to toggle the selection for it)."),
           h4("The source code of this app is available at: https://github.com/askrusyos/developing-data-products-CP")
           
           )
) #close tabsetpanel
) #close shinyUi
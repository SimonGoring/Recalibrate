
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(Bchron)

shinyUI(bootstrapPage(

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h3("Calibration Options"),
      p("Enter values.  Hover the mouse over an element to see tool tips."),
      tags$div(title = "Enter a number representing radiocarbon years before present.  When empty, will show the selected calibration curve.",
               numericInput("age",
                   "Radiocarbon Age:",
                   value = NULL)),
      tags$div(title = "Enter a number representing the standard deviation for the radiocarbon estimate.  When empty, will show the selected calibration curve.",
               numericInput("ageSds",
                   "Radiocarbon Age (one Sigma):", 
                   value = NULL)),
      tags$div(title = "Select the appropriate radiocarbon calibration curve.",
               selectInput('curve',
                  'Calibration Curve:',
                  choices = c('intcal13', 'marine13', 'shcal13'),
                  selected = 'intcal13',
                  multiple = FALSE))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h1('Calibration Probability Density Function'),
      plotOutput("curvePlot"),
      br(),
      h2("95% Probability Regions"),
      tableOutput('calibAge')
    )
  )
))

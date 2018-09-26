
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(Bchron)

shinyUI(bootstrapPage(

  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Roboto:400,700');
      
      h1 {
        font-family: 'Roboto';
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
      }
      h3 {
        font-family: 'Roboto';
        font-weight: 300;
        line-height: 1;
        color: #48ca3b;
      }

    "))
  ),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      width=2,
      h3("Calibration Options"),
      HTML('<b>Enter values</b><br>Hover the mouse over an element to see tool tips.  The INTCAL Calibration curve will appear until both age & uncertainty are entered.'),
      HTML('<hr style="border: 0;height: 1px;background-image: -webkit-linear-gradient(left, #f0f0f0, #8c8b8b, #f0f0f0);
                       background-image: -moz-linear-gradient(left, #f0f0f0, #8c8b8b, #f0f0f0);
           background-image: -ms-linear-gradient(left, #f0f0f0, #8c8b8b, #f0f0f0);
           background-image: -o-linear-gradient(left, #f0f0f0, #8c8b8b, #f0f0f0);">'),
      tags$div(title = "Enter a number representing radiocarbon years before present.  When empty, will show the selected calibration curve.",
               numericInput("age",
                   "Radiocarbon Age:",
                   value = NULL)),
      tags$div(title = "Enter a number representing the standard deviation for the radiocarbon estimate.  When empty, will show the selected calibration curve.",
               numericInput("ageSds",
                   "Radiocarbon Age Uncertainty (one Sigma):", 
                   value = NULL)),
      tags$div(title = "Select the appropriate radiocarbon calibration curve.",
               selectInput('curve',
                  'Calibration Curve:',
                  choices = c('intcal13', 'marine13', 'shcal13'),
                  selected = 'intcal13',
                  multiple = FALSE)),
      HTML('<hr style="border: 0;height: 1px;background-image: -webkit-linear-gradient(left, #f0f0f0, #8c8b8b, #f0f0f0);
                       background-image: -moz-linear-gradient(left, #f0f0f0, #8c8b8b, #f0f0f0);
           background-image: -ms-linear-gradient(left, #f0f0f0, #8c8b8b, #f0f0f0);
           background-image: -o-linear-gradient(left, #f0f0f0, #8c8b8b, #f0f0f0);">'),
      HTML('<a href="https://en.wikipedia.org/wiki/Calibration_of_radiocarbon_dates">Radiocarbon calibration</a> takes a sample date, in <sup>14</sup>C years and converts it to calendar years.
        Because the ratio of <sup>14</sup>C/<sup>12</sup>C in the atmosphere varies through time, this relationship is not constant.')
      
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h1('Calibration Probability Density Function'),
      plotOutput("curvePlot"),
      br(),
      tags$div(style="border:1px black;border-style:solid;padding:2px;width=20%",
        h2("95% Probability Regions"),
        tableOutput('calibAge')
      )
    )
  )
))

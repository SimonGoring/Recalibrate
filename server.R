library(shiny)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {

  output$curvePlot <- renderPlot({

    print(input$age)
    
    if (!(is.na(input$age) | is.na(input$ageSds))) {
    
      x    <- BchronCalibrate(ages = input$age,
                            ageSds = input$ageSds,
                            calCurves = input$curve)
    
      smoothed <- predict(smooth.spline(x = x$Date1$ageGrid, 
                                        y = x$Date1$densities),
                          x = seq(min(x$Date1$ageGrid),
                                  max(x$Date1$ageGrid),
                                  length.out = 1000))
      
      plot_frame <- data.frame(x = smoothed$x,
                               y = smoothed$y)
      
      bins <- summary(x) %>% 
        bind_rows %>% t %>% 
        data.frame
      
      bins$ymin <- -1
      bins$ymax <- 1
      colnames(bins)[1:2] <- c('xmin', 'xmax')
      
      ggplot(data = bins) +
        geom_rect(aes(xmin = xmin, ymin = ymin, 
                      xmax = xmax, ymax = ymax), alpha = 0.2,
                  color = 'darkgray') +
        geom_path(data = plot_frame, aes(x = x, y = y)) +
        theme_light() +
        ylab('Kernel Density') +
        xlab('Calibrated Radiocarbon Year') +
        coord_cartesian(ylim = c(0, max(plot_frame$y) * 1.1), 
                        expand = FALSE) +
        theme(axis.title = element_text(face='bold.italic', size = 16),
              axis.text.x = element_text(face='bold', size = 14),
              plot.margin=margin(5,40,5,5))
        
    } else {
      calcurve <- do.call(data, list(input$curve)) %>% get
      
      ggplot(data = calcurve) +
        geom_abline(slope = 1, intercept = 0, color = 'red', alpha = 0.1) +
        geom_line(aes(x = V1, y = V2), alpha = 0.2,
                  color = 'black') +
        geom_ribbon(aes(x = V1, 
                        ymin = V2 - V3, ymax = V2 + V3),
                    color = 'lightgray', alpha = 0.8) +
        geom_ribbon(aes(x = V1, 
                        ymin = V2 - V3*100, ymax = V2 + V3*100),
                    color = 'lightgray', alpha = 0.3) +
        theme_light() +
        ylab('Calibrated Radiocarbon Year BP') +
        xlab('Radiocarbon Year BP') +
        coord_cartesian(ylim = c(0, max(calcurve$V2)), 
                        expand = FALSE) +
        theme(axis.title = element_text(face='bold.italic', size = 16),
              axis.text.x = element_text(face='bold', size = 14),
              plot.margin=margin(5,40,5,5)) +
        annotate(geom = 'text', x = 5000, y = 35000,
                 label = paste0(input$curve, "\nCalibration Curve"),
                 size = 10, hjust = 'left',
                 fontface = 'bold') +
        annotate(geom = 'text', x = 36000, y = 28000,
                 label = "Uncertainty -\n100x Exaggeration",
                 size = 6, hjust = 'left',
                 fontface = 'italic')
      
    }

  })
    
  output$calibAge <- renderTable({

    if (!(is.na(input$age) | is.na(input$ageSds))) {
      # generate bins based on input$bins from ui.R
      x    <- BchronCalibrate(ages = input$age,
                              ageSds = input$ageSds,
                              calCurves = input$curve) %>% 
        summary %>% bind_rows %>% t %>% data.frame
      
      x$Percentile <- rownames(x)
      colnames(x)[1:2] <- c('Minimum', 'Maximum')
      
      xtable::xtable(x, caption = "Calibrated Radiocarbon Age")
    }
  }, spacing = 's', rownames = FALSE, striped = TRUE)

})

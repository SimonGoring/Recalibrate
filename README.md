# Shiny Radiocarbon Calibration

This `shiny` app was developed to provide a simple interface for individuals to learn how radiocarbon calibration works using [Andrew Parnell](http://mathsci.ucd.ie/~parnell_a/)'s [`Bchron`](https://github.com/andrewcparnell/Bchron) package.

This app takes only three inputs, the radiocarbon date, the uncertainty and the calibration curve.  I have added tooltips, and welcome additional contributions.


## Development

+ [Simon Goring](http://goring.org) - University of Wisconsin-Madison, Department of Geography

## Running the App

The app can be downloaded by cloning this repository from the command line:

```bash
git clone https://github.com/SimonGoring/Recalibrate.git
```

By starting a new project from RStudio's version control, or by downloading the [repository's zip file](http://github.com/SimonGoring/Recalibrate/archive/master.zip).

Once the project is downloaded or installed locally, make sure you have the required packages:

```r
install.packages(c("shiny", "dplyr", "Bchron", "ggplot2"))
```

At this point you just need to navigate to the home directory (which should be `Recalibrate`), making sure that is the working directory, and then use the command `shiny::runApp()`
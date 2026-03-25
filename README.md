# nicheR.experiment

This is a GSOC submission for the [nicheR shiny](https://github.com/rstats-gsoc/gsoc2026/wiki/nicheR-shiny) project.

[![R-CMD-check](https://github.com/annahuynhly/nicheR_experiment/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/annahuynhly/nicheR_experiment/actions/workflows/R-CMD-check.yaml)

This `R` package mostly includes the `R Shiny` site, which installs the 
[WorldCimb bioclimantic](https://www.worldclim.org/data/bioclim.html) variables, 
extracts the layer, the cropped extent, and the masked final result.

## Installation

You can install the development version of nicheR.experiment from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("annahuynhly/nicheR_experiment")
```

## Loading Website Example

Use the following command below after loading the library to launch the `R shiny` app.

``` r
library(nicheR.experiment)
launch_app()
```


#' Launches the test nicheR shiny app for GSOC2026.
#'
#' @importFrom shiny runApp
#' @export
launch_app <- function(){
  app_dir <- system.file("shinyapp", package = "nicheR.experiment")
  shiny::runApp(app_dir)
}

#' Downloads the WorldClim bioclimatic variables at 10 arc minute resolution.
#'
#' @examples
#' download_bioclim_bio()
#' @export
download_bioclim_bio <- function(){
  geodata::worldclim_global(var = "bio", res = 10)
}

#' Crops or masks the map region covering South America.
#' @param dat a S4 class 'SpatRaster' that is subsetted to retain the
#' relevant bioclimatic variables
#' @param modify indicates whether to crop or mask South America
#'
#' @examples
#' \dontrun{dat <- download_bioclim_bio()[[1]]
#' mod <- modify_south_america(dat)
#' terra::plot(mod)}
#' @importFrom terra ext mask crop
#' @export
modify_south_america <- function(dat, modify = "Crop"){
  modify <- match.arg(modify, c("Crop", "Mask"))
  sa_ext <- terra::ext(-82, -34, -56, 13)
  if(modify == "Crop"){
    bio1_sa <- crop(dat, sa_ext)
  } else {
    bio1_sa <- mask(dat, sa_ext)
  }
}

library("shiny")
library("bslib")
library("shinycssloaders") # for loading screens
library("terra")
library("geodata")

options(spinner.type = 8, spinner.color = "#6990EE")

# https://www.worldclim.org/data/bioclim.html
bio_vars <- list(
  "Annual Mean Temperature"                      = 1,
  "Mean Diurnal Range"                           = 2,
  "Isothermality (BIO2/BIO7 x100)"               = 3,
  "Temperature Seasonality (SD x100)"            = 4,
  "Max Temperature of Warmest Month"             = 5,
  "Min Temperature of Coldest Month"             = 6,
  "Temperature Annual Range (BIO5-BIO6)"         = 7,
  "Mean Temperature of Wettest Quarter"          = 8,
  "Mean Temperature of Driest Quarter"           = 9,
  "Mean Temperature of Warmest Quarter"          = 10,
  "Mean Temperature of Coldest Quarter"          = 11,
  "Annual Precipitation"                         = 12,
  "Precipitation of Wettest Month"               = 13,
  "Precipitation of Driest Month"                = 14,
  "Precipitation Seasonality (CV)"               = 15,
  "Precipitation of Wettest Quarter"             = 16,
  "Precipitation of Driest Quarter"              = 17,
  "Precipitation of Warmest Quarter"             = 18,
  "Precipitation of Coldest Quarter"             = 19
)

ui <- page_sidebar(
  theme = bs_theme(version = 5,
                   bootswatch = "flatly",
                   "navbar-bg" = "#2C3E50"), # may want to change theme?

  title = "nicheR shiny Test",

  sidebar = sidebar(

    selectInput("bio_var", "Select Variable", choices = bio_vars),

    layout_columns(
      actionButton("back_button", "Back"),
      actionButton("next_button", "Next"),
      col_widths = c(6, 6)
    )

  ), # end sidebar

  withSpinner(plotOutput("map_output"))
)

server = function(input, output) {

  click_count <- reactiveVal(0)

  observeEvent(input$next_button, {
    if(click_count() <= 3){
      click_count(click_count() + 1)
    }
  })

  observeEvent(input$back_button, {
    # do not want to go back to 1
    if(click_count() >= 3){
      click_count(click_count() - 1)
    }
  })

  dat <- reactiveVal(NULL)

  observeEvent(click_count() == 1, {
    if (click_count() == 1) {
      dat(download_bioclim_bio())
      #dat(geodata::worldclim_global(var = "bio", res = 10))
    }
  })

  selected_graph <- reactive({dat()[[as.integer(input$bio_var)]]})

  plot_name <- reactive({names(bio_vars)[bio_vars == input$bio_var]})

  # Output graph
  output$map_output <- renderPlot({
    count <- click_count()

    if (count == 1) {
      plot.new()
      text(0.5, 0.5, "WorldClim data downloaded.", cex = 1.5)
    } else if (count == 2){
      plot(selected_graph(), main = plot_name())
    } else if (count == 3) {
      # Cropping
      bio1_sa <- modify_south_america(selected_graph(), "Crop")
      #sa_ext <- ext(-82, -34, -56, 13)
      #bio1_sa <- crop(selected_graph(), sa_ext)
      plot(bio1_sa, main = paste("Cropped South America:", plot_name()))
    } else if (count >= 4) {
      # Masking
      bio1_sa <- modify_south_america(selected_graph(), "Mask")
      #sa_ext <- ext(-82, -34, -56, 13)
      #bio1_sa <- mask(selected_graph(), sa_ext)
      plot(bio1_sa, main = paste("Masked South America:", plot_name()))
    }
  })

}

shinyApp(ui = ui, server = server)

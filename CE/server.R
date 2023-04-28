library(tidyverse)
library(shiny)
library(rmarkdown) 
library(kableExtra)

function(input, output, session) {
  output$ce <- downloadHandler(
    filename = function() {
      glue::glue_safe(input$oem, ".", input$frame, ".", input$lens, "_CE_DecofConform_INVO", ".pdf")
      },
                  content =  function(file){
                    ce_path <- tempfile(fileext = ".Rmd")
                    topimPath <- file.path(tempdir(), "top_im1.JPG")
                    botimPath <- file.path(tempdir(), "bot_im_sml.JPG")
                    data_path <- file.path(tempdir(), "tech_data.xlsx")
                    file.copy("Gen_CE_Dec_of_Conform_Goggles.Rmd",
                              ce_path,
                              overwrite = TRUE)
                    file.copy("www/top_im1.JPG", 
                              topimPath, 
                              overwrite = TRUE)
                    file.copy("www/bot_im_sml.JPG", 
                              botimPath, 
                              overwrite = TRUE)
                    file.copy("data/Technical_Information.xlsx", 
                              data_path, 
                              overwrite = TRUE)
                    params <- list(frame = input$frame, 
                                   lens = input$lens
                                   )
                    id <- showNotification("Knitting...",
                                           duration = NULL,
                                           closeButton = FALSE)
                    on.exit(removeNotification(id), add = TRUE)
                    render(ce_path, 
                           output_file = file, 
                           params = params,
                           envir = new.env(parent = globalenv()))
                  })
}

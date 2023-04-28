library(tidyverse)
library(bslib)
library(shiny)

full_data <- readxl::read_excel("data/prod_specs_core_data.xlsx")
frame_choices <- full_data %>% 
  filter(type == "frame") 
frame_choices <- unique(frame_choices$product)
lens_choices <- full_data %>% 
  filter(type == "lens") 
lens_choices <- unique(lens_choices$product)

page_fluid(theme = bs_theme(version = 5,
                            bg = "black",
                            fg = "white"),
           card(
             card_header(
               h3("UKCA Declaration of Conformity (DoC)")
             ),
             fluidRow(column(4,
                             textInput("oem", "OEM Name", value = NULL, placeholder = NULL)),
                      column(4,
                             selectInput("frame", "Frame", choices = sort(frame_choices), selected = NULL)),
                      column(4,
                             selectInput("lens", "Lens", choices = sort(lens_choices), selected = NULL))
             ),
             fluidRow(h2(
               strong("Enter the OEM name and select the components of the product")), 
               h3(div("Then click the download button at the bottom of this page to output a UKCA DoC for that OEM")),
               h3(em("Note - Entering an OEM name is optional")),
               column(12,align = 'right',
                      downloadButton(outputId = "ce", label = "Download UKCA Declaration of Conformity (pdf)"))
             )
           )
)
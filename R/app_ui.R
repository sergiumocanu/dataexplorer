#' Application User Interface
#'
#' @param request Internal parameter for `{shiny}`.
#' @import shiny
#'
#' @return
#' @export
#'
#' @examples
app_ui <- function(request) {
  fluidPage(titlePanel("Data Explorer App"),

            sidebarLayout(
              # sidebar content
              sidebarPanel( width=3,
                mod_upload_file_ui("upload_file_ui_1", "Upload Lab Values"),
                mod_upload_file_ui("upload_file_ui_2", "Upload Patient Levels")
              ),

              # main page content
              mainPanel(
                tabsetPanel(
                  type = "tabs",
                  tabPanel("Table 1", mod_table_ui("mod_table_1")),
                  tabPanel("Table 1", mod_table_ui("mod_table_2")),
                  tabPanel("Visualize",
                           fluidRow(
                             column(6, mod_plot_ui("plot_1", "Lab Values Visualizer")),
                             column(6, mod_plot_ui("plot_2", "Patient Levels Visualizer"))
                           )),
                  tabPanel("Compare Patients", mod_patient_compare_ui("compare"))
                )
              )


            ))
}

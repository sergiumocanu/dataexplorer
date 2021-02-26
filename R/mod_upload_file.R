#' mod_upload_file_ui
#'
#' @param id
#'
#' @return
#' @export
#'
#' @examples
mod_upload_file_ui <- function(id, label){
  ns <- NS(id)
  tagList(
    fileInput(ns("file"), label, multiple = FALSE, accept = ".tsv")
  )
}


#' mod_upload_file_server
#'
#' @param id
#'
#' @return
#' @export
#'
#' @examples
mod_upload_file_server <- function(id){
  moduleServer(
    id,
    function(input, output, session){

      userFile <- reactive({
        validate(need(input$file, message = FALSE))
        input$file
      })

      df <- reactive({
        read.csv(userFile()$datapath,
                 header = TRUE,
                 sep = "\t",
                 quote = '"',
                 check.names = FALSE)
      })
      return(df)
    }

  )

}

#' Title
#'
#' @param id
#'
#' @return
#' @export
#'
#' @examples
mod_table_ui <- function(id){
  ns <- NS(id)

  tagList(
    dataTableOutput(ns("table"))
  )

}

#' Title
#'
#' @param id
#' @param df
#'
#' @return
#' @export
#'
#' @examples
mod_table_server <- function(id, df){
  moduleServer(
    id,
    function(input, output, session){
      output$table <- renderDataTable(
        df(),
        options = list(pageLength = 10)
      )
    }
  )
}

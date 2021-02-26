#' Title
#'
#' @param id
#'
#' @return
#' @export
#'
#' @examples
mod_plot_ui <- function(id, textlabel){
  ns <- NS(id)
  tagList(
    h3(textlabel),
    plotOutput(ns("plot")),
    uiOutput(ns("controls"))
  )
}

#' Title
#'
#' @param id
#' @param df
#'
#' @import ggplot2
#' @import dplyr
#'
#' @return
#' @export
#'
#' @examples
mod_plot_server <- function(id, df){
  moduleServer(
    id,
    function(input, output, session){

      tempdf <- reactive({
        count(df(), !! rlang::sym(toString(input$col)))
      })

      output$plot <- renderPlot({

        ggplot(tempdf(), aes(x="", y=n, fill=!! rlang::sym(toString(input$col)))) + geom_bar(stat="identity", width=1, color="white") + coord_polar("y", start = 0) + theme_void()
      })

      output$controls <- renderUI({
        ns <- session$ns
        selectInput(ns("col"), label = "Select X-variable", choices = colnames(df()), selected = colnames(df())[4])

      })

    }
  )
}

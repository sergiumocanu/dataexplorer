#' run_app
#'
#' @return
#' @export
#'
#' @examples
run_app <- function(){
  app = shinyApp(
    ui = app_ui,
    server = app_server
  )

  runApp(app, launch.browser = TRUE)
}

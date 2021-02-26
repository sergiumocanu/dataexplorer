#' app_server
#'
#' @param input
#' @param output
#' @param session
#'
#' @return
#' @export
#'
#' @examples
app_server <- function( input, output, session ) {
  # List the first level callModules here
  df_1 <- mod_upload_file_server("upload_file_ui_1")
  df_2 <- mod_upload_file_server("upload_file_ui_2")

  mod_table_server("mod_table_1", reactive(df_1()))
  mod_table_server("mod_table_2", reactive(df_2()))

  mod_plot_server("plot_1", reactive(df_1()))
  mod_plot_server("plot_2", reactive(df_2()))

  mod_patient_compare_server("compare", df_1, df_2)
}

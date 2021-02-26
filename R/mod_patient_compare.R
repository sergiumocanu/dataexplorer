#' Title
#'
#' @param id
#'
#' @return
#' @export
#'
#' @examples
mod_patient_compare_ui <- function(id){
  ns <- NS(id)
  tagList(

    fluidRow(
      column(6, uiOutput(ns("patient_1"))),
      column(6, uiOutput(ns("patient_2")))
    ),
    verbatimTextOutput(ns("demographics1")),
    verbatimTextOutput(ns("demographics2")),

    plotOutput(ns("ALT")),
    plotOutput(ns("CRP")),
    plotOutput(ns("IGA"))

  )


}

#' Title
#'
#' @param id
#' @param df2
#' @import tidyr
#'
#' @return
#' @export
#'
#' @examples
mod_patient_compare_server <- function(id, labvals, demographics){
   moduleServer(
     id,

     function(input, output, session){
       output$patient_1 <- renderUI({
         ns <- session$ns
         selectInput(ns("pat1"), label = "Select Patient 1", choices = demographics()$USUBJID)
       })
       output$patient_2 <- renderUI({
         ns <- session$ns
         selectInput(ns("pat2"), label = "Select Patient 2", choices = demographics()$USUBJID)
       })

       idx_dem_1 <- reactive({
         which(demographics()$USUBJID==input$pat1)
       })
       idx_dem_2 <- reactive({
         which(demographics()$USUBJID==input$pat2)
       })


       idx_lab_ALT_1 <- reactive({
         which(labvals()$USUBJID==input$pat1 & labvals()$LBTESTCD=="ALT")
       })
       idx_lab_ALT_2 <- reactive({
         which(labvals()$USUBJID==input$pat2 & labvals()$LBTESTCD=="ALT")
       })

       idx_lab_CRP_1 <- reactive({
         which(labvals()$USUBJID==input$pat1 & labvals()$LBTESTCD=="CRP")
       })
       idx_lab_CRP_2 <- reactive({
         which(labvals()$USUBJID==input$pat2 & labvals()$LBTESTCD=="CRP")
       })

       idx_lab_IGA_1 <- reactive({
         which(labvals()$USUBJID==input$pat1 & labvals()$LBTESTCD=="IGA")
       })
       idx_lab_IGA_2 <- reactive({
         which(labvals()$USUBJID==input$pat2 & labvals()$LBTESTCD=="IGA")
       })

       output$demographics1 <- renderText({paste0("Patient 1: ", input$pat1,
                                                  "; AGE: ", demographics()[idx_dem_1(),"AGE"],
                                                  "; SEX: ", demographics()[idx_dem_1(),"SEX"],
                                                  "; RACE: ", demographics()[idx_dem_1(),"RACE"],
                                                  "; ACTARM: ", demographics()[idx_dem_1(),"ACTARM"],
                                                  "; ACTARMCD: ", demographics()[idx_dem_1(),"ACTARMCD"],
                                                  ": BMRKR1: ", labvals()[idx_lab_ALT_1()[1],"BMRKR1"],
                                                  ": BMRKR2: ", labvals()[idx_lab_ALT_1()[1],"BMRKR2"])})
       output$demographics2 <- renderText({paste0("Patient 2: ", input$pat2,
                                                  "; AGE: ", demographics()[idx_dem_2(),"AGE"],
                                                  "; SEX: ", demographics()[idx_dem_2(),"SEX"],
                                                  "; RACE: ", demographics()[idx_dem_2(),"RACE"],
                                                  "; ACTARM: ", demographics()[idx_dem_2(),"ACTARM"],
                                                  "; ACTARMCD: ", demographics()[idx_dem_2(),"ACTARMCD"],
                                                  ": BMRKR1: ", labvals()[idx_lab_ALT_2()[1],"BMRKR1"],
                                                  ": BMRKR2: ", labvals()[idx_lab_ALT_2()[1],"BMRKR2"])})

       output$ALT <- renderPlot({
         tempdf <- data.frame(patient1 = labvals()[idx_lab_ALT_1(), "AVAL"], patient2 = labvals()[idx_lab_ALT_2(), "AVAL"], visit = labvals()[idx_lab_ALT_1(), "AVISIT"])
         tempdf <- gather(tempdf, patient, total, patient1:patient2)
         ggplot(tempdf, aes(x=visit, y=total, fill=patient)) + geom_bar(stat = "identity", position = "dodge") + ylab("ALT (U/L)") + xlab("Visit") + ggtitle("Alanine Aminotransferase Measurement")
       })
       output$CRP <- renderPlot({
         tempdf <- data.frame(patient1 = labvals()[idx_lab_CRP_1(), "AVAL"], patient2 = labvals()[idx_lab_CRP_2(), "AVAL"], visit = labvals()[idx_lab_CRP_1(), "AVISIT"])
         tempdf <- gather(tempdf, patient, total, patient1:patient2)
         ggplot(tempdf, aes(x=visit, y=total, fill=patient)) + geom_bar(stat = "identity", position = "dodge") + ylab("CRP (mg/L)") + xlab("Visit") + ggtitle("C-Reactive Protein Measurement")
       })
       output$IGA <- renderPlot({
         tempdf <- data.frame(patient1 = labvals()[idx_lab_IGA_1(), "AVAL"], patient2 = labvals()[idx_lab_IGA_2(), "AVAL"], visit = labvals()[idx_lab_IGA_1(), "AVISIT"])
         tempdf <- gather(tempdf, patient, total, patient1:patient2)
         ggplot(tempdf, aes(x=visit, y=total, fill=patient)) + geom_bar(stat = "identity", position = "dodge") + ylab("IGA (g/L)") + xlab("Visit") + ggtitle("Immunoglobulin A Measurement")
       })
     }


   )
}

library(shiny)

shinyUI(fluidPage(

  titlePanel("Probability of shared birthdays in a group"),
  hr(),
  includeMarkdown("description.Rmd"),
  hr(),
  sidebarLayout(
    sidebarPanel(
      sliderInput("number_in_group",
                  "People in group",
                  min = 0,
                  max = 100,
                  value = 28),
      sliderInput("birthday_matches",
                  "At least this many sharing a birthday",
                  min = 2,
                  max = 6,
                  value = 3)
    ),

    mainPanel(
      plotOutput("plot", height = "500px")
    )
  )
))

library(shiny)
library(ggplot2)
library(scales)

shinyServer(function(input, output) {
  output$plot <- renderPlot({
    raw_data <- readRDS("birthday_data.rds")
    data <- raw_data[raw_data$people_with_same_birthday == input$birthday_matches, ]

    probability_of_selection <- data[data$people_in_group == input$number_in_group,
                                     "probability"]

    print(
      ggplot(data,
             aes(x = people_in_group,
                 y = probability)) +
        geom_step() +
        geom_vline(xintercept = input$number_in_group, colour = "red") +
        geom_hline(
          yintercept = probability_of_selection,
          colour = "red") +
        ylab(paste("Probability of at least", input$birthday_matches, "with the same birthday")) +
        xlab("People in group") +
        scale_y_continuous(breaks = c(0, 1,
                                      # little hack to avoid over-writing the nice
                                      # 0% and 100% endpoints.
                                      if(round(probability_of_selection, 2) < 1 &
                                         round(probability_of_selection, 2) > 0) {
                                        probability_of_selection }),
                           labels = percent) +
        scale_x_continuous(breaks = c(0, 100,
                                      input$number_in_group)) +
        theme_bw(base_size = 20) +
        coord_cartesian(ylim = c(0, 1))
    )
  })
})

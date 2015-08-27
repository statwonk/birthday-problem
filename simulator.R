draw_birthdays <- function(people) round(runif(people, 1, 365))

number_of_matching_birthdays <- function(
  number_of_people = NULL,
  simulations = 100) {

  matches <- rep(NA, simulations)
  for(i in 1:simulations) {
    matches[i] <- number_of_people - (
      # number of unique birthdays - 1 (since matching birthdays
      # constitute a single subset)
      length(unique(draw_birthdays(number_of_people))) - 1)
  }

  return(matches)
}

d <- do.call(
  rbind,
  lapply(2:6, FUN = function(birthday_matches,
                             max_people = 100,
                             simulations = 2e4) {

    print(
      paste(birthday_matches, "out of", "5 matches simulated", simulations, "times"))

    data <- data.frame(
      people_in_group = rep(NA, max_people),
      people_with_same_birthday = birthday_matches,
      probability = rep(NA, max_people)
    )

    for(i in 1:max_people) {
      data$people_in_group[i] <- i

      data$probability[i] <- mean(
        number_of_matching_birthdays(
          number_of_people = i,
          simulations = simulations) >= birthday_matches
      )
    }

    return(data)
  })
)

saveRDS(d, "birthday_data.rds",
        # should make reading faster
        compress = FALSE)


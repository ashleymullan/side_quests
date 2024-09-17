
#running list of shows and episodes
shows <- list(b99 = list(title = "Brooklyn Nine-Nine", eps = c(22,23,23,22,22,18,13,10)),
              office = list(title = "The Office", eps = c(6,22,25,19,28,26,26,24,25)),
              modfam = list(title = "Modern Family", eps = c(22,24,24,24,24,24,22,22,22,22,18)),
              newgirl = list(title = "New Girl", eps = c(24,25,23,22,22,22,8)),
              middle = list(title = "The Middle", eps = c(24,24,24,24,24,24,24,23,24)),
              sheldon = list(title = "young Sheldon", eps = c(22,22,21,18,22,22,14)),
              tbbt = list(title = "The Big Bang Theory", eps = c(17,23,23,24,24,24,24,24,24,24,24,24)))



#function to list available shows and their string codes
list_shows <- function(){
  num_shows <- length(names(shows))
  titles <- rep(NA, times = num_shows)
  for(i in 1:num_shows){
    titles[i] <- shows[[i]][["title"]]
  }
  data.frame(shows = titles,
             code_string = names(shows))
}

#function to pick an episode
pick_episode <- function(show){
  show_code <- ifelse(missing(show), sample(names(shows), 1), show)
  show_title <- shows[[show_code]][["title"]]
  num_seasons <- length(shows[[show_code]])
  season <- sample(1:num_seasons, 1)
  num_eps <- shows[[show_code]][["eps"]][i]
  episode <- sample(1:num_eps,1)
  print(paste0("You are going to watch Season ",
               season, " Episode ", episode, " of ",
               show_title, "!"))
}


#run me to list available shows and their codes as a data frame
list_shows()

#run me to pick an episode. either pass in a show code or don't!
pick_episode()


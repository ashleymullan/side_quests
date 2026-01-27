
library(stringr) #for wrapping the prompts to fit
library(ggplot2) #for creating the bingo board
library(dplyr) #for data wrangling



#put your lists of prompts (at least 25, at most 50) in column A of a Google
#Sheet. name the sheet "bingo" and make cell A1 "bingo_prompts"

prompt_url <- paste0("https://docs.google.com/spreadsheets/d/1nj2IJ-",
                     "imAo89ih4wjVZ_VAZSXoPy9RDaJIZHba73Uuw/edit?",
                     "gid=482537420#gid=482537420")

prompts <- read_sheet(prompt_url,
                      range = "bingo!A1:A50") |>
  filter(!is.na(bingo_prompts)) |>
  pull(bingo_prompts)


rows <- c(rep(1, times = 5),
          rep(2, times = 5),
          rep(3, times = 5),
          rep(4, times = 5),
          rep(5, times = 5))

cols <- rep(c(1,2,3,4,5), times = 5)

bingo_header_height <- 6
prompt_font_size <- 3
bingo_font_size <- 8

bingo_board <- data.frame(rows, cols,
                          wrapped = sample(str_wrap(prompts, 12), 25)) |>
  mutate(wrapped = c(wrapped[1:12],
                     str_wrap("FREE SPACE", 8),
                     wrapped[14:25])) |>
  ggplot(aes(x = rows, y = cols)) +
  geom_tile(color = "black", fill = "white") +
  geom_text(aes(label = wrapped), size = prompt_font_size) +
  annotate("text", x = 1, y = bingo_header_height, label = "B",
           size = bingo_font_size, family = "bold") +
  annotate("text", x = 2, y = bingo_header_height, label = "I",
           size = bingo_font_size, family = "bold") +
  annotate("text", x = 3, y = bingo_header_height, label = "N",
           size = bingo_font_size, family = "bold") +
  annotate("text", x = 4, y = bingo_header_height, label = "G",
           size = bingo_font_size, family = "bold") +
  annotate("text", x = 5, y = bingo_header_height, label = "O",
           size = bingo_font_size, family = "bold") +
  theme_void() +
  theme(plot.margin = margin(5, 10, 10, 10))

bingo_board #ggsave this in an appropriate size in your local directory




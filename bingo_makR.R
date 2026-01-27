
library(stringr) #for wrapping the prompts to fit
library(ggplot2) #for creating the bingo board
library(dplyr) #for data wrangling
library(googlesheets4) #for data pulling
library(ggpubr) #for creating the bottom piece
library(png) #for reading in the bottom piece

# put your lists of prompts (at least 25, at most 50) in column A of a Google
# Sheet. name the sheet "bingo" and make cell A1 "bingo_prompts"
# the below is a sample sheet, feel free to duplicate
prompt_url <- paste0("https://docs.google.com/spreadsheets/d/1nj2IJ-",
                     "imAo89ih4wjVZ_VAZSXoPy9RDaJIZHba73Uuw/edit?",
                     "gid=482537420#gid=482537420")

# replace me with the image you want to go beneath your bingo board
# must be saved locally, not a URL
image_path <- "image_here.png"

prompts <- read_sheet(prompt_url,
                      range = "bingo!A1:A50") |>
  filter(!is.na(bingo_prompts)) |>
  pull(bingo_prompts)

img <- readPNG(image_path)

bottom_piece <- ggplot() +
  background_image(img) + 
  theme_void()

rows <- c(rep(1, times = 5),
          rep(2, times = 5),
          rep(3, times = 5),
          rep(4, times = 5),
          rep(5, times = 5))

cols <- rep(c(1,2,3,4,5), times = 5)

bingo_header_height <- 6 #change me to mess with "bingo" placement
prompt_font_size <- 3
bingo_font_size <- 8
num_distinct_boards <- 1 #change me to generate more boards
want_bottom_piece <- TRUE #change me if you want to ignore a bottom image
save_path <- "replace_me_with_directory_for_finished_boards" 

# run this loop to save a folder full of distinct bingo boards. 
# I then recommend https://www.ilovepdf.com/merge_pdf to make one file 
# so you can print in one shot
for(i in 1:num_distinct_boards){
  game_board <- data.frame(rows, cols,
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

  if(want_bottom_piece) {
    bingo <- game_board / bottom_piece + plot_layout(heights = c(4,1)) #change if image is wonky
  } else {
    bingo <- game_board
  }
  file_name <- paste0(save_path, "/bingo", i, ".pdf")
  ggsave(file_name, plot = bingo)
}






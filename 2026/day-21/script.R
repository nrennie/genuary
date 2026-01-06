library(tidyverse)

g <- aRt::divide(
  num_lines = 20,
  col_palette = c("#c20000", "#e5b200", "#221dbf", "#000000", "#ebebeb", "#ebebeb"),
  s = 1
)

g$layers[[1]]$aes_params$colour <- "#000000"
g$layers[[1]]$aes_params$linewidth <- 2

g

ggsave(
  filename = "2026/day-21/day-21.png",
  width = 5, height = 5, bg = "#ebebeb"
)

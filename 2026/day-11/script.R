library(tibble)
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(showtext)

font_add_google("Caveat")
showtext_auto()
showtext_opts(dpi = 300)

bg_col <- "#F3E9E2"
text_col <- "#2B1D12"

raw_data <- readLines("2026/day-11/script.R")

plot_data <- raw_data |>
  tibble(data = _) |>
  mutate(y = row_number()) |>
  mutate(chars = str_split(data, "")) |>
  unnest_longer(chars) |>
  group_by(y) |>
  mutate(char_num = row_number()) |>
  ungroup()

ggplot() +
  geom_text(
    data = plot_data,
    mapping = aes(x = char_num, y = y, label = chars),
    family = "Caveat",
    size = 4,
    hjust = 0
  ) +
  scale_y_reverse() +
  theme_void() +
  theme(
    plot.background = element_rect(fill = bg_col, colour = bg_col)
  )

ggsave(
  filename = "2026/day-11/day-11.png",
  width = 5, height = 5, bg = bg_col
)

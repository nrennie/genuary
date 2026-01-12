library(tidyverse)

centre <- c(0, 0)
start_r <- 1
sub_r <- 0.5
n <- 6
bg_col<- "#A3003F"
line_col <- "#FFC2D9"

init_data <- data.frame(
  x = centre[1],
  y = centre[1],
  r = start_r,
  loop = 1
) |>
  as_tibble()

for (j in 2:n) {
  input_data <- init_data |>
    filter(loop == j - 1)
  for (i in 1:nrow(input_data)) {
    init_data <- init_data |>
      add_row(
        x = input_data$x[i] + input_data$r[i],
        y = input_data$y[i] + input_data$r[i],
        r = sub_r * input_data$r[i],
        loop = j
      ) |>
      add_row(
        x = input_data$x[i] + input_data$r[i],
        y = input_data$y[i] - input_data$r[i],
        r = sub_r * input_data$r[i],
        loop = j
      ) |>
      add_row(
        x = input_data$x[i] - input_data$r[i],
        y = input_data$y[i] + input_data$r[i],
        r = sub_r * input_data$r[i],
        loop = j
      ) |>
      add_row(
        x = input_data$x[i] - input_data$r[i],
        y = input_data$y[i] - input_data$r[i],
        r = sub_r * input_data$r[i],
        loop = j
      )
  }
}

ggplot() +
  geom_rect(
    data = init_data,
    mapping = aes(
      xmin = x - r, xmax = x + r,
      ymin = y - r, ymax = y + r
    ),
    fill = "transparent",
    colour = line_col
  ) +
  coord_fixed(expand = FALSE) +
  theme_void() +
  theme(plot.background = element_rect(
    fill = bg_col, colour = bg_col
  ),
  plot.margin = margin(10, 10, 10, 10))

ggsave(
  filename = "2026/day-26/day-26.png",
  width = 5, height = 5, bg = bg_col
)


library(ggplot2)

set.seed(24)

bg_col <- "white"
line_col <- "black"

plot_data <- data.frame(
  x = c(0, 1, 1, 0, 0),
  y = c(0, 0, 1, 1, 0 - runif(1, 0.02, 0.05))
)

ggplot() +
  geom_path(
    data = plot_data,
    mapping = aes(x = x, y = y),
    colour = line_col
  ) +
  scale_x_continuous(limits = c(-0.5, 1.5)) +
  scale_y_continuous(limits = c(-0.5, 1.5)) +
  coord_fixed() +
  theme_void() +
  theme(plot.background = element_rect(
    fill = bg_col, colour = bg_col
  ))

ggsave(
  filename = "2026/day-24/day-24.png",
  width = 5, height = 5, bg = bg_col
)

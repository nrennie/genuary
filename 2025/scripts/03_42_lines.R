library(ggplot2)
s <- 2025
line_col <- "#3D3500"
bg_col <- "#FFFCE8"
set.seed(s)
lines_data <- function(n = 20, res = 250) {
  plot_data <- data.frame(
    x = c(
      runif(n, 0, 0.25),
      runif(n, 0.25, 0.5),
      runif(n, 0.5, 0.75),
      runif(n, 0.75, 1)
    ),
    y = runif(4 * n)
  )
  t <- seq_len(nrow(plot_data))
  smooth_x <- spline(t, plot_data$x, n = res)$y
  smooth_y <- spline(t, plot_data$y, n = res)$y
  smooth_path <- data.frame(x = smooth_x, y = smooth_y)
  return(smooth_path)
}
output <- purrr::map(
  .x = 1:42,
  .f = ~ lines_data()
) |>
  purrr::list_rbind(names_to = "id")
ggplot(
  data = output,
  mapping = aes(x = x, y = y)
) +
  geom_path(linewidth = 0.1) +
  facet_wrap(~id, ncol = 1, scales = "free") +
  theme_void() +
  coord_cartesian(expand = FALSE,clip = "off") +
  theme(
    plot.background = element_rect(fill = bg_col, colour = bg_col),
    strip.text = element_blank(),
    strip.background = element_blank(),
    plot.margin = margin(5, 5, 5, 5),
    panel.spacing = unit(0.1, "cm")
  )
ggsave("2025/art/03_42_lines.png", height = 4, width = 4)
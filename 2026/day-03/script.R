library(tidyverse)


# Data --------------------------------------------------------------------

n <- 20
fib <- c(0, 1, rep(NA, n - 1))
for (i in 3:(n + 1)) {
  fib[i] <- fib[i - 1] + fib[i - 2]
}
plot_data <- tibble(
  fib = fib
) |>
  mutate(x0 = 0, y0 = 0) |> 
  mutate(a = row_number())

positions <- rep(c("left", "bottom", "right", "top"), 10)
for (i in 3:nrow(plot_data)) {
  pos <- positions[i]
  if (pos == "right") {
    if (i == 3) {
      plot_data$x0[i] <- plot_data$x0[i - 1] +
        plot_data$fib[i - 1]
      plot_data$y0[i] <- plot_data$y0[i - 1]
    } else {
      plot_data$x0[i] <- plot_data$x0[i - 1] +
        0.5 * (plot_data$fib[i - 1] + plot_data$fib[i])
      plot_data$y0[i] <- 0.5 * (
        plot_data$y0[i - 1] - 0.5 * plot_data$fib[i - 1] +
          plot_data$y0[i - 2] + 0.5 * plot_data$fib[i - 2])
    }
  }
  if (pos == "top") {
    plot_data$x0[i] <- 0.5 * (
      plot_data$x0[i - 1] + 0.5 * plot_data$fib[i - 1] +
        plot_data$x0[i - 2] - 0.5 * plot_data$fib[i - 2])
    plot_data$y0[i] <- plot_data$y0[i - 1] +
      0.5 * (plot_data$fib[i - 1] + plot_data$fib[i])
  }
  if (pos == "left") {
    plot_data$x0[i] <- plot_data$x0[i - 1] -
      0.5 * (plot_data$fib[i - 1] + plot_data$fib[i])
    plot_data$y0[i] <- 0.5 * (
      plot_data$y0[i - 1] + 0.5 * plot_data$fib[i - 1] +
        plot_data$y0[i - 2] - 0.5 * plot_data$fib[i - 2])
  }
  if (pos == "bottom") {
    plot_data$x0[i] <- 0.5 * (
      plot_data$x0[i - 1] - 0.5 * plot_data$fib[i - 1] +
        plot_data$x0[i - 2] + 0.5 * plot_data$fib[i - 2])
    plot_data$y0[i] <- plot_data$y0[i - 1] -
      0.5 * (plot_data$fib[i - 1] + plot_data$fib[i])
  }
}


# Params ------------------------------------------------------------------

main_col <- "#721D54"
panel_col <- "white"


# Plot --------------------------------------------------------------------

ggplot() +
  geom_rect(
    data = plot_data,
    mapping = aes(
      xmin = x0 - fib / 2,
      xmax = x0 + fib / 2,
      ymin = y0 - fib / 2,
      ymax = y0 + fib / 2,
      alpha = fib,
      linewidth = fib
    ),
    fill = main_col,
    colour = main_col
  ) +
  scale_alpha(range = c(0.4, 0.9)) +
  scale_linewidth(range = c(0.1, 3)) +
  coord_fixed(expand = FALSE) +
  theme_void() +
  theme(
    legend.position = "none",
    panel.background = element_rect(fill = panel_col, colour = main_col),
    plot.background = element_rect(fill = main_col, colour = main_col),
    plot.margin = margin(5, 5, 5, 5)
  )


# Save --------------------------------------------------------------------

ggplot2::ggsave(
  filename = "2026/day-03/day-03.png",
  width = 5, height = 5 / 1.6, units = "in",
  bg = main_col
)

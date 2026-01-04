library(tidyverse)
library(magick)
library(ggimage)


# Data --------------------------------------------------------------------

n <- 20
# n <- 8
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
# main_col <- "#5D924F"
panel_col <- "white"


# Plot --------------------------------------------------------------------

g <- ggplot() +
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
    plot.background = element_rect(fill = main_col, colour = main_col)
  )

tmp1 <- tempfile()
tmp2 <- tempfile()
tmp3 <- tempfile()
tmp4 <- tempfile()
ggplot2::ggsave(
  filename = tmp1,
  plot = g,
  device = "png",
  width = 5, height = 5 / 1.6, units = "in",
  bg = main_col
)

img1 <- image_read(tmp1)
img2 <- image_rotate(img1, 90) |> image_write(tmp2)
img3 <- image_rotate(img1, 180) |> image_write(tmp3)
img4 <- image_rotate(img1, 270) |> image_write(tmp4)

ggplot() +
  geom_image(
    data = data.frame(
      x = c(-0.61, 0.61),
      y = c(-0.345, 0.345),
      image = c(tmp1, tmp3)
    ),
    aes(
      x = x,
      y = y,
      image = image
    ),
    size = 0.5
  ) +
  geom_image(
    data = data.frame(
      x = c(-0.38, 0.38),
      y = c(0.555, -0.555),
      image = c(tmp2, tmp4)
    ),
    aes(
      x = x,
      y = y,
      image = image
    ),
    by = "height",
    size = 0.5
  ) +
  scale_x_continuous(limits = c(-1.1, 1.1)) +
  scale_y_continuous(limits = c(-1, 1)) +
  theme_void() +
  theme(
    legend.position = "none",
    panel.background = element_rect(fill = main_col, colour = main_col),
    plot.background = element_rect(fill = main_col, colour = main_col),
    plot.margin = margin(5, 5, 5, 5)
  )


# Save --------------------------------------------------------------------

ggplot2::ggsave(
  filename = "2026/day-03/day-03.png",
  width = 5, height = 5, units = "in",
  bg = main_col
)

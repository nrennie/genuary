library(tidyverse)

# Functions
generate_x_values <- function(min_val, max_val, y) {
  n_x <- sample(min_val:max_val, 1)
  x_vals <- c(0, cumsum(runif(n_x, 0.2, 1)))
  x_vals <- x_vals / max(x_vals)
  plot_data <- data.frame(
    xmin = x_vals[1:n_x],
    xmax = x_vals[2:(n_x + 1)],
    ymin = rep(y, n_x),
    ymax = y + 1 + runif(n_x, 0.1, 0.3),
    col = sample(col_palette, n_x, replace = TRUE)
  )
}

split_thirds <- function(xmin, xmax) {
  output <- c(xmin + (xmax - xmin) / 3, xmin + 2 * (xmax - xmin) / 3)
  return(output)
}

# Parameters
n_x_min <- 4
n_x_max <- 8
n_y <- 5
col_palette <- c(
  "#a0462c", "#c38c39", "#d3d4cf",
  "#8a3e4c", "#3d3c41", "#a93830"
)
line_col <- "#2B1D12"
s <- 8

# Data
set.seed(s)
plot_data <- purrr::map(
  .x = 1:n_y,
  .f = ~ generate_x_values(n_x_min, n_x_max, .x)
) |>
  list_rbind() |>
  arrange(desc(ymin)) |> 
  mutate(row = ymin)

window_data <- data.frame(x = c(NA), y = c(NA), size = c(NA), row = c(NA)) |>
  as_tibble()
for (i in 1:nrow(plot_data)) {
  if (plot_data$xmax[i] - plot_data$xmin[i] > 0.09) {
    y1 <- mean(c(plot_data$ymin[i], plot_data$ymax[i])) + runif(1, 0.2, 0.35)
    y2 <- mean(c(plot_data$ymin[i], plot_data$ymax[i])) - runif(1, 0.2, 0.35)
    s <- runif(1, 4, 7)
    buffer <- runif(1, 0, 0.02)
    x <- split_thirds(plot_data$xmin[i], plot_data$xmax[i])
    x1 <- x[1] - buffer
    x2 <- x[2] + buffer
    window_data <- window_data |>
      add_row(x = c(x1, x2, x1, x2),
              y = c(y1, y1, y2, y2),
              size = s,
              row = plot_data$ymin[i]) 
  }
}
window_data <- window_data |> 
  drop_na()


# roofs
roof_data <- data.frame(x = c(NA), y = c(NA), grp = c(NA), row = c(NA)) |>
  as_tibble()
for (i in 1:nrow(plot_data)) {
  roof_width <- runif(1, 0.01, (plot_data$xmax[i] - plot_data$xmin[i])/2)
  roof_height <- runif(1, 0.1, 0.3)
  x <- c(plot_data$xmin[i], plot_data$xmax[i], 
         plot_data$xmax[i] - roof_width, plot_data$xmin[i] + roof_width,
         plot_data$xmin[i])
  y <- c(plot_data$ymax[i], plot_data$ymax[i], 
         plot_data$ymax[i] + roof_height, plot_data$ymax[i] + roof_height,
         plot_data$ymax[i])
  roof_data <- roof_data |>
    add_row(x = x, y = y, grp = i, row = plot_data$ymin[i]) 
}
roof_data <- roof_data |> 
  drop_na()

# Plot function
draw_row <- function(row_y) {
  output <- list(
    geom_rect(
      data = dplyr::filter(plot_data, row == row_y),
      aes(
        xmin = xmin, xmax = xmax,
        ymin = ymin, ymax = ymax,
        fill = col
      ),
      colour = line_col
    ),
    # windows
    geom_point(
      data = dplyr::filter(window_data, row == row_y),
      aes(x = x, y = y, size = size),
      colour = line_col,
      pch = 22,
      fill = '#FFF799'
    ),
    geom_point(
      data = dplyr::filter(window_data, row == row_y),
      aes(x = x, y = y, size = size / 1.8),
      colour = line_col,
      pch = 3
    ),
    # roofs
    geom_polygon(
      data = dplyr::filter(roof_data, row == row_y),
      aes(x = x, y = y, group = grp),
      fill = line_col,
      colour = line_col
    )
  )
  return(output)
}

# Plot
ggplot() +
  draw_row(row_y = 5) +
  draw_row(row_y = 4) +
  draw_row(row_y = 3) +
  draw_row(row_y = 2) +
  draw_row(row_y = 1) +
  scale_fill_identity() +
  scale_size_identity() +
  coord_cartesian(expand = FALSE, ylim = c(1, 6)) +
  theme_void() 

# Save
ggplot2::ggsave("2026/day-08/day-08.png",
  width = 5, height = 5, units = "in",
  bg = col_palette[3]
)

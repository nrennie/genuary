library(tidyverse)


# Parameters --------------------------------------------------------------

n_x_min <- 4
n_x_max <- 8
n_y <- 7
col_palette <- c(
  "#a0462c", "#c38c39", "#d3d4cf",
  "#8a3e4c", "#3d3c41", "#a93830"
)
line_col <- "#2B1D12"


# Functions ---------------------------------------------------------------

generate_x_values <- function(min_val, max_val, y) {
  n_x <- sample(min_val:max_val, 1)
  x_vals <- c(0, cumsum(runif(n_x, 0.2, 1)))
  x_vals <- x_vals / max(x_vals)
  house_data <- data.frame(
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

generate_street <- function(street_y) {
  house_data <- generate_x_values(n_x_min, n_x_max, street_y) |>
    mutate(row = ymin)

  window_data <- data.frame(x = NA, y = NA, size = NA, row = NA) |>
    as_tibble()
  for (i in 1:nrow(house_data)) {
    if (house_data$xmax[i] - house_data$xmin[i] > 0.09) {
      y1 <- mean(
        c(house_data$ymin[i], house_data$ymax[i])
      ) + runif(1, 0.2, 0.35)
      y2 <- mean(
        c(house_data$ymin[i], house_data$ymax[i])
      ) - runif(1, 0.2, 0.35)
      s <- runif(1, 4, 6)
      buffer <- runif(1, 0, 0.02)
      x <- split_thirds(house_data$xmin[i], house_data$xmax[i])
      x1 <- x[1] - buffer
      x2 <- x[2] + buffer
      window_data <- window_data |>
        add_row(
          x = c(x1, x2, x1, x2),
          y = c(y1, y1, y2, y2),
          size = s,
          row = house_data$ymin[i]
        )
    }
  }
  window_data <- window_data |>
    drop_na()

  # roofs
  roof_data <- data.frame(x = NA, y = NA, grp = NA, row = NA) |>
    as_tibble()
  for (i in 1:nrow(house_data)) {
    roof_width <- runif(
      1, 0.01,
      (house_data$xmax[i] - house_data$xmin[i]) / 2
    )
    roof_height <- runif(1, 0.1, 0.3)
    x <- c(
      house_data$xmin[i], house_data$xmax[i],
      house_data$xmax[i] - roof_width, house_data$xmin[i] + roof_width,
      house_data$xmin[i]
    )
    y <- c(
      house_data$ymax[i], house_data$ymax[i],
      house_data$ymax[i] + roof_height, house_data$ymax[i] + roof_height,
      house_data$ymax[i]
    )
    roof_data <- roof_data |>
      add_row(x = x, y = y, grp = i, row = house_data$ymin[i])
  }
  roof_data <- roof_data |>
    drop_na()
  output <- list(
    house_data = house_data,
    roof_data = roof_data,
    window_data = window_data
  )
  return(output)
}

# Plot function
draw_row <- function(list_data) {
  output <- list(
    # houses
    geom_rect(
      data = list_data$house_data,
      aes(
        xmin = xmin, xmax = xmax,
        ymin = ymin, ymax = ymax
      ),
      colour = line_col,
      fill = "grey20"
    ),
    geom_rect(
      data = list_data$house_data,
      aes(
        xmin = xmin, xmax = xmax,
        ymin = ymin, ymax = ymax,
        fill = col, alpha = (n_y + 1 - list_data$house_data$row[1])
      ),
      colour = line_col
    ),
    # windows
    geom_point(
      data = list_data$window_data,
      aes(x = x, y = y, size = size),
      colour = line_col,
      pch = 22,
      fill = "#FFF799"
    ),
    geom_point(
      data = list_data$window_data,
      aes(x = x, y = y, size = size / 1.8),
      colour = line_col,
      pch = 3
    ),
    # roofs
    geom_polygon(
      data = list_data$roof_data,
      aes(x = x, y = y, group = grp),
      fill = line_col,
      colour = line_col
    )
  )
  return(output)
}

# Plot --------------------------------------------------------------------

g <- ggplot() +
  scale_fill_identity() +
  scale_size_identity() +
  scale_alpha(range = c(0.2, 1)) +
  coord_cartesian(expand = FALSE, ylim = c(1, n_y + 1)) +
  theme_void() +
  theme(legend.position = "none")

set.seed(20260108)
for (i in n_y:1) {
  g <- g +
    draw_row(generate_street(i))
}

g


# Save --------------------------------------------------------------------

ggplot2::ggsave(
  filename = "2026/day-08/day-08.png",
  plot = g,
  width = 5, height = 5, units = "in",
  bg = col_palette[3]
)

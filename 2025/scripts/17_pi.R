
# Single quarter circle ----

quadrant <- function(main_col, bg_col) {
  # Data
  plot_data <- data.frame(
    theta = seq(
      from = 4 / 2,
      to = 4,
      length.out = 1000
    )
  ) |>
    dplyr::mutate(
      x = cos(theta),
      y = sin(theta)
    )
  # Plot
  p <- ggplot2::ggplot() +
    ggplot2::geom_area(
      data = plot_data,
      mapping = ggplot2::aes(x = x, y = y),
      fill = main_col
    ) +
    ggplot2::coord_cartesian(expand = FALSE) +
    ggplot2::theme_void() +
    ggplot2::theme(
      aspect.ratio = 1,
      plot.background = ggplot2::element_rect(
        fill = bg_col,
        colour = bg_col
      )
    )
  # Orientation
  o <- sample(1:4, 1)
  if (o == 2) {
    p <- p + ggplot2::scale_x_reverse()
  } else if (o == 3) {
    p <- p + ggplot2::scale_y_reverse()
  } else if (o == 4) {
    p <- p + ggplot2::scale_x_reverse() +
      ggplot2::scale_y_reverse()
  }
  return(p)
}

# Grid of quarter circles ----

quadrants <- function(
    n_x = 4,
    n_y = 4,
    col_palette = c("#A053A1", "#DB778F", "#E69F52", "#09A39A", "#5869C7"),
    bg_col = "#004B67",
    interpolate = TRUE,
    s = 1234) {
  # Data
  cols <- withr::with_seed(
    seed = s,
    code = {
      if (interpolate) {
        cols <- sample(
          grDevices::colorRampPalette(col_palette)(n_x * n_y)
        )
      } else {
        cols <- sample(
          col_palette,
          size = n_x * n_y, replace = TRUE
        )
      }
      cols
    }
  )
  # Map
  plot_list <- purrr::map(
    .x = cols,
    .f = ~ quadrant(.x, bg_col)
  )
  
  # Plot with patchwork
  p <- patchwork::wrap_plots(plot_list) +
    patchwork::plot_layout(nrow = n_y, ncol = n_x) &
    ggplot2::theme_void() +
    ggplot2::theme(
      plot.background = ggplot2::element_rect(
        fill = bg_col,
        colour = bg_col
      )
    )
  return(p)
}

# Examples ----

p <- quadrants(
  n_x = 8,
  n_y = 8,
  interpolate = TRUE,
  col_palette = PrettyCols::prettycols("Beach")[c(1,2,4,5)],
  bg_col = PrettyCols::prettycols("Beach")[c(3)]
)
ggplot2::ggsave("2025/art/17_pi.png", p, height = 4, width = 4)


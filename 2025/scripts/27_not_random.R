
# one tile
porto_tile <- function(data = NULL, col1, col2, bg_col, line_col, linewidth) {
  # get data
  plot_data <- data.frame(
    x = c(0, 0, 0.5, 0.5),
    y = c(0, 0.5, 0.5, 0.5)
  )
  plot_data <- do.call(rbind, lapply(seq_len(500) - 1, function(i) {
    plot_data$y <- plot_data$y - c(0, i / 500)
    plot_data$group <- i + 1
    plot_data
  }))
  
  g <- ggplot2::ggplot(data = data) +
    # Corner 1
    ggforce::geom_bezier(
      mapping = ggplot2::aes(
        x = x, y = y, group = group,
        colour = ggplot2::after_stat(index)
      ),
      data = plot_data
    ) +
    ggforce::geom_bezier(
      mapping = ggplot2::aes(
        x = y, y = x, group = group,
        colour = ggplot2::after_stat(index)
      ),
      data = plot_data
    ) +
    # Corner 2
    ggforce::geom_bezier(
      mapping = ggplot2::aes(
        x = x, y = -y - 0.5, group = group,
        colour = ggplot2::after_stat(index)
      ),
      data = plot_data
    ) +
    ggforce::geom_bezier(
      mapping = ggplot2::aes(
        x = y, y = -x - 0.5, group = group,
        colour = ggplot2::after_stat(index)
      ),
      data = plot_data
    ) +
    # Corner 3
    ggforce::geom_bezier(
      mapping = ggplot2::aes(
        x = -x - 0.5, y = y, group = group,
        colour = ggplot2::after_stat(index)
      ),
      data = plot_data
    ) +
    ggforce::geom_bezier(
      mapping = ggplot2::aes(
        x = -y - 0.5, y = x, group = group,
        colour = ggplot2::after_stat(index)
      ),
      data = plot_data
    ) +
    # Corner 4
    ggforce::geom_bezier(
      mapping = ggplot2::aes(
        x = -x - 0.5, y = -y - 0.5, group = group,
        colour = ggplot2::after_stat(index)
      ),
      data = plot_data
    ) +
    ggforce::geom_bezier(
      mapping = ggplot2::aes(
        x = -y - 0.5, y = -x - 0.5, group = group,
        colour = ggplot2::after_stat(index)
      ),
      data = plot_data
    ) +
    ggplot2::coord_fixed(expand = FALSE) +
    ggplot2::scale_color_gradient(low = col1, high = col2) +
    ggplot2::theme_void() +
    ggplot2::theme(
      legend.position = "none",
      strip.text = ggplot2::element_blank(),
      plot.background = ggplot2::element_rect(
        fill = bg_col,
        colour = bg_col,
        linewidth = linewidth
      ),
      panel.background = ggplot2::element_rect(
        fill = bg_col,
        colour = bg_col,
        linewidth = linewidth
      ),
      panel.border = ggplot2::element_rect(
        colour = line_col,
        fill = NA,
        linewidth = linewidth
      ),
      plot.margin = ggplot2::margin(0, 0, 0, 0)
    )
  if (!is.null(data)) {
    g <- g + ggplot2::facet_grid(b ~ a) +
      ggplot2::theme(panel.spacing = ggplot2::unit(0, "lines"))
  }
  return(g)
}

porto <- function(n_x = 5, n_y = 5, col1, col2, bg_col, line_col, linewidth) {
  grid_data <- expand.grid(a = factor(1:n_x), b = factor(1:n_y))
  p <- porto_tile(
    data = grid_data,
    col1 = col1,
    col2 = col2,
    bg_col = bg_col,
    line_col = line_col,
    linewidth = linewidth
  )
  return(p)
}

p <- porto(
  n_x = 3, n_y = 3,
  linewidth = 3,
  line_col = "#432263",
  bg_col = "#432263",
  col1 = "#9057c6",
  col2 = "#432263"
)

ggplot2::ggsave("2025/art/27_not_random.png", p, height = 4, width = 4)

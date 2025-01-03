# One tile
stream_tile <- function(
    extra_span = 0.01,
    n_grid = 1000,
    bw = 0.75,
    n_t = 30,
    col_palette = c("#413C58", "#D1495B", "#EDAE49", "#00798C", "#003D5B"),
    bg_col = "white",
    spacing_inner = 2,
    s = 1234) {
  # prep data
  set.seed(s)
  n_grp <- length(col_palette)
  plot_data <- expand.grid(
    x = seq(0, 1, length.out = n_t),
    grp = factor(1:n_grp)
  )
  plot_data$y <- stats::runif(n_t * n_grp)
  # plot
  g <- ggplot2::ggplot(
    data = plot_data,
    mapping = ggplot2::aes(
      x = x, y = y, fill = grp, colour = grp
    )
  ) +
    ggstream::geom_stream(
      extra_span = extra_span,
      type = "proportional",
      n_grid = n_grid,
      bw = bw,
      colour = NA
    ) +
    ggplot2::scale_fill_manual(values = col_palette) +
    ggplot2::scale_colour_manual(values = col_palette) +
    ggplot2::coord_fixed(expand = FALSE) +
    ggplot2::theme_void() +
    ggplot2::theme(
      legend.position = "none",
      plot.background = ggplot2::element_rect(
        colour = bg_col, fill = bg_col
      ),
      plot.margin = ggplot2::margin(
        spacing_inner, spacing_inner,
        spacing_inner, spacing_inner
      )
    )
  return(g)
}

# Tiled version
stream <- function(n_x = 3, n_y = 3,
                   extra_span = 0.01,
                   n_grid = 1000,
                   bw = 0.75,
                   n_t = 30,
                   col_palette = c("#413C58", "#D1495B", "#EDAE49", "#00798C", "#003D5B"),
                   bg_col = "white",
                   spacing_inner = 2,
                   spacing_outer = 2,
                   s = 1234) {
  s_vals <- s + 1:(n_x * n_y)
  g_list <- lapply(s_vals, function(x) {
    stream_tile(
      extra_span = extra_span,
      n_grid = n_grid,
      bw = bw,
      n_t = n_t,
      col_palette = col_palette,
      bg_col = bg_col,
      spacing_inner = spacing_inner,
      s = x
    )
  })
  p <- patchwork::wrap_plots(g_list) +
    patchwork::plot_layout(ncol = n_x, nrow = n_y) +
    patchwork::plot_annotation(
      theme =
        ggplot2::theme(
          plot.background = ggplot2::element_rect(
            colour = bg_col, fill = bg_col
          ),
          plot.margin = ggplot2::margin(
            spacing_outer, spacing_outer,
            spacing_outer, spacing_outer
          )
        )
    )
  
  return(p)
}

stream(
  n_x = 5,
  n_y = 5,
  s = 40,
  bg_col = "black",
  col_palette = PrettyCols::prettycols("Greys")
)
ggplot2::ggsave("2025/art/22_gradients.png", height = 4, width = 4)


aRt::distort(
  n_x = 10,
  n_y = 10,
  col_palette = PrettyCols::prettycols("Tangerines"),
  bg_col = PrettyCols::prettycols("Tangerines")[1],
  s = 2025
) +
  ggplot2::coord_fixed(expand = FALSE, clip = "off") +
  ggplot2::theme(
    plot.margin = ggplot2::unit(c(-0.5, -0.5, -0.5, -0.5), "cm")
  )

ggplot2::ggsave("2025/art/13_triangles.png", height = 4, width = 4)

aRt::crosshatch(
  n_x = 10,
  n_y = 10,
  n_lines = 20,
  line_overlap = 0.15,
  line_slope = 0.3,
  linewidth = 0.5,
  col_palette = PrettyCols::prettycols("Coast")[c(1,2,4,5)],
  bg_col = PrettyCols::prettycols("Coast")[3],
  interpolate = TRUE,
  s = 1234
) +
  ggplot2::coord_fixed(expand = FALSE) +
  ggplot2::theme(plot.margin = ggplot2::margin(0, 0, 0, 0))

ggplot2::ggsave("2025/art/01_lines.png", height = 4, width = 4)

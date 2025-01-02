p <- maprints::contours(
  location = "Edinburgh, UK",
  local_crs = 6384,
  dist = 4500,
  offset = 35,
  x_nudge = 0.1,
  y_nudge = 0.03,
  col_palette = PrettyCols::prettycols("TangerineBlues", dir = -1),
  bg_col = "#A4031F",
  line_col = "#FBB13C",
  linewidth = 0.3,
  res = 20
) +
  ggplot2::theme(
    plot.caption = ggplot2::element_blank()
  )
ggplot2::ggsave(
  filename = "2025/art/30_abstract_map.png",
  plot = p,
  height = 4, width = 4,
  bg = "#A4031F"
)

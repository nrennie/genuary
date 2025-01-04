c_pal <- usefunc::blend_palette(
  PrettyCols::prettycols("Winter"),
  "gray50"
)

aRt::mosaic(
  n = 20,
  line_size = 0.5,
  fill_cols = c_pal,
  line_col = "gray50",
  s = 2025
)

ggplot2::ggsave("2025/art/23_brutalism.png", height = 4, width = 4)

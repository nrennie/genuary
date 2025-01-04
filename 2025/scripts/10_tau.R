tau <- 2*pi

aRt::network(
  n_x = ceiling(2*tau),
  n_y = ceiling(2*tau),
  prop = 1/tau,
  col_palette = PrettyCols::prettycols("Celestial")[1:5],
  bg_col = "#004B67",
  bg_line_col = "#0096CC",
  line_col = "#0096CC",
  s = 2025
)

ggplot2::ggsave("2025/art/10_tau.png", height = 4, width = 4)



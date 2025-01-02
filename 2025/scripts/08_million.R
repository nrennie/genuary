p <- aRt::abacus(
  nx = 1000,
  ny = 1000,
  max_size = 0.2,
  main_col = "#D8D2E1",
  bg_col = "#34435E"
) +
  ggplot2::coord_cartesian(expand = FALSE)

ggplot2::ggsave("2025/art/08_million.png", p, height = 12, width = 12)

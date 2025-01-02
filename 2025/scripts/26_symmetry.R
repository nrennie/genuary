aRt::shatter(colour = "#00798C", bg_col = "#EDAE49") +
  ggplot2::scale_y_continuous() +
  ggplot2::coord_radial(
    theta = "x",
    start = pi / 4,
    end = 2 * pi + pi / 4,
    expand = FALSE,
    clip = "off"
  ) +
  ggplot2::theme(
    plot.margin = ggplot2::margin(-50, -50, -50, -50)
  )
ggplot2::ggsave("2025/art/26_symmetry.png", height = 4, width = 4)

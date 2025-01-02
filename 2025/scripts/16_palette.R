overlay <- ggplot2::ggplot() +
  ggplot2::theme_void() +
  ggplot2::theme(
    plot.background = ggplot2::element_rect(
      fill = ggplot2::alpha("#EDAE49", 0.5),
      colour = ggplot2::alpha("#EDAE49", 0.5)
    )
  )

aRt::gradients() +
  patchwork::inset_element(overlay, left = 0, bottom = 0, right = 1, top = 1) &
  ggplot2::theme(
    plot.margin = ggplot2::unit(c(0, 0, 0, 0), "cm")
  )

ggplot2::ggsave("2025/art/16_palette.png", height = 4, width = 4)

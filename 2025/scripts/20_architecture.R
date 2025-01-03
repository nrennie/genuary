library(patchwork)
library(ggplot2)

p1 <- aRt::stacked(
  col_palette = PrettyCols::prettycols("Coast"),
  s = 1
) +
  coord_cartesian(expand = FALSE)
p2 <- aRt::stacked(
  col_palette = PrettyCols::prettycols("Coast"),
  s = 2
) +
  coord_cartesian(expand = FALSE)
p3 <- aRt::stacked(
  n_x = 10,
  col_palette = PrettyCols::prettycols("Coast"),
  s = 3
) +
  coord_cartesian(expand = FALSE)

p <- (p1 + p2) / p3

png(
  filename = "2025/art/20_architecture.png",
  res = 300,
  width = 4,
  height = 4,
  unit = "in"
)

rayshader::plot_gg(p,
  fov = 0,
  theta = 0,
  phi = 90,
  scale = 150,
  shadow_intensity = 0.6,
  sunangle = 315,
  preview = TRUE
)

dev.off()

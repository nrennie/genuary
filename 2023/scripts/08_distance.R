library(ggplot2)
library(rayshader)
library(dplyr)

plot_data <- expand.grid(x = seq(-0.5, 0.5, by = 0.01),
                         y = seq(-0.5, 0.5, by = 0.01))
plot_data <- plot_data |>
  mutate(dists = 1 - sqrt(x^2 + y^2))

ggplot(plot_data,
       aes(x, y, fill = dists)) +
  geom_raster() +
  coord_fixed(expand = FALSE) +
  PrettyCols::scale_fill_pretty_c("PurpleTangerines", direction = -1) +
  theme_void() +
  theme(legend.position = "none")
ggplot2::ggsave(filename = "2023/art/08_distance.png",
                width = 600,
                height = 600,
                unit = "px")


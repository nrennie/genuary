library(patchwork)
library(ggplot2)

p1 <- aRt::polygons(n_x=24, n_y=12, gap_size=0.5, deg_jitter=0.5,
                    colours=rcartocolor::carto_pal(7, "Burg"),
                    rand = FALSE, bg_col="gray80")

p2 <- aRt::polygons(n_x=24, n_y=12, gap_size=0.5, deg_jitter=0.5,
                    colours=rcartocolor::carto_pal(7, "Burg"),
                    rand = FALSE, bg_col="gray75") +
  scale_y_reverse()

p1 + p2 + plot_layout(ncol = 1) &
  theme(plot.margin = margin(0,0,0,0))

ggplot2::ggsave(filename = "2023/art/16_reflection.png",
                width = 600,
                height = 600,
                unit = "px")

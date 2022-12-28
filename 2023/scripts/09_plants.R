library(ggplot2)
library(fractaltree)

leaf <- matrix(
    c(0, 0, 0, 1,
      0, 0.23, 0.12, 0.90,
      0, 0.85, -0.05, 0.94),
    byrow = TRUE, ncol = 4
  )

plot_data <- leaf %>%
  fractal_tree(depth = 7, growth_fraction = 0.7)

update_geom_defaults("path", list(linewidth = 0.1))
update_geom_defaults("line", list(linewidth = 0.1))
update_geom_defaults("segment", list(linewidth = 0.1))

plot_tree(plot_data, colors = c("#81A4CD", "#26408B")) +
  scale_x_continuous(limits = c(-1.4, 2.4)) +
  scale_y_continuous(limits = c(0, 3.8)) +
  coord_fixed(expand = FALSE) +
  theme(plot.background = element_rect(fill = "#DBE4EE", colour = "#DBE4EE"),
        panel.background = element_rect(fill = "#DBE4EE", colour = "#DBE4EE"))

ggplot2::ggsave(filename = "2023/art/09_plants.png",
                width = 600,
                height = 600,
                unit = "px")





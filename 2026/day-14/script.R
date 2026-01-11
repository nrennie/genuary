library(tidyverse)
library(ggnewscale)

g <- aRt::puzzles(
  n = 350,
  num_groups = 30,
  col_palette = PrettyCols::prettycols("Celestial")[1:5],
  bg_col = PrettyCols::prettycols("Celestial")[6],
  s = 14
)

set.seed(14)
g_build <- ggplot2::ggplot_build(g)
groups_to_plot <- sample(nrow(g_build$data[[1]]), 25)

new_data <- g_build$data[[1]] |>
  as_tibble() |>
  mutate(n = row_number()) |> 
  mutate(
    alpha = if_else(
      n %in% groups_to_plot,
      1,
      0.3
    )
  )

ggplot(
  data = new_data,
  mapping = aes(
    area = area,
    fill = fill,
    subgroup = subgroup,
    alpha = alpha
  )
) +
  treemapify::geom_treemap(colour = PrettyCols::prettycols("Celestial")[6]) +
  treemapify::geom_treemap_subgroup_border(
    colour = PrettyCols::prettycols("Celestial")[6], size = 4
  ) +
  scale_fill_identity() +
  scale_alpha_identity() +
  theme_void() +
  theme(
    plot.background = element_rect(
      fill = PrettyCols::prettycols("Celestial")[6],
      colour = PrettyCols::prettycols("Celestial")[6]
    ),
    plot.margin = margin(3, 3, 3, 3)
  )

ggsave(
  filename = "2026/day-14/day-14.png",
  width = 5, height = 5, bg = PrettyCols::prettycols("Celestial")[6]
)

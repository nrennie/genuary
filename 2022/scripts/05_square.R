# set params
n = 100
perc = 0.1
col_palette = "DarkMint"
bg_col = "black"
s = 1234

# prep data
set.seed(s)
x <- stats::rexp(n, 0.02)
y <- perc * x + (1 - perc) * stats::runif(n, 1, 60)
plot_data <- tibble::tibble(id = 1:n, areas = x, values = y)

# make plots
p_func <- function(input=plot_data){
  p <- ggplot2::ggplot(data=input, ggplot2::aes(area = .data$areas, fill = .data$values)) +
    treemapify::geom_treemap(alpha = 0.5, colour = NA) +
    rcartocolor::scale_fill_carto_c("", type = "diverging", palette = col_palette, direction = -1) +
    rcartocolor::scale_colour_carto_c("", type = "diverging", palette = col_palette, direction = -1) +
    ggplot2::theme(panel.background = ggplot2::element_rect(fill = bg_col, colour = bg_col),
                   plot.background = ggplot2::element_rect(fill = bg_col, colour = bg_col),
                   plot.title = ggplot2::element_blank(),
                   plot.subtitle = ggplot2::element_blank(),
                   legend.position = "none",
                   plot.margin = ggplot2::unit(c(0, 0, 0, 0), "cm"),
                   axis.title.x = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_blank(),
                   axis.text.x = ggplot2::element_blank(),
                   axis.text.y = ggplot2::element_blank(),
                   axis.ticks.x = ggplot2::element_blank(),
                   axis.ticks.y = ggplot2::element_blank(),
                   panel.grid.major = ggplot2::element_blank(),
                   panel.grid.minor = ggplot2::element_blank())
  p
}

setwd("G:/My Drive/GitHub/genuary/2022/art/05_anim")
for (i in 0:99){
  k <- p_func(input=dplyr::filter(plot_data, id < (100-i)))
  ggplot2::ggsave(k, filename = paste(i, ".jpg", sep=""),  bg = "transparent", height=500, width=500, unit="px")
}


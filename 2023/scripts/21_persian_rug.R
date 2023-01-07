library(ggplot2)
library(rcartocolor)
library(patchwork)

# generate polygon
gen_polygon <- function(x, y, height, width, group){
  data.frame(x = c(x, x+width, x+width, x),
             y = c(y, y, y+height, y+height),
             group = rep(group, 4),
             col = as.character(rep(sample(1:4, size = 1), 4)))
}

# generate multiple polygons
carpet_tile <- function(s){
  set.seed(s)
  n <- 5
  plot_data <- data.frame(x = c(),
                          y = c(),
                          group = c(),
                          col = c())
  for (i in 1:n){
    k <- gen_polygon(x = runif(1, 0, 5),
                     y = runif(1, 0, 5),
                     height = runif(1, 2, 6),
                     width = runif(1, 2, 6),
                     group = i)
    plot_data <- rbind(plot_data, k)
  }

  y1 <- runif(1, 0, 5)
  x1 <- runif(1, 0, 5)
  x2 <- x1 + 0.5

  # plot
  p <- ggplot() +
    geom_polygon(data=plot_data,
                 mapping=aes(x = x, y = y, group = group, fill = col), colour = NA, alpha=0.7) +
    geom_segment(aes(x = min(plot_data$x), y = y1, xend = max(plot_data$x), yend = y1),
                 colour = "#dfd6c6", size = 0.6) +
    geom_segment(aes(y = min(plot_data$y), x = x1, yend = max(plot_data$y), xend = x1),
                 colour = "#aa4499", size = 0.6) +
    geom_segment(aes(y = min(plot_data$y), x = x2, yend = max(plot_data$y), xend = x2),
                 colour = "#882255", size = 1) +
    scale_fill_manual(values=c("#cc6677", "#dfd6c6", "#aa4499", "#882255")) +
    coord_fixed(expand = F) +
    xlim((min(c(plot_data$x, plot_data$y, x1, x2))), (max(c(plot_data$x, plot_data$y, x1, x2)))) +
    ylim((min(c(plot_data$x, plot_data$y, y1))), (max(c(plot_data$x, plot_data$y, y1)))) +
    theme_void() +
    theme(legend.position = "none",
          panel.background = element_rect(fill = "#684b61", colour = "#684b61"),
          plot.background = element_rect(fill = "#684b61", colour = "#684b61"))
  p
}

set.seed(2023)
ss <- sample(1:200, size=64, replace=F)
p <- lapply(ss, function(i) carpet_tile(i))

wrap_plots(p) +
  plot_layout(ncol=8, nrow=8) &
  theme(plot.margin = unit(c(0,0,0,0), "cm"))

ggplot2::ggsave(filename = "2023/art/21_persian_rug.png",
                width = 600,
                height = 600,
                unit = "px")

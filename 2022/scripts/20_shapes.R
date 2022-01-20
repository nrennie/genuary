library(ggplot2)
library(rcartocolor)

# generate polygon
gen_polygon <- function(x, y, height, width, group){
  data.frame(x = c(x, x+width, x+width, x),
             y = c(y, y, y+height, y+height),
             group = rep(group, 4),
             col = as.character(rep(sample(1:13, size = 1, prob = c(rep(0.01, 12), 0.78)), 4)))
}

# generate multiple polygons
n <- 100
set.seed(123)
plot_data <- data.frame(x = c(),
                        y = c(),
                        group = c(),
                        col = c())
for (i in 1:n){
  k <- gen_polygon(x = runif(1, 0, 30),
                   y = runif(1, 0, 30),
                   height = runif(1, 2, 7),
                   width = runif(1, 2, 5),
                   group = i)
  plot_data <- rbind(plot_data, k)
}

# set colours
pal <- c(carto_pal(12, "Bold"), "lightgrey")
names(pal) <- 1:13

# plot
p <- ggplot(plot_data, aes(x = x, y = y)) +
  geom_polygon(aes(group = group, colour = col), fill = "transparent", size = 2) +
  scale_colour_manual(values = pal) +
  coord_fixed() +
  theme_void() +
  theme(legend.position = "none")
p


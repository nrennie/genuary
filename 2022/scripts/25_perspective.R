library(ggplot2)
library(rcartocolor)

# generate squares
gen_polygon <- function(x, y, height, width, group){
  data.frame(x = c(x, x+width, x+width, x),
             y = c(y, y, y+height, y+height),
             group = rep(group, 4))
}

# generate squares
heights <- seq(5, 0, -0.25)
widths <- heights
x <- -sqrt(heights/2)
y <- -sqrt(heights/2)
plot_data <- data.frame(x = c(),
                        y = c(),
                        group = c(),
                        col = c())
n <- length(heights)
for (i in 1:n){
  k <- gen_polygon(x = x[i],
                   y = y[i],
                   height = heights[i],
                   width = widths[i],
                   group = i)
  plot_data <- rbind(plot_data, k)
}

# plot
p <- ggplot(plot_data, aes(x = x, y = y)) +
  geom_polygon(aes(group = group, fill = group), colour = NA) +
  coord_fixed(expand = F) +
  scale_fill_carto_c(palette = "Mint") +
  theme_void() +
  theme(legend.position = "none")
p

library(ggplot2)
library(cartography)

# generate data
n <- 100000
x <- runif(n, 0, 0.01)
y <- runif(n, 0, 0.01)
col <- y + runif(n, 0, 0.001)
plot_data <- data.frame(x = x, y = y, col=col)

# plot
p <- ggplot() +
  geom_point(data = plot_data, mapping = aes(x = x, y = y, colour=col), size = 0.2) +
  scale_colour_gradient(low="#382301", high="#E1B567") +
  xlim(0, 0.01) +
  ylim(0, 0.01) +
  coord_fixed(expand = F) +
  theme_void() +
  theme(plot.background = element_rect(fill = "#c2b280", colour = "#c2b280"),
        panel.background = element_rect(fill = "#c2b280", colour = "#c2b280"),
        legend.position = "none")
p


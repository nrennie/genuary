library(ggplot2)
library(tibble)

greens <- c('#a1d99b','#74c476','#41ab5d','#238b45','#006d2c','#00441b')

# generate data
set.seed(123)
n <- 75
x <- 1:n
y <- 1:n
plot_data <- tibble(expand.grid(x = x, y = y))
plot_data$xend <- x + runif(n^2, 0.7, 0.9)
plot_data$ynew <- plot_data$y + runif(n^2, -0.2, 0.2)
plot_data$yend <- plot_data$y + runif(n^2, -0.2, 0.2)
plot_data$col <- sample(greens, size=n^2, replace = T)

# transform angles
for(i in 1:nrow(plot_data)){
  if ((plot_data$x[i] <= 0.2 & plot_data$y[i] <= 0.2) | (plot_data$x[i] >= 0.8 & plot_data$y[i] >= 0.8)) {
    plot_data$xend[i] <- plot_data$xend[i] + runif(1, -0.5, 0.5)
    plot_data$yend[i] <- plot_data$yend[i] + runif(1, -0.5, 0.5)
    plot_data$x[i] <- plot_data$x[i] + runif(1, -0.5, 0.5)
    plot_data$ynew[i] <- plot_data$ynew[i] + runif(1, -0.5, 0.5)
  }
}

# plot
ggplot(plot_data, mapping = aes(x = x, y = ynew)) +
  geom_segment(aes(xend = xend, yend = yend, colour = I(col))) +
  coord_fixed() +
  theme_void() +
  theme(legend.position = "none",
        panel.background = element_rect(fill = "#003D18", colour = "#003D18"),
        plot.background = element_rect(fill = "#003D18", colour = "#003D18"))



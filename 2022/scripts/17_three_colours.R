library(ggplot2)

# generate data
set.seed(1234)
n <- 1000
x <- runif(n, 0, 1)
y <- runif(n, 0, 1)
col <- as.character(sample(1:3, size = n, replace = T))
size <- sample(1:20, size = n, replace = T)
plot_data <- data.frame(x = x,
                        y = y,
                        col = col,
                        size = size)

# plot
ggplot() +
  geom_point(data = plot_data,
             mapping = aes(x=x, y=y, colour = col, size = I(size), alpha = I((1 - size/20))), pch = 19) +
  scale_colour_manual(values = c("#83D1C4", "#78517C", "#F17950")) +
  xlim(0, 1) +
  ylim(0, 1) +
  coord_fixed(expand = F) +
  theme_void() +
  theme(legend.position = "none")


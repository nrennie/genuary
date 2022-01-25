library(tibble)
library(RColorBrewer)
library(ggplot2)

create_hair <- function(n, group){
  y <- seq(0.1, 5, by = 0.001)
  x <- runif(1, 0.05, 0.25)*sin(runif(1, 6, 9)*y) + n
  col <- sample(RColorBrewer::brewer.pal(9, "Oranges"), size=1)
  group <- rep(group, length(y))
  tibble(x = x, y = y, col = col, group = group)
}

set.seed(1234)
xs <- seq(0, 4, by=0.05)
plot_data <- tibble(x = c(),
                    y = c(),
                    col = c(),
                    group = c())
for (i in 1:length(xs)){
  k <- create_hair(n = xs[i], group=i)
  plot_data <- rbind(plot_data, k)
}

ggplot() +
  geom_path(data=plot_data, mapping=aes(x = x, y = y, colour = I(col), group=group)) +
  coord_fixed() +
  theme_void() +
  theme(legend.position = "none")


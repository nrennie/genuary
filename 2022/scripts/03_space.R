library(ggvoronoi)
library(ggplot2)
set.seed(1234)
x <- sample(1:200,100)
y <- sample(1:200,100)
points <- data.frame(x, y,
                     distance = sqrt((x-100)^2 + (y-100)^2))
circle <- data.frame(x = 100*(1+cos(seq(0, 2*pi, length.out = 2500))),
                     y = 100*(1+sin(seq(0, 2*pi, length.out = 2500))),
                     group = rep(1,2500))

ggplot(data=points, aes(x=x, y=y, color=distance)) +
  geom_voronoi(outline = circle) +
  coord_fixed(expand = T) +
  scale_colour_gradient(low="gray20",high="white",guide=F) +
  theme_void() +
  theme(plot.margin = unit(c(0, 0, -0.1, -0.1), "cm"),
        legend.position = "none",
        plot.background = element_rect(colour="black", fill="black"),
        panel.background = element_rect(colour="black", fill="black"))

library(ggplot2)
library(rcartocolor)
library(patchwork)

set.seed(712022)

#background
d1 <- data.frame(x=1:36, y=rep(100,36), colour=sample(carto_pal(12, "Bold"), size=36, replace = T))
p1 <- ggplot() +
  geom_col(data=d1, mapping=aes(x=x, y=y, fill=I(colour)), colour=NA, width = 1) +
  coord_cartesian(expand = F) +
  theme_void()
p1

#foreground
x1 <- seq(1,36, by=0.1)
y1 <- -0.25*x1+1+4*sin(0.1*pi*x1)
d2 <- data.frame(x=rep(x1, 8),
                 y=rep(y1, 8) + rep(0:7, each=length(x1)),
                 colour=rep(sample(carto_pal(12, "Bold"), size=8, replace = F), each=length(x1)))
p2 <- ggplot() +
  geom_point(data=d2, mapping=aes(x=x, y=y, colour=I(colour), group=colour), size=8) +
  coord_cartesian(expand = F) +
  theme_void() +
  theme(panel.background = element_rect(fill="transparent", colour="transparent"),
        plot.background = element_rect(fill="transparent", colour="transparent"))
p2

#join
p <- p1 +
  inset_element(p2, left = 0, bottom = 0, right = 1, top = 1) &
  theme(plot.margin = unit(c(0,0,0,0), "cm"))
p






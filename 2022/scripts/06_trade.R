library(ggplot2)

#boxes
positions <- data.frame(
  id = rep(1:5, each = 4),
  x = c(0, 2, 2, 0,
        2.5, 3.5, 3.5, 2.5,
        4, 7, 7, 4,
        4, 7, 7, 4,
        7.5, 9, 9, 7.5),
  y = c(0, 0, 9, 9,
        0, 0, 9, 9,
        0, 0, 4.25, 4.25,
        4.75, 4.75, 9, 9,
        0, 0, 9, 9)
)

#points
x1 <- runif(10*2*9, 0, 2)
y1 <- runif(10*2*9, 0, 9)
x2 <- runif(10*1*9, 2.5, 3.5)
y2 <- runif(10*1*9, 0, 9)
x3 <- runif(10*3*4.25, 4, 7)
y3 <- runif(10*3*4.25, 0, 4.25)
x4 <- runif(10*3*4.25, 4, 7)
y4 <- runif(10*3*4.25, 4.75, 9)
x5 <- runif(10*1.5*9, 7.5, 9)
y5 <- runif(10*1.5*9, 0, 9)
d <- data.frame(x=c(x1, x2, x3, x4, x5), y=c(y1, y2, y3, y4, y5))
d$size = sample(seq(0.5, 4.5, by=0.5), size=nrow(d), replace=T)

#plot
p <- ggplot() +
  geom_polygon(data=positions, mapping=aes(x = x, y = y, group = id),
               fill="black", colour="white", size=0.5) +
  geom_point(data=d, mapping=aes(x=x, y=y, size=I(size)), pch=21, colour="white", fill="black") +
  xlim(-0.5,9.5) +
  ylim(-0.5,9.5) +
  coord_fixed(expand = F) +
  theme_void() +
  theme(panel.background = element_rect(fill="black", colour="black"),
        plot.background = element_rect(fill="black", colour="black"))
p

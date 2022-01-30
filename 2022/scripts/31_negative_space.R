library(ggplot2)
library(ggforce)

circles_1 <- data.frame(
  x0 = rep(1:10, 10),
  y0 = rep(1:10, each = 10),
  alpha = rep(seq(0.05, 0.95, by = 0.1), each = 10),
  r = rep(0.4, 10)
)

circles_2 <- data.frame(
  x0 = rep(1:10, 10),
  y0 = rep(1:10, each = 10),
  r = rep(0.2, 10)
)

ggplot() +
  geom_circle(data = circles_1, mapping = aes(x0 = x0, y0 = y0, r = r, alpha = alpha), fill = "white") +
  geom_circle(data = circles_2, mapping = aes(x0 = x0, y0 = y0, r = r), fill = "black") +
  coord_fixed() +
  theme_void() +
  theme(legend.position = "none",
        panel.background = element_rect(fill = "black", colour = "black"),
        plot.background = element_rect(fill = "black", colour = "black"))

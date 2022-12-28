library(ggplot2)
polygon1 <- sf::st_polygon(list(cbind(c(0, 1, 1, 0, 0), c(0, 0, 1, 1, 0))))
polygon2 <- sf::st_polygon(list(cbind(c(0.15, 0.85, 0.85, 0.15, 0.15), c(0.15, 0.15, 0.85, 0.85, 0.15))))
dots1 <- data.frame(x = runif(100, 0.16, 0.84), y = runif(100, 0.16, 0.84))
dots2 <- data.frame(x = runif(100, 0.16, 0.84), y = runif(100, 0.16, 0.84))
ggplot() +
  geom_sf(data = polygon1, fill = "#d5d7d4", colour = "#d5d7d4") +
  geom_sf(data = polygon2, fill = "#292a3f", colour = "#292a3f") +
  geom_point(data = dots1, mapping = aes(x = x, y = y), colour = "#696978", size = 0.1) +
  geom_point(data = dots2, mapping = aes(x = x, y = y), colour = "#535465", size = 0.1) +
  coord_sf(expand = FALSE) +
  theme_void()
ggplot2::ggsave(filename = "2023/art/11_suprematism.png",
                width = 600,
                height = 600,
                unit = "px")

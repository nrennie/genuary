library(sf)

b0 = st_polygon(list(rbind(c(-1,-1), c(1,-1), c(1,1), c(-1,1), c(-1,-1))))
b1 = b0 + 2
b2 = b0 + c(-0.2, 2)

a0 = b0 * 0.8
a1 = a0 * 0.4 + c(1.6, 0.6)
a2 = a0 + 0.7
a3 = b0 * 0.5 + c(2.4, -0.4)
a4 = a1 + c(0.6, 1.2)

#join
x = st_sfc(b0, b1, b2)
y = st_sfc(a0,a1,a2,a3)
z = st_intersection(st_union(x),st_union(y))

ggplot() +
  geom_sf(data = x, fill = "transparent") +
  geom_sf(data = y, fill = "transparent") +
  geom_sf(data = z, fill = "#DA4167") +
  geom_sf(data = a3, fill = "#7796CB") +
  geom_sf(data = a4, fill = "#7796CB") +
  coord_sf(expand = FALSE) +
  theme_void() +
  theme(plot.background = element_rect(fill = "grey90", colour = "grey90"),
        panel.background = element_rect(fill = "grey90", colour = "grey90"),
        legend.position = "none",
        plot.margin = margin(10,10,10,10))

ggplot2::ggsave(filename = "2023/art/13_learn.png",
                width = 600,
                height = 600,
                unit = "px")

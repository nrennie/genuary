library(sf)
library(roughsf)

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

x <- st_cast(x, "POLYGON")
x <- st_sf(x)
x$fill <- "#fafafa"
x$stroke <- 2

y <- st_cast(y, "POLYGON")
y <- st_sf(y)
y$fill <- "#fafafa"
y$stroke <- 2
y$fillstyle <- "cross-hatch"

z <- st_cast(z, "POLYGON")
z <- st_sf(z)
z$fill <- "#DA4167"
z$stroke <- 2
z$fillweight <- 2
z$fillstyle <- "zigzag-line"

a3 <- st_sfc(a3)
a3 <- st_cast(a3, "POLYGON")
a3 <- st_sf(a3)
a3$fill <- "#7796CB"
a3$stroke <- 2
a3$fillweight <- 2

a4 <- st_sfc(a4)
a4 <- st_cast(a4, "POLYGON")
a4 <- st_sf(a4)
a4$fill <- "#7796CB"
a4$stroke <- 2
a4$fillweight <- 2


r <- roughsf::roughsf(list(x, y, z, a3, a4),
                 roughness = 6,
                 bowing = 1,
                 simplification = 1,
                 width = 600,
                 height = 600
)

roughsf::save_roughsf(r, file = "2023/art/26_kid.png")

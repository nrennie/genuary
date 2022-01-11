library(packcircles)
library(ggplot2)
library(dplyr)
library(rcartocolor)
library(magick)

# make data
d <- data.frame(n=round(abs(rnorm(500, 0, 50))))
d <- filter(d, n != 0)
packing <- circleProgressiveLayout(d$n, sizetype='area')
data <- cbind(d, packing)
plot_data <- circleLayoutVertices(packing, npoints=50)
plot_data$n <- rep(d$n, each=51)
plot_data$col <- factor(sample(1:12, size=nrow(plot_data), replace=T))

# plot
p <- ggplot() +
  geom_polygon(data = plot_data, aes(x, y, group = id, fill=col), colour = NA, alpha = 1) +
  scale_fill_carto_d(palette = "Bold") +
  coord_fixed() +
  theme_void() +
  theme(legend.position = "none",
        panel.background = element_rect(fill = "#3fe7b2", colour="#3fe7b2"),
        plot.background = element_rect(fill = "#3fe7b2", colour="#3fe7b2"))
p
ggsave(p, filename="2022/art/raw.png", height=1800, width = 1800, unit="px")

# crop image
img <- image_read(path = "2022/art/raw.png")
k <- image_crop(img, "1100x1100+350+350")
image_write(k, "2022/art/12_packing.png", format = "png")





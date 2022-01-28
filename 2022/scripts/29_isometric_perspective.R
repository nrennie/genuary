library(dplyr)
library(threed)
library(rcartocolor)
library(patchwork)



plot_cube <- function(eye = c(1.5, 1.75, 4), at = c(0, 0, 0), n = 500, s = 123){
  set.seed(s)
  point_data <- data.frame(x = runif(n, -0.6, 0.6), y = runif(n, -0.6, 0.6), col = runif(n, 0, 1))
  obj <- threed::mesh3dobj$cube
  camera_to_world <- threed::look_at_matrix(eye = eye, at = at)
  obj <- obj %>%
    transform_by(invert_matrix(camera_to_world)) %>%
    perspective_projection()
  obj <- as.data.frame(obj)
  ggplot() +
    geom_point(data = point_data, mapping = aes(x, y, colour = col), pch = 19, size = 0.2) +
    geom_polygon(data = obj, mapping = aes(x, y, group = zorder, fill = fny + fnz), colour = NA, size = 0.2) +
    scale_fill_carto_c(palette = "SunsetDark") +
    scale_colour_carto_c(palette = "SunsetDark") +
    theme_void() +
    xlim(-0.6, 0.6) +
    ylim(-0.6, 0.6) +
    theme(legend.position = 'none',
          panel.background = element_rect(fill = "black", colour = "black"),
          plot.background = element_rect(fill = "black", colour = "black")) +
    coord_fixed(expand = F)
}
plot_cube()


setwd("G:/My Drive/GitHub/genuary/2022/art/29_anim")
z <- seq(3, 18, by = 0.33)
for (i in 1:length(z)){
  k <- plot_cube(eye = c(1.5, 1.75, z[i]), at = c(0, 0, 0), s = i*100)
  ggsave(k, filename = paste(i, ".jpg", sep=""),  bg = "transparent", height=500, width=500, unit="px")
}


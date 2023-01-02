library(ggplot2)

x_vec <- seq(0,5)
y_vec <- seq(0,5)
params_vec <- expand.grid(x_vec, y_vec)

x_vec2 <- seq(0.5, 4.5, 1)
y_vec2 <- seq(0.5, 4.5, 1)
params_vec2 <- expand.grid(x_vec2, y_vec2)

params <- rbind(params_vec, params_vec2)

plot_data <- data.frame(x = c(), y = c(), group = c())
plot_lines <- data.frame(x = c(), y = c(), group = c())

for (i in 1:nrow(params)) {
  x <- params[i,1]
  y <- params[i,2]
  plot_data <- rbind(plot_data,
                     data.frame(x = c(x, x+0.5, x, x-0.5, x),
                          y = c(y, y+0.5, y+1, y+0.5, y),
                          group = i))
  a <- seq(x-0.5, x+0.5, 0.125)
  b <- rep(x, 9)
  x_v <- c(rbind(a, b))
  c <- c(seq(y+0.5, y+1, by = 0.125), seq(y+0.875, y+0.5, by = -0.125))
  d <- rep(y, 9)
  y_v <- c(rbind(c, d))
  group <- rep(paste0(1:9,"_",i), each = 2)
  plot_lines <- rbind(plot_lines,
                      data.frame(x = x_v,
                                 y = y_v,
                                 group = group))
}

ggplot() +
  geom_path(data = plot_lines,
            aes(x = x, y = y, group = group),
            colour = "gold",
            linewidth = 0.1) +
  geom_polygon(data = plot_data,
               aes(x = x, y = y, group = group),
               colour = "gold",
               fill = "transparent",
               linewidth = 0.15) +
  coord_fixed(expand = FALSE) +
  theme_void() +
  theme(plot.background = element_rect(fill = "grey10", colour = "grey10"),
        panel.background = element_rect(fill = "grey10", colour = "grey10"),
        legend.position = "none",
        plot.margin = margin(10,10,10,10))

ggplot2::ggsave(filename = "2023/art/20_art_deco.png",
                width = 600,
                height = 600,
                unit = "px")

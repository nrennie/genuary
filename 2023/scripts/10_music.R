library(ggplot2)

n_x <- 1000
n_facets <- 10
x <- rep(1:n_x, times = n_facets)
y <- rnorm(n_facets*n_x)
group <- rep(1:n_facets, each = n_x)
bg_col <- "grey50"

ggplot(data = data.frame(x = x, y = y, group = group)) +
  geom_line(mapping = aes(x = x, y = y, colour = group)) +
  scale_color_gradient(low = "grey10", high = "grey90") +
  scale_y_continuous(limits = c(-5, 5)) +
  theme_void() +
  theme(plot.background = element_rect(fill = bg_col, colour = bg_col),
        panel.background = element_rect(fill = bg_col, colour = bg_col),
        legend.position = "none",
        strip.text = element_blank(),
        panel.spacing = unit(0.1, "lines"))

ggplot2::ggsave(filename = "2023/art/10_music.png",
                width = 600,
                height = 600,
                unit = "px")

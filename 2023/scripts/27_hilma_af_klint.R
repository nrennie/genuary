library(ggplot2)
library(ggforce)
library(dplyr)
library(tibble)

# Series VIII. Picture of the Starting Point (1920)

plot_data <- tibble(
  x0 = rev(rep(0, 13)),
  y0 = rev(rep(0, 13)),
  r = rev(c(1:7, 7.2, 8:12)),
  r_col = LETTERS[1:13]
)

ggplot() +
  geom_circle(
    data = plot_data[1:6,],
    mapping = aes(x0 = x0,
                  y0 = y0,
                  r = r,
                  fill = r_col),
    colour = "#9b9589",
    linewidth = 0.01
  ) +
  geom_circle(
    data = plot_data[7:13,],
    mapping = aes(x0 = x0,
                  y0 = y0,
                  r = r,
                  fill = r_col),
    colour = "#9b9589",
    linewidth = 0.01
  ) +
  geom_segment(data = data.frame(x = 0, y = 0, xend = 0, yend = -7.2),
               aes(x = x, y = y, xend = xend, yend = yend),
               colour = "#b4a39d",
               linewidth = 0.5) +
  geom_segment(data = data.frame(x = 0, y = -7.2, xend = 0, yend = -12),
               aes(x = x, y = y, xend = xend, yend = yend),
               colour = "#ac8957",
               linewidth = 0.5) +
  scale_fill_manual(
    values = c("#ddcdb3", "#c2beaf", "#9b9589", "#585d69",
               "#272727", "#ac8957", "#af96ab", "#355c79",
               "#7499c5", "#6ba386", "#e1be5a", "#e89943",
               "#f15d35")
    ) +
  coord_fixed() +
  theme_void() +
  theme(legend.position = "none",
        panel.background = element_rect(fill = "#e0dace", colour = "#e0dace"),
        plot.background = element_rect(fill = "#e0dace", colour = "#e0dace"),
        plot.margin = margin(10, 10, 10, 10))

ggplot2::ggsave(filename = "2023/art/27_hilma_af_klint.png",
                width = 600,
                height = 600,
                unit = "px")

library(ggplot2)
library(showtext)

font_add_google("Inspiration")
showtext_auto()

set.seed(1234)
plot_data1 <- stringr::str_flatten(
  sample(c(LETTERS, letters, " ", " ", " ", " ", " ", " ", " ", " "),
         replace = TRUE, size = 600)
  )
plot_data2 <- stringr::str_flatten(
  sample(c(LETTERS, letters, " ", " ", " ", " ", " ", " ", " ", " "),
         replace = TRUE, size = 600)
)
plot_data3 <- stringr::str_flatten(
  sample(c(LETTERS, letters, " ", " ", " ", " ", " ", " ", " ", " "),
         replace = TRUE, size = 600)
)
plot_data4 <- stringr::str_flatten(
  sample(c(LETTERS, letters, " ", " ", " ", " ", " ", " ", " ", " "),
         replace = TRUE, size = 600)
)

ggplot() +
  geom_text(data = data.frame(x = 0, y = 0, label = stringr::str_wrap(plot_data1, 40)),
            aes(x = x, y = y, label = label),
            hjust = 0.5, vjust = 0.5, family = "Inspiration", fontface = "bold",
            colour = "grey95",
            size = 16,
            lineheight = 0.3) +
  geom_text(data = data.frame(x = 0, y = 0, label = stringr::str_wrap(plot_data2, 40)),
            aes(x = x, y = y, label = label),
            hjust = 0.5, vjust = 0.5, family = "Inspiration", fontface = "bold",
            colour = "#FFBA49",
            size = 16,
            lineheight = 0.3) +
  geom_text(data = data.frame(x = 0, y = 0, label = stringr::str_wrap(plot_data3, 40)),
            aes(x = x, y = y, label = label),
            hjust = 0.5, vjust = 0.5, family = "Inspiration", fontface = "bold",
            colour = "#A14A76",
            size = 16,
            lineheight = 0.3) +
  geom_text(data = data.frame(x = 0, y = 0, label = stringr::str_wrap(plot_data4, 40)),
            aes(x = x, y = y, label = label),
            hjust = 0.5, vjust = 0.5, family = "Inspiration", fontface = "bold",
            colour = "#4D7EA8",
            size = 16,
            lineheight = 0.3) +
  coord_cartesian(expand = FALSE) +
  theme_void() +
  theme(plot.background = element_rect(fill = "grey10", colour = "grey10"),
        panel.background = element_rect(fill = "grey10", colour = "grey10"),
        plot.margin = margin(0, 0, 0, 0))

ggplot2::ggsave(filename = "2023/art/14_asemic.png",
                width = 600,
                height = 600,
                unit = "px")

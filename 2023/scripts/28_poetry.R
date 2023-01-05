library(ggplot2)
library(showtext)
library(stringr)
library(tibble)
library(gganimate)

font_add_google("Moon Dance")
showtext_auto()

line1 <- str_split_1("A Red, Red Rose", "")
line2 <- str_split_1("by Robert Burns", "")
line3 <- str_split_1("O my Luve is like a red, red rose", "")
line4 <- str_split_1("That’s newly sprung in June;", "")
line5 <- str_split_1("O my Luve is like the melody", "")
line6 <- str_split_1("That’s sweetly played in tune.", "")
all <- c(line1, line2, line3, line4, line5, line6)

plot_data <- tibble(letter = all,
                    time = 1:length(all))
plot_data$y <- c(rep(1, length(line1)),
                 rep(2, length(line2)),
                 rep(4, length(line3)),
                 rep(5, length(line4)),
                 rep(6, length(line5)),
                 rep(7, length(line6)))
plot_data$x <- c(seq(1, by = 1.5, length.out = length(line1)),
                 1:length(line2), 1:length(line3),
                 1:length(line4), 1:length(line5),
                 1:length(line6))
plot_data$size <- c(rep(20, length(line1)),
                    rep(9, length(line2)),
                    rep(12, length(line3)),
                    rep(12, length(line4)),
                    rep(12, length(line5)),
                    rep(12, length(line6)))

ggplot(data = plot_data) +
  geom_text(aes(x = x, y = y, label = letter, size = size),
            hjust = 0.5, vjust = 0.5, family = "Moon Dance",
            colour = "grey5") +
  scale_y_reverse(limits = c(7.5, 0.5)) +
  scale_size_identity() +
  theme_void() +
  theme(plot.background = element_rect(fill = "grey95", colour = "grey95"),
        panel.background = element_rect(fill = "grey95", colour = "grey95"),
        plot.margin = margin(20, 10, 20, 10),
        legend.position = "none")

ggplot2::ggsave(filename = "2023/art/28_poetry.png",
                width = 600,
                height = 600,
                unit = "px")

ggplot(data = plot_data) +
  geom_text(aes(x = x, y = y, label = letter, size = size),
            hjust = 0.5, vjust = 0.5, family = "Moon Dance",
            colour = "grey5") +
  scale_y_reverse(limits = c(7.5, 0.5)) +
  scale_size_identity() +
  theme_void() +
  theme(plot.background = element_rect(fill = "grey95", colour = "grey95"),
        panel.background = element_rect(fill = "grey95", colour = "grey95"),
        plot.margin = margin(20, 10, 20, 10),
        legend.position = "none") +
  #animate
  transition_states(time) +
  shadow_mark()

anim_save("2023/art/28_poetry.gif",
          width = 600,
          height = 600,
          unit = "px")

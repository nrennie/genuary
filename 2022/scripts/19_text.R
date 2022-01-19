library(ggplot2)
library(stringr)
library(tibble)

# generate data
word1 <- unlist(str_split("GENUARY", ""))
word2 <- unlist(str_split("ART", ""))
word3 <- unlist(str_split("RTISTRY", ""))
word4 <- unlist(str_split("CREATIVECODING", ""))
word5 <- unlist(str_split("GENERATIVEART", ""))
words <- list(word1, word2, word3, word4, word5)

set.seed(123)
all_letters <- c()
all_cols <- c()
while (length(all_letters) < 625){
  s <- sample(1:5, size=1)
  w <- words[[s]]
  all_letters <- c(all_letters, w)
  all_cols <- c(all_cols, rep(sample(1:6, 1), length(w)))
}

x <- 1:25
y <- 1:25
plot_data <- tibble(expand.grid(x = x, y = y))
plot_data$all_letters <- all_letters[1:nrow(plot_data)]
plot_data$all_cols <- as.character(all_cols[1:nrow(plot_data)])

# plot
ggplot() +
  geom_text(data = plot_data,
            mapping = aes(x = x, y = y, label = all_letters, colour = all_cols), size = 5, fontface = 2) +
  coord_fixed() +
  theme_void() +
  theme(legend.position = "none",
        panel.background = element_rect(fill = "black", colour = "black"),
        plot.background = element_rect(fill = "black", colour = "black"))



library(ggplot2)
library(tibble)
library(dplyr)

# generate squares
gen_polygon <- function(x, y, height, width, group, col){
  data.frame(x = c(x, x+width, x+width, x),
             y = c(y, y, y+height, y+height),
             group = rep(group, 4),
             col = rep(col, 4))
}

# generate squares
gen_squares <- function(heights, colours = c("#2E294E", "#541388", "#F1E9DA", "#FFD400", "#D90368")){
  widths <- heights
  x <- -sqrt((heights^2)/4)
  y <- -sqrt((heights^2)/4)
  plot_data <- data.frame(x = c(),
                          y = c(),
                          group = c(),
                          col = c())
  n <- length(heights)
  for (i in 1:n){
    k <- gen_polygon(x = x[i],
                     y = y[i],
                     height = heights[i],
                     width = widths[i],
                     group = i,
                     col = colours[i])
    plot_data <- rbind(plot_data, k)
  }
  # plot
  p <- ggplot(plot_data, aes(x = x, y = y)) +
    geom_polygon(aes(group = group, fill = I(col)), colour = NA) +
    coord_fixed(expand = F) +
    xlim(-2.5, 2.5) +
    ylim(-2.5, 2.5) +
    theme_void() +
    theme(legend.position = "none",
          panel.background = element_rect(fill = "black", colour = "black"),
          plot.background = element_rect(fill = "black", colour = "black"))
  p
}
gen_squares(heights = seq(5, 1, -1))

#heights matrix
heights_df <- tibble(x1=seq(0, 9, 0.1)) %>%
  mutate(x2 = x1 - 1,
         x3 = x2 - 1,
         x4 = x3 - 1,
         x5 = x4 - 1)
heights_df <- as.matrix(heights_df)
heights_df[which(heights_df < 0, arr.ind = T)] <- 0
heights_df[which(heights_df > 5, arr.ind = T)] <- 5
num_anim <- nrow(heights_df)

setwd("G:/My Drive/GitHub/genuary/2022/art/27_anim")
for (i in 1:num_anim){
  k <- gen_squares(heights=unlist(heights_df[i,]))
  ggplot2::ggsave(k, filename = paste(i, ".jpg", sep=""),  bg = "transparent", height=500, width=500, unit="px")
}




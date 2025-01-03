library(ggplot2)

# Params
s <- 2025
n <- 20
res <- 250
line_col <- "black"
bg_col <- "#09A39A"

# Data
set.seed(s)
plot_data <- data.frame(
  x = runif(n),
  y = runif(n)
)
t <- seq_len(nrow(plot_data))
smooth_x <- spline(t, plot_data$x, n = res)$y
smooth_y <- spline(t, plot_data$y, n = res)$y
smooth_path <- data.frame(x = smooth_x, y = smooth_y)

# Plot
ggplot(data = smooth_path, 
       mapping = aes(x = x, y = y)) +
  geom_path() +
  theme_void() +
  theme(
    plot.background = element_rect(
      fill = bg_col, colour = bg_col
    )
  )

# Save
ggsave("2025/art/25_one_line.png", height = 4, width = 4)


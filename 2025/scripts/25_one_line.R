library(ggplot2)

# Params
s <- 2025
n <- 150
res <- 1500
line_col <- "black"
bg_col <- "#09A39A"

# Data
set.seed(s)
plot_data <- data.frame(
  x = runif(n, -1, 1),
  y = runif(n, -1, 1)
) |> 
  dplyr::filter(x^2 + y^2 <= 1)
t <- seq_len(nrow(plot_data))
smooth_x <- spline(t, plot_data$x, n = res)$y
smooth_y <- spline(t, plot_data$y, n = res)$y
smooth_path <- data.frame(x = smooth_x, y = smooth_y)
lim <- max(abs(c(smooth_path$x, smooth_path$y)))

# Plot
ggplot(data = smooth_path, 
       mapping = aes(x = x, y = y)) +
  geom_path() +
  scale_x_continuous(limits = c(-lim, lim)) +
  scale_y_continuous(limits = c(-lim, lim)) +
  theme_void() +
  theme(
    aspect.ratio = 1,
    plot.background = element_rect(
      fill = bg_col, colour = bg_col
    )
  )

# Save
ggsave("2025/art/25_one_line.png", height = 4, width = 4)


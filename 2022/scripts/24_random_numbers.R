library(numbers)
library(ggplot2)
library(tibble)
library(stringr)
library(rcartocolor)

# random number generator
rn_gen <- function(seed, n, a = 37, b = 19, m = 123){
  if (any(c(seed, n, a, b, m) <= 0)) stop("Inputs must be greater than 0")
  if (a > m | b > m) stop("a and b must be less than m")
  if (seed > m) stop("seed must be less than m")
  output <- numeric(length = n)
  output[1] <- mod(a * seed + b, m)
  if (n >=2){
    for (i in 2:n){
      output[i] <- mod(a * output[i-1] + b, m)
    }
  }
  output
}
rn_gen(seed=5, n=10)

# generate data
n <- 1000
rn <- as.character(rn_gen(seed=5, n=n))
theta <- seq(0, 20 * pi, length.out = n)
r <- 0.5 + 0.5 * theta
plot_data <- tibble(x = r * cos(theta),
                    y = r * sin(theta),
                    size = nchar(rn),
                    colour = str_sub(rn,-1))

# plot
ggplot(data = plot_data,
       mapping = aes(x = x, y = y, size = I(size/2), colour = colour)) +
  geom_point() +
  scale_color_carto_d(palette = "Bold") +
  coord_fixed() +
  xlim(-(max(abs(c(plot_data$x, plot_data$y))) + 2), (max(abs(c(plot_data$x, plot_data$y))) + 2)) +
  ylim(-(max(abs(c(plot_data$x, plot_data$y))) + 2), (max(abs(c(plot_data$x, plot_data$y))) + 2)) +
  theme_void() +
  theme(legend.position = "none",
        plot.background = element_rect(fill = "black", colour = "black"),
        panel.background = element_rect(fill = "black", colour = "black"))



library(ggplot2)
library(lubridate)
library(tibble)
library(gganimate)
library(rcartocolor)

# add new point for every hours
start <- ymd_hms("2022-01-01 00:00:00")
now <- Sys.time()
num_points <- as.numeric(round(difftime(now, start, units='hours')))

# make data
set.seed(1234)
plot_data <- tibble(time = 1:num_points,
                    x = runif(num_points),
                    y = runif(num_points),
                    col = as.character(sample(1:12, size=num_points, replace = T)))

# plot
ggplot() +
  geom_point(data = plot_data,
             mapping = aes(x = x, y = y, colour = col), size = 1.5) +
  scale_color_carto_d(palette = "Prism") +
  ylim(0, 1) +
  xlim(0, 1) +
  coord_fixed() +
  theme_void() +
  theme(legend.position = "none",
        panel.background = element_rect(fill = "black", colour = "black"),
        plot.background = element_rect(fill = "black", colour = "black"))

# animate
anim <- ggplot() +
  geom_point(data = plot_data,
             mapping = aes(x = x, y = y, colour = col), size = 1.5) +
  scale_color_carto_d(palette = "Prism") +
  ylim(0, 1) +
  xlim(0, 1) +
  coord_fixed() +
  theme_void() +
  theme(legend.position = "none",
        panel.background = element_rect(fill = "black", colour = "black"),
        plot.background = element_rect(fill = "black", colour = "black")) +
  # gganimate
  transition_states(time) +
  shadow_mark()
animate(anim, nframes=500)
anim_save("2022/art/22_different_in_a_year.gif")

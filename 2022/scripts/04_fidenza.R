library(tidyverse)
library(ambient)
library(particles)
library(tidygraph)

set.seed(56)

#create noise field
grid <- long_grid(seq(1, 10, length.out = 10000), seq(1, 10, length.out = 10000)) %>%
  mutate(noise = gen_simplex(x, y))

#convert noise values to a matrix of angles
field <- as.matrix(grid, x, value = normalize(noise, to = c(-1, 1))) * (2 * pi)

#particle simulation, taken from {particles} vignette
sim <- create_ring(10000) %>%
  simulate(alpha_decay = 0, setup = aquarium_genesis()) %>%
  wield(reset_force, xvel = 0, yvel = 0) %>%
  wield(field_force, angle = field, vel = 0.25, xlim = c(-5, 5), ylim = c(-5, 5)) %>%
  evolve(100, record)

traces <- data.frame(do.call(rbind, lapply(sim$history, position)))
names(traces) <- c('x', 'y')
traces$particle <- rep(1:10000, 100)

bl_yl <- c('#8E1600', '#FF4F00')

traces2 <-
  traces %>%
  group_by(particle) %>%
  mutate(color = sample(bl_yl, 1, replace = TRUE))

p <- ggplot(traces2) +
  geom_path(aes(x, y, group = particle, color = color), size = 0.035, alpha = 0.6) +
  scale_color_identity(guide = "none") +
  theme_void() +
  theme(legend.position = 'none')

p
#https://www.williamrchase.com/post/flow-fields-12-months-of-art-september/

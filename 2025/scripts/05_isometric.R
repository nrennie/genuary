library(ggplot2)

square_dots <- function(r, n) {
  top <- data.frame(
    x = seq(-r, r, length.out = n),
    y = rep(r, n)
  )
  bottom <- data.frame(
    x = seq(-r, r, length.out = n),
    y = rep(-r, n)
  )
  left <- data.frame(
    x = rep(-r, n),
    y = seq(-r, r, length.out = n)
  )
  right <- data.frame(
    x = rep(r, n),
    y = seq(-r, r, length.out = n)
  )
  output <- do.call(rbind, list(top, left, right, bottom))
  output$r <- r
  return(output)
}

s <- 2025
bg_col <- "#B1D3C2"
main_col <- "#364958"

set.seed(s)

plot_data <- purrr:::map(
  .x = seq(0.25, 2, by = 0.25),
  .f = ~ square_dots(r = .x, n = 10)
) |>
  purrr::list_rbind() |>
  dplyr::distinct()

ggplot(
  data = plot_data,
  mapping = aes(x = x, y = y, size = r)
) +
  geom_point(
    position = position_jitter(width = 0.05, height = 0.05, seed = 42),
    colour = "white"
  ) +
  geom_point(
    position = position_jitter(width = 0.05, height = 0.05, seed = 42),
    colour = main_col,
    mapping = aes(alpha = r)
  ) +
  scale_size(range = c(1, 5)) +
  scale_alpha(
    range = c(0.4, 1)
  ) +
  theme_void() +
  theme(
    aspect.ratio = 1,
    legend.position = "none",
    panel.background = element_rect(
      fill = bg_col, colour = bg_col
    )
  )

ggsave("2025/art/05_isometric.png", height = 4, width = 4)

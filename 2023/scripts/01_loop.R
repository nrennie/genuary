x <- seq(2, 4, by = 0.1)
for (i in seq_len(length(x))) {
  aRt::fractals(N = 25,
                col_palette = rev(MetBrewer::met.brewer("Veronese", n = 25, direction = -1)),
                shift = 0, left = -3, right = 3,
                y_param = x[i], resolution = 0.01, dist_max = 4)
  filename <- paste0("2023/art/01_loop", i, ".png")
  ggplot2::ggsave(filename = filename,
                  width = 600,
                  height = 600,
                  unit = "px")
}

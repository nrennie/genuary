library(ggplot2)
library(patchwork)

perc = 0.95
n = 1
col_palette = "TealGrn"
s = 1234

set.seed(s)
plot_df <- matrix(NA, ncol = 1000, nrow = n)
for (i in seq_len(n)) {
  k <- stats::runif(1000)
  vals <- sample(x = 1:1000, size = perc * 1000, replace = FALSE)
  k[sort(vals)] <- sort(k[vals])
  plot_df[i, ] <- k
}
colnames(plot_df) <- seq_len(ncol(plot_df))
rownames(plot_df) <- seq_len(nrow(plot_df))
plot_data <- tibble::tibble(times = seq_len(nrow(plot_df)), tibble::as_tibble(plot_df))
plot_data <- tidyr::pivot_longer(plot_data, cols = 2:(ncol(plot_df) + 1))

p1 <- ggplot2::ggplot(data = plot_data,
                     ggplot2::aes(x = .data$times, y = as.numeric(.data$name), fill = .data$value)) +
  ggplot2::geom_tile(size=1) +
  ggplot2::coord_flip(expand = FALSE) +
  rcartocolor::scale_fill_carto_c(palette = col_palette) +
  ggplot2::theme(panel.background = ggplot2::element_rect(fill = "transparent"),
                 plot.background = ggplot2::element_rect(fill = "transparent"),
                 axis.text = ggplot2::element_blank(),
                 axis.ticks = ggplot2::element_blank(),
                 axis.title = ggplot2::element_blank(),
                 plot.margin = ggplot2::unit(c(-0.5, -0.5, -0.5, -0.5), "cm"),
                 legend.position = "none",
                 legend.key = ggplot2::element_blank())
p1

p2 <- ggplot2::ggplot(data = plot_data,
                      ggplot2::aes(x = .data$times, y = as.numeric(.data$name), fill = .data$value)) +
  ggplot2::geom_tile(alpha = 0.5, colour=NA, size=1) +
  ggplot2::coord_cartesian(expand = FALSE) +
  rcartocolor::scale_fill_carto_c(palette = col_palette) +
  ggplot2::theme(panel.background = ggplot2::element_rect(fill = "transparent"),
                 plot.background = ggplot2::element_rect(fill = "transparent"),
                 axis.text = ggplot2::element_blank(),
                 axis.ticks = ggplot2::element_blank(),
                 axis.title = ggplot2::element_blank(),
                 plot.margin = ggplot2::unit(c(-0.5, -0.5, -0.5, -0.5), "cm"),
                 legend.position = "none",
                 legend.key = ggplot2::element_blank())
p2

dev.new(width=6,height=6,unit="in", noRStudioGD = TRUE)
p <- p1 +
  patchwork::inset_element(p2, left = 0, bottom = 0, right = 1, top = 1) &
  ggplot2::theme(plot.margin = ggplot2::unit(c(-0.5, -0.5, -0.5, -0.5), "cm"))
p

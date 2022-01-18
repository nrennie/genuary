library(imager)
library(ggplot2)

# set params
n = 100
perc = 0.1
col_palette = "DarkMint"
bg_col = "black"
s = 1234

# prep data
set.seed(s)
x <- stats::rexp(n, 0.02)
y <- perc * x + (1 - perc) * stats::runif(n, 1, 60)
plot_data <- tibble::tibble(id = 1:n, areas = x, values = y)

# make plots
p_func <- function(input=plot_data){
  p <- ggplot2::ggplot(data=input, ggplot2::aes(area = .data$areas, fill = .data$values)) +
    treemapify::geom_treemap(alpha = 0.5, colour = NA) +
    rcartocolor::scale_fill_carto_c("", type = "diverging", palette = col_palette, direction = -1) +
    rcartocolor::scale_colour_carto_c("", type = "diverging", palette = col_palette, direction = -1) +
    ggplot2::theme(panel.background = ggplot2::element_rect(fill = bg_col, colour = bg_col),
                   plot.background = ggplot2::element_rect(fill = bg_col, colour = bg_col),
                   plot.title = ggplot2::element_blank(),
                   plot.subtitle = ggplot2::element_blank(),
                   legend.position = "none",
                   plot.margin = ggplot2::unit(c(0, 0, 0, 0), "cm"),
                   axis.title.x = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_blank(),
                   axis.text.x = ggplot2::element_blank(),
                   axis.text.y = ggplot2::element_blank(),
                   axis.ticks.x = ggplot2::element_blank(),
                   axis.ticks.y = ggplot2::element_blank(),
                   panel.grid.major = ggplot2::element_blank(),
                   panel.grid.minor = ggplot2::element_blank())
  p
}

rep_mat <- function(mat, nrow_out, ncol_out) {
  mat[rep(seq_len(nrow(mat)), length.out = nrow_out),
      rep(seq_len(ncol(mat)), length.out = ncol_out)]
}

recursive_bayer_pattern <- function(n) {
  if(n <= 0) {
    return(matrix(0))
  }
  m <- recursive_bayer_pattern(n - 1)
  rbind(
    cbind(4 * m + 0, 4 * m + 2),
    cbind(4 * m + 3, 4 * m + 1))
}

normalized_bayer_pattern <- function(n) {
  pattern <- recursive_bayer_pattern(n)
  (1 + pattern) / ( 1 + length(pattern) )
}

rep_bayer_cimg <- function(nrow_out, ncol_out) {
  bayer_matrix <- rep_mat(normalized_bayer_pattern(2), nrow_out, ncol_out)
  as.cimg(bayer_matrix)
}

img_to_bayer_bw <- function(img) {
  img <- grayscale(rm.alpha(img))
  bayer_cimg <- rep_bayer_cimg(nrow(img), ncol(img))
  img >= bayer_cimg
}

ggplot_to_cimg <- function(width, height) {
  tmp_fname <- tempfile(fileext = ".png")
  ggsave(tmp_fname, width = width, height = height, unit = "px", antialias = "none")
  load.image(tmp_fname)
}

setwd("G:/My Drive/GitHub/genuary/2022/art/18_anim")
for (i in 0:99){
  # make plot
  p_func(input=dplyr::filter(plot_data, id < (100-i)))
  # save temp file
  plot_img <- suppressWarnings(ggplot_to_cimg(width = 500, height = 500))
  # add dither
  img_out <- img_to_bayer_bw(plot_img)
  g <- as.data.frame(img_out)
  p <- ggplot() +
    geom_tile(data = g, mapping = aes(x = x, y= y, fill=cc)) +
    coord_fixed(expand = F) +
    scale_fill_gradient(high="black", low="white") +
    theme_void() +
    theme(legend.position = "none")
  p
  ggplot2::ggsave(p, filename = paste(i, ".jpg", sep=""),  bg = "transparent", height=500, width=500, unit="px")
}











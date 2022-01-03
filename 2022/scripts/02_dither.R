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


#https://www.r-bloggers.com/2019/01/image-dithering-in-r/
library(imager)
flower <- load.image("2022/data/02_original.jpg")
img_out <- img_to_bayer_bw(flower)
par(mar = rep(0, 4))
plot(img_out, axes = F)

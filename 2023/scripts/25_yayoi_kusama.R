library(tidyverse)
library(poissoned)

set.seed(1)
points <- poissoned::poisson_disc(ncols = 16, nrows = 16, cell_size = 1/16, verbose = TRUE)
points$size <- sample(c(0.5, 1.4), size = nrow(points), replace = TRUE)

col_palette <- c("#fdc818", "#fdd95f", "#fbc000", "#dba800")
num_lines <- 20
polygon1 <- sf::st_polygon(list(cbind(c(0, 1, 1, 0, 0), c(0, 0, 1, 1, 0))))
endpoints <- tibble::tibble(x = c(seq(0, 1, length = 100),
                                  seq(0, 1, length = 100),
                                  rep(0, 100),
                                  rep(1, 100)),
                            y = c(rep(0, 100),
                                  rep(1, 100),
                                  seq(0, 1, length = 100),
                                  seq(0, 1, length = 100)))
choose_ends <- purrr::map(.x = 1:num_lines,
                          .f = ~as.matrix(dplyr::slice_sample(endpoints, n = 2)))
make_lines <- sf::st_multilinestring(x = choose_ends)
cropped_sf <- lwgeom::st_split(polygon1, make_lines) %>%
  sf::st_collection_extract(c("POLYGON")) %>%
  sf::st_as_sf() %>%
  dplyr::mutate(col = sample(seq_len(length(col_palette)),
                             size = nrow(.), replace = TRUE))
ggplot2::ggplot() +
  ggplot2::geom_sf(data = cropped_sf,
                   mapping = ggplot2::aes(fill = col),
                   colour = "transparent",
                   linewidth = 0) +
  ggplot2::geom_point(data = points,
                      mapping = ggplot2::aes(x = x, y = y, size = size)) +
  ggplot2::scale_size_identity() +
  ggplot2::scale_fill_gradientn(colours = col_palette) +
  ggplot2::coord_sf(expand = FALSE) +
  ggplot2::theme_void() +
  ggplot2::theme(legend.position = "none")

ggplot2::ggsave(filename = "2023/art/25_yayoi_kusama.png",
                width = 800,
                height = 800,
                unit = "px")

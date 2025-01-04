img_path <- system.file("images", "tree.jpg", package = "pixR")
rescale <- 50

img <- imager::load.image(img_path)
img <- imager::resize(
  img, round(imager::width(img) / rescale),
  round(imager::height(img) / rescale)
)

# Gray
img_gray <- imager::grayscale(imager::rm.alpha(img))
m <- as.matrix(img_gray)
colnames(m) <- seq_len(ncol(m))
rownames(m) <- seq_len(nrow(m))

# Colour
img_mat <- imager::channels(img)
hex_m <- grDevices::rgb(as.matrix(img_mat$c.1), as.matrix(img_mat$c.2), as.matrix(img_mat$c.3))
m_col <- matrix(hex_m, nrow = nrow(as.matrix(img_mat$c.1)))
colnames(m_col) <- seq_len(ncol(m_col))
rownames(m_col) <- seq_len(nrow(m_col))


# Process image
m_df <- m |>
  tibble::as_tibble() |>
  dplyr::mutate(x = dplyr::row_number()) |>
  tidyr::pivot_longer(-x, names_to = "y") |>
  dplyr::mutate(y = as.numeric(y))

m_col_df <- m_col |>
  tibble::as_tibble() |>
  dplyr::mutate(x = dplyr::row_number()) |>
  tidyr::pivot_longer(-x, names_to = "y", values_to = "fill") |>
  dplyr::mutate(y = as.numeric(y))

plot_data <- m_df |>
  dplyr::left_join(m_col_df, by = c("x", "y")) |>
  dplyr::group_by(y) |>
  dplyr::arrange(dplyr::desc(value)) |>
  dplyr::mutate(new_x = dplyr::row_number()) |>
  dplyr::ungroup()

ggplot2::ggplot() +
  ggplot2::geom_raster(
    data = plot_data,
    mapping = ggplot2::aes(x = new_x, y = y, fill = fill)
  ) +
  ggplot2::scale_fill_identity() +
  ggplot2::scale_y_reverse() +
  ggplot2::coord_fixed(expand = FALSE) +
  ggplot2::theme_void()

ggplot2::ggsave(
  filename = "2025/art/31_pixel_sort.png",
  width = rescale * imager::width(img),
  height = rescale * imager::height(img),
  units = "px"
)

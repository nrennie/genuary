library(patchwork)

one_square <- function(col_palette) {
  cols <- sample(col_palette, 2)
  # base
  p <- ggplot2::ggplot() +
    ggplot2::scale_x_continuous(limits = c(-1, 1)) +
    ggplot2::scale_y_continuous(limits = c(-1, 1)) +
    ggplot2::theme_void() +
    ggplot2::theme(
      aspect.ratio = 1,
      plot.background = ggplot2::element_rect(
        fill = cols[1],
        colour = cols[1]
      )
    )
  o <- sample(1:4, 1)
  if (o == 1) {
    p <- p + ggforce::geom_circle(
      data = data.frame(x0 = 0, y0 = 0, r = 0.8),
      mapping = aes(x0 = x0, y0 = y0, r = r),
      colour = NA,
      fill = cols[2]
    )
  } else if (o == 2) {
    p <- p + ggforce::geom_circle(
      data = data.frame(x0 = 0, y0 = 0, r = 0.4),
      mapping = aes(x0 = x0, y0 = y0, r = r),
      colour = NA,
      fill = cols[2]
    )
  } else if (o == 3) {
    p <- p + ggplot2::annotate(
      "rect", xmin = -0.6, xmax = 0.6,
      ymin = -0.6, ymax = 0.6,
      fill = cols[2], colour = NA
    )
  } else if (o == 4) {
    p <- p + ggplot2::annotate(
      "rect", xmin = -0.4, xmax = 0.4,
      ymin = -0.4, ymax = 0.4,
      fill = cols[2], colour = NA
    )
  }
  return(p)
}

op_art_grid <- function(
    n_x = 5,
    n_y = 5,
    col_palette = c("#F75C03", "#D90368", "#04A777", "#820263", "#F4E409"),
    bg_col = "gray20",
    interpolate = TRUE,
    s = 1234) {
  # Data
  cols <- withr::with_seed(
    seed = s,
    code = {
      if (interpolate) {
        cols <- sample(
          grDevices::colorRampPalette(col_palette)(n_x * n_y)
        )
      } else {
        cols <- sample(
          col_palette,
          size = n_x * n_y, replace = TRUE
        )
      }
      cols
    }
  )
  # Map
  plot_list <- purrr::map(
    .x = cols,
    .f = ~ one_square(col_palette = col_palette)
  )
  
  # Plot with patchwork
  p <- patchwork::wrap_plots(plot_list,
                             nrow = n_y, ncol = n_x) &
    ggplot2::theme(
      plot.margin = margin(0, 0, 0, 0)
    )
  return(p)
}

pal1 <- PrettyCols::prettycols("Disco")
pal2 <- usefunc::blend_palette(
  pal1,
  PrettyCols::prettycols("Disco")[2]
)
pal3 <- usefunc::blend_palette(
  pal2,
  PrettyCols::prettycols("Disco")[2]
)

p1 <- op_art_grid(n_x = 10, n_y = 10, s = 2025,
                  col_palette = pal3)
p2 <- op_art_grid(n_x = 6, n_y = 6,
                  col_palette = pal2)
p3 <- op_art_grid(n_x = 2, n_y = 2, col_palette = pal1)



tmp1 <- tempfile()
ggplot2::ggsave(tmp1, p1, device = "png", width = 4, height = 4)
tmp2 <- tempfile()
ggplot2::ggsave(tmp2, p2, device = "png", width = 4, height = 4)
tmp3 <- tempfile()
ggplot2::ggsave(tmp3, p3, device = "png", width = 4, height = 4)

magick::image_read(tmp2) |> 
  magick::image_shadow(geometry = "80x30+50+50") |> 
  magick::image_write(tmp2)

magick::image_read(tmp3) |> 
  magick::image_shadow(geometry = "80x30+50+50") |> 
  magick::image_write(tmp3)

ggplot2::ggplot() +
  ggplot2::theme_void() +
  ggplot2::scale_x_continuous(limits = c(-1, 1)) +
  ggplot2::scale_y_continuous(limits = c(-1, 1)) +
  ggimage::geom_image(
    data = data.frame(
      x = 0, y = 0, image = tmp1
    ),
    mapping = aes(
      x = x, y = y, image = image
    ),
    size = 1
  ) +
  ggimage::geom_image(
    data = data.frame(
      x = 0.035, y = -0.036, image = tmp2
    ),
    mapping = aes(
      x = x, y = y, image = image
    ),
    size = 0.656
  ) +
  ggimage::geom_image(
    data = data.frame(
      x = 0.01, y = -0.01, image = tmp3
    ),
    mapping = aes(
      x = x, y = y, image = image
    ),
    size = 0.22
  )

ggplot2::ggsave("2025/art/19_op_art.png", height = 4, width = 4)

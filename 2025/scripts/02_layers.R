bullseye_new <- function(main_col = "grey80",
                         bg_col = "transparent",
                         s = 1) {
  plot_data <- withr::with_seed(
    seed = s,
    code = {
      df1 <- data.frame(id = seq(1, 20), value = sample(seq(-20, 100), 20, replace = TRUE), grp = 1)
      df2 <- data.frame(id = seq(1, 20), value = sample(seq(-20, 100), 20, replace = TRUE), grp = 2)
      plot_data <- do.call(rbind, list(df1, df2))
      plot_data
    }
  )
  p <- ggplot2::ggplot() +
    ggplot2::geom_bar(
      data = dplyr::filter(plot_data, .data$grp == 1),
      mapping = ggplot2::aes(x = as.factor(.data$id), y = .data$value),
      stat = "identity",
      width = 1,
      fill = ggplot2::alpha(main_col, 0.3)
    ) +
    ggplot2::geom_bar(
      data = dplyr::filter(plot_data, .data$grp == 2),
      mapping = ggplot2::aes(x = as.factor(.data$id), y = .data$value),
      stat = "identity",
      width = 0.2,
      fill = ggplot2::alpha(main_col, 0.3)
    ) +
    ggplot2::ylim(-20, 100) +
    ggplot2::coord_polar(start = 0) +
    aRt:::theme_aRt(bg_col, -0.5)
  return(p)
}

col_palette <- rep(PrettyCols::prettycols("Celestial")[1:5], 2)
plot_list <- purrr::map(
  .x = 1:length(col_palette),
  .f = ~ bullseye_new(main_col = col_palette[.x], s = .x)
)

ggplot2::ggplot() +
  ggplot2::theme_void() +
  ggplot2::theme(
    plot.background = ggplot2::element_rect(
      fill = PrettyCols::prettycols("Celestial")[6],
      colour = PrettyCols::prettycols("Celestial")[6],
    ),
    plot.margin = ggplot2::unit(c(-0.5, -0.5, -0.5, -0.5), "cm")
  ) +
  patchwork::inset_element(plot_list[[1]], left = 0, bottom = 0, right = 1, top = 1) +
  patchwork::inset_element(plot_list[[2]], left = 0, bottom = 0, right = 1, top = 1) +
  patchwork::inset_element(plot_list[[3]], left = 0, bottom = 0, right = 1, top = 1) +
  patchwork::inset_element(plot_list[[4]], left = 0, bottom = 0, right = 1, top = 1) +
  patchwork::inset_element(plot_list[[5]], left = 0, bottom = 0, right = 1, top = 1) +
  patchwork::inset_element(plot_list[[6]], left = 0, bottom = 0, right = 1, top = 1) +
  patchwork::inset_element(plot_list[[7]], left = 0, bottom = 0, right = 1, top = 1) +
  patchwork::inset_element(plot_list[[8]], left = 0, bottom = 0, right = 1, top = 1) +
  patchwork::inset_element(plot_list[[9]], left = 0, bottom = 0, right = 1, top = 1) +
  patchwork::inset_element(plot_list[[10]], left = 0, bottom = 0, right = 1, top = 1) &
  ggplot2::theme(
    plot.margin = ggplot2::unit(c(-0.5, -0.5, -0.5, -0.5), "cm")
  )

ggplot2::ggsave("2025/art/02_layers.png", height = 4, width = 4)

fpath <- system.file("images", "tree.jpg", package = "pixR")
p <- pixR::pixelate(
  img_path = fpath,
  rescale = 50,
  save = FALSE
)

basic_built <- ggplot2::ggplot_build(p)
p_data <- basic_built$data[[1]] |>
  tibble::as_tibble() |>
  dplyr::select(x, y, fill) |>
  tidyr::pivot_wider(
    names_from = "x",
    values_from = "fill",
  ) |>
  dplyr::select(-y)

library(openxlsx)
wb <- createWorkbook()
addWorksheet(wb, "Sheet", zoom = 35)
setColWidths(wb, "Sheet", cols = 1:ncol(p_data), widths = 3)
setRowHeights(wb, "Sheet", rows = 1:nrow(p_data), heights = 20)
writeData(wb,
  "Sheet",
  matrix("",
    nrow = nrow(p_data),
    ncol = ncol(p_data)
  ),
  colNames = FALSE
)
for (row in 1:(nrow(p_data))) {
  for (col in 1:(ncol(p_data))) {
    hex_color <- p_data[row, col] |> as.character()
    style <- createStyle(fgFill = hex_color)
    addStyle(wb, "Sheet", style, rows = row, cols = col, gridExpand = FALSE)
  }
}
saveWorkbook(wb, file = "2025/art/07_software.xlsx", overwrite = TRUE)

fpath <- system.file("images", "tree.jpg", package = "pixR")
pixR::recolour(
  img_path = fpath,
  palette = PrettyCols::prettycols("Teals", direction = -1),
  rescale = 100,
  filename = "2025/art/06_landscape.png"
)

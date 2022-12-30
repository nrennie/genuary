aRt::streams(bg_col = "grey20", line_col = "grey20",
             fill_col = PrettyCols::prettycols("Beach", type = "continuous", n = 50),
             type = "right", s = 2023)
ggplot2::ggsave(filename = "2023/art/18_not_a_grid.png",
                width = 600,
                height = 600,
                unit = "px")

aRt::black_hole(r_max = c(5000, 15000, 25000), n = 7500, lim = 50000,
                main_cols = grey.colors(n = 10, start = 0.01, end = 0.9),
                bg_col = "black", size = 0, a = 0.75, s = 1234)
ggplot2::ggsave(filename = "2023/art/19_black_and_white.png",
                width = 1200,
                height = 1200,
                unit = "px")


set.seed(2023)
sizes = runif(13469, 0.001, 2)
aRt::black_hole(r_max = c(1000, 30000), n = 7500, lim = 60000,
                main_cols = PrettyCols::prettycols("PurplePinks"),
                bg_col = "#fafafa", size = sizes, a = 0.75, s = 1234)
ggplot2::ggsave(filename = "2023/art/31_break.png",
                width = 1200,
                height = 1200,
                unit = "px")




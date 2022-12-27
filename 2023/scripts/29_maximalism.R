aRt::smudge(n = 25,
            binwidth = 0.01,
            col_palette = PrettyCols::prettycols("Dark"),
            s = 2023)

ggplot2::ggsave(filename = "2023/art/29_maximalism.png",
                width = 600,
                height = 600,
                unit = "px")

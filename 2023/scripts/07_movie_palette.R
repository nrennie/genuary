# Chariots of fire colours
eyedroppeR::extract_pal(n = 7, img_path = "2023/data/chariots.jpg")
pal <- c('#291514', '#704D33', '#8F7662', '#AFA08B', '#C4C1AE', '#D5D7CE')

# Map of St Andrews
aRt::contours(xmin = -2.8156,
              xmax = -2.7933,
              ymin = 56.34169,
              ymax = 56.35173,
              col_palette = pal,
              light = "white",
              dark = "black",
              range = c(0.1, 0.3))

# save image
ggplot2::ggsave(filename = "2023/art/07_movie_palette.png",
                width = 600,
                height = 600,
                unit = "px")

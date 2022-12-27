aRt::flow_fields(n = 5000, granualarity = 1000, x_freq = 10,
                 y_freq = 1, alpha = 0.2, line_col = "#333533",
                 bg_col = "#E8EDDF", s = 2023)
ggplot2::ggsave(filename = "2023/art/05_debug.png",
                width = 600,
                height = 600,
                unit = "px")

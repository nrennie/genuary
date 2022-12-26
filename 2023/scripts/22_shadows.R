png("2023/art/22_shadows.png", width = 600, height = 600, units = "px", res = 300)
aRt::stacked(n_x = 4, n_y = 4, col_palette = MetBrewer::met.brewer("Monet", 6), shadow_intensity = 0.1, sunangle = 315, s = 123)
dev.off()

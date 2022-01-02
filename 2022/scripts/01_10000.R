remotes::install_github("nrennie/aRt")
library(aRt)
remotes::install_github("BlakeRMills/MetBrewer")
library(MetBrewer)

polygons(n_x=100,
         n_y=100,
         gap_size=0.7,
         deg_jitter=0.4,
         colours=met.brewer("Pillement", 6)[2:6],
         rand = TRUE,
         bg_col=met.brewer("Pillement", 6)[1]) +
  ggplot2::coord_fixed(expand = F) +
  ggplot2::theme(plot.margin = ggplot2::unit(c(0, 0, -0.1, -0.1), "cm"))

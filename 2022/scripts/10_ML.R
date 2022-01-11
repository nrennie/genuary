library(aRt)
library(ggplot2)

setwd("G:/My Drive/GitHub/genuary/2022/art/10_anim")
for (i in 2:50){
  k <- connected(n=i, n_geom=5, random=T, col_palette="BrBG", bg_col="#ae217e", s=1234)
  ggplot2::ggsave(k, filename = paste(i, ".jpg", sep=""))
}
for (i in 2:50){
  k <- connected(n=52-i, n_geom=5, random=T, col_palette="BrBG", bg_col="#ae217e", s=1234)
  ggplot2::ggsave(k, filename = paste(49+i, ".jpg", sep=""))
}

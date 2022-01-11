library(aRt)
library(ggplot2)
library(rcartocolor)

p <- stripes(perc=0.3, n=8, s=1234) +
  scale_fill_carto_c(palette="Magenta")
p
ggsave(p, filename="2022/art/13_80x800.jpeg", height=600, width=600, unit="px")

library(tidyverse)
library(rayshader)
library(lubridate)
library(zoo)
library(plyr)

dates <- seq(from=as.Date("2012/1/1"), to=as.Date("2015/12/31"), by = "day")

plot_data <- data.frame(dates=dates)
plot_data$weekday = weekdays(dates)
plot_data$monthf<-factor(month(dates),levels=as.character(1:12),labels=c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"),ordered=TRUE)
plot_data$yearmonth <- factor(as.yearmon(dates))
plot_data$week <- as.numeric(format(dates,"%W"))
plot_data$n <- month(dates) + abs(rnorm(length(dates), 0, 10))
plot_data <- ddply(plot_data,.(yearmonth),transform,monthweek=1+week-min(week))

p <- ggplot(plot_data, aes(monthweek, weekday, fill = n)) +
  geom_tile(colour="grey90") + facet_grid(year(dates)~monthf) +
  scale_fill_gradient(low="gray90", high="gray30") +
  theme_void() +
  theme(plot.background = element_rect(fill="grey90", colour=NA),
        panel.background = element_rect(fill="grey90", colour=NA),
        strip.text = element_blank(),
        legend.position = "none")
p

plot_gg(p, height=3, width=3.5, multicore=TRUE)
render_snapshot("2022/art/09_architecture.png", clear = TRUE, vignette=T)
render_movie("2022/art/09_architecture.mp4", zoom = 0.7)


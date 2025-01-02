
camcorder::gg_record(
  dir = file.path("recording"),
  device = "png",
  width = 4,
  height = 4,
  units = "in",
  dpi = 300
)

for (i in 1:25) {
  print(
    aRt::shatter(n_x = 25, n_y = i) +
      ggplot2::scale_y_reverse(limits = c(25, 1))
  )
}

camcorder::gg_playback(
  name = "2025/aRt/28_infinite_scroll.gif",
  first_image_duration = 0.25,
  last_image_duration = 0.25,
  frame_duration = 0.25,
  last_as_first = FALSE
)


aRt::shatter(n_x = 25, n_y = 13) +
  ggplot2::scale_y_reverse(limits = c(25, 1))
ggplot2::ggsave("2025/aRt/28_infinite_scroll.png", height = 4, width = 4)

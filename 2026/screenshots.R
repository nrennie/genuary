day <- 17
webshot2::webshot(
    url = glue::glue("2026/day-{day}/index.html"),
    file = glue::glue("2026/day-{day}/day-{day}.png"),
    selector = "#art",
    expand = c(8, 8, 8, 8),
    quiet = TRUE,
    zoom = 2,
    vwidth = 1000,
    vheight = 1000
)
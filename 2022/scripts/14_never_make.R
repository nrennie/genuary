library(ggplot2)
library(ggraph)
library(igraph)

graph <- graph_from_data_frame(flare$edges, vertices = flare$vertices)
ggraph(graph, 'dendrogram', circular = TRUE) +
  geom_edge_diagonal(colour="white") +
  coord_fixed() +
  theme_void() +
  theme(plot.background = element_rect(fill = "black", colour = "black"),
        panel.background = element_rect(fill = "black", colour = "black"))

import plotnine as pn
import random
import pandas as pd
import matplotlib.colors as mcolors

def nexus(n_x, max_y, size, linewidth, bg_col, col_palette, s):
  """Generates plot of lines and points."""
  # generate data
  random.seed(s)
  # start and end points
  random.seed(s)
  n_y_start=random.choices(range(round(max_y/2)), k=n_x)
  n_y_end=random.choices(range(round(max_y/2)+1, max_y + 1), k=n_x)
  # get x and y co-ordinates in dataframe
  x_list=[]
  y_list=[]
  for i in range(n_x):
    x_list.extend([i]*len(range(n_y_start[i], n_y_end[i])))
    y_list.extend(range(n_y_start[i], n_y_end[i]))
  plot_data = pd.DataFrame({'x': x_list, 'y': y_list})
  # choose colours
  cmap=mcolors.LinearSegmentedColormap.from_list('custom_cmap', col_palette, N=len(plot_data.index))
  plot_data['col']=[mcolors.to_hex(cmap(i)) for i in range(len(plot_data.index))]
  # plot data
  p = (pn.ggplot(data=plot_data, mapping=pn.aes(x="x", y="y", group="x", colour="col")) +
    pn.geom_line(size=linewidth) +
    pn.geom_point(size=size) +
    pn.scale_colour_identity() +
    pn.theme_void() +
    pn.theme(plot_background=pn.element_rect(fill=bg_col, colour=bg_col)))
  return p

# Save
p = nexus(n_x=100, max_y=15, size=0.7, linewidth=0.5, col_palette=["#A053A1", "#DB778F", "#E69F52", "#09A39A", "#5869C7"], bg_col="#004B67", s=2025)
p.save("2025/art/18_wind.png", width=5, height=5, units="in", dpi=300)

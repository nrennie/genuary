
import random
import numpy as np
import pandas as pd
from shapely.geometry import Polygon, LineString
from shapely.ops import split
import geopandas as gpd
import plotnine as pn

def make_square(x0, y0, buffer, col_palette, bg_col):
    # Draw square
    x_vals = [x0, x0 + 1, x0 + 1, x0, x0]
    y_vals = [y0, y0, y0 + 1, y0 + 1, y0]
    square_coords = np.column_stack([x_vals, y_vals])
    square_polygon = Polygon(square_coords)
    
    # Draw line
    side = random.choice(["x", "y"])
    if side == "y":
        xs1, xs2 = x0, x0 + 1
        ys1, ys2 = random.uniform(y0 + buffer, y0 + 1 - buffer), random.uniform(y0 + buffer, y0 + 1 - buffer)
    else:
        xs1, xs2 = random.uniform(x0 + buffer, x0 + 1 - buffer), random.uniform(x0 + buffer, x0 + 1 - buffer)
        ys1, ys2 = y0, y0 + 1

    line = LineString([(xs1, ys1), (xs2, ys2)])
    
    # Split the square with the line
    split_result = split(square_polygon, line)
    split_polygons = [geom for geom in split_result.geoms]
    
    if len(split_polygons) != 2:
      split_polygons.append(Polygon())
      
    split_gdf = gpd.GeoDataFrame(geometry=split_polygons)
    split_gdf['col'] = [bg_col, random.choice(col_palette)]
    
    return split_gdf

def fifty_one(n_x=4, n_y=4, buffer=0.1, col_palette=["#8EA604", "#F5BB00", "#EC9F05", "#D76A03", "#BF3100"], bg_col="#FAFAFA", s=1234):
    if buffer < 0 or buffer > 0.5:
        raise ValueError("'buffer' needs to be between 0 and 0.5")
    
    np.random.seed(s)
    
    # Data generation
    plot_grid = pd.DataFrame([(x, y) for x in range(1, n_x + 1) for y in range(1, n_y + 1)], columns=['x', 'y'])
    all_data = pd.concat(
        [make_square(row['x'], row['y'], buffer, col_palette, bg_col) for _, row in plot_grid.iterrows()],
        ignore_index=True
    )
    def extract_coords(geometry):
        x, y = geometry.exterior.xy
        return pd.DataFrame({'x': x, 'y': y})
    
    plot_data = pd.concat([
        extract_coords(row.geometry).assign(col=row.col, group=row.Index)
        for row in all_data.itertuples(index=True, name='Pandas')
    ])
    
    # Plot
    plot = (pn.ggplot(data=plot_data)
            + pn.geom_polygon(pn.aes(x='x', y='y', group='group', fill='col'), color=None)
            + pn.scale_fill_identity()
            + pn.coord_fixed(expand=False)
            + pn.theme_void()
            + pn.theme(
                plot_background=pn.element_rect(fill=bg_col, color=bg_col),
                panel_background=pn.element_rect(fill=bg_col, color=bg_col)
            ))
    return plot


# Save
p = fifty_one(n_x=15, n_y=15, buffer=0.15, s=2024)
p.save("2025/art/29_grid.png", width=5, height=5, units="in", dpi=300)

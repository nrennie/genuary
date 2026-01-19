function setup() {
  const width = globalConfig.settings.width;
  const height = globalConfig.settings.height;
  const padding = globalConfig.style.padding;
  
  let canvas = createCanvas(width, height);
  canvas.parent('art');
  background(config.style.bgCol);
  
  // 16x16 grid configuration
  const gridSize = 16;
  const cellWidth = (width - padding * 2) / gridSize;
  const cellHeight = (height - padding * 2) / gridSize;
  const baseSize = Math.min(cellWidth, cellHeight) * 0.7;
  
  // Generate data for 16x16 grid
  const data = [];
  for (let row = 0; row < gridSize; row++) {
    for (let col = 0; col < gridSize; col++) {
      const x = padding + col * cellWidth + cellWidth / 2 - width / 2;
      const y = padding + row * cellHeight + cellHeight / 2 - height / 2;
      
      // Create pattern based on grid position
      const distFromCenter = dist(col - gridSize/2, row - gridSize/2, 0, 0);
      const normalizedDist = distFromCenter / (gridSize / Math.sqrt(2));
      
      data.push({
        x: x,
        y: y,
        size: baseSize * (1 + random(-0.3, 0.3)),
        fillCol: random(0, 1),
        fillOpacity: map(normalizedDist, 0, 1, config.data.fillOpacityMax, config.data.fillOpacityMin)
      });
    }
  }
  
  // Shuffle the data array to plot in random order
  for (let i = data.length - 1; i > 0; i--) {
    const j = floor(random(i + 1));
    [data[i], data[j]] = [data[j], data[i]];
  }
  
  // Translate to center
  translate(width / 2, height / 2);
  
  // Draw circles
  noStroke();
  for (let d of data) {
    // Map fillCol to palette index
    const colorIndex = floor(d.fillCol * config.style.colPalette.length);
    const colorString = config.style.colPalette[colorIndex];
    
    // Set fill and opacity in one call
    const col = color(colorString);
    col.setAlpha(d.fillOpacity * 255);
    fill(col);
    
    circle(d.x, d.y, d.size * 2);
  }
  
  noLoop();
}
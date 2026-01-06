config = {
  "settings": {
    "width": 600,
    "height": 600
  },
  "data": {
    "n": 8
  },
  "style": {
    "colour1": "#6D1A36",
    "colour2": "#AA3E98",
    "colour3": "white",
    "padding": 10
  }
}

function art() {
  const width = config.settings.width;
  const height = config.settings.width;
  const padding = config.style.padding;

  const labels = d3.range(config.data.n).map(i => String.fromCharCode(65 + i));

  // Generate the data array
  const data = d3.range(config.data.n ** 2).map(i => ({
    x: labels[i % config.data.n],
    y: labels[Math.floor(i / config.data.n)],
    z1: Math.random(),
    z2: Math.random(),
    z3: Math.random()
  }));

  const chartContainer = d3.select("#art")
    .style('background-color', config.style.colour)
    .style('padding', padding + 'px')
    .style('width', width + padding * 2 + 'px');

  const svg = chartContainer
    .append('svg')
    .attr('viewBox', `0 0 ${width} ${height}`)
    .attr('preserveAspectRatio', 'xMidYMid meet')
    .style('width', '100%')
    .style('height', 'auto')
    .append('g');

  const x = d3.scaleBand()
    .range([0, width])
    .domain(labels)
    .padding(0.05);

  const y = d3.scaleBand()
    .range([height, 0])
    .domain(labels)
    .padding(0.05);

  svg.selectAll('rect-1')
    .data(data)
    .enter()
    .append('rect')
    .attr('x', d => x(d.x))
    .attr('y', d => y(d.y))
    .attr('width', x.bandwidth())
    .attr('height', y.bandwidth())
    .style('fill', config.style.colour1)
    .style('stroke', config.style.colour3);

  svg.selectAll('line-1')
    .data(data)
    .enter()
    .append('line')
    .attr('x1', d => x(d.x))
    .attr('y1', d => y(d.y) + y.bandwidth() / 2)
    .attr('x2', d => x(d.x) + x.bandwidth())
    .attr('y2', d => y(d.y) + y.bandwidth() / 2)
    .style('stroke', config.style.colour3)
    .style('stroke-width', 1);

  svg.selectAll('line-2')
    .data(data)
    .enter()
    .append('line')
    .attr('x1', d => x(d.x) + x.bandwidth() / 2)
    .attr('y1', d => y(d.y))
    .attr('x2', d => x(d.x) + x.bandwidth() / 2)
    .attr('y2', d => y(d.y) + y.bandwidth())
    .style('stroke', config.style.colour3)
    .style('stroke-width', 1);

  svg.selectAll('triangle-1')
    .data(data)
    .enter()
    .append('polygon')
    .attr('points', d => {
      const x0 = x(d.x);
      const y0 = y(d.y);
      const w = x.bandwidth();
      const h = y.bandwidth();
      const apexY = y0 + (2 * h / 3);
      return `${x0},${y0 + h} ${x0 + w / 2},${apexY} ${x0 + w},${y0 + h}`;
    })
    .style('fill', config.style.colour2)
    .style('stroke', config.style.colour3);

  svg.selectAll('triangle-2')
    .data(data)
    .enter()
    .append('polygon')
    .attr('points', d => {
      const x0 = x(d.x);
      const y0 = y(d.y);
      const w = x.bandwidth();
      const h = y.bandwidth();
      const apexY = y0 + (h / 3);
      return `${x0},${y0} ${x0 + w / 2},${apexY} ${x0 + w},${y0}`;
    })
    .style('fill', config.style.colour2)
    .style('stroke', config.style.colour3);

  svg.selectAll('triangle-3')
    .data(data)
    .enter()
    .append('polygon')
    .attr('points', d => {
      const x0 = x(d.x);
      const y0 = y(d.y);
      const w = x.bandwidth();
      const h = y.bandwidth();
      const apexX = x0 + (w / 3);
      return `${x0},${y0} ${apexX},${y0 + h / 2} ${x0},${y0 + h}`;
    })
    .style('fill', config.style.colour2)
    .style('stroke', config.style.colour3);

  svg.selectAll('triangle-4')
    .data(data)
    .enter()
    .append('polygon')
    .attr('points', d => {
      const x0 = x(d.x);
      const y0 = y(d.y);
      const w = x.bandwidth();
      const h = y.bandwidth();
      const apexX = x0 + (2 * w / 3);
      return `${x0 + w},${y0} ${apexX},${y0 + h / 2} ${x0 + w},${y0 + h}`;
    })
    .style('fill', config.style.colour2)
    .style('stroke', config.style.colour3);

  svg.selectAll('circle1')
    .data(data)
    .enter()
    .append('circle')
    .attr('cx', d => x(d.x) - 2)
    .attr('cy', d => y(d.y) - 2)
    .attr('r', 6)
    .attr('fill', config.style.colour3);

  svg.selectAll('circle2')
    .data(data)
    .enter()
    .append('circle')
    .attr('cx', d => x(d.x) + x.bandwidth() + 2)
    .attr('cy', d => y(d.y) - 2)
    .attr('r', 6)
    .attr('fill', config.style.colour3);

  svg.selectAll('circle3')
    .data(data)
    .enter()
    .append('circle')
    .attr('cx', d => x(d.x) - 2)
    .attr('cy', d => y(d.y) + y.bandwidth() + 2)
    .attr('r', 6)
    .attr('fill', config.style.colour3);

  svg.selectAll('circle3')
    .data(data)
    .enter()
    .append('circle')
    .attr('cx', d => x(d.x) + x.bandwidth() + 2)
    .attr('cy', d => y(d.y) + y.bandwidth() + 2)
    .attr('r', 6)
    .attr('fill', config.style.colour3);

}

window.onload = function () {
  art();
};

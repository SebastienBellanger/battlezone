class Model
  constructor: ->
    @vertices = new Array()
    @indices = new Array()
    @transform = new Transform()
    @renderMode = "points"
    @color = "rgb(255, 255, 255)"
    
  addVertex: (vector3) ->
    @vertices.push vector3
    
  addIndex: (scalar) ->
    @indices.push scalar
    
  render: (renderer) =>
    renderer.pipeline.push()
    
    renderer.pipeline.addTransform @transform.getMatrix()
    
    switch @renderMode
      when "points" then @renderPoints(renderer)
      when "lines" then @renderLines(renderer)
     
    renderer.pipeline.pop()
    
  renderPoints: (renderer) ->
    for point in @indices
      do (point) =>
        position = renderer.pipeline.transform @vertices[point]
        renderer.drawPixel position.x, position.y, @color
        
  renderLines: (renderer) ->
    count = @indices.length
    line = 0
    while line < count
      p1 = renderer.pipeline.transform @vertices[@indices[line]]
      p2 = renderer.pipeline.transform @vertices[@indices[line + 1]]
      renderer.drawLine p1.x, p1.y, p2.x, p2.y, @color
      line += 2

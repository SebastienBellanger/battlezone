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
        #if position.z < -1 or position.z > 1 then continue
        renderer.drawPixel position.x, position.y, @color
        
  renderLines: (renderer) ->
    count = @indices.length
    line = 0
    while line < count
      currentLine = line
      line += 2
      p1 = renderer.pipeline.transform @vertices[@indices[currentLine]]
      if p1.z < 0 or p1.z > 1 then continue
      p2 = renderer.pipeline.transform @vertices[@indices[currentLine + 1]]
      if p2.z < 0 && p2.z > 1 then continue
      renderer.drawLine p1.x, p1.y, p2.x, p2.y, @color
     

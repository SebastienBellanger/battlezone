class Renderer

  constructor: ->
    @canvas = $?('#canvas')
    @context = @canvas?.get(0).getContext '2d'
    @context?.font = '400 16px/2 Unknown Font, sans-serif'    
    @context?.lineWidth = 1
    @context?.lineCap = 'butt'
    
    @width = @canvas?.width() || 1
    @height = @canvas?.height() || 1
    
    projection = new Projection(@width, @height, 0.00001, 1000, 75.0)
    #projection = new OrthoProjection(0, @width, @height, 0, 1, 1000)
    viewMatrix = new Matrix4()
    
    # TODO: explain purpose of this translation, commented for now since it does not seem to have effect.
    #viewMatrix.translate(0, -4, -10)
    
    halfWidth = @width / 2
    halfHeight = @height / 2
    
    viewportMatrix = new Matrix3()
    viewportMatrix.set( 
      halfWidth, 0,  0
      0, -halfHeight, 0,
      halfWidth, halfHeight, 1
    )
    
    @pipeline = new Pipeline()
    @pipeline.setProjection projection.getMatrix()
    @pipeline.setView viewMatrix
    @pipeline.setViewport viewportMatrix
    
  clear: ->
    @context.clearRect(0,0, @width, @height)  
    
  drawPixel: (x, y, color) ->
    if not @context? then return
  
    @context.save()
    @context.fillStyle = color.getColorString()
    @context.fillRect(x-1,y-1,3,3)  
    @context.restore()
  
  drawText: (x, y, string, color) ->
    if not @context? then return
  
    @context.save()
    if not color? then color = Color.WHITE
    @context.fillStyle = color.getColorString()
    @context.fillText string, x, y
    @context.restore()
    
  drawLine: (fromX, fromY, toX, toY, color) ->
    if not @context? then return
  
    @context.save();
    @context.beginPath()
    @context.strokeStyle = color.getColorString()
    @context.moveTo fromX, fromY
    @context.lineTo toX, toY
    @context.stroke()
    @context.restore()

  renderModel: (model) ->
    switch model.renderMode
      when "points" then @renderPoints(model)
      when "lines" then @renderLines(model)

  renderPoints: (model) ->
    for point in model.indices
      do (point) =>
        #console.log 'renderPoints point ' + @vertices[point]
        position = @pipeline.transform model.vertices[point]
        #if position.z < -1 or position.z > 1 then continue
        #console.log 'renderPoints position ' + position
        @drawPixel position.x, position.y, model.color
        
  renderLines: (model) ->
    count = model.indices.length
    line = 0
    while line < count
      currentLine = line
      line += 2
      p1 = @pipeline.transform model.vertices[model.indices[currentLine]]
      if p1.z < 0 or p1.z > 1 then continue
      p2 = @pipeline.transform model.vertices[model.indices[currentLine + 1]]
      if p2.z < 0 or p2.z > 1 then continue
      #console.log 'renderLines ' + p1.x + ', ' + p1.y + ', ' + p2.x + ', ' + p2.y
      @drawLine p1.x, p1.y, p2.x, p2.y, model.color

exports?.Renderer = Renderer

class Model
  constructor: ->
    @vertices = new Array()
    @lines = new Array()
    @transform = new Transform()
    
    @vertices[0] = new Vector3( 10, 10, 10 )
    @vertices[1] = new Vector3( -10, 10, 10 )
    @vertices[2] = new Vector3( -10, -10, 10 )
    @vertices[3] = new Vector3( 10, -10, 10 )
    @vertices[4] = new Vector3( 10, 10, -10 )
    @vertices[5] = new Vector3( -10, 10, -10 )
    @vertices[6] = new Vector3( -10, -10, -10 )
    @vertices[7] = new Vector3( 10, -10, -10 )
    
    @lines[0] = [0, 1]
    @lines[1] = [1, 2]
    @lines[2] = [2, 3]
    @lines[3] = [3, 0]
    @lines[4] = [0, 4]
    @lines[5] = [1, 5]
    @lines[6] = [2, 6]
    @lines[7] = [3, 7]
    @lines[8] = [4, 5]
    @lines[9] = [5, 6]
    @lines[10] = [6, 7]
    @lines[11] = [7, 4]  
    
  render: (renderer) =>
    renderer.pipeline.push()
    
    renderer.pipeline.addTransform @transform.getMatrix()

    for line in @lines 
      do (line) =>
        from = renderer.pipeline.transform @vertices[line[0]]
        to = renderer.pipeline.transform @vertices[line[1]]
        renderer.drawLine from.x, from.y, to.x, to.y, "rgb(0, 255, 0)"
    
    renderer.pipeline.pop()
    

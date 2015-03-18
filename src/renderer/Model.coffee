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

exports?.Model = Model

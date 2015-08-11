class BulletNode extends Node
  constructor: (@direction) ->
    super new BulletModel
    @transform.setUniformScale 0.8
    @timeOut = 4.0
    
  onUpdate: (step) ->
    move_step = step * 100 
    @transform.translate @direction.mul move_step
    @timeOut -= step
    if @timeOut <= 0
      @remove()
  
class BulletModel extends Model
  constructor: ->
    super
    @color = Renderer.RED
    @renderMode = "lines"
    
    @addVertex new Vector3(1,1,1)
    @addVertex new Vector3(-1,1,1)
    @addVertex new Vector3(-1,-1,1)
    @addVertex new Vector3(1,-1,1)
    @addVertex new Vector3(1,1,-1)
    @addVertex new Vector3(-1,1,-1)
    @addVertex new Vector3(-1,-1,-1)
    @addVertex new Vector3(1,-1,-1)
    
    @indices = [
      0,1, 1,2, 2,3, 3,0, 
      4,5, 5,6, 6,7, 7,4, 
      0,4, 1,5, 2,6, 3,7
    ]
    

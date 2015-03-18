class BulletNode extends Node
  constructor: ->
    super new BulletModel
    @transform.setUniformScale 0.5
    
  onUpdate: (step) ->
    @transform.translateZ -step * 0.05  
  
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
    

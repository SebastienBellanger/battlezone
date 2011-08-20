class Bullet
  constructor: ->
    @bullet = new BulletModel()
    @transform = new Transform()
    @transform.setUniformScale( 0.5 )
    
  update: (step) ->
    @transform.translateZ -step * 0.05  
    
  render: (renderer) ->
    renderer.pipeline.push()
    renderer.pipeline.addTransform @transform.getMatrix()
    @bullet.render renderer
    
    renderer.pipeline.pop()
  
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
    

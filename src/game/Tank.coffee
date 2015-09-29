GRAVITY = new Vector3(0, -4, 0)
MOVESPEED = 0.2
ROTATIONSPEED = 0.3

class TankNode extends Node
  constructor: ->
    super Models.TankModel    
    @transform.setUniformScale(1.5)
    
    @radarNode = new Node(Models.TankRadar)
    @radarNode.transform.translate(new Vector3(0,2.9, 1.6))
    @radarNode.transform.setUniformScale(0.4)
    @addChild(@radarNode)

    @trankRotation = Math.random() * Math.PI * 2
    @transform.setRotation(Quaternion.fromAxisAngle(Vector3.UNITY, @trankRotation))

    @stateTimer = Math.random() * 2 + 1
    @rotate = Math.random() * ROTATIONSPEED * 2 - ROTATIONSPEED

    #@testNode = new Node(Models.Sphere)    
    #@testNode.transform.setUniformScale(3.5)
    #@testNode.transform.translate(new Vector3(0,2,0))
    #@addChild(@testNode)

  onUpdate: (step) ->
    @radarNode.transform.rotateY( step * 1 )

    moveTranslation = new Vector3(-Math.sin(@trankRotation) * MOVESPEED, 0.0, -Math.cos(@trankRotation) * MOVESPEED)
    @transform.translate(moveTranslation)

    @stateTimer -= step
    if @stateTimer <= 0 
      @stateTimer = Math.random() * 2 + 1
      @rotate = Math.random() * ROTATIONSPEED * 2 - ROTATIONSPEED

    @trankRotation += @rotate * step
    @transform.setRotation(Quaternion.fromAxisAngle(Vector3.UNITY, @trankRotation))

  onRemove: ->
    if @parent != null
      root = new Node()
      root.transform.setTranslation(@transform.translation)
      root.transform.setRotation(Quaternion.fromAxisAngle(Vector3.UNITY, @trankRotation))
      @parent.addChild(root)

      chunk = new TankChunkNode Models.Chunk, 1.0
      chunk.transform.setUniformScale(1.2)
      chunk.transform.translate(new Vector3(0,2.5,0))
      root.addChild(chunk)

      chunk = new TankChunkNode Models.BarrelChunk, 1.0
      chunk.transform.setUniformScale(0.9)
      chunk.transform.translate(new Vector3(0,3,-4))
      root.addChild(chunk)

      chunk = new TankChunkNode Models.BodyChunk, 0.5
      chunk.transform.setUniformScale(1.8)
      chunk.transform.translate(new Vector3(0,0,0))
      root.addChild(chunk)

      chunk = new TankChunkNode Models.TankRadar, 2.0
      chunk.transform.setUniformScale(0.4)
      chunk.transform.translate(new Vector3(0,4,1))
      root.addChild(chunk)


class TankChunkNode extends Node
  constructor: (model, forceMultiplier = 1 ) ->
    super model
    @velocity = new Vector3(Math.random() * 4.0 - 2.0, Math.random() * 2 + 4, Math.random() * 4.0 - 2.0)
    @rotationX = Math.random() * 5.0 - 2.5
    @rotationY = Math.random() * 5.0 - 2.5
    @rotationZ = Math.random() * 5.0 - 2.5

    @velocity.x *= forceMultiplier
    @velocity.y += @velocity.y * (forceMultiplier - 1) * 0.25
    @velocity.z *= forceMultiplier
    @rotationX *= forceMultiplier
    @rotationY *= forceMultiplier
    @rotationZ *= forceMultiplier

  onUpdate: (step) ->
    @transform.rotateX( step * @rotationX )
    @transform.rotateY( step * @rotationY )
    @transform.rotateZ( step * @rotationZ )

    @velocity.addThis GRAVITY.mul step
    @transform.translate @velocity.mul step

    if @transform.translation.y <= -1.0
      @remove()

class TankRadarModel extends Model
  constructor: ->
    super
    @color = Color.RED
    @renderMode = "lines"
    
    @addVertex(new Vector3(0,0,0))
    @addVertex(new Vector3(0,0.5,0))
    @addVertex(new Vector3(1,0.5,0))
    @addVertex(new Vector3(-1,0.5,0))
    @addVertex(new Vector3(1,1.5,0))
    @addVertex(new Vector3(-1,1.5,0))
 
    @indices = [0,1, 1,2, 1,3, 2,4, 3,5, 4,5, 4,3, 5,2]

class TankBodyModel extends Model
  constructor: ->
    super
    @color = Color.GREEN
    @renderMode = "lines"
    @addVertex(new Vector3(-3, 0, -5))
    @addVertex(new Vector3( 3, 0, -5))
    @addVertex(new Vector3( 3, 0,  5))
    @addVertex(new Vector3(-3, 0,  5))

    @addVertex(new Vector3(-2.5, 2, -2))
    @addVertex(new Vector3( 2.5, 2, -2))
    @addVertex(new Vector3( 2.5, 2,  4))
    @addVertex(new Vector3(-2.5, 2,  4))

    @addVertex(new Vector3(-1.5, 2, -1))
    @addVertex(new Vector3( 1.5, 2, -1))
    @addVertex(new Vector3( 1.5, 2,  3))
    @addVertex(new Vector3(-1.5, 2,  3))

    @addVertex(new Vector3(-1.5, 4, -1))
    @addVertex(new Vector3( 1.5, 4, -1))
    @addVertex(new Vector3( 1.5, 4,  3))
    @addVertex(new Vector3(-1.5, 4,  3))

    @addVertex(new Vector3(-0.4, 2.6, -1))
    @addVertex(new Vector3( 0.4, 2.6, -1))
    @addVertex(new Vector3( 0.4, 3.4, -1))
    @addVertex(new Vector3(-0.4, 3.4, -1))
    
    @addVertex(new Vector3(-0.4, 2.6, -7))
    @addVertex(new Vector3( 0.4, 2.6, -7))
    @addVertex(new Vector3( 0.4, 3.4, -7))
    @addVertex(new Vector3(-0.4, 3.4, -7))
    
    @indices = [
      0,1, 1,2, 2,3, 3,0,
      4,5, 5,6, 6,7, 7,4,
      0,4, 1,5, 2,6, 3,7,
      8,9, 9,10, 10,11, 11,8, 
      12,13, 13,14, 14,15, 15,12,
      8,12, 9,13, 10,14, 11,15,
      16,17, 17,18, 18,19, 19,16,
      20,21, 21,22, 22,23, 23,20,
      16,20, 17,21, 18,22, 19, 23
    ]

class TankNode extends Node
  constructor: ->
    super new TankBodyModel
    @radarNode = new Node(new TankRadarModel)
    @radarNode.transform.translate(new Vector3(0,4,1))
    @addChild(@radarNode)

  onUpdate: (step) ->
    @radarNode.transform.rotateY( step * 5 )

class TankRadarModel extends Model
  constructor: ->
    super
    @color = Renderer.RED
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
    @color = Renderer.GREEN
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

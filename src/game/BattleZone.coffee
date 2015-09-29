class BattleZone
  @MOVESPEED = 20
  @ROTATIONSPEED = 0.7

  @TANKCOLLIDER = new Sphere(new Vector3(0,2,0), 3.5)
  @BULLETCOLLIDER = new Sphere(new Vector3(0, 0, 0), 1.0)

  constructor: ->
    @renderer = new Renderer()
    @hud = new Hud()
    @hudMessages = new HudMessages()
    @rootNode = new Node()
    @skyboxNode = new Node()
    @sceneNode = new Node()
    @cameraRotationNode = new Node()
    @cameraTranslationNode = new Node()
    @position = new Vector3(0, 3, 30)
    @rotation = 0    

    @cameraTranslationNode.addChild(@sceneNode)
    @cameraRotationNode.addChild(@cameraTranslationNode)

    @rootNode.addChild(@skyboxNode)
    @rootNode.addChild(@cameraRotationNode)
    
    @skyboxNode.addChild(new Node(new BackgroundHorizonModel))
    @skyboxNode.addChild(new Node(new BackgroundMountainsModel))

    @tanks = new Array()
    @bullets = new Array()

    for i in [0...20]
      tank = new TankNode()
      tank.transform.translateX( Math.floor( Math.random() * 600 ) - 300 )
      tank.transform.translateZ( Math.floor( Math.random() * 600 ) - 300 )
      @sceneNode.addChild(tank)
      @tanks.push tank
    
    @mainTank = new TankNode
    @sceneNode.addChild(@mainTank)
    @sceneNode.addChild(new Node(new AxisModel))
    @tanks.push @mainTank

    @moveForward = false
    @moveBackward = false
    @moveLeft = false
    @moveRight = false
    @moveUp = false
    @moveDown = false
    @shoot = false;
    
    $(document).bind 'keydown', @onKeyDown
    $(document).bind 'keyup', @onKeyUp
        
    now = new Date().getTime()
    @last = now + 50
    @intervalID = setInterval @update, 50

  onKeyUp: (key) =>
    key.preventDefault()
    switch key.keyCode
      when 37 then @moveLeft = false
      when 39 then @moveRight = false
      when 38 then @moveForward = false
      when 40 then @moveBackward = false
      when 65 then @moveUp = false
      when 90 then @moveDown = false
      when 32 then @shoot = false
  
  onKeyDown: (key) =>
    key.preventDefault()  
    switch key.keyCode
      when 37 then @moveLeft = true
      when 39 then @moveRight = true
      when 38 then @moveForward = true
      when 40 then @moveBackward = true   
      when 65 then @moveUp = true
      when 90 then @moveDown = true
      when 32 then @shoot = true
          
  update: =>
    now = new Date().getTime()
    step = (now - @last) * 0.001 # step in seconds
    @last = now
    
    #if @moveLeft then @position.addThis Vector3.UNITX.mul -step * 0.02
    #if @moveRight then @position.addThis Vector3.UNITX.mul step * 0.02
    if @moveLeft then @rotation += -step * BattleZone.ROTATIONSPEED
    if @moveRight then @rotation += step * BattleZone.ROTATIONSPEED

    if @moveForward
      move_delta = -step * BattleZone.MOVESPEED
      @position.x += -Math.sin(@rotation) * move_delta
      @position.z += Math.cos(@rotation) * move_delta

    if @moveBackward 
      move_delta = step * BattleZone.MOVESPEED
      @position.x += -Math.sin(@rotation) * move_delta
      @position.z += Math.cos(@rotation) * move_delta

    if @moveUp then @position.addThis Vector3.UNITY.mul step * BattleZone.MOVESPEED
    if @moveDown then @position.addThis Vector3.UNITY.mul -step * BattleZone.MOVESPEED
    if @shoot
      @hudMessages.addMessage("bang!", Color.RED)
      direction = new Vector3(Math.sin(@rotation), 0, -Math.cos(@rotation))
      bullet = new BulletNode(direction)
      bullet.transform.setTranslation @position
      bullet.transform.rotateY(-@rotation)
      @sceneNode.addChild(bullet)
      @bullets.push bullet
      @shoot = false
      
    @renderer.clear()

    @renderer.drawText( 10, 20, @position )

    rotationQuat = Quaternion.fromAxisAngle(Vector3.UNITY, @rotation)

    # position indicates where the camera is, but instead of moving the camera we move the whole scene 
    # in the negated direction to get the same result
    @cameraTranslationNode.transform.setTranslation @position.invert()
    @cameraRotationNode.transform.setRotation rotationQuat

    # Skybox is only rotated and not moved to always stay at the same distance from the camera
    @skyboxNode.transform.setRotation rotationQuat

    @rootNode.update step 
    @rootNode.render @renderer

    @hud.render @renderer
    @hudMessages.update step
    @hudMessages.render @renderer

    #bullet collision test
    for bullet in @bullets
      bulletColliderPosition = bullet.getWorldTransform().transformVector3 BattleZone.BULLETCOLLIDER.position
      bulletCollider = new Sphere(bulletColliderPosition, BattleZone.BULLETCOLLIDER.radius)
      for tank in @tanks
        tankColliderPosition = tank.getWorldTransform().transformVector3 BattleZone.TANKCOLLIDER.position
        tankCollider = new Sphere(tankColliderPosition, BattleZone.TANKCOLLIDER.radius)
        if bulletCollider.intersects(tankCollider)
          @hudMessages.addMessage("Enemy hit!", Color.GREEN)
          @tanks = (x for x in @tanks when x != tank)
          tank.remove()

          @bullets = (x for x in @bullets when x != bullet)
          bullet.remove()
    

    return true

class AxisModel extends Model
  constructor: ->
    super
    @renderMode = "lines"
    @addVertex new Vector3(0,0,0)
    @addVertex new Vector3(1,0,0)
    @addVertex new Vector3(0, 1, 0)
    @addVertex new Vector3(0, 0, -1)
    @indices = [0,1,0,2,0,3]
    
class Tester
  constructor: ->
    renderer = new Renderer()
    i = -2
    while i < -1 
      res = renderer.pipeline.transform new Vector3(1, 0, i)
      if res.z > -1 and res.z < 1
        alert res
      i += 0.01
        
#new Tester()    

$? -> new BattleZone()


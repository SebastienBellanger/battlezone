class BattleZone
  constructor: ->
    @renderer = new Renderer()
    @axisModel = new AxisModel()
    @backgroundModel = new BackgroundModel()
    
    @scene = new Array()
    for i in [0...10]
      tank = new Tank()
      tank.transform.translateX( Math.floor( Math.random() * 200 ) - 100 )
      tank.transform.translateZ( -Math.floor( Math.random() * 200 ) )
      tank.transform.rotateY( Math.random() * Math.PI )
      @scene.push tank
    @scene.push new Tank()    
 
    @position = new Vector3(0, 5, 30)
        
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
    step = now - @last
    @last = now
    
    if @moveLeft then @position.addThis Vector3.UNITX.mul -step * 0.02
    if @moveRight then @position.addThis Vector3.UNITX.mul step * 0.02
    if @moveForward then @position.addThis Vector3.UNITZ.mul -step * 0.02
    if @moveBackward then @position.addThis Vector3.UNITZ.mul step * 0.02
    if @moveUp then @position.addThis Vector3.UNITY.mul step * 0.02
    if @moveDown then @position.addThis Vector3.UNITY.mul -step * 0.02
    if @shoot
      bullet = new Bullet()
      bullet.transform.setTranslation @position
      @scene.push bullet
      @shoot = false
      
    @renderer.clear()
    
    @renderer.drawText( 10, 20, @position.negate() )
    
    # TODO: explain why negate is used. the scene objects seem to be in -z?
    @renderer.pipeline.viewMatrix.setTranslationV @position.negate()
    @renderer.pipeline.recalculateTransform()
     
    #@axisModel.render @renderer
    #@backgroundModel.render @renderer
    
    for sceneObject in @scene
      do (sceneObject) =>
        sceneObject.update step
        #sceneObject.transform.RotateY step * 0.022
        sceneObject.render @renderer    
      
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


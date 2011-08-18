class BattleZone
  constructor: ->
    @renderer = new Renderer()
    @axisModel = new AxisModel()
    
    @tankArray = new Array()
    for i in [0...10]
      tank = new Tank()
      tank.transform.translateX( Math.floor( Math.random() * 200 ) - 100 )
      tank.transform.translateZ( -Math.floor( Math.random() * 200 ) )
      tank.transform.rotateY( Math.random() * Math.PI )
      @tankArray.push tank
    @tankArray.push new Tank()
        
    @moveUp = false
    @moveDown = false
    @moveLeft = false
    @moveRight = false
    @moveIn = false
    @moveOut = false
    
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
      when 38 then @moveUp = false
      when 40 then @moveDown = false
      when 65 then @moveIn = false
      when 90 then @moveOut = false
  
  onKeyDown: (key) =>
    key.preventDefault()  
    switch key.keyCode
      when 37 then @moveLeft = true
      when 39 then @moveRight = true
      when 38 then @moveUp = true
      when 40 then @moveDown = true   
      when 65 then @moveIn = true
      when 90 then @moveOut = true
          
  update: =>
    now = new Date().getTime()
    step = now - @last
    @last = now
    
    moveX = 0
    moveY = 0
    moveZ = 0
    
    if @moveLeft then moveX += step * 0.02
    if @moveRight then moveX -= step * 0.02
    if @moveUp then moveY -= step * 0.02
    if @moveDown then moveY += step * 0.02
    if @moveIn then moveZ += step * 0.02
    if @moveOut then moveZ -= step * 0.02
           
    @renderer.clear()
    
    
    @renderer.pipeline.viewMatrix.translate(moveX, moveY, moveZ)
    @renderer.pipeline.recalculateTransform()
     
    #@axisModel.render @renderer 
    for tank in @tankArray
      do (tank) =>
        tank.update step
        tank.transform.rotateY( step * 0.0001 )
        tank.render @renderer    
      
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
    
#new BattleZone()
    

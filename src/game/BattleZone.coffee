class BattleZone
  constructor: ->
    @renderer = new Renderer()
    @model = new Model()
    
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
    elapsed = now - @last
    @last = now
    
    moveX = 0
    moveY = 0
    moveZ = 0
    
    if @moveLeft then moveX += elapsed * 0.05
    if @moveRight then moveX -= elapsed * 0.05
    if @moveUp then moveY += elapsed * 0.05
    if @moveDown then moveY -= elapsed * 0.05
    if @moveIn then moveZ += elapsed * 0.05
    if @moveOut then moveZ -= elapsed * 0.05
    
    @model.transform.rotateY( elapsed * 0.001 )
    @model.transform.rotateX( elapsed * 0.002 )
       
    @renderer.clear()
    
    @renderer.pipeline.viewMatrix.translate(moveX, moveY, moveZ)
    @renderer.pipeline.recalculateTransform()
     
    @model.render @renderer
    
    return true

    
new BattleZone()
    

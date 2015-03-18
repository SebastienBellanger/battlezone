# Background consisting of horizon and (TODO) mountains and a volcano.
# TODO: clipping problems, perhaps horizon should be more fake than a distant circle.
class BackgroundMountainsModel extends Model
  constructor: ->
    super
    
    @color = Renderer.BLUE
    @renderMode = "lines"
    
    r = 400
    o = r/2
    c = 0

    for a in [0...2*Math.PI] by 0.1
      @addVertex new Vector3(r*Math.cos(a) - o, Math.random() * 20, r*Math.sin(a) - o)
      if (c>0) then @indices.push c
      @indices.push c++
    
    @indices.pop()

    @indices.push c - 1
    @indices.push 0

class BackgroundHorizonModel extends Model
  constructor: ->
    super
    
    @color = Renderer.BLUE
    @renderMode = "lines"
    
    r = 400
    o = r/2
    c = 0

    for a in [0...2*Math.PI] by 0.1
      @addVertex new Vector3(r*Math.cos(a) - o, 0, r*Math.sin(a) - o)
      if (c>0) then @indices.push c
      @indices.push c++
    
    @indices.pop()

    @indices.push c - 1
    @indices.push 0


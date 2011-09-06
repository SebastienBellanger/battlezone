# Represents orthogonal projection
# TODO: not sure if this is correct yet... needs to be verified.
class OrthoProjection
  constructor: (@left, @right, @top, @bottom, @near, @far) ->
    @matrixUpdated = true
    @matrix = new Matrix4()
    
  getMatrix: ->
    if @matrixUpdated
      w = @right - @left  
      h = @top - @bottom
      p = @far - @near

      x = ( @right + @left ) / w
      y = ( @top + @bottom ) / h
      z = ( @far + @near ) / p
      
      @matrix.set(
        2/w, 0,   0,    -x,
        0,   2/h, 0,    -y,
        0,   0,   -2/p, -z,
        0,   0,   0,    1
      )
      
      @matrixUpdated = false
    
    return @matrix

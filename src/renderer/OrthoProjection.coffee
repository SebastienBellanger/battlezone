# Represents orthogonal projection
# TODO: not sure if this is correct yet... needs to be verified.
class OrthoProjection
  constructor: (@left, @right, @top, @bottom, @near, @far) ->
    @matrixUpdated = true
    @matrix = new Matrix4()
    
  getMatrix: ->
    if @matrixUpdated
      
      # symmetric ortho projection calc
      A = 1 / @right
      B = 1 / @top
      C = -2 / (@far - @near)
      D = - ((@far + @near) / (@far - @near))
      
      @matrix.set(
        A, 0, 0, 0,
        0, B, 0, 0,
        0, 0, C, D,
        0, 0, 0, 1
      )
      
      @matrixUpdated = false
    
    return @matrix

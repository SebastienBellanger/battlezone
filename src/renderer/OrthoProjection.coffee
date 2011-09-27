# Represents orthogonal projection
# TODO: not sure if this is correct yet... needs to be verified.
class OrthoProjection
  constructor: (@left, @right, @top, @bottom, @near, @far) ->
    @matrixUpdated = true
    @matrix = new Matrix4()
    
  getMatrix: ->
    if @matrixUpdated
      
      # ortho projection calc
      # TODO: this is general case calc, previously used symmetric ortho but couldn't get it to work
      
      w = @right - @left
      h = @top - @bottom
      p = @far - @near
      
      x = (@right + @left) / w
      y = (@top + @bottom) / h
      z = (@far + @near) / p
      
      A = 2 / w
      B = 2 / h
      C = -2 / p
      
      # TODO: find out why last component should be negative, seems more common with a positive here.
      @matrix.set(
        A, 0, 0, -x,
        0, B, 0, -y,
        0, 0, C, -z,
        0, 0, 0, -1
      )
      
      @matrixUpdated = false
    
    return @matrix

exports?.OrthoProjection = OrthoProjection

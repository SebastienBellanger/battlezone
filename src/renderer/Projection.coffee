class Projection
  constructor: (@viewWidth, @viewHeight, @near, @far, @fov) ->
    @matrixUpdated = true
    @matrix = new Matrix4()
    
  setView: (@viewWidth, @viewHeight) ->
    @matrixUpdated = true
    
  setNearFar: (@near, @far) ->
    @matrixUpdated = true
    
  # Set the field of view in degrees
  setFov: (@fov) ->
    @matrixUpdated
    
  getMatrix: ->
    if @matrixUpdated
      # Projection for a symetric view volume
      aspect = @viewHeight / @viewWidth
      farNearInv = 1.0 / (@far - @near)
      A = 1.0 / Math.tan( 0.5 * @fov * Math.PI / 360.0 )
      F = A / aspect
      K = -(@far + @near) * farNearInv
      L = -2.0 * @far * @near * farNearInv
      
      @matrix.set(
        A, 0, 0,  0,
        0, F, 0,  0,
        0, 0, K, -1,
        0, 0, L,  0
      )
      
      @matrixUpdated = false
    
    return @matrix

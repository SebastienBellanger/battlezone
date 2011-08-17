class Quaternion
  constructor: ->
    @i = 0
    @j = 0
    @k = 0
    @r = 1
    
  @fromSet: (i, j, k, r) ->
    quat = new Quaternion();
    quat.i = i
    quat.j = j
    quat.k = k
    quat.r = r
    return quat
    
  @fromAxisAngle: (vector3, radians) ->
    halfAngle = 0.5 * radians
    sinHalfAngle = Math.sin halfAngle
    return @fromSet(
      vector3.x * sinHalfAngle,
      vector3.y * sinHalfAngle,
      vector3.z * sinHalfAngle,
      Math.cos halfAngle
    )
    
  toMatrix: ->
    di = 2 * @i
    dj = 2 * @j
    dk = 2 * @k

    ii = di * @i
    ij = di * @j
    ik = di * @k
    xr = di * @r
    jj = dj * @j
    jk = dj * @k
    jr = dj * @r
    kr = dk * @r
    kk = dk * @k

    return Matrix4.fromSet(
      1 - (jj + kk), (ij - kr), (ik + jr), 0, # first row
      (ij + kr), 1 - (ii + kk), (jk - xr), 0, # second row
      (ik - jr), (jk + xr), 1 - (ii + jj), 0, # third row
              0,         0,             0, 1  # forth row      
    )
    
  set: (@i, @j, @k, @r) ->
  
  add: (rhs) ->
    return @fromSet(
      @i + rhs.i,
      @j + rhs.j,
      @k + rhs.k,
      @r + rhs.r
    )
    
  addThis: (rhs) ->
    @i += rhs.i
    @j += rhs.j
    @k += rhs.k
    @r += rhs.r
    
  sub: (rhs) ->
    return Quaternion.fromSet(
      @i - rhs.i,
      @j - rhs.j,
      @k - rhs.k,
      @r - rhs.r
    )
    
  subThis: (rhs) ->
    @i -= rhs.i
    @j -= rhs.j
    @k -= rhs.k
    @r -= rhs.r
    
  mul: (rhs) ->
    return Quaternion.fromSet(
      @r * rhs.i + @i * rhs.r + @j * rhs.k - @k * rhs.j,
      @r * rhs.j - @i * rhs.k + @j * rhs.r + @k * rhs.i,
      @r * rhs.k + @i * rhs.j - @j * rhs.i + @k * rhs.r,
      @r * rhs.r - @i * rhs.i - @j * rhs.j - @k * rhs.k
    )
    
  mulThis: (rhs) ->
    i = @r * rhs.i + @i * rhs.r + @j * rhs.k - @k * rhs.j
    j = @r * rhs.j - @i * rhs.k + @j * rhs.r + @k * rhs.i
    k = @r * rhs.k + @i * rhs.j - @j * rhs.i + @k * rhs.r
    r = @r * rhs.r - @i * rhs.i - @j * rhs.j - @k * rhs.k
    @set(i, j, k, r)
  
  negate: ->
    return Quaternion.fromSet(-@i, -@j, -@k, -@r)
    
  conjugate: ->
    return Quaternion.fromSet(-@i, -@j, -@k, @r)
    
  invert: ->
    squared = @i * @i + @j * @j + @k * @k + @r * @r
    squaredInv = 1.0 / squared
    return Quaternion.fromSet( -@i * squaredInv, -@j * squaredInv, -@k * squaredInv, @r * squaredInv )
    
  toString: ->
    return "Quaternion [#{@i},#{@j},#{@k},#{@r}]" 

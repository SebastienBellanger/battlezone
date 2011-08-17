class Vector4
  constructor: (@x, @y, @z, @w) ->
  
  @fromVector3: (vector, w) ->
    return new Vector4(vector.x, vector.y, vector.z, w)
    
  toVector3: ->
    if @w != 0
      wInv = 1.0 / @w
      return new Vector3(@x * wInv, @y * wInv, @z * wInv)
    return new Vector3(@x, @y, @z)
  
  addThis: (vector) ->
    @x += vector.x;
    @y += vector.y;
    @z += vector.z;
    @w += vector.w;
    
  subThis: (vector) ->
    @x -= vector.x;
    @y -= vector.y;
    @z -= vector.z;
    @w -= vector.w;
    
  mulThis: (scalar) ->
    @x *= scalar;
    @y *= scalar;
    @z *= scalar;
    @w *= scalar;
    
  divThis: (scalar) ->
    scalarInv = 1.0 / scalar;
    mul(scalarInv);
    
  dot: (vector) ->
    return @x * vector.x + @y * vector.y + @z * vector.z + @w * vector.w;
    
  lengthSquared: ->
    return dot(this);
    
  length: ->
    return Math.sqrt(lengthSquared()); 
    
  toString: ->
    return "Vector4 [#{@x},#{@y},#{@z},#{@w}]"    
    


class Vector4
  constructor: (@x, @y, @z, @w) ->
  
  add: (vector) ->
    @x += vector.x;
    @y += vector.y;
    @z += vector.z;
    @w += vector.w;
    
  sub: (vector) ->
    @x -= vector.x;
    @y -= vector.y;
    @z -= vector.z;
    @w -= vector.w;
    
  mul: (scalar) ->
    @x *= scalar;
    @y *= scalar;
    @z *= scalar;
    @w *= scalar;
    
  div: (scalar) ->
    scalarInv = 1.0 / scalar;
    mul(scalarInv);
    
  dot: (vector) ->
    return @x * vector.x + @y * vector.y + @z * vector.z + @w * vector.w;
    
  lengthSquared: ->
    return dot(this);
    
  length: ->
    return Math.sqrt(lengthSquared()); 
  

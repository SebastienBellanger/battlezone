class Vector3
  constructor: (@x, @y, @z) ->

  add: (vector) ->
    @x += vector.x;
    @y += vector.y;
    @z += vector.z;
    
  sub: (vector) ->
    @x -= vector.x;
    @y -= vector.y;
    @z -= vector.z;
    
  mul: (scalar) ->
    @x *= scalar;
    @y *= scalar;
    @z *= scalar;
    
  div: (scalar) ->
    @x /= scalar;
    @y /= scalar;
    @z /= scalar;
    
  lengthSquared: ->
    return dot(this);
    
  length: ->
    return Math.sqrt( lengthSquared() );
    
  normalize: ->
    lengthInv = 1.0 / length();
    mul(lengthInv);
    
  getNormalized: ->
    vector = new Vector3(@x, @y, @z);
    return vector.normalize();
    
  dot: (vector) ->
    return @x * vector.x + @y * vector.y + @z * vectory.z;
    
  cross: (vector) ->
    return new Vector3( 
      @y * vector.z - @z * vector.y,
      @z * vector.x - vector.x * @z,
      @x * vector.y - vextor.y * @x
    )
    
  toString: ->
    return "Vector3 [#{@x},#{@y},#{@z}]"

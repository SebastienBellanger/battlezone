class Vector3
  @UNITX = new Vector3(1, 0, 0)
  @UNITY = new Vector3(0, 1, 0)
  @UNITZ = new Vector3(0, 0, 1)

  constructor: (@x, @y, @z) ->
  
  set: (@x, @y, @z) ->

  addThis: (vector) ->
    @x += vector.x;
    @y += vector.y;
    @z += vector.z;
    
  subThis: (vector) ->
    @x -= vector.x;
    @y -= vector.y;
    @z -= vector.z;
    
  mulThis: (scalar) ->
    @x *= scalar;
    @y *= scalar;
    @z *= scalar;
    
  divThis: (scalar) ->
    @x /= scalar;
    @y /= scalar;
    @z /= scalar;
    
  lengthSquared: ->
    return dot(this);
    
  length: ->
    return Math.sqrt( lengthSquared() );
    
  normalizeThis: ->
    lengthInv = 1.0 / length();
    @mulThis(lengthInv);
    
  normalize: ->
    vector = new Vector3(@x, @y, @z);
    return vector.normalizeThis();
    
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

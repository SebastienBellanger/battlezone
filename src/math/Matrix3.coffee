class Matrix3
  constructor: ->
    @v = new Array(9);
    @identity();
    
  set: (v0, v1, v2, v3, v4, v5, v6, v7, v8) ->
    @v[0] = v0; @v[1] = v1; @v[2]  = v2;
    @v[3] = v3; @v[4] = v4; @v[5]  = v5;
    @v[6] = v6; @v[7] = v7; @v[8]  = v8;
    
  identity: ->
    @v[0] = 1; @v[1] = 0; @v[2] = 0;
    @v[3] = 0; @v[4] = 1; @v[5] = 0; 
    @v[6] = 0; @v[7] = 0; @v[8] = 1;
    
  mul: (matrix) ->
    result = new Matrix4();
    for c in [0...3]
      do (c) =>
        for r in [0...3]
          do (r) =>
            result.v[r + 3 * c] = 0
            for i in [0...3]
              do (i) =>
                result.v[r + 3 * c] += @v[r + 3 * i] * matrix.v[i + 3 * c]
    return result;
                 
  setScaling: (x, y, z) ->
    @identity();
    @scale(x, y, z);
    
  scale: (x, y, z) ->
    @v[0] *= x;
    @v[5] *= y;
    @v[10] *= z;
  
  scaleUniform: (scalar) ->
    @scale(scalar, scalar, scalar);
    
  transform: (vector) ->
    return new Vector3(
      vector.x * @v[0] + vector.y * @v[3] + vector.z * @v[6],
      vector.x * @v[1] + vector.y * @v[4] + vector.z * @v[7],
      vector.x * @v[2] + vector.y * @v[5] + vector.z * @v[8]
    )
    
  toString: ->
    return "Matrix3 [#{@v[0]},#{@v[1]},#{@v[2]},#{@v[3]},#{@v[4]},#{@v[5]},#{@v[6]},#{@v[7]},#{@v[8]}]"

exports?.Matrix3 = Matrix3

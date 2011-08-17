class Matrix4
  constructor: ->
    @v = new Array(16);
    @identity();
    
  @fromSet: (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15) ->
    matrix = new Matrix4()
    matrix.v[0]  = v0;  matrix.v[1]  = v1;  matrix.v[2]  = v2;  matrix.v[3]  = v3;
    matrix.v[4]  = v4;  matrix.v[5]  = v5;  matrix.v[6]  = v6;  matrix.v[7]  = v7;
    matrix.v[8]  = v8;  matrix.v[9]  = v9;  matrix.v[10] = v10; matrix.v[11] = v11;
    matrix.v[12] = v12; matrix.v[13] = v13; matrix.v[14] = v14; matrix.v[15] = v15;
    return matrix
    
  set: (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15) ->
    @v[0]  = v0;  @v[1]  = v1;  @v[2]  = v2;  @v[3]  = v3;
    @v[4]  = v4;  @v[5]  = v5;  @v[6]  = v6;  @v[7]  = v7;
    @v[8]  = v8;  @v[9]  = v9;  @v[10] = v10; @v[11] = v11;
    @v[12] = v12; @v[13] = v13; @v[14] = v14; @v[15] = v15;
    
  identity: ->
    @v[0]  = 1; @v[1]  = 0; @v[2]  = 0; @v[3]  = 0;
    @v[4]  = 0; @v[5]  = 1; @v[6]  = 0; @v[7]  = 0;
    @v[8]  = 0; @v[9]  = 0; @v[10] = 1; @v[11] = 0;
    @v[12] = 0; @v[13] = 0; @v[14] = 0; @v[15] = 1;
    
  mul: (matrix) ->
    result = new Matrix4();
    for c in [0...4]
      do (c) =>
        for r in [0...4]
          do (r) =>
            result.v[r + 4 * c] = 0
            for i in [0...4]
              do (i) =>
                result.v[r + 4 * c] += @v[r + 4 * i] * matrix.v[i + 4 * c]
    return result;
             
  setTranslation: (x, y, z) ->
    @identity();
    @v[12] = x;
    @v[13] = y;
    @v[14] = z;
    
  setTranslationV: (vector3) ->
    @identity()
    @v[12] = vector3.x
    @v[13] = vector3.y
    @v[14] = vector3.z
    
  translate: (x, y, z) ->
    @v[12] += x;
    @v[13] += y;
    @v[14] += z;
    
  translateV: (vector3) ->
    @v[12] += vector3.x
    @v[13] += vector3.y
    @v[14] += vector3.z
    
  setScaling: (x, y, z) ->
    @identity();
    @scale(x, y, z);
    
  setScalingV: (vector3) ->
    @identity()
    @scale(vector3.x, vector3.y, vector3.z)
    
  scale: (x, y, z) ->
    @v[0] *= x;
    @v[5] *= y;
    @v[10] *= z;
    
  scaleV: (vector3) ->
    @scale(vector3.x, vector3.y, vector3.z)    
  
  scaleUniform: (scalar) ->
    @scale(scalar, scalar, scalar);    
    
  transform: (vector) ->
    return new Vector4(
      vector.x * @v[0] + vector.y * @v[4] + vector.z * @v[ 8] + vector.w * @v[12],
      vector.x * @v[1] + vector.y * @v[5] + vector.z * @v[ 9] + vector.w * @v[13],
      vector.x * @v[2] + vector.y * @v[6] + vector.z * @v[10] + vector.w * @v[14],
      vector.x * @v[3] + vector.y * @v[7] + vector.z * @v[11] + vector.w * @v[15]
    )    
    
  toString: ->
    return "Matrix4 [#{@v[0]},#{@v[1]},#{@v[2]},#{@v[3]},#{@v[4]},#{@v[5]},#{@v[6]},#{@v[7]},#{@v[8]},#{@v[9]},#{@v[10]},#{@v[11]},#{@v[12]},#{@v[13]},#{@v[14]},#{@v[15]}]"

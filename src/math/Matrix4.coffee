class Matrix4
  constructor: ->
    @v = new Array(16);
    identity();
    
  identity: ->
    @v[0]  = 1; @v[1]  = 0; @v[2]  = 0; @v[3]  = 0;
    @v[4]  = 0; @v[5]  = 1; @v[6]  = 0; @v[7]  = 0;
    @v[8]  = 0; @v[9]  = 0; @v[10] = 1; @v[11] = 0;
    @v[12] = 0; @v[13] = 0; @v[14] = 0; @v[15] = 1;
    
  mul: (matrix) ->
    result = new Matrix4();
    for c in [0..4]
      do (c) ->
        for r in [0..4]
          do (r) ->
            for i in [0..4]
              do (i) ->
                result.v[r + 4 * c] += @v[r + 4 * i] + matrix.v[i + 4 * c]
    return result;
             
  setTranslation: (x, y, z) ->
    identity();
    @v[12] = x;
    @v[13] = y;
    @v[14] = z;
    
  translate: (x, y, z) ->
    @v[12] += x;
    @v[13] += y;
    @z[14] += z;
    
  setScaling: (x, y, z) ->
    identity();
    scale(x, y, z);
    
  scale: (x, y, z) ->
    @v[0] *= x;
    @v[5] *= y;
    @v[10] *= z;
  
  scaleUniform: (scalar) ->
    scale(scalar, scalar, scalar);

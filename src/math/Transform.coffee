class Transform
  constructor: ->
    @translation = new Vector3(0, 0, 0)
    @rotation = new Quaternion()
    @scaling = new Vector3(1, 1, 1)
    @identity()
    
  identity: ->
    @noTranslation()
    @noRotation()
    @noScaling()
    
  noTranslation: ->
    @translation.set(0, 0, 0)
    
  translate: (vector3) ->
    @translation.addThis vector3
    
  translateX: (scalar) ->
    @translation.x += scalar
    
  translateY: (scalar) ->
    @translation.y += scalar
    
  translateZ: (scalar) ->
    @translation.z += scalar
 
  setTranslation: (vector3) ->
    @translation.setV(vector3)
        
  setTranslationX: (scalar) ->
    @translation.x = scalar
    
  setTranslationY: (scalar) ->
    @translation.y = scalar
    
  setTranslationZ: (scalar) ->
    @translation.z = scalar
    
  noRotation: ->
    @rotation = new Quaternion()
    
  rotate: (quat) ->
    @rotation = quat.mul @rotation
    
  rotateX: (radians) ->
    @rotate(Quaternion.fromAxisAngle(Vector3.UNITX, radians))
    
  rotateY: (radians) ->
    @rotate(Quaternion.fromAxisAngle(Vector3.UNITY, radians))

  rotateZ: (radians) ->
    @rotate(Quaternion.fromAxisAngle(Vector3.UNITZ, radians))

  setRotation: (quat) ->
    @rotation = quat

  noScaling: ->
    @scaling.set(1, 1, 1)
    
  scale: (vector3) ->
    @scaling.addThis vector3
    
  scaleX: (scalar) ->
    @scaling.x += scalar
    
  scaleY: (scalar) ->
    @scaling.y += scalar
    
  scaleZ: (scalar) ->
    @scaling.z += scalar

  scaleUniform: (scalar) ->
    @scaling.mulThis scalar
   
  setUniformScale: (scalar) ->
    @scaling.set(scalar, scalar, scalar) 
    
  setScaling: (vector3) ->
    @scaling = vector3
    
  getMatrix: ->
    translation = new Matrix4()
    translation.setTranslationV(@translation)
    
    rotation = @rotation.toMatrix()
    
    scaling = new Matrix4()
    scaling.setScalingV(@scaling)
    
    transform = rotation.mul scaling
    transform = translation.mul transform
    
    return transform

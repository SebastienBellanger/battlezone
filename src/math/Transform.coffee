class Transform
  constructor: ->
    @translation = new Vector3(0, 0, 0)
    @rotation = new Quaternion()
    @scaling = new Vector3(1, 1, 1)

    # optimization to only calculate the transform when needed
    @transform = null
    @dirty = true
    
  identity: ->
    @noTranslation()
    @noRotation()
    @noScaling()
    @dirty = true
    
  noTranslation: ->
    @translation.set(0, 0, 0)
    @dirty = true
    
  translate: (vector3) ->
    @translation.addThis vector3
    @dirty = true
    
  translateX: (scalar) ->
    @translation.x += scalar
    @dirty = true
    
  translateY: (scalar) ->
    @translation.y += scalar
    @dirty = true
    
  translateZ: (scalar) ->
    @translation.z += scalar
    @dirty = true
 
  setTranslation: (vector3) ->
    @translation.setV(vector3)
    @dirty = true
        
  setTranslationX: (scalar) ->
    @translation.x = scalar
    @dirty = true
    
  setTranslationY: (scalar) ->
    @translation.y = scalar
    @dirty = true
    
  setTranslationZ: (scalar) ->
    @translation.z = scalar
    @dirty = true

  noRotation: ->
    @rotation = new Quaternion()
    @dirty = true
    
  rotate: (quat) ->
    @rotation = quat.mul @rotation
    @dirty = true
    
  rotateX: (radians) ->
    @rotate(Quaternion.fromAxisAngle(Vector3.UNITX, radians))
    @dirty = true
    
  rotateY: (radians) ->
    @rotate(Quaternion.fromAxisAngle(Vector3.UNITY, radians))
    @dirty = true

  rotateZ: (radians) ->
    @rotate(Quaternion.fromAxisAngle(Vector3.UNITZ, radians))
    @dirty = true

  setRotation: (quat) ->
    @rotation = quat
    @dirty = true

  noScaling: ->
    @scaling.set(1, 1, 1)
    @dirty = true
    
  scale: (vector3) ->
    @scaling.addThis vector3
    @dirty = true
    
  scaleX: (scalar) ->
    @scaling.x += scalar
    @dirty = true
    
  scaleY: (scalar) ->
    @scaling.y += scalar
    @dirty = true
    
  scaleZ: (scalar) ->
    @scaling.z += scalar
    @dirty = true

  scaleUniform: (scalar) ->
    @scaling.mulThis scalar
    @dirty = true
   
  setUniformScale: (scalar) ->
    @scaling.set(scalar, scalar, scalar) 
    @dirty = true
    
  setScale: (vector3) ->
    @scaling = vector3
    @dirty = true

  setScaleX: (scalar) ->
    @scaling.x = scalar
    @dirty = true
  
  setScaleY: (scalar) ->
    @scaling.y = scalar
    @dirty = true

  setScaleZ: (scalar) ->
    @scaling.z = scalar 
    @dirty = true

  getMatrix: ->
    if not @dirty
      return @transform    

    translation = new Matrix4()
    translation.setTranslationV(@translation)
    
    rotation = @rotation.toMatrix()

    scaling = new Matrix4()
    scaling.setScalingV(@scaling)
    
    @transform = rotation.mul scaling
    @transform = translation.mul @transform
    @dirty = false
    
    return @transform

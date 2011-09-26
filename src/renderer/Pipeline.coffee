# vectex transform pipeline
class Pipeline
  constructor: ->
    @transformMatrix = new Matrix4()
    @viewMatrix = new Matrix4()
    @projectionMatrix = new Matrix4()
    @viewportMatrix = new Matrix3()
    @matrixStack = new Array()  
  
  setProjection: (matrix) ->
    @projectionMatrix = matrix
    @recalculateTransform()
    
  setView: (matrix) ->
    @viewMatrix = matrix
    @recalculateTransform()
        
  setViewport: (matrix) ->
    @viewportMatrix = matrix
    
  recalculateTransform: ->
    @transformMatrix = @projectionMatrix.mul @viewMatrix  
    
  addTransform: (matrix) ->
    @transformMatrix = @transformMatrix.mul matrix
  
  push: ->
    @matrixStack.push @transformMatrix
   
  pop: ->
    @transformMatrix = @matrixStack.pop()
    
  transform: (vector3) ->
    vector4 = Vector4.fromVector3 vector3, 1
    vector4Proj = @transformMatrix.transform vector4
    vector3Proj = vector4Proj.toVector3()
    vector3View = @viewportMatrix.transform vector3Proj
    return vector3View
    
exports?.Pipeline = Pipeline

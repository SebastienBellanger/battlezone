Vector3 = require('../../lib/battlezone').Vector3
Matrix3 = require('../../lib/battlezone').Matrix3
Matrix4 = require('../../lib/battlezone').Matrix4
Projection = require('../../lib/battlezone').Projection
OrthoProjection = require('../../lib/battlezone').OrthoProjection
Pipeline = require('../../lib/battlezone').Pipeline
Model = require('../../lib/battlezone').Model

describe "Math", ->
  it "should be able to create a Vector3", ->
    vector3 = new Vector3()

    expect(vector3).toBeDefined()

  it "should be able to perspective project a vector", ->
    model = new Model()
    model.addVertex new Vector3(0, 0, -10)
    model.addIndex 0
    
    width = 1
    height = 1
    position = new Vector3(0, 0, 0)
    
    projection = new Projection(width, height, 0, 1000, 80.0)
    viewMatrix = new Matrix4()
    
    viewportMatrix = new Matrix3()
    viewportMatrix.set( 
      width / 2, 0,  0
      0, -height / 2, 0,
      width / 2, height / 2, 1
    )
    
    pipeline = new Pipeline()
    pipeline.setProjection projection.getMatrix()
    pipeline.setView viewMatrix
    pipeline.setViewport viewportMatrix
    
    pipeline.viewMatrix.setTranslationV position.negate()
    pipeline.recalculateTransform()

    pipeline.push()  
    pipeline.addTransform model.transform.getMatrix()
    position = pipeline.transform model.vertices[0]
    pipeline.pop()

    expect(Math.round(position.x*10)/10).toEqual(0.5)
    expect(Math.round(position.y*10)/10).toEqual(0.5)
    
  it "should be able to ortho project a vector", ->
    model = new Model()
    model.addVertex new Vector3(0, 0, -10)
    model.addIndex 0
    
    width = 1
    height = 1
    position = new Vector3(0, 0, 0)
    
    projection = new OrthoProjection(0, 1, 1, 0, 0, 1000)
    viewMatrix = new Matrix4()
    
    viewportMatrix = new Matrix3()
    # TODO: find out why this viewport matrix works for ortho case (actually this is one I found as "standard" viewport matrix)
    viewportMatrix.set( 
      width / 2, 0         , width / 2,
      0        , height / 2, height / 2,
      0        , 0         , 1
    )
    
    pipeline = new Pipeline()
    pipeline.setProjection projection.getMatrix()
    pipeline.setView viewMatrix
    pipeline.setViewport viewportMatrix
    
    pipeline.viewMatrix.setTranslationV position.negate()
    pipeline.recalculateTransform()

    pipeline.push()  
    pipeline.addTransform model.transform.getMatrix()
    position = pipeline.transform model.vertices[0]
    pipeline.pop()

    expect(Math.round(position.x*10)/10).toEqual(0.5)
    expect(Math.round(position.y*10)/10).toEqual(0.5)
    
    # TODO: find out why the above assertions fail. (point is at -0.5 but I expect it to be at 0.5 which is in the middle)


Vector3 = require('../../lib/battlezone').Vector3
Projection = require('../../lib/battlezone').Projection
Renderer = require('../../lib/battlezone').Renderer
Model = require('../../lib/battlezone').Model

describe "Math", ->
  it "should be able to create a Vector3", ->
    vector3 = new Vector3()

    expect(vector3).toBeDefined()

  it "should be able to project a vector", ->
    renderer = new Renderer()
    
    @position = new Vector3(0, 0, 0)
    
    model = new Model()
    model.addVertex new Vector3(0, 0, -10)
    model.addIndex 0
    
    renderer.pipeline.viewMatrix.setTranslationV @position.negate()
    renderer.pipeline.recalculateTransform()

    renderer.pipeline.push()  
    renderer.pipeline.addTransform model.transform.getMatrix()
    position = renderer.pipeline.transform model.vertices[0]
    renderer.pipeline.pop()

    expect(Math.round(position.x*10)/10).toEqual(0.5)
    expect(Math.round(position.y*10)/10).toEqual(0.5)
    
    # TODO: find out why the above assertions fail. (point is at 0.4 but I expect it to be at 0.5 which is in the middle)


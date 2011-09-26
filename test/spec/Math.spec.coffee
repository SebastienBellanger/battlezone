Vector3 = require('../../lib/battlezone').Vector3

describe "Math", ->
  it "should be able to create a Vector3", ->
    vector3 = new Vector3()

    expect(vector3).toBeDefined();


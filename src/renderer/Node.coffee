class Node
	constructor: (@model = undefined) ->
		@transform = new Transform()
		@children = new Array()

	addChild: (childNode) ->
		@children.push childNode

	update: (step) ->
		@onUpdate step

		for childNode in @children
			do (childNode) =>
				childNode.update step

	render: (renderer) ->
		renderer.pipeline.push()
		renderer.pipeline.addTransform @transform.getMatrix()

		if @model		
			renderer.renderModel @model

		for childNode in @children
			do (childNode) =>
				childNode.render renderer

		renderer.pipeline.pop()

	onUpdate: (step) ->


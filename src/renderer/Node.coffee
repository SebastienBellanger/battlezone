class Node
	constructor: (@model = undefined) ->
		@transform = new Transform()
		@children = new Array()
		@parent = null

	addChild: (childNode) ->
		@children.push childNode
		childNode.parent = this

	removeChild: (childNode) ->
		@children = @children.filter (e) -> e != childNode

	remove: ->
		for childNode in @children
			do (childNode) =>
				childNode.remove
		@onRemove()
		if @parent != null
			@parent.removeChild(this)

	update: (step) ->
		@onUpdate step

		for childNode in @children
			do (childNode) =>
				childNode.update step

	getWorldTransform: ->
		if @parent == null
			return @transform.getMatrix()
		return @parent.getWorldTransform().mul @transform.getMatrix()

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

	onRemove: ->

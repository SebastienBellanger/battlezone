class Color
	@RED 	= new Color(1.0, 0.0, 0.0)
	@GREEN 	= new Color(0.0, 1.0, 0.0)
	@BLUE	= new Color(0.0, 0.0, 1.0)
	@BLACK	= new Color(0.0, 0.0, 0.0)
	@WHITE	= new Color(1.0, 1.0, 1.0)

	constructor: (@r, @g, @b, @a = 1.0) ->
		@r = Math.min(1.0, Math.max(0.0, @r))
		@g = Math.min(1.0, Math.max(0.0, @g))
		@b = Math.min(1.0, Math.max(0.0, @b))
		@a = Math.min(1.0, Math.max(0.0, @a))

	setA: (@a) ->
		@a = Math.min(1.0, Math.max(0.0, @a))

	copy: () ->
		return new Color(@r, @g, @b, @a)

	getColorString: ->
		intR = Math.floor(255 * @r)
		intG = Math.floor(255 * @g)
		intB = Math.floor(255 * @b)
		
		return "rgba(#{intR},#{intG},#{intB},#{@a})"
class Hud
	constructor: ->
		@hasTarget = false

	render: (renderer) ->
		c_x = renderer.width * 0.5
		c_y = renderer.height * 0.5

		o_y = 40
		o_w = 40

		color = Color.RED

		if @hasTarget 

	    	renderer.drawLine(c_x, c_y - o_y - 30, c_x, c_y - o_y, color) 
		    renderer.drawLine(c_x - o_w, c_y - o_y, c_x + o_w, c_y - o_y, color)
		    renderer.drawLine(c_x - o_w, c_y - o_y, c_x - o_w + 20, c_y - o_y + 20, color)
		    renderer.drawLine(c_x + o_w, c_y - o_y, c_x + o_w - 20, c_y - o_y + 20, color)

		    renderer.drawLine(c_x, c_y + o_y + 30, c_x, c_y + o_y, color) 
		    renderer.drawLine(c_x - o_w, c_y + o_y, c_x + o_w, c_y + o_y, color)
		    renderer.drawLine(c_x - o_w, c_y + o_y, c_x - o_w + 20, c_y + o_y - 20, color)
		    renderer.drawLine(c_x + o_w, c_y + o_y, c_x + o_w - 20, c_y + o_y - 20, color)

	    else

		    renderer.drawLine(c_x, c_y - o_y - 30, c_x, c_y - o_y, color) 
		    renderer.drawLine(c_x - o_w, c_y - o_y, c_x + o_w, c_y - o_y, color)
		    renderer.drawLine(c_x - o_w, c_y - o_y, c_x - o_w, c_y - o_y + 20, color)
		    renderer.drawLine(c_x + o_w, c_y - o_y, c_x + o_w, c_y - o_y + 20, color)

		    renderer.drawLine(c_x, c_y + o_y + 30, c_x, c_y + o_y, color) 
		    renderer.drawLine(c_x - o_w, c_y + o_y, c_x + o_w, c_y + o_y, color)
		    renderer.drawLine(c_x - o_w, c_y + o_y, c_x - o_w, c_y + o_y - 20, color)
		    renderer.drawLine(c_x + o_w, c_y + o_y, c_x + o_w, c_y + o_y - 20, color)

class HudMessages
	@FADEOUTTIME = 0.1
	@DEFAULTX = 10
	@DEFAULTY = 40
	@DEFAULTOFFSETY = 20

	instance = null

	constructor: ->
		if instance
			return instance
		else
			instance = this		

		@messageArray = new Array()
		@maxMessage = 5
		@timeToLive = 5

	addMessage: (text, color = Color.WHITE) ->
		if @messageArray.length > @maxMessage
			@messageArray.splice(0, 1)

		@messageArray.push( { text : text, color : color.copy(), timeToLive : @timeToLive } )

	update: (step) ->
		for message in @messageArray
			message.timeToLive -= step
			if message.timeToLive <= @timeToLive * HudMessages.FADEOUTTIME				
				alpha = message.timeToLive / (@timeToLive * HudMessages.FADEOUTTIME)
				message.color.setA(alpha)
		
		if @messageArray.length > 0 && @messageArray[0].timeToLive <= 0
			@messageArray.splice(0, 1)

	render: (renderer) ->
		for message, index in @messageArray
			x = HudMessages.DEFAULTX
			y = HudMessages.DEFAULTY + index * HudMessages.DEFAULTOFFSETY
			renderer.drawText( x, y, message.text, message.color )
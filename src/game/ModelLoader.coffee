class ModelLoader
	constructor: ->
	@FromString: (modelData) ->	
		model = new Model()
		model.renderMode = "lines"
		
		lines = modelData.split("\n")
		done = 0
		for line in lines
			words = line.split(" ")
			
			if words.length == 4 and words[0] == "v"
				v1 = parseFloat(words[1])
				v2 = parseFloat(words[2])
				v3 = parseFloat(words[3])

				if not isNaN(v1) and not isNaN(v2) and not isNaN(v3)					
					model.addVertex(new Vector3(v1, v2, v3))

			else if words.length > 0 and words[0] == "f"
				indexArray = new Array()
				lastWord = words.length - 1
				for i in [1..lastWord] by 1
					index = parseInt(words[i]) - 1
					if not isNaN(index)
						indexArray.push index
				lastIndex = indexArray.length - 1
				if lastIndex > 0 
					model.addIndex(indexArray[0])
					for j in [1..lastIndex] by 1
						model.addIndex(indexArray[j])
						model.addIndex(indexArray[j])
					model.addIndex(indexArray[0])

			else if words.length == 2 and words[0] == "color"
				model.color = words[1]					

		return model


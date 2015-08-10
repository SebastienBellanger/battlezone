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

			else if words.length == 4 and words[0] == "f"
				f1 = parseInt(words[1]) - 1
				f2 = parseInt(words[2]) - 1
				f3 = parseInt(words[3]) - 1
				
				if not isNaN(f1) and not isNaN(f2) and not isNaN(f3)
					model.addIndex(f1)
					model.addIndex(f2)
					model.addIndex(f2)
					model.addIndex(f3)
					model.addIndex(f3)
					model.addIndex(f1)

			else if words.length == 5 and words[0] == "f"
				f1 = parseInt(words[1]) - 1
				f2 = parseInt(words[2]) - 1
				f3 = parseInt(words[3]) - 1
				f4 = parseInt(words[4]) - 1
				
				if not isNaN(f1) and not isNaN(f2) and not isNaN(f3) and not isNaN(f4)
					model.addIndex(f1)
					model.addIndex(f2)
					model.addIndex(f2)
					model.addIndex(f3)
					model.addIndex(f3)
					model.addIndex(f4)
					model.addIndex(f4)
					model.addIndex(f1)


			else if words.length == 2 and words[0] == "color"
				model.color = words[1]					

		return model


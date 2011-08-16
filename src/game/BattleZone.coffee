class BattleZone
  constructor: ->
    outputSpan = document.getElementById "output"
    
    @vector = new Vector3(1,2,3);
    
    outputSpan.innerHTML = @vector
    

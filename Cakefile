fs     = require 'fs'
{exec} = require 'child_process'

appFiles  = [
  'math/Vector3'
  'math/Vector4'
  'math/Matrix3'
  'math/Matrix4'
  'math/Quaternion'
  'math/Transform'
  'renderer/Model'
  'renderer/Projection'
  'renderer/Pipeline'
  'renderer/Renderer'
  'game/BattleZone'
]

task 'build', 'Build single application file from source files', ->
  appContents = new Array remaining = appFiles.length
  for file, index in appFiles then do (file, index) ->
    fs.readFile "src/#{file}.coffee", 'utf8', (err, fileContents) ->
      if err
        console.log "Error reading #{file}"
        throw err
      appContents[index] = fileContents
      process() if --remaining is 0
  process = ->
    fs.writeFile 'lib/battlezone.coffee', appContents.join('\n\n'), 'utf8', (err) ->
      if err
        console.log "Error while writing lib/battlezone.coffe"
        throw err
      exec 'coffee --compile lib/battlezone.coffee', (err, stdout, stderr) ->
        if err
          console.log "Error while compiling lib/battlezone.coffee"
          throw err
        console.log stdout + stderr
        fs.unlink 'lib/battlezone.coffee', (err) ->
          throw err if err
          console.log 'Done.'

task 'minify', 'Minify the resulting application file after build', ->
  exec 'java -jar "compiler.jar" --js lib/battlezone.js --js_output_file lib/battlezone-min.js', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr


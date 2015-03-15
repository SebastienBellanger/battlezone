fs     = require 'fs'
{exec} = require 'child_process'

appFolders  = [
  'math'
  'renderer'
  'game'
]


String::endsWith = (str) -> if @match(new RegExp "#{str}$") then true else false

task 'build', 'Build single application file from source files', ->
  build = ->
    appContents = new Array
    for folder in appFolders then do (folder) ->
      fullPath = "src/#{folder}/"
      files = fs.readdirSync fullPath
      for file in files then do (file) ->
        if file.endsWith ".coffee"
          fileContents = fs.readFileSync "#{fullPath}#{file}", 'utf8'
          appContents.push fileContents
    process appContents
  
  process = (appContents) ->
    fs.exists 'lib', (exists) ->
      if not exists
        fs.mkdir 'lib'
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

  build()

task 'minify', 'Minify the resulting application file after build', ->
  exec 'java -jar "compiler.jar" --js lib/battlezone.js --js_output_file lib/battlezone-min.js', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr


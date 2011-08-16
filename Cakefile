fs     = require 'fs'
{exec} = require 'child_process'

appFolders = [
  'math'
  'game'
]

outputDir = "public/lib/"

String::endsWith = (str) -> if @match(new RegExp "#{str}$") then true else false

task 'build', 'build the project', ->

  process = (libFolder, libContents) ->
    outputFile = "#{outputDir}#{libFolder}.coffee"
    fs.writeFile outputFile, libContents.join('\n\n'), 'utf8', (err) ->
      throw err if err
      exec "coffee -c -b #{outputFile}", (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr
        fs.unlink outputFile, (err) ->
          throw err if err
          console.log "Built library #{libFolder}"

  for libFolder in appFolders then do (libFolder) ->
    libPath = "src/#{libFolder}/"
    libContents = new Array
    files = fs.readdirSync libPath
    for file, index in files then do (file, index) ->
      if file.endsWith(".coffee")
        fileContents = fs.readFileSync "#{libPath}#{file}", 'utf8'
        libContents[index] = fileContents
    process(libFolder, libContents)
 
       

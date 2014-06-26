
{spawn} = require 'child_process'

app = null

#    "nw": "NODE_PATH=src:avocado/src:node_modules distribution/nw `pwd`",

env = process.env
env.NODE_PATH = 'src:avocado/src:node_modules'
env.watching = true

options =
	
	stdio: 'inherit'
	env: env

closeParent = -> process.exit 0

spawnApp = ->
	
	app = spawn 'distribution/nw', [process.cwd()], options
	app.on 'exit', closeParent

# Hot reload the engine when source files change.
{Gaze} = require 'gaze'
gaze = new Gaze [
	'avocado/src/**/*.js'
	'avocado/src/**/*.coffee'
	'src/**/*.js'
	'src/**/*.coffee'
	'ui/**/*.html'
	'ui/**/*.css'
	'index-nw.html'
]

gaze.on 'all', (event, filepath) ->
	
	console.log 'Source changed...'
	
	app.removeListener 'exit', closeParent
	app.on 'exit', -> spawnApp()

	app.kill()
	
spawnApp()

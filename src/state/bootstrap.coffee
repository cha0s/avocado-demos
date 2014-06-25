
AbstractState = require 'avo/state/abstractState'
Animation = require 'avo/graphics/animation'
color = require 'avo/graphics/color'
Container = require 'avo/graphics/container'
Entity = require 'avo/entity'
Font = require 'avo/graphics/font'
input = require 'avo/input'
PIXI = require 'avo/vendor/pixi'
Promise = require 'avo/vendor/bluebird'
SortedList = require 'avo/vendor/SortedList'
Sound = require 'avo/sound'
Sprite = require 'avo/graphics/sprite'
Stage = require 'avo/graphics/stage'
Text = require 'avo/graphics/text'
timing = require 'avo/timing'
Vector = require 'avo/extension/vector'
window = require 'avo/graphics/window'

Environment = require 'avo/environment/2D'
Layer = require 'avo/environment/2D/tileLayer'
LayerView = require 'avo/environment/2D/layerView'

module.exports = class extends AbstractState

	initialize: ->
		
		@_stage = new Stage()
		
		# How we display a camera.
		@_container = new Container()
		
		input.registerKeyMovement()
		
		input.registerGamepadAxisMovement()
		input.registerGamepadButtonMovement()
		
		[width, height] = [60, 60]
		
		entity = new Entity()
		
		Promise.all([
			
			entity.extendTraits [
				type: 'corporeal'
				state:
					directionCount: 4
			,
				type: 'mobile'
				state:
					movingSpeed: 700
			,
				type: 'visible'
			,
				type: 'animated'
				state:
					animations:
						initial: uri: '/animations/environment-initial.animation.json'
						moving: uri: '/animations/environment-moving.animation.json'
			]
			
			(new Environment()).fromObject(
				rooms: [
					size: [width, height]
					tilesetUri: '/tileset/wb-forest.tileset.json'
				]
			)
				
		]).then ([@_entity, environment, animation]) =>
			
			@_entity.setPosition [200, 200]
	
			room = environment.room 0
			
			layer = room.layer 0
			
			for y in [0...height]
				for x in [0...width]
					
					layer.setTileIndex(
						if Math.random() < .5 then 1 else 50
						x, y
					)
					
			@_layerView = new LayerView()
			@_layerView.setLayer layer
			
			@_container.addChild @_layerView.container()
			@_container.addChild @_entity.optional 'localContainer'
			
			@_stage.addChild @_container
			
	tick: ->
		
		@_entity.move input.unitMovement()
		
		@_entity.tick()
		
	render: (renderer) ->
		
		renderer.render @_stage

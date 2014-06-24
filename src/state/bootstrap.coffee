
AbstractState = require 'avo/state/abstractState'
Animation = require 'avo/graphics/animation'
color = require 'avo/graphics/color'
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
window = require 'avo/graphics/window'

Environment = require 'avo/environment/2D'
Layer = require 'avo/environment/2D/tileLayer'
LayerView = require 'avo/environment/2D/layerView'

module.exports = class extends AbstractState

	initialize: ->
		
		@_stage = new Stage()
		@_container = new Stage new PIXI.DisplayObjectContainer()
		
		@_container.setPosition [100, 100]
		
		[width, height] = [60, 60]
		
		@_entity = new Entity()
		@_entity.extendTraits [
			type: 'corporeal'
		]
		
		Promise.all([
			
			(new Environment()).fromObject(
				rooms: [
					size: [width, height]
					tilesetUri: '/tileset/wb-forest.tileset.json'
				]
			)
				
			Font.load('/font/DroidSans.ttf')
			
			Animation.load(
				'/animations/environment-initial.animation.json'
			)
			
		]).then ([environment, text, animation]) =>
	
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
			
			@_stage.addChild @_layerView.container()
			
			
			text = new Text "Hello!"
			
			text.setFillColor color 255, 255, 255, .4
			text.setStrokeColor color 0, 0, 0
			text.setStrokeThickness 2
			
			@_stage.addChild text
			
			
			animation.setPosition [400, 400]
			animation.start()
			
			@_container.addChild animation.sprite()
			
			@_stage.addChild @_container
			
	tick: ->
		
	render: (renderer) ->
		
		renderer.render @_stage

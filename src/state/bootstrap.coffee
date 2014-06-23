
AbstractState = require 'avo/state/abstractState'
Animation = require 'avo/graphics/animation'
color = require 'avo/graphics/color'
Entity = require 'avo/entity'
Font = require 'avo/graphics/font'
PIXI = require 'avo/vendor/pixi'
Promise = require 'avo/vendor/bluebird'
SortedList = require 'avo/vendor/SortedList'
Sound = require 'avo/sound'
Sprite = require 'avo/graphics/sprite'
Text = require 'avo/graphics/text'
window = require 'avo/graphics/window'

Environment = require 'avo/environment/2D'
Layer = require 'avo/environment/2D/tileLayer'
LayerView = require 'avo/environment/2D/layerView'

module.exports = class extends AbstractState

	initialize: ->
		
		@_stage = new PIXI.Stage()
		
		[width, height] = [60, 60]
		
		@_entity = new Entity()
		@_entity.extendTraits [
			type: 'corporeal'
		,
			type: 'behavioral'
			state:
				routines:
					initial:
					
						rules: []
						actions: [
						
							selector: 'entity:parallel'
							args: [
								[
									actions: [
										selector: 'entity:lfo'
										args: [
											[
												literal:
													x:
													
														frequency: 2
														magnitude: 20
														median: 400
														modulators: [
															'Sine'
														]
														
											,
												literal: 2000						
											]
										]
									,
										selector: 'entity:lfo'
										args: [
											[
												literal:
													y:
													
														frequency: .25
														magnitude: 4
														median: 270
														modulators: [
															'Sine'
														]
														
											,
												literal: 2000						
											]
										]
									]
								]
							]
						]
		]
		
		context = @_entity.context()
		context['entity'] = @_entity
		context['test'] = foo: -> console.log 'yay'
		
		@_entity.setX 400
		
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
			@_layerView.addToStage @_stage
			
			
			text = new Text "Hello!"
			
			text.setFillColor color 255, 255, 255, .4
			text.setStrokeColor color 0, 0, 0
			text.setStrokeThickness 2
			
			text.addToStage @_stage
			
			
			animation.setPosition [400, 400]
			animation.start()
			
			animation.addToStage @_stage
			
	tick: ->
		
		@_entity.tick()
		@_layerView.setPosition @_entity.position()
	
	render: (renderer) ->
		
		renderer.render @_stage

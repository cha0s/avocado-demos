
AbstractState = require 'avo/state/abstractState'
Container = require 'avo/graphics/container'
Entity = require 'avo/entity'
input = require 'avo/input'
Promise = require 'avo/vendor/bluebird'
Stage = require 'avo/graphics/stage'

Environment = require 'avo/environment/2D'
LayerView = require 'avo/environment/2D/layerView'

module.exports = class WalkAround extends AbstractState

	initialize: ->
	
		@loading.show()
		
		@_stage = new Stage()
		
		# How we display a camera.
		@_container = new Container()
		
		input.registerMovement()
		
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
				
		]).then ([@_entity, environment]) =>
			
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
			
	enter: ->
		
		@loading.hide()
		
		input.on 'keyDown.WalkAround', ({keyCode, preventDefault, repeat}) =>
			
			switch keyCode
			
				when input.Key.Escape then @transitionToState 'main'
		
	leave: ->
		
		input.off '.WalkAround'
			
	tick: ->
		
		@_entity.move input.unitMovement()
		
		@_entity.tick()
		
	render: (renderer) ->
		
		renderer.render @_stage

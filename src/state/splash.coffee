
Image = require 'avo/graphics/image'
PIXI = require 'avo/vendor/pixi'
Sprite = require 'avo/graphics/sprite'

AbstractState = require 'avo/state/abstractState'
color = require 'avo/graphics/color'
config = require 'avo/config'
Stage = require 'avo/graphics/stage'
Vector = require 'avo/extension/vector'
window_ = require 'avo/graphics/window'

module.exports = class extends AbstractState
	
	initialize: ->
		
		@_stage = new Stage()
		@_stage.setBackgroundColor color 255, 255, 255
		
		Image.load('/logo.png').then (image) =>
			
			resolution = config.get 'graphics:resolution'
			
			position = Vector.scale Vector.sub(resolution, image.size()), .5
			
			sprite = new Sprite image
			sprite.setPosition position
			sprite.setAlpha 0
			sprite.addToStage @_stage
			
			setTimeout(
				=> sprite.transition(alpha: 1, 750).promise.then =>
					@transitionToState 'bootstrap'
				250
			)
			
	render: (renderer) ->
		
		@_stage.renderWith renderer

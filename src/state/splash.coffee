
AbstractState = require 'avo/state/abstractState'
ui = require 'avo/ui'

module.exports = class extends AbstractState
	
	initialize: ->
		
		ui.load('splash/avocado').then (@_splash) =>
			@_splash.fadeUp().then =>
				setTimeout(
					=> @transitionToState 'main'
					250
				)
			
	leave: ->
		
		@_splash.hide()

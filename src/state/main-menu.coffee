
AbstractState = require 'avo/state/abstractState'
input = require 'avo/input'
ui = require 'avo/ui'

module.exports = class MainMenu extends AbstractState

	initialize: ->
		
		self = this
		
		@loading.show()
		
		ui.load('main-menu').then (@_mainMenu) =>
			
			@_mainMenu.on 'clickedDemo', (state) => @transitionToState state
		
	enter: ->
		
		@loading.hide()
		
		input.on 'keyDown.MainMenu', ({keyCode, preventDefault, repeat}) =>
			
			switch keyCode
			
				when input.Key.Escape then @quit()
		
		@_mainMenu.show()
		
	leave: ->
		
		input.off '.MainMenu'
		
		@_mainMenu.hide()

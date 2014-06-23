
AbstractState = require 'avo/state/abstractState'
input = require 'avo/input'

module.exports = class extends AbstractState
	
	initialize: ->
		
		# node-webkit keybindings.
		if global?
		
			{Window} = global.window.nwDispatcher.requireNwGui()
			window_ = Window.get()
			
			input.on 'keyDown', ({keyCode, preventDefault, repeat}) ->
				return if repeat
			
				switch keyCode
	
					# F11 - Fullscreen
					when input.KeyCode.F11 then window_.toggleFullscreen()
					
					# F12 - Dev tools
					when input.KeyCode.F12
						
						if window_.isDevToolsOpen()
							window_.closeDevTools()
						else
							window_.showDevTools()
					
				preventDefault()
		
		input.on 'keyDown', ({keyCode, preventDefault, repeat}) =>
			
			switch keyCode
			
				when input.KeyCode.Escape then @quit()
			
		@transitionToState 'splash'


AbstractState = require 'avo/state/abstractState'
config = require 'avo/config'
input = require 'avo/input'
ui = require 'avo/ui'

module.exports = class extends AbstractState
	
	initialize: ->
		
		if 'node-webkit' is config.get 'platform'
		
			{Window} = global.window.nwDispatcher.requireNwGui()
			window_ = Window.get()
			
			input.on 'keyDown', ({keyCode, preventDefault, repeat}) ->
				return if repeat
			
				switch keyCode
					
					# F5 - Reload
					when input.Key.F5 then window_.reloadDev()
			
					# F11 - Fullscreen
					when input.Key.F11 then window_.toggleFullscreen()
					
					# F12 - Dev tools
					when input.Key.F12
						
						if window_.isDevToolsOpen()
							window_.closeDevTools()
						else
							window_.showDevTools()
					
				preventDefault()
			
		# Create a loading screen for when states are initializing.
		ui.loadNode('/loading.html').then (node) =>
			
			AbstractState::loading = node
		
			@transitionToState 'splash'

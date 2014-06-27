
AbstractState = require 'avo/state/abstractState'

module.exports = class extends AbstractState
	
	initialize: ->
		
		display = new (require 'avo/ui/node') """
<h1 style="font-size: 70px">Baseline</h1>
<p style="font-size: 40px">
	If you don't know where to start, you might consider checking out
	<a href="https://github.com/cha0s/avocado-baseline">the avocado demos</a>
	for an idea of the kind of stuff you can do!
</p>
"""
		
		display.css 'background-color', 'white'
		display.show()
		
		uiContainer = require('avo/graphics/window').uiContainer()
		uiContainer.appendChild display.element()		

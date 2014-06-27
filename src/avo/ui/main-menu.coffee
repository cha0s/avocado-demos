
$ = require 'avo/vendor/jquery'
UiAbstract = require 'avo/ui/abstract'

module.exports = class UiMainMenu extends UiAbstract
	
	constructor: (@_node) ->
		super
		
		self = this
		
		@_node.find('.demos a').each ->
			
			# Suppress default link behavior.
			$(this).attr 'href', 'javascript: void 0;'
			
			# Emit an event when a demo is clicked.
			$(this).on 'click', ->
				self.emit 'clickedDemo', $(this).data 'state'


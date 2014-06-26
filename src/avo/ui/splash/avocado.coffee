
Node = require 'avo/ui/node'
UiAbstract = require 'avo/ui/abstract'

module.exports = class UiSplashAvocado extends UiAbstract
	
	constructor: (@_node) ->
		super
		
		self = this
		
		@_logo = new Node @_node.find('.logo')[0]
		
		@show()
		
	fadeUp: ->
		
		@_logo.transition(opacity: 1, 750).promise

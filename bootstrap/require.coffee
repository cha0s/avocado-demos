# Implement require in the spirit of NodeJS.

__avocadoModules = {}

_resolveModuleName = (name, parentFilename) ->
	
	tried = [parentFilename]
	
	checkModuleName = (name) ->
		tried.push name
		return name if __avocadoModules[name]
		tried.push "#{name}/index"
		return "#{name}/index" if __avocadoModules["#{name}/index"]?
		
	return checked if (checked = checkModuleName name)?
	
	# Resolve relative paths.
	path = _require 'avo/vendor/node/path'
	return checked if (checked = checkModuleName(
		path.resolve(
			path.dirname parentFilename
			name
		).substr 1
	))?
	
	throw new Error "Cannot find module '#{name}'"

_require = (name, parentFilename) ->
	
	name = _resolveModuleName name, parentFilename
	
	unless __avocadoModules[name].module?
		exports = {}
		module = exports: exports
		
		f = __avocadoModules[name]
		__avocadoModules[name] = module: module
		
		path = _require 'avo/vendor/node/path'
		
		# Need to check for dirname, since when 'path' is required the first
		# time, it won't be available.
		__dirname = (path.dirname? name) ? ''
		__filename = name
		
		f(
			module, exports
			(name) -> _require name, __filename
			__dirname, __filename
		)
		
	__avocadoModules[name].module.exports

@require = (name) -> _require name, ''

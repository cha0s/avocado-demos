
path = require 'path'

module.exports = (grunt) ->

	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		
		coffee:
			
			modules:
				files: [
					src: [
						'src/**/*.coffee'
						'!**/*.spec.coffee'
					]
					dest: 'build/raw/dev'
					expand: true
					ext: '.js'
				]
			
			bootstrap:
				files: [
					src: [
						'bootstrap/**/*.coffee'
					]
					dest: 'build/raw/dev'
					ext: '.js'
					expand: true
				]
				
				options:
					bare: true
		
		concat:
			baseline:
				src: [
					'build/raw/dev/bootstrap/**/*.js'
					'avocado/build/wrapped/dev/**/*.js'
					'build/wrapped/dev/**/*.js'
				]
				dest: 'build/index.js'
		
			nw:
				
				src: [
					'distribution/nw'
					'build/baseline.nw'
				]
				dest: 'distribution/baseline'
				
				options:
					binary: true
		
		copy:
			nwDev:
				files: [
					cwd: 'avocado/build/raw/dev/'
					src: ['**/*.js']
					dest: 'build/node_modules'
					expand: true
				,
					cwd: 'build/raw/dev/src/'
					expand: true
					src: ['**/*.js']
					dest: 'build/node_modules'
				]
		
			nwProduction:
				files: [
					cwd: 'avocado/build/raw/production/'
					src: ['**/*.js']
					dest: 'build/node_modules'
					expand: true
				,
					cwd: 'build/raw/production/src/'
					expand: true
					src: ['**/*.js']
					dest: 'build/node_modules'
				]

		subgrunt:
			avocadoDev:
				avocado: ['default']
					
			avocadoProduction:
				avocado: ['production']
		
		uglify:
			baseline:

				files: [
					expand: true
					cwd: 'build/raw/dev'
					src: '**/*.js'
					dest: 'build/raw/production'
				]
					
		wrap:
			
			modules:
			
				files: [
					cwd: 'build/raw/dev/src'
					expand: true
					src: ['**/*.js']
					dest: 'build/wrapped/dev/'
				]
			
				options:
					wrapper: (filepath) ->
						
						moduleName = filepath.substr 'build/raw/dev/src/'.length
						dirname = path.dirname moduleName
						extname = path.extname moduleName
						moduleName = "#{dirname}/#{path.basename moduleName, extname}"
					
						if moduleName?
							["__avocadoModules['#{moduleName}'] = function(module, exports, require, __dirname, __filename) {\n", '};\n']
						else
							['', '']
							
			global:
				
				files: [
					src: ['build/index.js']
					dest: 'build/index.js'
				]
				
				options:
					wrapper: ['(function() {\n', "require('avo/main');\n\n})();"]
			
		zip:
			nw:
				router: (filename) ->
					filename.replace 'build/node_modules', 'node_modules'

				src: [
					'node_modules/coffee-script/**'
					'build/node_modules/**'
					'resource/**'
					'index-nw.html'
					'package.json'
					'style.css'
				]
				dest: 'build/baseline.nw'
				
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-subgrunt'
	grunt.loadNpmTasks 'grunt-wrap'
	grunt.loadNpmTasks 'grunt-zip'
	
	grunt.registerTask 'dev', ['coffee:modules', 'coffee:bootstrap', 'wrap:modules', 'concat:baseline', 'wrap:global']
	grunt.registerTask 'production', ['subgrunt:avocadoProduction', 'dev', 'uglify']

	grunt.registerTask 'nw', ['default', 'copy:nwDev', 'zip:nw', 'concat:nw']
	grunt.registerTask 'nwProduction', ['production', 'copy:nwProduction', 'zip:nw', 'concat:nw']
	
	grunt.registerTask 'default', ['subgrunt:avocadoDev', 'dev']
	
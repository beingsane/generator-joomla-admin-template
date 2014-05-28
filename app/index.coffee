###
	generator-joomla-admin-template

	index.coffee

	@author Sean
	
	@note Created on 2014-05-27 by PhpStorm
	@note uses Codoc
	@see https://github.com/coffeedoc/codo
###

"use strict"

util = require("util")
path = require("path")
yeoman = require("yeoman-generator")
yosay = require("yosay")
chalk = require("chalk")

JoomlaAdminTemplateGenerator = yeoman.generators.Base.extend(
	init: ->
		@pkg = require("../package.json")
		@on "end", ->
			@installDependencies() unless @options["skip-install"]

	askFor: ->
		done = @async()

		# Have Yeoman greet the user.
		@log yosay("Welcome to the marvelous JoomlaAdminTemplate generator!")
		prompts = [
			{
				name: "description"
				message: "Describe your component"
				default: "A sample description"
			}
			{
				name: "name"
				message: "What's the template's name?"
				default: "default-value"
			}
			{
				name: "authorName"
				message: "What's your name?"
				default: "Author name"
			}
			{
				name: "authorEmail"
				message: "What's your e-mail?"
				default: "email@somedomain.com"
			}
			{
				name: "authorURL"
				message: "What's your website?"
				default: "somedomain.com"
			}
			{
				name: "license"
				message: "What's the copyright license?"
				default: "MIT"
			}
			{
				type: "confirm",
				name: "includejQuery",
				message: "Use jQuery?"
			}
			{
				type: "confirm",
				name: "includeModernizr",
				message: "Use modernizr?"
			}
			{
				type: "confirm"
				name: "sassBoilerplate"
				message: "Use my sass boilerplate to quickly create base styles?"
			}
		]
		@prompt prompts, ((props) ->
			@description = props.description
			@name = props.name
			@authorName = props.authorName
			@authorEmail = props.authorEmail
			@authorURL = props.authorURL
			@license = props.license
			@requireManageRights = props.requireManageRights
			@sassBoilerplate = props.sassBoilerplate
			@includejQuery = props.includejQuery
			@includeModernizr = props.includeModernizr
			@currentDate = "September 11, 2003"
			done()
		).bind(this)

	app: ->
		@mkdir "app"
		@mkdir "app/templates"
		@template "_package.json", "package.json"
		@template "_bower.json", "bower.json"

	projectfiles: ->
		@copy "editorconfig", ".editorconfig"
		@copy "jshintrc", ".jshintrc"
	createLanguageFiles: ->
		@template "language/en-GB/_en-GB.tpl_template-name.ini", "languages/en-GB/en-GB.tpl_" + @_.slugify(@name) + ".ini"
		@template "language/en-GB/_en-GB.tpl_template-name.sys.ini", "languages/en-GB/en-GB.tpl_" + @_.slugify(@name) + ".sys.ini"

	createTemplateInfoFiles: ->
		@template "_templateDetails.xml", "templateDetails.xml"
	createRootPHPFiles: ->
		@template "_index.php", "index.php"
	createEmptyMVCFolders: ->
		folders = [
			"css"
			"scripts"
			"styles"
			"html"
			"bower_components"
		]
		folders.forEach (folderName) =>
			@mkdir folderName
			@template "_index.html", folderName + "/index.html"
)

module.exports = JoomlaAdminTemplateGenerator
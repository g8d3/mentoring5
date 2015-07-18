# Router.server = (path, f, opts = {}) ->
# 	Router.route path, f, _(where: 'server').extend(opts)

# Router.resources = (name) ->
#   @route name
Router.configure
	layoutTemplate: 'app'

Router.route '/root', ->
	@layout 'app'
	@render 'root'

@Files = new Meteor.Collection('files')

if Meteor.isServer
	Files.before.insert (userId, doc) ->
		fs = Meteor.npmRequire 'fs'
		fs.writeFile('../../../../../' + doc.path, doc.text, flags: 'w+')

@Files.qq = ->
	@insert path: 'tmp.txt', text: '<h1>test</h1>'

# Router.route '/app2'


if Meteor.isClient
	timeout = null
	Template.app.events
		'keyup body': ->
			Meteor.clearTimeout timeout if timeout
			console.log arguments
			save = ->
				# Files.insert(path: 'test2.html', text: "<template name='app2'>#{$('body').html()}</template>")
				Files.insert(path: 'test.html', text: "<template name='root'>#{$('body').html()}</template>")
			timeout = Meteor.setTimeout save, 1000
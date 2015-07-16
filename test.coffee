Router.server = (path, f, opts = {}) ->
	Router.route path, f, _(where: 'server').extend(opts)

# Router.resources = (name) ->
#   @route name
Router.configure
	layoutTemplate: 'app'

@Files = new Meteor.Collection('files')

Files.before.insert (userId, doc) ->
	fs = Meteor.require 'fs'
	fs.writeFile(doc.path, doc.text)

@Files.qq = ->
	@insert path: 'tmp.txt', '<h1>test</h1>'

Router.route '/save', ->
	console.log 'saving'
	@render 'test'
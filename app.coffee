express = require 'express'
app = module.exports = express.createServer()
staticsMiddleware = require './lib/middleware/statics'

app.configure () ->
	app.set 'views', "#{__dirname}/views"
	app.set 'view engine', 'jade'
	app.set 'view options', { 'with': 'locals' }
	app.use express.methodOverride()
	app.use express.bodyParser()
	app.use express.static "#{__dirname}/public"
	app.use staticsMiddleware.statics()
	app.use staticsMiddleware.globalStatics()
	app.use app.router
	app.use express.errorHandler { dumpExceptions: true, showStack: true }

reminders = []
app.get '/', (req, res) ->
	res.addScript 'home'
	res.render 'home', { req: req, reminders: reminders }


app.post '/reminders', (req, res) ->
	reminders.push(newReminder req)
	res.redirect '/'

app.listen process.env.PORT || 80

console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env

newReminder = (req) ->
	reminder =
		what: req.body.what
		month: req.body.month
		day: req.body.day
		year: req.body.year
		hours: req.body.hours
		minutes: req.body.minutes
		amPm: req.body.amPm
		reminderOffset: req.body.reminderOffset
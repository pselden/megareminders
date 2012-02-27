express = require 'express'
app = module.exports = express.createServer()
middleware = require './lib/middleware'
routes = require './routes'

app.configure () ->
	app.set 'views', "#{__dirname}/views"
	app.set 'view engine', 'jade'
	app.set 'view options', { 'with': 'locals' }
	app.use express.methodOverride()
	app.use express.cookieParser()
	app.use express.bodyParser()
	app.use express.static "#{__dirname}/public"
	app.use middleware.statics.statics()
	app.use middleware.statics.globalStatics()
	app.use middleware.currentUser()
	app.use app.router
	app.use express.errorHandler { dumpExceptions: true, showStack: true }

routes.register app

app.listen process.env.PORT || 80

console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env


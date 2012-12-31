express = require 'express'
app = module.exports = express()
middleware = require './lib/middleware'
routes = require './routes'
config = require './lib/config'

app.configure () ->
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'jade'
  app.use express.compress()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.cookieSession { key: 'session', secret: config.cookieSecret, proxy: true }
  app.use express.bodyParser()
  app.use express.query()
  app.use express.static "#{__dirname}/public"
  app.use middleware.statics.statics()
  app.use middleware.statics.globalStatics()
  app.use middleware.currentUser()
  app.use middleware.helpers()
  app.use app.router
  app.use express.errorHandler { dumpExceptions: true, showStack: true }

routes.register app

process.on 'uncaughtException', (err) ->
	console.log err.stack || err

app.listen process.env.PORT || 80

console.log "Express server started"


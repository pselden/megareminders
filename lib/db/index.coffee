pg = require 'pg'
config = require('../config')

# connects to the db and executes the query
exports.query = () ->
	args = arguments
	pg.connect config.dbConnection, (err, client) ->
		client.query.apply client, args
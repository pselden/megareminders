pg = require('pg').native
config = require('../config')

# connects to the db and executes the query
exports.query = () ->
	args = arguments
	console.log config.dbConnection
	pg.connect config.dbConnection, (err, client) ->
		console.log 'dberr'
		console.log err
		client.query.apply client, args
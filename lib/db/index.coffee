pg = require('pg')
config = require('../config')

# connects to the db and executes the query
exports.query = (query, callback) ->
	pg.connect config.dbConnection, (err, client, done) ->
		client.query query, (err, result) ->
      done()
      callback err, result

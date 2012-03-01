peristence = require '../persistence'

exports.getUserByUserId = (userId, callback) ->
	peristence.users.getUserByUserId userId, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.createUser = (callback) ->
	peristence.users.createUser (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]
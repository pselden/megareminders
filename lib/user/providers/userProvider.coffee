peristence = require '../persistence'

exports.getUserByUserId = (userId, callback) ->
	peristence.user.getUserByUserId userId, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.createUser = (callback) ->
	peristence.user.createUser callback
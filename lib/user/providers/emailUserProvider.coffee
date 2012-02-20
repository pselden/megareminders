peristence = require '../persistence'
bcyrpt = require 'bcrypt'

exports.getUserByEmail= (email, callback) ->
	peristence.user.getUserByUserId userId, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.createEmailUser = (userId, email, password, callback) ->
	salt = bcrypt.genSaltSync()
	passwordHash = bcrypt.hashSync password, salt

	peristence.user.createEmailUser userId, email, passwordHash, callback
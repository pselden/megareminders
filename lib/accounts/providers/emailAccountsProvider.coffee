persitence = require '../persistence'
bcrypt = require 'bcrypt'

exports.getEmailAccountByEmail= (email, callback) ->
	persitence.emailAccounts.getEmailAccountByEmail email, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.getEmailAccountByUserId= (userId, callback) ->
	persitence.emailAccounts.getEmailAccountByUserId userId, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.createEmailAccount = (userId, email, password, callback) ->
	bcrypt.gen_salt 10, (err, salt) ->
		bcrypt.encrypt password, salt, (err, hash) ->
			persitence.emailAccounts.createEmailAccount userId, email, hash, callback

# verifies the given email account
exports.verifyEmailAccount = (email, callback) ->
	persitence.emailAccounts.verifyEmailAccount email, callback
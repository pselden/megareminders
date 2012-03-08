persistence = require '../persistence'
bcrypt = require 'bcrypt'

exports.getEmailAccountByEmail= (email, callback) ->
	persistence.emailAccounts.getEmailAccountByEmail email, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.getEmailAccountByUserId= (userId, callback) ->
	persistence.emailAccounts.getEmailAccountByUserId userId, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.createEmailAccount = (userId, email, password, callback) ->
	try
		validator.check(email, 'Invalid email.').isEmail();
		validator.check(password, 'Invalid password.').is
		bcrypt.gen_salt 10, (err, salt) ->
		bcrypt.encrypt password, salt, (err, hash) ->
		persistence.emailAccounts.createEmailAccount userId, email, hash, callback
	catch err
		callback err



# verifies the given email account
exports.verifyEmailAccount = (email, callback) ->
	persistence.emailAccounts.verifyEmailAccount email, callback
db = require '../../db'

# gets the email account that has the given email address
exports.getEmailAccountByEmail = (email, callback) ->
	query =
		name: 'get email account by email'
		text: 'SELECT * FROM email_accounts WHERE email = $1'
		values: [email]
	db.query query, callback

# gets the email account by user id
exports.getEmailAccountByUserId = (userId, callback) ->
	query =
		name: 'get email account by user id'
		text: 'SELECT * FROM email_accounts WHERE user_id = $1'
		values: [userId]
	db.query query, callback

# creates an email account
exports.createEmailAccount = (userId, email, passwordHash, callback) ->
	query =
		name: 'create email account'
		text: 'INSERT INTO email_accounts (email, password_hash, user_id) VALUES ($1, $2, $3)'
		values: [email, passwordHash, userId]
	db.query query, callback

# marks the email account as verified
exports.verifyEmailAccount = (email, callback) ->
	query =
		name: 'verify email account'
		text: 'UPDATE email_accounts SET is_verified = $1'
		values: [true]
	db.query query, callback
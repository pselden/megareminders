db = require '../../../lib/db'

# gets the email user that has the given email address
exports.getEmailUserByEmail = (email, callback) ->
	query = {
		name: 'get email user by email'
		text: 'SELECT * FROM email_users WHERE email = $1'
		values: [email]
	}
	db.query query, callback

# creates an email user
exports.createEmailUser = (userId, email, passwordHash, callback) ->
	query = {
		name: 'create email user'
		text: 'INSERT INTO email_users (email, password_hash, user_id) VALUES ($1, $2, $3)'
		values: [email, passwordHash, email]
	}
	db.query query, callback
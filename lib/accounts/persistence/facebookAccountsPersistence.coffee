db = require '../../db'

# gets the facebook account that has the given facebook id
exports.getFacebookAccountByFacebookId = (facebookId, callback) ->
	query =
		name: 'get facebook account by facebook id'
		text: 'SELECT * FROM facebook_accounts WHERE facebook_id = $1'
		values: [facebookId]
	db.query query, callback

# gets the facebook account by user id
exports.getFacebookAccountByUserId = (userId, callback) ->
	query =
		name: 'get facebook account by user id'
		text: 'SELECT * FROM facebook_accounts WHERE user_id = $1'
		values: [userId]
	db.query query, callback

# creates a facebook account
exports.createFacebookAccount = (userId, facebookId, accessToken, callback) ->
	query =
		name: 'create facebook account'
		text: 'INSERT INTO facebook_accounts (facebook_id, token, user_id) VALUES ($1, $2, $3)'
		values: [facebookId, accessToken, userId]
	db.query query, callback
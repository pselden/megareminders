db = require '../../../lib/db'

# gets a user by user id
exports.getUserByUserId = (userId, callback) ->
	query =
		name: 'get user by user id',
		text: 'SELECT * from users WHERE user_id = $1',
		values: [userId]
	db.query query, callback

# creates a new user
exports.createUser = (callback) ->
	query =
		name: 'create user'
		text: 'INSERT INTO users DEFAULT VALUES RETURNING user_id'
	db.query query, callback

# deletes a user
exports.deleteUser = (userId, callback) ->
	query =
		name: 'delete user'
		text: 'DELETE FROM users WHERE user_id = $1'
		values: [userId]
	db.query query, callback
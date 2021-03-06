db = require '../../db'

# gets the twitter account that has the given twitter id
exports.getTwitterAccountByTwitterId = (twitterId, callback) ->
	query =
		name: 'get twitter account by twitter id'
		text: 'SELECT * FROM twitter_accounts WHERE twitter_id = $1'
		values: [twitterId]
	db.query query, callback

# gets the twitter account by user id
exports.getTwitterAccountByUserId = (userId, callback) ->
	query =
		name: 'get twitter account by user id'
		text: 'SELECT * FROM twitter_accounts WHERE user_id = $1'
		values: [userId]
	db.query query, callback

# creates a twitter account
exports.createTwitterAccount = (userId, twitterId, accessToken, accessTokenSecret, callback) ->
	query =
		name: 'create twitter user'
		text: 'INSERT INTO twitter_accounts (twitter_id, token, token_secret, user_id) VALUES ($1, $2, $3, $4)'
		values: [twitterId, accessToken, accessTokenSecret, userId]
	db.query query, callback
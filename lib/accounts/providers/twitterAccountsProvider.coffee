persistence = require '../persistence'

exports.getTwitterAccountByUserId = (userId, callback) ->
	persistence.twitterAccounts.getTwitterAccountByUserId userId, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.getTwitterAccountByTwitterId = (twitterId, callback) ->
	persistence.twitterAccounts.getTwitterAccountByTwitterId twitterId, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.createTwitterAccount = (userId, twitterId, accessToken, accessTokenSecret, callback) ->
	persistence.twitterAccounts.createTwitterAccount userId, twitterId, accessToken, accessTokenSecret, callback
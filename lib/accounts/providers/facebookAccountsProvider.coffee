persistence = require '../persistence'

exports.getFacebookAccountByFacebookId = (facebookId, callback) ->
	persistence.facebookAccounts.getFacebookAccountByFacebookId facebookId, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.getFacebookAccountByUserId = (userId, callback) ->
	persistence.facebookAccounts.getFacebookAccountByUserId userId, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.createFacebookAccount = (userId, facebookId, accessToken, callback) ->
	persistence.emailAccounts.createFacebookAccount userId, facebookId, accessToken, callback
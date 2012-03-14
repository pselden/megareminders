thirdPartyProviders = require '../../../thirdparty/providers'
twitterAccountsProvider = require '../twitterAccountsProvider'

exports.createAccount = (accountData, callback) ->
	thirdPartyProviders.twitter.getUser accountData.token, (err, user) ->
		if err
			callback err
		else
			twitterAccountsProvider.createTwitterAccount accountData.userId, user.externalId, accountData.token.token, accountData.token.secret, callback

exports.getAccountByUserId = (userId, callback) ->
	twitterAccountsProvider.getTwitterAccountByUserId userId, callback
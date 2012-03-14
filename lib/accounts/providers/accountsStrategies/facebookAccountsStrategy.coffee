thirdPartyProviders = require '../../../thirdparty/providers'
facebookAccountsProvider = require '../facebookAccountsProvider'

exports.createAccount = (accountData, callback) ->
	thirdPartyProviders.facebook.getUser accountData.token, (err, user) ->
		if err
			callback err
		else
			facebookAccountsProvider.createFacebookAccount accountData.userId, user.externalId, accountData.token.token, callback

exports.getAccountByUserId = (userId, callback) ->
	facebookAccountsProvider.getFacebookAccountByUserId userId, callback
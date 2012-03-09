thirdPartyProviders = require '../../../thirdparty/providers'
accountsProviders = require '../../../accounts/providers'

exports.signIn = (credentials, callback) ->
	thirdPartyProviders.facebook.getUser credentials.token, (err, user) ->
		if err
			callback err
		else
			accountsProviders.facebookAccounts.getFacebookAccountByFacebookId user.externalId, callback
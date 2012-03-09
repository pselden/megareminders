thirdPartyProviders = require '../../../thirdparty/providers'
accountsProviders = require '../../../accounts/providers'

exports.signIn = (credentials, callback) ->
	thirdPartyProviders.twitter.getUser credentials.token, (err, user) ->
		if err
			callback err
		else
			accountsProviders.twitterAccounts.getTwitterAccountByTwitterId user.externalId, callback
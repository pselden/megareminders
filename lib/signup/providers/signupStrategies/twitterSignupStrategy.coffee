thirdPartyProviders = require '../../../thirdparty/providers'
accountsProviders = require '../../../accounts/providers'

exports.signup = (signupData, callback) ->
	thirdPartyProviders.twitter.getUser signupData.token, (err, user) ->
		if err
			callback err
		else
			accountsProviders.twitterAccounts.createTwitterAccount signupData.userId, user.externalId, signupData.token.token, signupData.token.secret, callback
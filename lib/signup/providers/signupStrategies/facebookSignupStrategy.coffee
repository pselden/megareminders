thirdPartyProviders = require '../../../thirdparty/providers'
accountsProviders = require '../../../accounts/providers'

exports.signup = (signupData, callback) ->
	thirdPartyProviders.facebook.getUser signupData.token, (err, user) ->
		if err
			callback err
		else
			accountsProviders.facebookAccounts.createFacebookAccount signupData.userId, user.externalId, signupData.token.token, callback
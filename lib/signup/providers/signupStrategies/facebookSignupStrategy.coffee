accountsProviders = require '../../../accounts/providers'

exports.signup = (signupData, callback) ->
	accountsProviders.facebookAccounts.createFacebookAccount signupData.userId, signupData.externalId, signupData.token.token, callback
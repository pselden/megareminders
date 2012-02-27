accountsProviders = require '../../../accounts/providers'

exports.signup = (signupData, callback) ->
	accountsProviders.twitterAccounts.createTwitterAccount signupData.userId, signupData.externalId, signupData.token.token, signupData.token.secret, callback
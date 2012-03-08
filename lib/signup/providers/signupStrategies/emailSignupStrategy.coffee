accountsProviders = require '../../../accounts/providers'

exports.signup = (signupData, callback) ->
	accountsProviders.emailAccounts.createEmailAccount signupData.userId, signupData.email, signupData.password, callback

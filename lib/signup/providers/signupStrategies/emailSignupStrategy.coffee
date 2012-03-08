accountsProviders = require '../../../accounts/providers'
validator = require 'validator'

exports.signup = (signupData, callback) ->
	try
		validator.check(signupData.email).isEmail()
		validator.check(signupData.password).notEmpty()
		accountsProviders.emailAccounts.createEmailAccount signupData.userId, signupData.email, signupData.password, callback
	catch err
		callback err

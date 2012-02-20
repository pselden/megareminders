userProviders = require '../../../user/providers'

exports.signup = (signupData, callback) ->
	userProviders.email.createUser signupData.userId, signupData.email, signupData.password, callback
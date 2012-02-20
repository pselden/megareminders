userProviders = require '../../user/providers'
signupStrategies = require './signupStrategies'

#signs the user up using the given 
exports.signup = (signupData, signupType, callback) ->
	createUserCallback = (err, newUser) ->
		signupData.userId = newUser.user_id
		signupStrategy = signupStrategies[signupType]
		signupStrategy.signup signupData, callback

	userProviders.user.createUser createUserCallback

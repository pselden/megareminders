usersProviders = require '../../users/providers'
signupStrategies = require './signupStrategies'

#signs the user up using the given 
exports.signup = (signupData, signupType, callback) ->
	createUserCallback = (err, newUser) ->
		signupData.userId = newUser.user_id
		signupStrategy = signupStrategies[signupType.toLowerCase()]
		signupStrategy.signup signupData, (err, result) ->
			if err
				callback err
			else
				callback null, newUser

	usersProviders.users.createUser createUserCallback

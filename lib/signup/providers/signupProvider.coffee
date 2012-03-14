usersProviders = require '../../users/providers'
accountsProviders = require '../../accounts/providers'

#signs the user up using the given 
exports.signup = (signupData, accountType, callback) ->
	createUserCallback = (err, newUser) ->
		signupData.userId = newUser.user_id
		accountsProviders.accountsHelper.createAccount accountType, signupData, (err, result) ->
			if err
				# roll back the "transaction" by deleting the orphaned user
				usersProviders.users.deleteUser newUser.user_id, (deleteErr, result) ->
					callback err
			else
				callback null, newUser

	usersProviders.users.createUser createUserCallback

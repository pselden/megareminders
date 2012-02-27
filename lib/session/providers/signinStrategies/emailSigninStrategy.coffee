accountsProviders = require '../../../accounts/providers'
bcrypt = require('bcrypt')

exports.signIn = (credentials, callback) ->
	accountsProviders.emailAccounts.getEmailAccountByEmail credentials.email, (err, emailAccount) ->
		if emailAccount
			bcrypt.compare credentials.password, emailAccount.password_hash, (err, isCorrectPassword) ->
				if isCorrectPassword
					callback null, emailAccount
				else #incorrect password
					callback null, null
		else
			callback null, null

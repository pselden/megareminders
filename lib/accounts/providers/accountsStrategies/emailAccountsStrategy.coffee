emailAccountsProvider = require '../emailAccountsProvider'
uuid = require 'node-uuid'

exports.createAccount = (accountData, callback) ->
	verificationCode = uuid.v4()
	emailAccountsProvider.createEmailAccount accountData.userId, accountData.email, accountData.password, verificationCode, (err, result) ->
		if err
			callback err
		else
			# send the verification email but don't wait for a success to return to user
			emailAccountsProvider.sendVerificationEmail accountData.email, verificationCode, (err) ->
				if err
					console.log err
			callback null, result

exports.getAccountByUserId = (userId, callback) ->
	emailAccountsProvider.getEmailAccountByUserId userId, callback
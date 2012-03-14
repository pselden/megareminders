emailAccountsProvider = require '../emailAccountsProvider'

exports.createAccount = (accountData, callback) ->
	emailAccountsProvider.createEmailAccount accountData.userId, accountData.email, accountData.password, callback

exports.getAccountByUserId = (userId, callback) ->
	emailAccountsProvider.getEmailAccountByUserId userId, callback
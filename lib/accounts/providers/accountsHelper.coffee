async = require 'async'
emailAccountsProvider = require './emailAccountsProvider'
facebookAccountsProvider = require './facebookAccountsProvider'
twitterAccountsProvider = require './twitterAccountsProvider'

exports.getAccounts = (userId, callback) ->
	tasks =
		email: (callback) ->
			emailAccountsProvider.getEmailAccountByUserId userId, callback
		facebook: (callback) ->
			facebookAccountsProvider.getFacebookAccountByUserId userId, callback
		twitter: (callback) ->
			twitterAccountsProvider.getTwitterAccountByUserId userId, callback
	async.parallel tasks, callback
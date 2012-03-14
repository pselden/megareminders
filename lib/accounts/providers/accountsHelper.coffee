async = require 'async'
accountsStrategies = require './accountsStrategies'

exports.getAccounts = (userId, callback) ->
	accountTypes = ['email', 'twitter', 'facebook']
	tasks = {}
	accountTypes.forEach (type) ->
		tasks[type] = (callback) ->
			accountsStrategies[type].getAccountByUserId userId, callback

	async.parallel tasks, callback

exports.createAccount = (accountType, accountData, callback) ->
	accountsStrategies[accountType].createAccount accountData, callback

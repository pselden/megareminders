async = require 'async'
accountsProviders = require '../lib/accounts/providers'

exports.index = (req, res) ->
	req.pageName = 'accounts'
	accountsProviders.accountsHelper.getAccounts req.currentUser.user_id, (err, accounts) ->
		res.render 'accounts', { accounts: accounts }

exports.create = (req, res) ->
	accountType = req.params.type
	accountData = req.body
	accountData.userId = req.currentUser.user_id
	accountsProviders.accountsHelper.createAccount accountType, accountData, (err, result) ->
		res.redirect('/accounts')
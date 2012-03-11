async = require 'async'
accountsProviders = require '../lib/accounts/providers'

exports.show = (req, res) ->
	req.pageName = 'accounts'
	accountsProviders.accountsHelper.getAccounts req.currentUser.user_id, (err, accounts) ->
		res.render 'accounts', { accounts: accounts }
async = require 'async'
accountsProviders = require '../lib/accounts/providers'

exports.index = (req, res) ->
	req.pageName = 'accounts'
	accountsProviders.accountsHelper.getAccounts req.currentUser.user_id, (err, accounts) ->
		res.render 'accounts/index', { accounts: accounts }

exports.create = (req, res) ->
	accountType = req.params.type
	accountData = req.body
	accountData.userId = req.currentUser.user_id
	accountsProviders.accountsHelper.createAccount accountType, accountData, (err, result) ->
		res.redirect '/accounts'

# NYI
exports.destroy = (req, res) ->
		res.redirect '/accounts'

exports.verifyEmailAccount = (req, res) ->
	email = req.params.email
	verificationCode = req.params.code
	accountsProviders.emailAccounts.verifyEmailAccount email, verificationCode, (err, result) ->
		res.render 'accounts/verify_email_success', { email: email }

exports.denyEmailAccount = (req, res) ->
	email = req.params.email
	verificationCode = req.params.code
	accountsProviders.emailAccounts.denyEmailAccount email, verificationCode, (err, result) ->
		res.render 'accounts/deny_email_success', { email: email }
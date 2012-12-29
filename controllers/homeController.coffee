async = require 'async'
remindersProviders = require '../lib/reminders/providers'
accountsProviders = require '../lib/accounts/providers'

exports.homeSignedOut = (req, res, next) ->
	req.pageName = 'home'
	res.render 'home_signed_out'

exports.homeSignedIn = (req, res, next) ->
	req.pageName = 'home'
	res.addScript('chrono.min')
	res.addScript('home')
	tasks = {}
	tasks.getUpcomingReminders = (callback) ->
		remindersProviders.reminders.getUpcomingReminders req.currentUser.user_id, 10, 0, callback

	tasks.getAccounts = (callback) ->
		accountsProviders.accountsHelper.getAccounts req.currentUser.user_id, callback

	async.parallel tasks, (err, results) ->
		data =
			reminders: results.getUpcomingReminders
			accounts: results.getAccounts
		res.render 'home_signed_in', data

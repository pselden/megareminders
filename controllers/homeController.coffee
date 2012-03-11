async = require 'async'
remindersProvider = require '../lib/reminders/providers'

exports.homeSignedOut = (req, res, next) ->
	req.pageName = 'home'
	res.render 'home_signed_out'

exports.homeSignedIn = (req, res, next) ->
	req.pageName = 'home'
	res.addScript('home')
	tasks = {}
	tasks.getUpcomingReminders = (callback) ->
		remindersProvider.reminders.getUpcomingReminders req.currentUser.user_id, 5, 0, callback

	async.parallel tasks, (err, results) ->
		res.render 'home_signed_in', { reminders: results.getUpcomingReminders }

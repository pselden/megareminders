async = require 'async'
remindersProvider = require '../lib/reminders/providers'

exports.homeSignedOut = (req, res, next) ->
	return next() if req.isSignedIn
	res.render 'home_signed_out', { req: req }

exports.homeSignedIn = (req, res, next) ->
	return next() if !req.isSignedIn
	res.addScript('home')
	tasks = {}
	tasks.getUpcomingReminders = (callback) ->
		remindersProvider.reminders.getUpcomingReminders req.currentUser.user_id, 5, 0, callback

	async.parallel tasks, (err, results) ->
		res.render 'home_signed_in', { req: req, reminders: results.getUpcomingReminders }

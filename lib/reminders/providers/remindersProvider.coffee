reminderStrategies = require './reminderStrategies'
persistence = require '../persistence'
async = require 'async'

exports.getUpcomingReminders = (userId, limit, offset, callback) ->
	persistence.reminders.getUpcomingReminders userId, limit, offset, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows

exports.createReminder = (userId, reminder, callback) ->
	persistence.reminders.createReminder userId, reminder, callback

exports.sendReminder = (reminder, callback) ->
	tasks = {}
	reminder.reminder_types.forEach (type) ->
		task[type] = (callback) ->
			reminderStrategies[type.toLowerCase()].sendReminder reminder, callback

	async.parallel tasks, callback
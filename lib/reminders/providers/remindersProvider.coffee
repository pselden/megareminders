reminderStrategies = require './reminderStrategies'
persistence = require '../persistence'
async = require 'async'

exports.getReminderByReminderId = (reminderId, callback) ->
	persistence.reminders.getReminderByReminderId reminderId, (err, results) ->
		if err
			callback err
		else
			callback null, parseRow results.rows[0]

# gets upcoming reminders for the user
exports.getUpcomingReminders = (userId, limit, offset, callback) ->
	persistence.reminders.getUpcomingReminders userId, limit, offset, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows

# creates a reminder for the given user
exports.createReminder = (userId, reminder, callback) ->
	persistence.reminders.createReminder userId, reminder, callback

# sends the reminder via all reminder types
exports.sendReminder = (reminder, callback) ->
	tasks = {}
	reminder.reminder_types.forEach (type) ->
		tasks[type] = (callback) ->
			strategy = reminderStrategies[type.toLowerCase()]
			if strategy
				strategy.sendReminder reminder, callback
			else
				callback null, null

	async.parallel tasks, (err, results) ->
		persistence.reminders.markReminderAsSent reminder.reminder_id, callback

# gets "expired" reminders that have not been sent yet
exports.getRemindersToSend = (limit, callback) ->
	persistence.reminders.getRemindersToSend limit, (err, results) ->
		if err
			callback err
		else
			callback null, parseRows results.rows
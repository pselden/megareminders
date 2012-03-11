reminderStrategies = require './reminderStrategies'
persistence = require '../persistence'
async = require 'async'

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

parseRows = (rows) ->
	reminders = rows.map (row) ->
		reminder = row
		reminderTypes = reminder.reminder_types
		reminderTypes = reminderTypes.substring 1, reminderTypes.length - 1
		reminder.reminder_types = reminderTypes.split(',')
		return reminder

	return reminders
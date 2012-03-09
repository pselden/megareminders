remindersProvider = require '../reminders/providers'

interval = null
exports.start = () ->
	interval = setInterval

exports.stop = () ->

sendReminders = () ->
	limit = 50
	remindersProvider.reminders.getRemindersToSend 50, (err, reminders) ->
		if err


	sendAll = (reminders, callback) ->
		reminders.forEach (reminder)
			remindersProvider.reminders.sendReminder reminder, (err) ->

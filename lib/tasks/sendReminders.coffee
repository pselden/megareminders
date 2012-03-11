remindersProvider = require '../reminders/providers'
async = require 'async'

interval = null
intervalTime = 1000 * 60 * 5; # 5 minutes
exports.start = () ->
	run = () ->
		console.log 'Starting sendReminders task.'
		processReminders (err) ->
			if err
				console.log "Error running sendReminders task:"
				console.log err
			else
				console.log "Finished running sendReminders task"

	interval = setInterval run, intervalTime

exports.stop = () ->
	clearInterval interval

# gets all reminders to send and sends them
processReminders = (callback) ->
	limit = 50
	getReminders = (callback) ->
		remindersProvider.reminders.getRemindersToSend limit, callback

	getReminders (err, reminders) ->
		if err
			callback err
		else if reminders.length == 0
			callback null, null
		else
			sendReminders reminders, (err) ->
				if err
					callback err
				else
					getReminders callback

# sends all reminders in the list
sendReminders = (reminders, callback) ->
	tasks = []
	reminders.forEach (reminder) ->
		tasks.push (callback) ->
			remindersProvider.reminders.sendReminder reminder, callback
	async.parallel tasks, (err, results) ->
		if err
			callback err
		else
			callback null, null
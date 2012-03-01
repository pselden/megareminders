remindersProvider = require '../lib/reminders/providers'

exports.create = (req, res) ->
	reminder = newReminder req
	remindersProvider.reminders.createReminder req.currentUser.user_id, reminder, (err, result) ->
		res.redirect '/'

newReminder = (req) ->
	body = req.body
	if body.amPm == "PM"
		body.hours = body.hours + 12
	reminder_when = new Date body.year, body.month-1, body.day, body.hours, body.minutes
	reminder_time = new Date (reminder_when.getTime() - (body.reminderOffset * 60 * 1000))
	reminder =
		what: body.what
		when: reminder_when
		reminderTime: reminder_time
		reminderTypes: body.reminderTypes || []
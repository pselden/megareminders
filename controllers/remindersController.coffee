remindersProvider = require '../lib/reminders/providers'

exports.create = (req, res) ->
	reminder = newReminder req
	remindersProvider.reminders.createReminder req.currentUser.user_id, reminder, (err, result) ->
		res.redirect '/'

newReminder = (req) ->
	body = req.body
	if body.amPm == "PM" then body.hours = body.hours + 12
	reminderWhen = new Date body.year, body.month-1, body.day, body.hours, body.minutes
	reminderTime = new Date (reminderWhen.getTime() - (body.reminderOffset * 60 * 1000))
	reminderTypes = body.reminderTypes or []
	reminderTypes = if !Array.isArray(reminderTypes) then [body.reminderTypes]
	reminder =
		what: body.what
		when: reminderWhen
		reminderTime: reminderTime
		reminderTypes: reminderTypes
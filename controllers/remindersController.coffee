remindersProvider = require '../lib/reminders/providers'

exports.create = (req, res) ->
	reminder = newReminder req
	remindersProvider.reminders.createReminder req.currentUser.user_id, reminder, (err, result) ->
		res.redirect '/'

newReminder = (req) ->
	body = req.body
	body.hours = Number body.hours
	body.minutes = Number body.minutes
	if body.amPm == "PM" then body.hours = Number(body.hours) + 12
	date = new Date body.when
	reminderWhen = new Date date.getFullYear(), date.getMonth(), date.getDate(), body.hours, body.minutes
	reminderTime = new Date (reminderWhen.getTime() - (body.reminderOffset * 60 * 1000))
	reminderTypes = body.reminderTypes or []
	reminderTypes = if Array.isArray(reminderTypes) then reminderTypes else [reminderTypes]
	reminder =
		what: body.what
		when: reminderWhen
		reminderTime: reminderTime
		reminderTypes: reminderTypes

exports.show = (req, res) ->
	remindersProvider.getReminderByReminderId req.params.reminderId, (err, reminder) ->
		res.render 'reminders/show'
reminders = []
exports.create = (req, res) ->
	reminders.push(newReminder req)
	res.redirect '/'

newReminder = (req) ->
	reminder =
		what: req.body.what
		month: req.body.month
		day: req.body.day
		year: req.body.year
		hours: req.body.hours
		minutes: req.body.minutes
		amPm: req.body.amPm
		reminderOffset: req.body.reminderOffset
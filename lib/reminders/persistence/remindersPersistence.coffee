db = require '../../db'

exports.getUpcomingReminders = (userId, limit, offset, callback) ->
	query =
		name: 'get upcoming reminders'
		text: "SELECT * FROM reminders WHERE user_id = $1 AND \"when\" > $2
				ORDER BY \"when\" ASC
				LIMIT $3
				OFFSET $4",
		values: [userId, new Date(), limit, offset]
	db.query query, callback

exports.getRemindersToSend = (limit, callback) ->
	query =
		name: 'get reminders to send'
		text: "SELECT * FROM reminders
				WHERE reminder_time <= $1 AND is_sent = false
				LIMIT $2"
		values: [new Date(), limit]
	db.query query, callback

exports.markReminderAsSent = (reminderId, callback) ->
	query =
		name: 'mark reminder as sent'
		text: "UPDATE reminders
				SET is_sent = true
				WHERE reminder_id = $1"
		values: [reminderId]
	db.query query, callback

exports.createReminder = (userId, reminder, callback) ->
	query =
		name: 'create reminder'
		text: 'INSERT INTO reminders (user_id, what, "when", reminder_time, reminder_types) VALUES ($1, $2, $3, $4, $5)'
		values: [userId, reminder.what, reminder.when, reminder.reminderTime, "{#{reminder.reminderTypes.join(',')}}"]
	db.query query, callback
db = require '../lib/db'

exports.up = (next) ->
	query = "CREATE INDEX reminders_reminder_time_is_sent ON reminders (reminder_time, is_sent)"
	db.query query, next

exports.down = (next) ->
	query = "DROP INDEX reminders_reminder_time_is_sent"
	db.query query, next
db = require '../lib/db'

exports.up = (next) ->
	query = "CREATE INDEX reminders_reminder_time ON reminders (reminder_time)"
	db.query query, next

exports.down = (next) ->
	query = "DROP INDEX reminders_reminder_time"
	db.query query, next
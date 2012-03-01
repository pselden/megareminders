db = require '../lib/db'

exports.up = (next) ->
	query = "CREATE INDEX reminders_user_id_when ON reminders (user_id, \"when\")"
	db.query query, next

exports.down = (next) ->
	query = "DROP INDEX reminders_user_id_when"
	db.query query, next
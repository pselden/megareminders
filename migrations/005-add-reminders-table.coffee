db = require '../lib/db'

exports.up = (next) ->
	query = "CREATE TABLE reminders (
			reminder_id serial PRIMARY KEY,
			user_id integer REFERENCES users (user_id),
			what text NOT NULL,
			\"when\" timestamp with time zone NOT NULL,
			reminder_time timestamp with time zone NOT NULL,
			reminder_types character varying[] NOT NULL,
			is_sent boolean NOT NULL DEFAULT (false)
			);"
	db.query query, next

exports.down = (next) ->
	query = "DROP TABLE reminders"
	db.query query, next
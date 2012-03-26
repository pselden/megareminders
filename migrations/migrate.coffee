fs = require 'fs'
db = require '../lib/db'

# gets the list of migrations in sorted order
getMigrations = () ->
	files = fs.readdirSync('./migrations')
	migrations = files.filter (file) ->
		file.match /^\d+.*\.*$/

	migrations.sort().map (file) ->
		"./#{file}"

# gets the current schema version
getVersion = (callback) ->
	query =
		name: 'get database version',
		text: 'SELECT version FROM _metadata LIMIT 1'
	db.query query, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0].version

# sets the current schema version
setVersion = (version, callback) ->
	query =
		name: 'set database version',
		text: 'UPDATE _metadata SET version = $1'
		values: [version]

	db.query query, (err, results) ->
		if err
			callback err
		else
			callback null, null

# checks for existence of database metadata and creates it if one does not exist
prepareMetadata = (callback) ->
	console.log 'metadata 1'
	createMetadata = () ->
		query = "CREATE TABLE _metadata (
				   	version integer DEFAULT 0
					);

					INSERT INTO _metadata (version) VALUES (0);
					"
		db.query query, callback

	getVersion (err) ->
		if err
			console.log 'metadata 3'
			createMetadata()
		else
			console.log 'metadata 2'
			callback null, null

# runs all remaining migrations
up = (callback) ->
	migrations = getMigrations()
	getVersion (err, version) ->
		migrationsRemaining = migrations[version..]
		migrationCallback = (err) ->
			if err
				callback err
			else
				version += 1
				setVersion version, () ->
					runMigrations()

		runMigrations = () ->
			if migrationsRemaining.length > 0
				migrationName = migrationsRemaining.shift()
				migration = require migrationName
				console.log "running migration: #{migrationName}"
				migration.up migrationCallback
			else
				callback null, null

		runMigrations()

# rolls back the previous migration
rollback = (callback) ->
	migrations = getMigrations()
	getVersion (err, version) ->
		migrationName = migrations[version - 1]
		if migrationName
			migration = require migrationName
			console.log "rolling back migration: #{migrationName}"
			migration.down (err) ->
				if err
					callback err
				else
					setVersion version - 1, () ->
						callback null
		else
			callback null, null

# rolls back all migrations
down = (callback) ->
	migrations = getMigrations()
	getVersion (err, version) ->
		migrationCallback = (err) ->
			if err
				callback err
			else
				version -= 1
				setVersion version, () ->
					runMigrations()

		runMigrations = () ->
			if migrationsRemaining.length > 0
				migrationName = migrationsRemaining.pop()
				migration = require migrationName
				console.log "rolling back migration: #{migrationName}"
				migration.down migrationCallback
			else
				callback null, null

		if version > 0
			end = version - 1
			migrationsRemaining = migrations[0..end]
			runMigrations()
		else
			callback null, null


# called when the migration is finished
onMigrationFinish = (err) ->
	if err
		console.log 'error running migrations'
		console.log err
	else
		console.log 'complete'

	process.exit()

run = () ->
	console.log 'running migrations'
	prepareMetadata () ->
		mode = process.argv[process.argv.length-1]
		switch mode
			when "rollback" then rollback onMigrationFinish
			when "down" then down onMigrationFinish
			else
				up onMigrationFinish

run()
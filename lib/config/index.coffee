config = {
	development: {}
	production: {}
}

config.development.dbConnection = 'pg://postgres:password@localhost:5432/reminders'
config.production.dbConnection = process.env.DATABASE_URL

module.exports = config[process.env.NODE_ENV] || config.development
config =
	development: {}
	production: {}

config.development.dbConnection = 'pg://postgres:password@localhost:5432/reminders'
config.production.dbConnection = process.env.DATABASE_URL

config.development.twitter =
	consumerKey: 'A4v4gvuqNzxb9BFeRSUUg'
	consumerSecret: '5SAvedpNxaSSFotDkj4azmyxSNYOu8sg0bqnpKPUw'

config.production.twitter =
	consumerKey: 'A4v4gvuqNzxb9BFeRSUUg'
	consumerSecret: '5SAvedpNxaSSFotDkj4azmyxSNYOu8sg0bqnpKPUw'

config.development.facebook =
	applicationId: '324385787613251'
	applicationSecret: '234f98a5442329fc556bb8b120ce6b90'

config.production.facebook =
	applicationId: '324385787613251'
	applicationSecret: '234f98a5442329fc556bb8b120ce6b90'

module.exports = config[process.env.NODE_ENV] || config.development
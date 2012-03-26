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
	applicationId: '381744965182982'
	applicationSecret: 'b8b43750129b6a06081534e1e6c65f3b'

module.exports = config[process.env.NODE_ENV] || config.development
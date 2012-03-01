require('coffee-script');
var db = require('../lib/db');

exports.up = function(next){
	var query = "CREATE TABLE twitter_accounts (" +
			"twitter_id bigint PRIMARY KEY," +
			"token varchar(128) NOT NULL," +
			"token_secret varchar(128) NOT NULL," +
			"user_id integer REFERENCES users (user_id) CONSTRAINT one_twitter_account_per_user UNIQUE" +
			");";

	db.query(query, next);
};

exports.down = function(next){
	var query = "DROP TABLE twitter_accounts";
	db.query(query, next);
};

require('coffee-script');
var db = require('../lib/db');

exports.up = function(next){
	var query = "CREATE TABLE email_accounts (" +
			"email varchar(40) PRIMARY KEY," +
			"password_hash varchar(128) NOT NULL," +
			"user_id integer REFERENCES users (user_id) CONSTRAINT one_email_per_user UNIQUE," +
			"is_verified boolean DEFAULT false" +
			");";

	db.query(query, next);
};

exports.down = function(next){
	var query = "DROP TABLE email_accounts";
	db.query(query, next);
};

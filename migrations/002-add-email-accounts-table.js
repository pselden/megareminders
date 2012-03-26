require('coffee-script');
var db = require('../lib/db');

exports.up = function(next){
	var query = "CREATE TABLE email_accounts (" +
			"email varchar(127) PRIMARY KEY," +
			"password_hash varchar(127) NOT NULL," +
			"user_id integer REFERENCES users (user_id) CONSTRAINT one_email_per_user UNIQUE," +
			"is_verified boolean DEFAULT false," +
			"verification_code varchar(63) NOT NULL" +
			");";

	db.query(query, next);
};

exports.down = function(next){
	var query = "DROP TABLE email_accounts";
	db.query(query, next);
};

require('coffee-script');
var db = require('../lib/db');

exports.up = function(next){
	var query = "CREATE TABLE facebook_accounts (" +
			"facebook_id bigint PRIMARY KEY," +
			"token varchar(128) NOT NULL," +
			"user_id integer REFERENCES users (user_id) CONSTRAINT one_facebook_account_per_user UNIQUE" +
			");";

	db.query(query, next);
};

exports.down = function(next){
	var query = "DROP TABLE facebook_accounts";
	db.query(query, next);
};

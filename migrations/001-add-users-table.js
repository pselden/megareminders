require('coffee-script');
var db = require('../lib/db');

exports.up = function(next){
	var query = "CREATE TABLE users (" +
			"user_id serial PRIMARY KEY" +
			");";

	db.query(query, next);
};

exports.down = function(next){
	var query = "DROP TABLE users";
	db.query(query, next);
};

config = require '../../config'
Twitter = require './twitterApi'
Facebook = require './facebookApi'

exports.twitter = new Twitter config.twitter.consumerKey, config.twitter.consumerSecret
exports.facebook = new Facebook config.facebook.applicationId, config.facebook.applicationSecret
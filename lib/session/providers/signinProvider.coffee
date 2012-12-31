signinStrategies = require './signinStrategies'

exports.signIn = (credentials, signinType, callback) ->
  signinStrategies[signinType].signIn credentials, callback
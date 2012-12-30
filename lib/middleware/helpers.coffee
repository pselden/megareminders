dateformat = require 'dateformat'

module.exports = () ->
  (req, res, next) ->
    res.locals.formatter =
      date: dateformat
    next()
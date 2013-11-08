querystring = require('querystring')
OAuth = require("oauth").OAuth2
request = require('request')
;

module.exports = (appId, appSecret) ->
  rest_base = 'https://graph.facebook.com'
  oauth = new OAuth appId, appSecret, rest_base

  # authorizes the user for api requests
  authorize = (req, res, redirectUrl, callback) ->
    protocol = req.protocol
    callbackUrl = "#{protocol}://#{req.header 'host'}#{redirectUrl}"

    options =
      redirect_uri: callbackUrl
    # scope: 'email' -- add this back in if we need some sort of scope

    res.redirect oauth.getAuthorizeUrl options

  getAccessToken = (req, callback) ->
    protocol = req.protocol
    params =
      redirect_uri: "#{protocol}://#{req.header 'host'}#{req.path}"
    oauth.getOAuthAccessToken req.param('code'), params, (err, token) ->
      callback err, { token: token }

  # makes a call to the facebook api
  apiCall = (method, path, params, callback) ->
    params.access_token = params.token.token if params.token
    delete params.token

    request { method: method, uri: "#{rest_base}#{path}?#{querystring.stringify params}" }, (err, response, body) ->
      data = null
      try
        data = JSON.parse body
      catch e
        err = e
      callback err, data

  # gets normalized user data
  getUser = (token, callback) ->
    getMeCallback = (err, profile) ->
      if err
        callback err
      else
        callback null, normalizeUser profile

    normalizeUser = (profile) ->
      return {
      provider: 'Facebook',
      externalId: profile.id
      fullName: profile.name
      username: profile.username
      image: "http://graph.facebook.com/#{profile.id}/picture?type=large"
      }

    apiCall 'GET', '/me', { token: token }, getMeCallback

  # sends an application request to the user specified by the facebook id and access token
  sendApplicationRequest = (token, facebookId, message, data, callback) ->
    params =
      token: token
      message: message
      data: data || ""

    apiCall "POST", "/#{facebookId}/apprequests", params, callback

  return {
    authorize: authorize
    getAccessToken: getAccessToken
    getUser: getUser
    sendApplicationRequest: sendApplicationRequest
  }

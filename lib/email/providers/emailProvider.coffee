nodemailer = require 'nodemailer'
transport = nodemailer.createTransport "SMTP",
    service: "Gmail",
    auth:
        user: "pselden4@gmail.com",
        pass: "PsniperS69"

exports.sendEmail = (options, callback) ->
	options.transport = transport
	nodemailer.sendMail options, callback
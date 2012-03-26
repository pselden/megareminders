nodemailer = require 'nodemailer'
transport = nodemailer.createTransport "SMTP",
    service: "Gmail",
    auth:
        user: "megareminders@gmail.com",
        pass: "RemindMe"

exports.sendEmail = (options, callback) ->
	options.transport = transport
	options.from = options.from || "MegaReminders <megareminders@gmail.com>"
	nodemailer.sendMail options, callback
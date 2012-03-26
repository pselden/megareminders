persistence = require '../persistence'
bcrypt = require 'bcrypt'
validator = require 'validator'
emailProviders = require '../../email/providers'


exports.getEmailAccountByEmail= (email, callback) ->
	persistence.emailAccounts.getEmailAccountByEmail email, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.getEmailAccountByUserId= (userId, callback) ->
	persistence.emailAccounts.getEmailAccountByUserId userId, (err, results) ->
		if err
			callback err
		else
			callback null, results.rows[0]

exports.createEmailAccount = (userId, email, password, verificationCode, callback) ->
	try
		validator.check(email, 'Invalid email.').isEmail();
		validator.check(password, 'Invalid password.').notEmpty();
		bcrypt.genSalt 10, (err, salt) ->
			bcrypt.hash password, salt, (err, hash) ->
				persistence.emailAccounts.createEmailAccount userId, email, hash, verificationCode, callback
	catch err
		callback err
# deletes the email account
exports.deleteEmailAccount = (email, callback) ->
	persistence.emailAccounts.deleteEmailAccount email, callback

# verifies the given email account
exports.verifyEmailAccount = (email, verificationCode, callback) ->
	exports.getEmailAccountByEmail email, (err, emailAccount) ->
		if err or !emailAccount
			callback err
		else
			if verificationCode == emailAccount.verification_code
				persistence.emailAccounts.verifyEmailAccount email, callback
			else
				callback new Error 'Invalid verification code.'

# deletes the email account if the verification code matches
exports.denyEmailAccount = (email, verificationCode, callback) ->
	exports.getEmailAccountByEmail email, (err, emailAccount) ->
		if err or !emailAccount
			callback err
		else
			if verificationCode == emailAccount.verification_code
				exports.deleteEmailAccount email, callback
			else
				callback new Error 'Invalid verification code.'

exports.sendVerificationEmail = (email, verificationCode, callback) ->
	verificationUrl = "http://www.megareminders.com/accounts/email/#{email}/verify/#{verificationCode}"
	notMyAccountUrl = "http://www.megareminders.com/accounts/email/#{email}/deny/#{verificationCode}"
	mailOptions =
		to: email
		subject: 'MegaReminders: please confirm your email account'
		html: "
		<h2 style='font-size: 18px; font-weight: normal;'>Hi, #{email},</h2>
		<div style=\"font-family:'Helvetica Neue',Arial,Helvetica,sans-serif;font-size:13px;margin:15px\">
			<div style='margin-bottom: 10px;'>Please confirm your MegaReminders account by clicking this link: <a href='#{verificationUrl}'>#{verificationUrl}</a></div>
			<div>Once you confirm, you will be able to create reminders that will be sent to this email address.</div>
			<div style='border-top: 1px solid #CCC; margin-top: 10px; padding-top: 10px; color: #CCC; font-size:11px;' >
				<p>If you received this message in error and did register an email address with MegaReminders, click <a href='#{notMyAccountUrl}'>not my account</a>.</p>
				<p>Please do not reply to this message; it was sent from an unmonitored email address.</p>
			</div>
		</div>"

	emailProviders.email.sendEmail mailOptions, callback

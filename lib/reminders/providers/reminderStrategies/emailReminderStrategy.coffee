emailProviders = require '../../../email/providers'
accountsProviders = require '../../../accounts/providers'

exports.sendReminder = (reminder, callback) ->
	accountsProviders.emailAccounts.getEmailAccountByUserId reminder.user_id, (err, emailAccount) ->
		if emailAccount && emailAccount.is_verified
			mailOptions =
				from: "Paul Selden <pselden4@gmail.com>",
				to: emailAccount.email,
				subject: "Reminder: #{reminder.what} on #{reminder.when}",
				text: "This is a reminder."
			emailProviders.email.sendEmail mailOptions, callback
		else
			callback null, null

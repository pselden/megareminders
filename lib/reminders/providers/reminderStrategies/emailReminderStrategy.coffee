emailProviders = require '../../../email/providers'
accountsProviders = require '../../../accounts/providers'
dateformat = require 'dateformat'

exports.sendReminder = (reminder, callback) ->
	accountsProviders.emailAccounts.getEmailAccountByUserId reminder.user_id, (err, emailAccount) ->
		if emailAccount #&& emailAccount.is_verified
			reminderUrl = "http://www.megareminders.com/reminders/#{reminder.reminder_id}"
			mailOptions =
				to: emailAccount.email,
				subject: "MegaReminder: #{reminder.what} on #{dateformat reminder.when, 'dddd, mmmm dS'}",
				text: "Hey you!

				You wanted to be reminded about <a href='#{reminderUrl}'>\"#{reminder.what}\"</a>... so don't forget about it!

				Go to http://www.megareminders.com/reminders/#{reminder.reminder_id}' to view the details."
				html: "Hey you!<br/><br/>
					You wanted to be reminded about \"#{reminder.what}\"... so don't forget about it!<br/><br/>
					<a href='#{reminderUrl}'>Click here to view the details.</a>"
			emailProviders.email.sendEmail mailOptions, callback
		else
			callback null, null

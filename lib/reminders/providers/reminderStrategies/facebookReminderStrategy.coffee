accountsProviders = require '../../../accounts/providers'
thirdPartyProviders = require '../../../thirdparty/providers'

exports.sendReminder = (reminder, callback) ->
	accountsProviders.facebookAccounts.getFacebookAccountByUserId reminder.user_id, (err, facebookAccount) ->
		if facebookAccount
			token =
				token: facebookAccount.token

			facebookId = facebookAccount.facebook_id
			message = "Reminder: #{reminder.what} on #{reminder.when}"
			data = "reminder_id=#{reminder.reminder_id}"
			thirdPartyProviders.facebook.sendApplicationRequest token, facebookId, message, data, callback
		else
			callback null, null
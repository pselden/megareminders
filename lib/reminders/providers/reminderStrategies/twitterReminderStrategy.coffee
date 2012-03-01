accountsProviders = require '../../../accounts/providers'
thirdPartyProviders = require '../../../thirdparty/providers'

exports.sendReminder = (reminder, callback) ->
	accountsProviders.twitterAccounts.getTwitterAccountByUserId reminder.user_id, (err, twitterAccount) ->
		if twitterAccount
			token =
				token: twitterAccount.token
				secret: twitterAccount.token_secret

			twitterId = twitterAccount.twitter_id
			text = "Reminder: #{reminder.what} on #{reminder.when}" #TODO -- 140 chars?
			thirdPartyProviders.twitter.sendDirectMessage token, twitterId, text, callback
		else
			callback null, null
accountsProviders = require '../../../accounts/providers'
thirdPartyProviders = require '../../../thirdparty/providers'

exports.sendReminder = (reminder, callback) ->
	accountsProviders.twitterAccounts.getTwitterAccountByUserId reminder.user_id, (err, twitterAccount) ->
		if twitterAccount
			token =
				token: twitterAccount.token
				secret: twitterAccount.token_secret

			twitterId = twitterAccount.twitter_id
			text = "MegaReminder: #{reminder.what} on #{dateformat reminder.when, 'dddd, mmmm dS'}" #TODO -- 140 chars?
			thirdPartyProviders.twitter.sendDirectMessage token, twitterId, text, callback
		else
			callback null, null
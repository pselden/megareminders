request = require('request').forever({minSockets: 50, maxSockets: 50})

num = 100

get = () ->
	url = 'http://www.google.com'
	request url, (err) -> return
for x in [1..num/2]
	get()

abc = () ->
	for x in [1..num/2]
		get()

setTimeout abc, 5000
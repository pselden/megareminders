exports.statics = () ->
	return (req, res, next) ->
		req.statics = {
			scripts: [],
			css: []
		}

		res.addScript = (scripts...) ->
			req.statics.scripts.push "/js/#{s}.js" for s in scripts

		res.addCss = (css...) ->
			req.statics.css.push "/css/#{c}.css" for c in css

		next()

exports.globalStatics = () ->
	return (req, res, next) ->
		res.addCss 'bootstrap', 'font-awesome', 'jquery-ui.custom', 'global'
		res.addScript 'jquery.min', 'bootstrap.min', 'jquery-ui.custom.min'
		next()

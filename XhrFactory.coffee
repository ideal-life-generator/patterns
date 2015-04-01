class ListDisplay
	constructor: (id, parent) ->
		@list = document.createElement "ul"
		@list.id = id
		parent.appendChild @list

	append: (text) ->
		newEl = document.createElement "li"
		@list.appendChild newEl
		newEl.innerHTML = text
		newEl
	remove: (el) ->
		@list.removeChild el
	clear: ->
		@list.innerHTML = ""


conf =
	id: "cnn-top-stories"
	feedUrl: "http://rss.cnn.com/rss/cnn_topstories.rss"
	updateInterval: 60
	parent: document.querySelector "#feed-readers"


class FeedReader extends XhrMnager
	construnctor: (@display, @xhrHandler, @conf) ->
		@startUpdate()

	fetchFeed: ->
		@request
			method: "GET"
			url: "feedProxy.php?feed=" + @conf.feedUrl
			callback:
				success: (text, xml) =>
					@parseFeed text, xml
				error: (status) =>
					@showError status

	parseFeed: (responseText, responseXML) ->
		@display.clear()
		items = responseXML.querySelector "[item]"
		for item in items
			title = item.querySelector "[title]"
			link = item.querySelector "[link]"
			@display.append "<a href='" + link.firstChild.data + "'>" + title.firstChild.data + "</a>"

	showError: (statusCode) ->
		@display.clear()
		@display.append "Error fetching feed."

	stopUpdates: ->
		clearInterval @interval

	startUpdate: ->
		@fetchFeed()
		@interval = setInterval =>
			@fetchFeed()
		, @conf.updateInterval * 1000


FeedManager =
	createFeedReader: (conf) ->
		displayModule = new ListDisplay conf.id + "-display", conf.parent

		xhrHandler = XhrMnager.createXhrHandler()

		new FeedReader displayModule, xhrHandler, conf
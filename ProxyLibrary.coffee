class Book
	constructor: (isbn, title, author) ->

class PublicLibrary
	constructor: (books) ->
		@catalog = { }

		@catalog[book.getIsbn()] = book: book, avaliable: on for book in books

	findBooks: (searchString) ->
		for own isbn, book of @catalog when searchString.match(book.getTitle()) or searchString.match(book.getAuthor())
			book

	checkoutBook: (book) ->
		isbn = book.getIsbn()
		if @catalog[isbn]
			if @catalog[isbn].avaliable
				@catalog[isbn].avaliable = off
				@catalog[isbn]
			else
				throw new Error "PublikLibrary: book #{book.getTitle()} is not currently available."
		else
			throw new Error "PublikLibrary: book #{book.getTitle()} not found."

	returnBook: (book) ->
		isbn = book.getIsbn()
		if @catalog[isbn] then @catalog[isbn].avaliable = on
		else throw new Error "PublikLibrary: book #{book.getTitle()} not found."


class PublicLibraryProxy
	constructor: (catalog) ->
		@library = new PublikLibrary catalog

	findBooks: (searchString) ->
		@library.findBooks searchString

	checkoutBook: (book) ->
		@library.checkoutBook book

	returnBook: (book) ->
		@library.returnBook book


class PublicLibraryVirtualProxy
	constructor: (@catalog) ->

	_initializeLibrary: ->
		@library ? new PublikLibrary @catalog

	findBooks: (searchString) ->
		@_initializeLibrary()
		@library.findBooks searchString

	checkoutBook: (book) ->
		@_initializeLibrary()
		@library.checkoutBook book

	returnBook: (book) ->
		@_initializeLibrary()
		@library.returnBook book


# 

xhrHandler = XhrManager.createXhrHandler

callback =
	success: (responseText) ->
		stats = eval "(#{responseText})"
		displayPageviews stats
	failture: (statusCode) ->
		throw new Error "Asynchronous request for stats failed."

xhrHandler.request "GET", "/stats/getPageviews/?page=index.html", callback

callback =
	success: (responseText) ->
		stats = eval "(#{responseText})"
		displayBrowserShare stats
	failture: (statusCode) ->
		throw new Error "Asynchronous request for stats failed."

xhrHandler.request "GET", "/stats/getBrowserShare/?page=index.html", callback


StatsProxy = (->
	xhrHandler = XhrManager.createXhrHandler()
	urls =
		pageviews: "/stats/getPageviews/"
		uniques: "/stats/getUniques/"
		browserShare: "/stats/getBrowserShare/"
		topSearchTerms: "/stats/getTopSearchTerms/"
		mostVisitedPages: "/stats/getMostVisitedPages/"

	xhrFailure = ->
		throw new Error "StatsProxy: Asynchronous request for stats failed."

	fetchData = (url, dataCallback, startDate, endDate, page) ->
		callback =
			success: (responseText) ->
				stats = eval "(#{responseText})"
				dataCallback stats
			failure: xhrFailure

		getVars = [ ]
		getVars.push "startDate=#{encodeURI startDate}" if startDate
		getVars.push "startDate=#{encodeURI endDate}" if endDate
		getVars.push "page=#{page}" if page
		url = "#{url}?#{getVars.join '&'}"
		xhrHandler.request "GET", url, callback

	getPageviews: (callback, startDate, endDate, page) ->
		fetchData urls.pageviews, callback, startDate, endDate, page
	getUniques: (callback, startDate, endDate, page) ->
		fetchData urls.uniques, callback, startDate, endDate, page
	getBrowserShare: (callback, startDate, endDate, page) ->
		fetchData urls.browserShare, callback, startDate, endDate, page
	getTopSearchTerms: (callback, startDate, endDate, page) ->
		fetchData urls.topSearchTerms, callback, startDate, endDate, page
	getMostVisitedPages: (callback, startDate, endDate, page) ->
		fetchData urls.mostVisitedPages, callback, startDate, endDate, page
)()


class WebService
	@xhrHandler = XhrManager.createXhrHandler()

	_xhrFailure: (statusCode) ->
		throw new Error "StatsProxy: Asynchronous request for stats failed."
	_fetchData: (url, dataCallback, getVars) ->
		callback =
			success: (responseText) ->
				obj = eval "(#{responseText})"
				dataCallback obj
			failure: (=>
				@_xhrFailure
			)()

		getVarArray = [ ]
		getVarArray.push "#{varName}=#{getVar}" for key, getVar of getVars
		url = "#{url}?#{getVarArray.join '&'}"

		xhrHandler.request "GET", url, callback

class StatsProxy
	getPageviews: (callback, startDate, endDate, page) ->
		@_fetchData "/stats/getPageviews/", callback,
			startDate: startDate
			endDate: endDate
			page: page
	getUniques: (callback, startDate, endDate, page) ->
		@_fetchData "/stats/getUniques/", callback,
			startDate: startDate
			endDate: endDate
			page: page
	getBrowserShare: (callback, startDate, endDate, page) ->
		@_fetchData "/stats/getBrowserShare/", callback,
			startDate: startDate
			endDate: endDate
			page: page
	getTopSearchTerms: (callback, startDate, endDate, page) ->
		@_fetchData "/stats/getTopSearchTerms/", callback,
			startDate: startDate
			endDate: endDate
			page: page
	getMostVisitedPages: (callback, startDate, endDate, page) ->
		@_fetchData "/stats/getMostVisitedPages/", callback,
			startDate: startDate
			endDate: endDate
			page: page


#

class PersonnelDirectory
	constructor: (@parent) ->
		@xhrHandler = XhrManager.createXhrHandler()

		callback =
			success: @_configure
			failture: ->
				throw new Error "PersonnelDirectory: failture in data retrivial."

		xhrHandler.request "GET", "directoryData.php", callback

	_configure: (responseText) ->
		@data = eval "(#{responseText})"
		@currentPage = "a"

	showPage: (page) ->
		document.querySelector "[page-#{@currentPage}]"
			.style.display = "none"
		document.querySelector "[page-#{page}]"
			.style.display = "block"
		@currentPage = page


class DirectoryProxy
	constructor: (@parent) ->
		addEvent parent, "mouseover", @_initialize

	_initialize: ->
		@warning = document.createElement "div"
		@parent.appendChild @warning
		@warning.innerHTML = "The company directory is loading..."

		@directory = new PersonnelDirectory @parent
		@interval = setInterval =>
			@_checkInitialization
		, 100

	_checkInitialization: ->
		if @directory.currentPage
			clearInterval @interval
			@initialized = on
			@parent.removeChild @warning

	showPage: (page) ->
		unless @initialized then @directory.showPage page

class DynamicProxy
	constructor: ->
		@args = arguments

		if typeof @class isnt "function" then throw new Error "DynamicProxy: the class attribute must be set before calling the super-class consructor."

		for key, prop of @class.prototype when typeof prop is "function"
			do (key) =>
				@[key] = ->
					if @initialized then @subject[key].apply @subject, arguments

	_initialize: ->
		@subject = { }
		@class.apply @subject, @args
		@subject.__proto__ = @class.prototype

		@interval = setInterval =>
			@_checkInitialization()
		, 100

	_checkInitialization: ->
		if @_isInitialized()
			clearInterval @interval
			@initialized = on

	_initialized: ->
		throw new Error "Unsupported operation on an abstract class."

class TestProxy extends DynamicProxy
	constructor: ->
		@class = TestClass
	
		addEvent document.querySelector "test-link", "click", =>
			@_initialize()
	
		super arguments

	_isInitialized = ->
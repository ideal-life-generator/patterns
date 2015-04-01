# class Book
# 	constructor: (@isbn, @title, @author, @genres) ->

# class PublicLibrary
# 	constructor: (books, @firstGenreCatalog) ->
# 		@catalog = { }

# 		@addBook book for book in books

# 	findBooks: (searchString) ->
# 		results = [ ]
# 		results.push book for own isbn, book of @catalog when book.getTitle().match(searchString) or book.getAuthor().match searchString
# 		results

# 	checkoutBook: (book) ->
# 		isbn = book.getIsbn()
# 		book = @catalog[isbn]
# 		if book
# 			if book.avaliable
# 				book.avaliable = off
# 				book
# 			else
# 				throw new Error "PublicLibrary: book #{book.getTitle()} is not currently avaliable."
# 		else
# 			throw new Error "PublicLibrary: book #{book.getTitle()} not found."

# 	returnBook: (book) ->
# 		isbn = book.getIsbn()
# 		if @catalog[isbn] then @catalog[isbn].avaliable = on else throw new Error "PublicLibrary: book #{book.getTitle()} not found."

# 	addBook: (newBook) ->
# 		@catalog[newBook.getIsbn()] = book: newBook, avaliable: on

# 		@firstGenreCatalog.handleFilingRequest newBook


# biographyCatalog = new BiographyCatalog
# fantasyCatalog = new FantasyCatalog
# mysteryCatalog = new MysteryCatalog
# nonFictionCatalog = new NonFictionCatalog
# sciFiCatalog = new SciFiCatalog

# biographyCatalog.setSuccess fantasyCatalog
# fantasyCatalog.setSuccess mysteryCatalog
# mysteryCatalog.setSuccess nonFictionCatalog
# nonFictionCatalog.setSuccess sciFiCatalog

# myLibrary = new PublicLibrary books, biographyCatalog

# historyCatalog = new HistoryCatalog
# sciFiCatalog.setSuccesss historyCatalog

# class GenreCatalog
# 	constructor: ->
# 		@catalog = [ ]

# 	_bookMathesCriteria: (book) ->

# 	handleFilingRequest: (book) ->
# 		@catalog.push book if @_bookMathesCriteria book
# 		@successor.handleFilingRequest book if @successor

# 	findBooks: (request) ->
# 		@successor.findBooks request if @successor

# 	setSuccess: (successor) ->
# 		@successor = successor

# class SciFiCatalog extends GenreCatalog
# 	constructor: ->
# 		@genreName = ["sci-fi", "scifi", "science fiction"]

# 	_bookMathesCriteria = (book) ->
# 		genres = book.getGenres()
# 		on if book.getTitle().math /space/i
# 		for genre in genres
# 			genre = genre.toLowerCase()
# 			on if genre is "sci-fi" or genre is "scifi" or genre is "science fiction"

# class PublicLibrary
# 	constructor: (books) ->

# 	findBooks: (searchString, genres) ->
# 		if typeof genres is "object" or genres.length > 0
# 			requestObject =
# 				searchString: searchString
# 				genres: genres
# 				results: [ ]

# 			responseObject = @firstGenereCatalog.findBooks requestObject
# 			responseObject.results
# 		else
# 			results = [ ]
# 			results.push book for own isbn, book of @catalog when book.getTitle().match(searchString) or book.getAuthor().match searchString
# 			results

# 	checkoutBook: (book) ->
# 	returnBook: (book) ->
# 	addBook: (newBook) ->

# class GenreCatalog
# 	constructor: ->
# 		@catalog = [ ]
# 		@genreNames = [ ]

# 	_bookMathesCriteria: (book) ->
# 	handleFilingRequest: (book) ->
# 	findBook: (request) ->
# 		found = off
# 		for genreName in @genreNames
# 			for genre in request.genres when genreName is genre
# 				found = on
# 				break

# 		if found
# 			for book in @catalog when book.getTitle().match(searchString) or book.getAuthor().match searchString
# 				request.results.push book for result in request.results when book.getIsbn() isnt result.getIsbn()

# 		if @successor then @successor.findBooks request
# 		else request

# 	setSuccessor: (successor) ->


#  #

# class DynamicGallery
# 	constructor: (id) ->
# 		@childrens = [ ]
# 		@tags = [ ]

# 		@element = document.createElement "div"
# 		@element.id = id
# 		@element.className = "dynamic-gallery"

# 	add: (child) ->
# 		@childrens.push child
# 		@element.appendChild child.getElement()

# 	addTag: (tag) ->
# 		@tags.push tag
# 		child.addTag tag for child in @childrens

# 	remove: (child) ->
# 		for children, i in @childrens when children is child
# 			@childrens.slice i, 1
# 			break
# 		@element.removeChild child.getElement()

# 	getChild: (n) ->
# 		@childrens[n]

# 	getAllLeaves: ->
# 		leaves = [ ]
# 		leaves.concat child.getAllLeaves() for child in @childrens
# 		leaves

# 	getPhotosWithTag: (tag) ->
# 		return @getAllLeaves() for tagInTags in @tags when tag is tagInTags

# 		results = [ ]
# 		results.concat child.getPhotosWithTag tag for child in @childrens
# 		results

# 	hide: ->
# 		@element.style.display = "none"

# 	show: ->
# 		@element.style.display = ""
# 		children.show() for children in @childrens

# 	getElement: ->
# 		@element


# class GalleryImage
# 	constructor: (src) ->
# 		@element = document.createElement "img"
# 		@element.className = "gallery-image"
# 		@element.src = src
# 		@tags = [ ]

# 	add: ->
# 	remove: ->
# 	getChild: ->

# 	getAllLeaves: ->
# 		[@]

# 	getPhotosWithTag: (tag) ->
# 		return [@] for tagInTags in @tags when tag is tagInTags
# 		[ ]

# 	addTag: (tag) ->
# 		@tags.push tag

# 	hide: ->
# 		@element.style.display = "none"

# 	show: ->
# 		@element.style.display = ""

# 	getElement: ->
# 		@element


# topGallery = new DynamicGallery "top-gallery"

# topGallery.add new GalleryImage "/img/image-1.jpg"
# topGallery.add new GalleryImage "/img/image-2.jpg"
# topGallery.add new GalleryImage "/img/image-3.jpg"

# vacationPhotos = new DynamicGallery "vacation-photos"

# vacationPhotos.add imageIndex for imageIndex in [0..30]

# topGallery.add vacationPhotos
# topGallery.show()
# vacationPhotos.hide()


# 

class MoneyStack
	constructor: (@billSize) ->

	withdraw: (amount) ->
		numOfBills = Math.floor amount / @billSize

		if numOfBills > 0
			@_ejectMoney numOfBills
			amount -= @billSize * numOfBills

		amount > 0 and @next and @next.withdraw amount

	setNextStack: (stack) ->
		@next = stack

	_ejectMoney: (numOfBills) ->
		console.log "#{numOfBills} $#{@billSize} bill(s) has/have been spit out"

class ATM
	constructor: ->
		stack100 = new MoneyStack 100
		stack50 = new MoneyStack 50
		stack20 = new MoneyStack 20
		stack10 = new MoneyStack 10
		stack5 = new MoneyStack 5
		stack1 = new MoneyStack 1

		stack100.setNextStack stack50
		stack50.setNextStack stack20
		stack20.setNextStack stack10
		stack10.setNextStack stack5
		stack5.setNextStack stack1

		@moneyStack = stack100

	withdraw: (amount) ->
		@moneyStack.withdraw amount

atm = new ATM

atm.withdraw 186

atm.withdraw 72
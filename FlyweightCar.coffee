# class Car
# 	constructor: (@make, @model, @year, @owner, @tag, @renewDate) ->

# 	getMake: ->
# 		@make

# 	getModel: ->
# 		@model

# 	getYear: ->
# 		@year

# 	transferOwnership: (newOwner, newTag, newRenewDate) ->
# 		@owner = newOwner
# 		@tag = newTag
# 		@renewDate = newRenewDate

# 	renewRegistration: (newRenewDate) ->
# 		@renewDate = newRenewDate

# 	isRegistrationCurrent: ->
# 		today = new Date()
# 		today.getTime() < Date.parse @renewDate


class Car
	constructor: (@make, @model, @year) ->

	getMake: ->
		@make

	getModel: ->
		@model

	getYear: ->
		@year


CarFactory = (->
	createdCars = { }

	createCar: (make, model, year) ->
		data = "#{make}-#{model}-#{year}"
		if createdCars[data] then createCar[data] 
		else createdCars[data] = new Car make, model, year
)()


CarRecordManage = (->
	carRecordDatabase = { }

	addRecordCar: (make, model, year, owner, tag, renewDate) ->
		carRecordDatabase[tag] =
			owner: owner
			renewDate: renewDate
			car: CarFactory.createdCar make, model, year

	transferOwnership: (tag, newOwner, newTag, newRenewDate) ->
		record = carRecordDatabase[tag]
		record.owner = newOwner
		record.tag = newTag
		record.renewDate = newRenewDate

	renewRegistration: (tag, newRenewDate) ->
		carRecordDatabase[tag].renewDate = newRenewDate

	isRegistrationCurrent: (tag) ->
		today = new Date()
		today.getTime() < Date.parse carRecordDatabase[tag].renewDate
)()


# class CalendarItem
# 	constructor: (@year, parent) ->
# 		@element = document.createElement "div"
# 		@element.style.display = "none"
# 		parent.appendChild @element

# 	isLeapYear = (y) ->
# 		(y > 0) and not (y % 4) and ((y % 4) or not (y % 400))

# 	@months = [ ]

# 	@numDays = [ 31, isLeapYear @year ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

# 	@months[i] = new CalendarMonth i, @numDays[i], @element for i in [0..12]

# 	display: ->
# 		month.display() for month in @months
# 		@element.style.display = "block"

# class CalendarMonth
# 	constructor: (@monthNum, numDays, parent) ->
# 		@element = document.createElement "div"
# 		@element.style.display = "none"
# 		parent.appendChild @element

# 		@days = [ ]

# 		@days[i] = new CalendarDay i, @element for i in [0..numDays]

# 	display: ->
# 		day.display() for day in @days
# 		@element.style.display = "block"

# class CalendarDay
# 	constructor: (@date, parent) ->
# 		@element = document.createElement "div"
# 		@element.style.display = "none"
# 		parent.appendChild @element

# 	display: ->
# 		@element.innerHTML = @date
# 		@element.style.display = "block"


class CalendarDay
	display: (date, parent) ->
		element = document.createElement "div"
		parent.appendChild element
		@element.innerHTML = date

calendarDay = new CalendarDay

class CalendarMonth
	constructor: (@monthNum, numDays, parent) ->
		@element = document.createElement "div"
		@element.style.display = "none"
		parent.appendChild @element

		@days = [ ]

		@days[i] = calendarDay for i in [0..numDays]

	display: ->
		day.display i, @element for day in @days
		@element.style.display = "block"

class CalendarItem
	constructor: (@year, parent) ->
		@element = document.createElement "div"
		@element.style.display = "none"
		parent.appendChild @element

	isLeapYear = (y) ->
		(y > 0) and not (y % 4) and ((y % 4) or not (y % 400))

	@months = [ ]

	@numDays = [ 31, isLeapYear @year ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

	@months[i] = new CalendarMonth i, @numDays[i], @element for i in [0..12]

	display: ->
		month.display() for month in @months
		@element.style.display = "block"


# class Tooltip
# 	constructor: (targetElement, @text) ->
# 		@target = targetElement
# 		@delayTimeout = null
# 		@delay = 1500

# 		@element = document.createElement "div"
# 		@element.style.display = "none"
# 		@element.style.position = "absolute"
# 		@element.className = "tooltip"
# 		document.querySelector "body"
# 			.appendChild @element

# 		addEvent @target, "mouseover", (e) => @startDelay e
# 		addEvent @target, "mouseout", (e) => @hide e

# 	startDelay: (e) ->
# 		unless @delayTimeout
# 			x = e.clientX
# 			y = e.clientY
# 			@delayTimeout = setTimeout =>
# 				@show x, y
# 			, @delay

# 	show: (x, y) ->
# 		clearTimeout @delayTimeout
# 		@delayTimeout = null
# 		@element.style.left = "#{x}px"
# 		@element.style.top =  "#{y + 20}px"
# 		@element.style.display = "block"

# 	hide: ->
# 		clearTimeout @delayTimeout
# 		@delayTimeout = null
# 		@element.style.display = "none"


TooltipManager = (->

	storedInstance = null

	class Tooltip
		constructor: ->
			@delayTimeout = null
			@delay = 1500

			@element = document.createElement "div"
			@element.style.display = "none"
			@element.style.position = "absolute"
			@element.className = "tooltip"
			document.querySelector "body"
				.appendChild @element

		startDelay: (e) ->
			unless @delayTimeout
				x = e.clientX
				y = e.clientY
				@delayTimeout = setTimeout =>
					@show x, y, text
				, @delay

		show: (x, y, text) ->
			clearTimeout @delayTimeout
			@delayTimeout = null
			@element.innerHTML = text
			@element.style.left = "#{x}px"
			@element.style.top =  "#{y + 20}px"
			@element.style.display = "block"

		hide: ->
			clearTimeout @delayTimeout
			@delayTimeout = null
			@element.style.display = "none"

	addTooltip: (targetElement, text) ->
		tt = @getTooltip

		addEvent targetElement, "mouseover", (e) => tt.startDelay e
		addEvent targetElement, "mouseout", (e) => tt.hide e

	getTooltip: ->
		storedInstance ? new Tooltip

)()


class DialogBox
	constructor: ->

	show: (header, body, footer) ->

	hide: ->

	state: ->

DialogBoxManager = (->

	created = [ ]

	displayDialogBox: (header, body, footer) ->
		inUse = @numberInUse()
		created.push @createdDialogBox() if inUse > created.length
		created[inUse].show header, body, footer

	createdDialogBox: ->
		new DialogBox

	numberInUse: ->
		inUse = 0
		inUse++ for create in created if create.state() is "visible"
		inUse

)()
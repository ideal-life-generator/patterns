# class AcmeComfortCriuser
# 	assamble: ->
# 	wash: ->
# 	ride: ->
# 	repair: ->
# 	getPrice: ->
# 		399

# class BicycleDecorator
# 	constructor: (@bicycle) ->

# 	assamble: ->
# 		@bicycle.assamble()
# 	wash: ->
# 		@bicycle.wash()
# 	ride: ->
# 		@bicycle.ride()
# 	repair: ->
# 		@bicycle.repair()
# 	getPrice: ->
# 		399

# class HeadlightDecorator extends BicycleDecorator
# 	constructor: (bicycle) ->
# 		super bicycle

# 	assamble: ->
# 		@bicycle.assamble() + " Attach heandling to handlebars."
# 	getPrice: ->
# 		@bicycle.getPrice() + 15

# # myBicycle = new AcmeComfortCriuser()
# # console.log myBicycle

# # myBicycle = new HeadlightDecorator myBicycle
# # console.log myBicycle


# class FrameColorDecorator extends BicycleDecorator
# 	constructor: (bicycle, @frameColor) ->
# 		super bicycle

# 	assamble: ->
# 		"Paint the frame #{@frameColor} and allow it to dry. #{@bicycle.assamble()}"
# 	getPrice: ->
# 		@bicycle.getPrice() + 30

# # myBicycle = new AcmeComfortCriuser()
# # myBicycle = new FrameColorDecorator myBicycle, "red"

# # myBicycle = new HeadlightDecorator myBicycle

# # myBicycle = new HeadlightDecorator myBicycle

# # alert myBicycle.assamble()


# class LifetimeWarrantyDecorator
# 	constructor: ->
# 		super bicycle

# 	repair = ->
# 		"This bicycle is covered by a lifetime warranty. Please take it to an authorized Acme Repair Centre."

# 	getPrice: ->
# 		@bicycle.getPrice() + 199


# class TimedWarrantyDecorator extends BicycleDecorator
# 	constructor: (bicycle, @coverageLength) ->
# 		super bicycle
# 		@expDate = (new Date()).getTime() + @coverageLength * 365 * 24 * 60 * 60 * 1000

# 	repair: ->
# 		if (new Date()).getTime() < @expDate then "This bicycle is currently covered by a warranty. Please take it to an authorized Acme Repair Center."
# 		else @bicycle.repair()

# 	getPrice: ->
# 		@bicycle.getPrice() + 40 * @coverageLength


# class BellDecorator extends BicycleDecorator
# 	constructor: (bicycle) ->
# 		super bicycle

# 	assamble: ->
# 		@bicycle.assamble() + " Attach bell to handlebars."

# 	getPrice: ->
# 		@bicycle.getPrice() + 6

# 	ringBell: ->
# 		"Bell rung."

# # myBicycle = new AcmeComfortCriuser()
# # myBicycle = new BellDecorator myBicycle

# # alert myBicycle.ringBell()

# # myBicycle = new AcmeComfortCriuser()
# # myBicycle = new BellDecorator myBicycle

# # myBicycle = new HeadlightDecorator myBicycle

# # alert myBicycle.ringBell()


# class BicycleDecorator
# 	constructor: (@bicycle) ->
# 		@interface = Bicycle

# 		for key of bicycle
# 			continue if typeof key isnt "function"
		
# 			for method in @interface.methods
# 				if key is method
# 					((methodName) =>
# 						@[methodName] = ->
# 							@bicycle[methodName]()
# 					)(key)

# 	assamble: ->
# 		@bicycle.assamble()
# 	wash: ->
# 		@bicycle.wash()
# 	ride: ->
# 		@bicycle.ride()
# 	repair: ->
# 		@bicycle.repair()
# 	getPrice: ->
# 		@bicycle.getPrice()


# class AcmeBicycleShop extends BicycleShop
# 	constructor: ->

# 	createBicycle: (model, options) ->
# 		bicycle = new AcmeBicycleShop.models[model]()

# 		for option in options
# 			decorator = AcmeBicycleShop.options[option.name]
# 			if typeof decorator isnt "function"
# 				throw new Error "Decorator " + option.name + " not found."
# 			new decorator bicycle, option.arg

# 	AcmeBicycleShop.models = [
# 		"The Speedster": AcmeSpeedster
# 		"The Lowrider": AcmeLowrider
# 		"The Flatlander": AcmeFlatlander
# 		"The Comfort Cruiser": AcmeComfortCruiser
# 	]

# 	AcmeBicycleShop.options =
# 		"heandlight": HeadlightDecorator
# 		"taillight": TaillightDecorator
# 		"bell": BellDecorator
# 		"basket": BasketDecorator
# 		"color": FrameColorDecorator
# 		"lifetime warranty": LifetimeWarrantyDecorator
# 		"timed warranty": TimedWarrantyDecorator

# alecsCruisers = new AcmeBicycleShop()
# myBicycle = alecsCruisers.createBicycle "The Speedster", [
# 	name: "color", arg: "blue"
# 	name: "heandlight"
# 	name: "taillight"
# 	name: "timed warranty", arg: 2
# ]


# upperCaseDecorator = (func) ->
# 	->
# 		func.apply @, argumments
# 			.toUpperCase()

# getDate = ->
# 	(new Date()).toString()

# getDateCaps = upperCaseDecorator getDate

# BellDecorator::ringBellLoudly =
# 	upperCaseDecorator BellDecorator::ringBell


# class ListBuilder
# 	constructor: (parent, @listLength) ->
# 		@parentEl = document.querySelector parent

# 	buildList: ->
# 		list = document.createElement "ol"
# 		@parentEl.appendChild list
# 		list.appendChild document.createElement "li" for item in [0..@listLength]

# class SimpleProfile
# 	constructor: (@component) ->

# 	buildList: ->
# 		startTime = new Date()
# 		@component.buildList()
# 		elapsedTime = (new Date()).getTime() - startTime.getTime()
# 		console.log "buildList: #{elapsedTime} ms"

# list = new ListBuilder "list-container", 5000
# list = new SimpleProfile list

# list.buildList()


# class MethodProfile
# 	constructor: (@component) ->
# 		@timers = { }

# 		for value, name in @component when typeof value is "function"
# 			do (name) ->
# 				=>
# 					@[name] = ->
# 						@startTime name
# 						returnValue = @component[name].apply @component, arguments
# 						@displayTime name, @getElapsedTime name
# 						returnValue

# 	startTime: (name) ->
# 		@timers[name] = (new Date()).getTime()

# 	getElapsedTime: (name) ->
# 		(new Date()).getTime() - @timers[name]

# 	displayTime: (name, time) ->
# 		console.log "#{name}: #{time} ms"

# var list = new ListBuilder 'list-container', 5000
# list = new MethodProfiler list
# list.buildList('ol'
# list.buildList('ul'); // Displays "buildList: 287 ms".
# list.removeLists('ul'); // Displays "removeLists: 10 ms".
# list.removeLists('ol'); // Displays "removeLists: 12 ms".


# Компонент
class Notebook
	constructor: ->
		# Маркетинг
		@price = 500 # $

		# Характеристики
		@hdd = 320
		@ram = 4
		@core = "i5 2.3"

# Декоратор
class NovaNotebook extends Notebook
	constructor: (product) ->
		super product
		@price = @product.price * 1.3

# Декоратор
class ImportNotebook extends Notebook
	constructor: (product) ->
		@product = product
		@price = @product.price * 1.5

# Декоратор
class AppleNotebook extends Notebook
	constructor: (product) ->
		super product
		@price = @price * 2.1

macBookInRussia = new NovaNotebook new Notebook
console.log macBookInRussia
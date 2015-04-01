class Publisher
	@subscribers = [ ]

	deliver: (data) ->
		@subscribers.forEach (fn) ->
			fn data
		@

Function::subscribe = (publisher) ->
	alreadyExists = publisher.subscribers.some (el) => on if el is @
	publisher.subscribers.push @ unless alreadyExists
	@

Function::unsubscribe = (publisher) ->
	publisher.subscribers = publisher.subscribers.filter (el) => el if el isnt @
	@

publisherObject = new Publisher

observerObject.subscribe publisherObject

#

Animation = (o) ->
	@onStart = new Publisher
	@onTween = new Publisher
	@onComplate = new Publisher

	fly: ->
		@onStart.deliver()
		@onTween.deliver n for n in [0..framesLength]
		@onComplate.deliver()

Superman = new Animation { }

putOnCare.subscribe Superman.onStart
takeOffCafe.subscribe Superman.onComplate

Superman.fly()

addEvent element, "click", -> Superman.fly()
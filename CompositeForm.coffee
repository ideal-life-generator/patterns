class CompositeForm
	constructor: (id, method, action) ->
		@formComponents = [ ]

		@element = document.createElement "form"
		@element.id = id
		@element.method = method or "POST"
		@element.action = action or "#"

	add: (child) ->
		@formComponents.push child
		@element.appendChild child.getElement()

	remove: (child) ->
		for component, i in @formComponents when component is child
			@formComponents.slice i, 1
			break

	getChild: (n) ->
		@formComponents[n]

	save: ->
		component.save() for component in @formComponents

	restore: ->
		component.restore() for component in @formComponents

	getElement: ->
		@element


class CompositeFieldset
	constructor: (id, legendText) ->
		@components = { }

		@element = document.createElement "fieldset"
		@element.id = id

		if legendText
			@legend = document.createElement "legend"
			@legend.appendChild document.createTextNode legendText
			@element.appendChild @legend

	add: (child) ->
		@components[child.id] = child
		@element.appendChild child.getElement()

	remove: (child) ->
		delete @components[child.id]

	getChild: (id) ->
		@components[id] if @components[id]

	save: ->
		component.save() for own name, component of @components

	restore: ->
		component.restore() for own name, component of @components

	getElement: ->
		@element


class Field
	constructor: (@id) ->
		@element

	add: ->

	remove: ->

	getChild: ->

	save: ->
		setCookie @id, @getValue

	restore: ->
		@element.value = getCookie @id

	getElement: ->
		@element

	getValue: ->
		throw new Error "Unsupported operation on the class Field."


class InputField extends Field
	constructor: (id, label) ->
		Field.call @, id

		@input = document.createElement "input"
		@input.id = id

		@label = document.createElement "label"
		labelTextNode = document.createTextNode label
		@label.appendChild labelTextNode

		@element = document.createElement "div"
		@element.className = "input-field"
		@element.appendChild @label
		@element.appendChild @input

	getValue: ->
		@input.value


class TextareaField extends Field
	constructor: (id, label) ->
		Field.call @, id

		@textarea = document.createElement "textarea"
		@textarea.id = id

		@label = document.createElement "label"
		labelTextNode = document.createTextNode label
		@label.appendChild labelTextNode

		@element = document.createElement "div"
		@element.className = "input-field"
		@element.appendChild @label
		@element.appendChild @textarea

	getValue: ->
		@textarea.value


class SelectField extends Field
	constructor: (id, label) ->
		Field.call @, id

		@select = document.createElement "select"
		@select.id = id

		@label = document.createElement "label"
		labelTextNode = document.createTextNode label
		@label.appendChild labelTextNode

		@element = document.createElement "div"
		@element.className = "input-field"
		@element.appendChild @label
		@element.appendChild @select

	getValue: ->
		@select.select.options[@select.selectedIndex].value


contactForm = new CompositeForm "contact-form", "POST", "contact.php"

nameFieldset = new CompositeFieldset "name-fieldset"
nameFieldset.add new InputField "first-name", "First Name"
nameFieldset.add new InputField "last-name", "Last Name"
contactForm.add nameFieldset

addresFieldset = new CompositeFieldset "addres-fieldset"
addresFieldset.add new InputField "addres", "Addres"
addresFieldset.add new InputField "city", "City"
addresFieldset.add new SelectField "state", "State", [ ]
addresFieldset.add new InputField "zip", "Zip"
contactForm.add addresFieldset

console.log new InputField("first-name", "First Name").getElement().id

contactForm.add new TextareaField "comments", "Comments"

document.body.appendChild contactForm.getElement()

console.log contactForm

# addEvent window, "upload", contactForm.save
# addEvent window, "load", contactForm.restore

# addEvent "save-button", "click", nameFieldset.save
# addEvent "restore-button", "click", nameFieldset.restore
# class StopAd
# 	constructor: (@ad = adObject) ->

# 	execute: ->
# 		@ad.stop()

# class StartAd
# 	constructor: (@ad = adObject) ->

# 	execute: ->
# 		@ad.stop()


# ads = getAds()
# for ad in ads
# 	startCommand = new StartAd ad
# 	stopCommand = new StopAd ad

# 	new UIButton "Start #{ad.name}", startCommand
# 	new UIButton "Stop #{ad.name}", stopCommand


# makeStart (adObject) -> -> adObject.start()
# makeStop (adObject) -> -> adObject.stop()

# startCommand = makeStart ads[0]
# stopCommand = makeStop ads[0]

# startCommand()
# stopCommand()


# class SimpleCommand
# 	constructor: (@receiver) ->

# 	execute: ->
# 		@receiver.action()


# class ComplexCommand
# 	constructor: ->
# 		@logger = new logger
# 		@xhrHandler = XhrManager.createXhrHandler()
# 		@parameters = { }

# 	setParameter: (key, value) ->
# 		@parameters[key] = value

# 	execute: ->
# 		@logger.log "Executing command"
# 		postArray = [ ]
# 		postArray.push "#{key}=#{value}" for key, value of @parameters
# 		postString = postArray.join "&"
# 		@xhrHandler.request "POST", "script.php", (->), postString


# class GreyAreaCommand
# 	constructor: (@receiver) ->
# 		@logger = new logger

# 	execute: ->
# 		@logger.log "Executing command"
# 		@receiver.prepareAction()
# 		@receiver.action()

# #

# class MenuBar
# 	constructor: ->
# 		@menus = { }
# 		@element = document.createElement "ul"
# 		@element.style.display = "none"

# 	add: (menuObject) ->
# 		@menus[menuObject.name] = menuObject
# 		@element.appendChild @menus[menuObject.name].getElement()

# 	remove: (name) ->
# 		delete @menus[name]

# 	getChild: (name) ->
# 		@menus[name]

# 	getElement: ->
# 		@element

# 	show: ->
# 		@element.style.display = "block"
# 		menu.show() for key, menu of @menus

# class Menu
# 	constructor: (@name) ->
# 		@items = { }
# 		@element = document.createElement "li"
# 		@element.innerHTML = @name
# 		@element.style.display = "none"
# 		@container = document.createElement "ul"
# 		@element.appendChild @container

# 	add: (menuItemObject) ->
# 		@items[menuItemObject.name] = menuItemObject
# 		@container.appendChild @items[menuItemObject.name].getElement()

# 	remove: (name) ->
# 		delete @items[name]

# 	getChild: (name) ->
# 		@items[name]

# 	getElement: ->
# 		@element

# 	show: ->
# 		@element.style.display = "block"
# 		item.show() for key, item of @items

# class MenuItem
# 	constructor: (@name, command) ->
# 		@element = document.createElement "li"
# 		@element.style.display = "none"
# 		@anchor = document.createElement "a"
# 		@anchor.href = "#"
# 		@element.appendChild @anchor
# 		@anchor.innerHTML = @name

# 		addEvent @anchor, "click", (e) ->
# 			e.preventDefault()
# 			command.execute()

# 	add: ->

# 	remove: ->

# 	getChild: ->
	
# 	getElement: ->
# 		@element

# 	show: ->
# 		@element.style.display = "block"

# class MenuCommand
# 	constructor: (@action) ->

# 	execure: ->
# 		@action()

# fileActions = new FileActions
# editActions = new EditActions
# insertActions = new InsertActions
# helpActions = new HelpActions

# appMenuBar = new MenuBar

# fileMenu = new Menu "File"

# openCommand = new MenuCommand fileActions.open
# closeCommand = new MenuCommand fileActions.close
# saveCommand = new MenuCommand fileActions.save
# saveAsCommand = new MenuCommand fileActions.saveAs

# fileMenu.add new MenuItem "Open", openCommand
# fileMenu.add new MenuItem "Close", closeCommand
# fileMenu.add new MenuItem "Save", saveCommand
# fileMenu.add new MenuItem "Save As...", saveAsCommand

# appMenuBar.add fileMenu

# editMenu = new Menu "Edit"

# cutCommand = new MenuCommand editActions.cut
# copyCommand = new MenuCommand editActions.copy
# pasteCommand = new MenuCommand editActions.paste
# deleteCommand = new MenuCommand editActions.delete

# editMenu.add new MenuItem "Cut", cutCommand
# editMenu.add new MenuItem "Copy", copyCommand
# editMenu.add new MenuItem "Paste", pasteCommand
# editMenu.add new MenuItem "Delete", deleteAsCommand

# appMenuBar.add editMenu

# insertMenu = new Menu "Insert"

# textBlockCommand = new MenuCommand insertActions.textBlock
# imageCommand = new MenuCommand insertActions.image

# insertMenu.add new MenuItem "Text Block", textBlockCommand
# insertMenu.add new MenuItem "Image", imageCommand

# appMenuBar.add insertMenu

# helpMenu = new Menu "Help"

# showHelpCommand = new MenuCommand helpActions.showHelp

# helpMenu.add new MenuItem "Text Block", showHelpCommand

# appMenuBar.add helpMenu

# document.querySelector "body"
# 	.appendChild appMenuBar.getElement()

# appMenuBar.show()


#

# class MoveUp
# 	constructor: (@cursor) ->

# 	execute: ->
# 		@cursor.move 0, -10

# class MoveDown
# 	constructor: (@cursor) ->

# 	execute: ->
# 		@cursor.move 0, 10

# class MoveLeft
# 	constructor: (@cursor) ->

# 	execute: ->
# 		@cursor.move -10, 0

# class MoveRight
# 	constructor: (@cursor) ->

# 	execute: ->
# 		@cursor.move 10, 0

# class Cursor
# 	constructor: (@width, @height, parent) ->
# 		@commandStack = [ ]

# 		@canvas = document.createElement "canvas"
# 		@canvas.width = @width
# 		@canvas.height = @height
# 		parent.appendChild @canvas

# 		@ctx = @canvas.getContext "2d"
# 		@ctx.fillStyle = "#cc0000"
# 		@move 0, 0

# 	move: (x, y) ->
# 		@commandStack.push => @lineTo x, y
# 		@executeCommands()

# 	lineTo: (x, y) ->
# 		@position.x += x
# 		@position.y += y
# 		@ctx.lineTo @position.x, @position.y

# 	executeCommands: ->
# 		@position = x: @width / 2, y: @height / 2
# 		@ctx.clearRect 0, 0, @width, @height
# 		@ctx.beginPath()
# 		@ctx.moveTo @position.x, @position.y
# 		command() for command in @commandStack
# 		@ctx.stroke()

# 	undo: ->
# 		@commandStack.pop()
# 		@executeCommands()

# class CommandButton
# 	constructor: (label, command, parent) ->
# 		@element = document.createElement "button"
# 		@element.innerHTML = label
# 		parent.appendChild @element

# 		@element.addEventListener "click", ->
# 			command.execute()

# class UndoButton
# 	constructor: (label, parent, cursor) ->
# 		@element = document.createElement "button"
# 		@element.innerHTML = label
# 		parent.appendChild @element

# 		@element.addEventListener "click", ->
# 			cursor.undo()

# body = document.querySelector "body"
# cursor = new Cursor 400, 400, body

# upCommand = new MoveUp cursor
# downCommand = new MoveDown cursor
# leftCommand = new MoveLeft cursor
# rightCommand = new MoveRight cursor

# upButton = new CommandButton "Up", upCommand, body
# downButton = new CommandButton "Down", downCommand, body
# leftButton = new CommandButton "Left", leftCommand, body
# rightButton = new CommandButton "Right", rightCommand, body
# undoButton = new UndoButton "Undo", body, cursor


#

# CCommand - базовый класс, объявляет операции для выполнения и отмены команд ( execute, unExecute )
# CDocument - получатель команды, обеспечивает основные операции над документом
# CCommandImpl - вспомогательный класс, обеспечивает согласованое выполнение и отмену команды
# CInsertTextCommand, CEraseTextCommand - конкретные команды редактирования документа
# CCommands - инициатор команды, история изменений, undo/redo
# CTextEditor - клиент, упровляет созданием команд, и передачей их инициатору, предоставляет команды undo/redo которые перенаправляются CCommands


class TextArea
	constructor: (parent, @width, @height, @placeholder) ->
		@element = document.createElement "textarea"
		@element.style.width = @width + "px"
		@element.style.height = @height + "px"
		@element.placeholder = placeholder

		parent.appendChild @element

class TextInsertCommand
	constructor: (@area = area.element, @text) ->

	execute: ->
		@area.element.value += @text

	unExecute: ->
		@area.element.value = @area.element.value.slice 0, @area.element.value.length - @text.length

class TextCommander
	constructor: ->
		@commands = [ ]
		@count = 0

	execute: (command) ->
		@commands[@count] = command
		command.execute()
		@count++

	redo: ->
		if @count < @commands.length
			@count++
			@commands[@count-1].execute()

	undo: ->
		if @count > 0
			@commands[@count-1].unExecute()
			@count--

class TextInputButton
	constructor: (@parent, @placeholder) ->
		@element = document.createElement "input"
		@element.placeholder = @placeholder

		@parent.appendChild @element

class TextExecuteButton
	constructor: (@parent, @name, @input, commander) ->
		@element = document.createElement "button"
		@element.innerHTML = @name

		@parent.appendChild @element

		@element.addEventListener "click", =>
			commander.execute new TextInsertCommand area, @input.element.value
			@input.element.value = ""

class TextUndoButton
	constructor: (@parent, @name, commander) ->
		@element = document.createElement "button"
		@element.innerHTML = @name

		@parent.appendChild @element

		@element.addEventListener "click", ->
			commander.undo()

class TextRedoButton
	constructor: (@parent, @name, commander) ->
		@element = document.createElement "button"
		@element.innerHTML = @name

		@parent.appendChild @element

		@element.addEventListener "click", ->
			commander.redo()


area = new TextArea document.body, 300, 100, "text-area"
insertCommand = new TextCommander
textInput = new TextInputButton document.body, "input text here"
executeButton = new TextExecuteButton document.body, "Insert text", textInput, insertCommand
undoButton = new TextUndoButton document.body, "Undo", insertCommand
redoButton = new TextRedoButton document.body, "Redo", insertCommand
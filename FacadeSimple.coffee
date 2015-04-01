addEvent = (el, type, fn) ->
	if addEventListener then el.addEventListener type, fn
	else if attachEvent then el.attachEvent "on" + type, fn
	else el["on" + type] = fn


a = (x) ->
b = (y) ->
ab = (x, y) ->
	a x
	b y


DED = DED or { }
DED.util =


setStyle = (elements, prop, val) ->
	document.getElementById element
		.style[prop] = val for element in elements

# setStyle [ "foo", "bar", "baz" ], "color", "red"

setCSS = (el, styles) ->
	setStyle el, prop, style for own prop, style of styes

# setCSS [ "foo" ], position: "absolute", top: "50px", left: "300px"

# setCSS [ "foo", "bar", "baz" ], color: "white", background: "black", fontSize: "16px", fontFamily: "Georgia, times, self"


DED.util.Event =
	getEvent: (e) -> e or event

	getTarget: (e) -> e.target or e.srcElement

	stopPropagation: (e) ->
		if e.stopPropagation then e.stopPropagation()
		else e.cancelBuble = on

	preventDefault: (e) ->
		if e.preventDefault then e.preventDefault()
		else e.returnValue = off

	stopEvent: (e) ->
		@stopPropagation e
		@preventDefault e

addEvent document.querySelector("body"), "click", (e) ->
	console.log DED.util.Event.getTarget e
	DED.util.Event.stopEvent e
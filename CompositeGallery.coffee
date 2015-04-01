class DynamicGallery
	constructor: (id) ->
		@childrens = [ ]

		@element = document.createElement "div"
		@element.id = id
		@element.className = "dynamic-gallery"

	add: (child) ->
		@children.push child
		@element.appendChild child.getElement()

	remove: (child) ->
		for children in @childrens, i when children is child
			@childrens.slice i, 1
			break
		@element.removeChild child.getElement()

	getChild: (n) ->
		@childrens[n]

	hide: ->
		children.hide() for children in @childrens
		@element.style.display = "none"

	show: ->
		@element.style.display = "block"
		children.show() for children in @childrens

	getElement: ->
		@element


class GalleryImage
	constructor: (src) ->
		@element = document.createElement "img"
		@element.className = "gallery-image"
		@element.src = src

	add: ->
	remove: ->
	getChild: ->

	hide: ->
		@element.style.display = "none"

	show: ->
		@element.style.display = ""

	getElement: ->
		@element


topGallery = new DynamicGallery "top-gallery"

topGallery.add new GalleryImage "/img/image-1.jpg"
topGallery.add new GalleryImage "/img/image-2.jpg"
topGallery.add new GalleryImage "/img/image-3.jpg"

vacationPhotos = new DynamicGallery "vacation-photos"

vacationPhotos.add imageIndex for imageIndex in [0..30]

topGallery.add vacationPhotos
topGallery.show()
vacationPhotos.hide()
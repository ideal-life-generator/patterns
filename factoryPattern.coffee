class Item
	createItem: (type) ->
		item = @createType type
		item.getInfo()
		item.setTime()
		item

	createType: (type) ->
		new Error "This is abstract class"

class Shoes extends Item
	createType: (type) ->
		switch type
			when "Oxfords" then new ShoesOxfords()
			when "Boots" then new ShoesBoots()
			else new ShoesUncathegory()

class Jackets extends Item
	createType: (type) ->
		switch type
			when "Clothing" then new JacketsClothing()
			when "Watches" then new JacketsWatches()
			else new JacketsUncathegory()

shoes = new Shoes()
shoesOxfords = shoes.createType "Oxfords"

jackets = new Jackets()
jacketsClothing = jackets.createType "Clothing"
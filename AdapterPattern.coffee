clientObject =
	string1: "foo"
	string2: "bar"
	string3: "baz"

interfaceMethod = (str1, str2, str3) ->

clientToInterfaceAdapter = (object) ->
	interfaceMethod object.string1, object.string2, object.string3

clientToInterfaceAdapter clientObject
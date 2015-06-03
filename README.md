## Ordered Dictionary

This is a simple implementation of an OrderedDictionary in Swift since Apple does not provide a default implementation. 
It will maintain the order that objects are added. 
Furthermore, it is generic so that it supports any Hashable key and a value of any type. 
The OrderedDictionary supports very similar syntax to the standard dictionary. This means you can use subscript syntax and iterate through the dictionary using a tuple, see Example Usage for more details. 

#Example Usage

	var orderedDict = OrderedDictionary<String, Int>()
	orderedDict["A"] = 100
	orderedDict["B"] = 102
	orderedDict["C"] = 103
	orderedDict["A"] = nil // will remove that element from the dict
	
	// supports tuple iteration in order of insertion
	for (key, value) in orderedDict {
		println("Key: \(key), Value: \(value)")
	}

	// lets you determine if a key already exists
	let containsKey = orderedDict.containsKey("A")
	
	// Allows updating without subscript syntax as well
	orderedDict.updateValue(123, forKey: "B")
	
	// Get the position of an item in your list
	orderedDict.getKeyPosition("B")
	
	// Find a key at a given position
	orderedDict.getKeyAtPosition(0)



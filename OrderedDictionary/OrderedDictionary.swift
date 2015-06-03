//
//  OrderedDictionary.swift
//  BookShelf
//
//  Created by Joel Cummings on 2015-06-02.
//  Copyright (c) 2015 Joel Cummings. All rights reserved.
//

import Foundation

/**
*  The Ordered dictionary is designed to maintain the order of insertion into a dictionary.
*  This enables one to use sorted data within the dictionary
*/
public struct OrderedDictionary<Tk: Hashable, Tv> : Printable, SequenceType {
	
	private var keys: Array<Tk> = []
	private var dict: Dictionary<Tk, Tv> = [:]

	
	public init() {
		
	}
	
	/**
	Allows iteration of the dictionary
	
	:returns: returns a tuple of the form ([key], [value])
	*/
	public func generate() -> GeneratorOf<(Tk, Tv)> {
	
		var lastIndex = countKeys()
		var nextIndex = 0
		
		return GeneratorOf<(Tk, Tv)> {
			if (nextIndex >= lastIndex) {
				return nil
			}
			var result: (Tk, Tv) = (self.keys[nextIndex], self.dict[self.keys[nextIndex]]!)
			nextIndex++
			return result
			
		}
	
	}
	
	/// Outputs the dictionary in string format
	public var description: String {
		get {
			var str = "{\n"
			for (key, value) in self {
				str += "\tKey: \(key), Value: \(value)\n"
			}
			str += "}"
			return str
		}
	}
	
	/**
	Allows access via the subscript operator to manipulate 
	the structure like a normal non-ordered dictionary. 
	
	:param: key key inside the dictionary
	
	:returns: The value at that position if the key exists, nil otherwise
	*/
	public subscript(key: Tk) -> Tv? {
		get {
			return dict[key]
		}
		set(newValue) {
			if newValue != nil {
				
				// If the key exists update it and leave positions alone
				let existsInDict = self.dict[key]
				if existsInDict == nil {
					self.keys.append(key)
				}
				
				self.dict[key] = newValue
				
				return
			} else {
				self.dict.removeValueForKey(key)
				self.keys.removeAtIndex(getKeyPosition(key)!)
			}
		}
	}
	
	
	/**
	Searches the dictionary to determine if the key already exists.
	Note: if the key exists it also contains some non-nil value 
	in the dictionary.
	
	:param: key The key of to locate in the dictionary
	
	:returns: true if the key exists and has a value, false otherwise
	
		*/
	public func containsKey(key: Tk) -> Bool {
		var result: Bool
		if let value = self.dict[key] {
			result = true
		} else {
			result = false
		}
		
		return result
	}
	
	
	/**
	Counts the keys within the dictionary
	
	:returns: the total number of keys in the dictionary
	*/
	func countKeys() -> Int {
		return keys.count
	}
	
	/**
	Retrieves the key from dictionary given a position
	
	:param: pos some integer value in the dictionary
	
	:returns: the key value if it exists, nil otherwise
	*/
	public func getKeyAtPosition(pos: Int) -> Tk? {
		var result: Tk?
		if (pos < self.keys.count) {
			result = self.keys[pos]
		}
		return result
	}
	
	/**
	Returns the value at a given position in the dictionary
	
	:param: pos some integer value in the dictionary
	
	:returns: the value at that position
	*/
	public func getValueAtPosition(pos: Int) -> Tv? {
		var result: Tv?
		if let key = getKeyAtPosition(pos) {
			result =  self.dict[key]
		}
		return result
	}
	
	/**
	Given a key in the dicitionary retrieve its position
	
	:param: key to search in the dictionary
	
	:returns: the position of the key provided it exists, nil otherwise
	*/
	public func getKeyPosition(key: Tk) -> Int? {
		var keyPos: Int?
		for var i = 0; i < self.keys.count; i++ {
			if key == keys[i] {
				keyPos = i;
				break
			}
		}
		
		return keyPos
	}
	
	/**
	Updates a current key value pair in the dictionary at a particular position
	
	:param: newValue The new value to be added
	:param: key      They current key within the dictionary to replace the value for
	*/
	mutating public func updateValue(newValue: Tv, forKey key: Tk) {
		if let keyPos = getKeyPosition(key) {
			keys[keyPos] = key
			dict.updateValue(newValue, forKey: key)
			
		}
	}
	
	
}


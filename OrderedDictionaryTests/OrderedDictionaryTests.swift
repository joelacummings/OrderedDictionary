//
//  OrderedDictionaryTests.swift
//  OrderedDictionaryTests
//
//  Created by Joel Cummings on 2015-06-03.
//  Copyright (c) 2015 Joel Cummings. All rights reserved.
//

import UIKit
import XCTest
import OrderedDictionary

class OrderedDictionaryTests: XCTestCase {
    
	var od = OrderedDictionary<String, Int>()
	
	override func setUp() {
		super.setUp()
		
		
	}
	
	func testAddIntoDictionary() {
		od["A"] = 1
		od["B"] = 2
		od["C"] = 3
		od["D"] = 4
		od["E"] = 5
		od["F"] = 6
		od["G"] = 7
		od["H"] = 8
		od["I"] = 9
		od["J"] = 10
		
		println(od["A"])
		
		if let position: Int = self.od.getKeyPosition("A") {
			XCTAssertEqual(position, 0, "The correct Position for A is found")
		} else {
			XCTAssertTrue(false, "The Key A was not found, but should've been")
		}
		
		od["A"] = nil
		
		if let position: Int = self.od.getKeyPosition("A") {
			XCTAssertTrue(false, "Should not have found, it was removed: Found at Position: \(position)")
		} else {
			XCTAssertTrue(true, "The non-existant key was not found")
		}
		
		od["C"] = 123
		
		XCTAssertTrue(od["C"] == 123, "The Update value has been accepted")
		
		od["C"] = nil
		
		XCTAssertFalse(od.containsKey("C"), "The key was successfully removed")
		
		
		od.updateValue(123, forKey: "B")
		
		
	}
	
	
	func testRemoval() {
		var dict = OrderedDictionary<String, String>()
		
		dict["Person A"] = "George Johnson"
		dict["Person B"] = "Rob Smith"
		dict["Person C"] = "Tom Dunn"
		
		dict["Person B"] = nil
		
		let personBContained = dict.containsKey("Person B")
		
		XCTAssertFalse(personBContained, "Person B is not contained")
		
		dict["Person B"] = "Re-added Person B"
		
		let nowContained = dict.containsKey("Person B")
		
		XCTAssertTrue(nowContained, "Person B has been re-added")
		
		let expectedKeyPos = 2
		let actualKeyPosition = dict.getKeyPosition("Person B")
		
		XCTAssertTrue(expectedKeyPos == actualKeyPosition, "Test Person B was added to the end of the list")
		
	}
	
	func testReplace() {
		
		var dict = OrderedDictionary<String, String>()
		
		dict["A"]  = "Jim"
		dict["B"] = "Tim"
		dict["C"] = "Paul"
		
		let keyPosition = dict.getKeyPosition("B")
		let expectedPosition: Int = 1
		
		XCTAssertTrue(keyPosition == expectedPosition, "Test B Matches expected position of 1")
		
		let value: String = dict.getValueAtPosition(1)!
		let expectedValue: String = "Tim"
		
		XCTAssertTrue(value == expectedValue, "Test Order is correct")
		
		
		dict["B"] = "John"
		
		let newKeyPosition = dict.getKeyPosition("B")
		let newExpectedPos: Int = 1
		
		XCTAssertTrue(newKeyPosition == newKeyPosition, "Test B Matches expected position of 1")
		
		let newValue: String = dict.getValueAtPosition(1)!
		let expectedNewValue: String = "John"
		
		XCTAssertTrue(newValue == expectedNewValue, "Test Order is correct")
		
	}
	
}

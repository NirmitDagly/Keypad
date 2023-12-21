//
//  KeypadTests.swift
//  KeypadTests
//
//  Created by Nirmit Dagly on 20/12/2023.
//

import XCTest
@testable import Keypad

final class KeypadTests: XCTestCase {

	var keypadViewModel: KeypadViewModel!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		keypadViewModel = KeypadViewModel(itemDetails: [String: Any]())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		keypadViewModel = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
	
	func test_ClickOnKeypadButton() {
		let currentPrice = "0.00"
		let enteredPrice = "100"
		
		let updatedPrice = keypadViewModel.updatePriceOnButtonClick(currentEnteredPrice: currentPrice, andSelectedAmount: enteredPrice)
		let expectedPrice = "1.00"
		
		XCTAssertEqual(updatedPrice, expectedPrice, "Test passed...")
	}
	
	func test_ClickOnKeypadBackButton() {
		let currentPrice = "100.00"
		
		let updatedPrice = keypadViewModel.updateValueOnBackspaceClick(currentEnteredPrice: currentPrice)
		let expectedPrice = "10.00"
		
		XCTAssertEqual(updatedPrice, expectedPrice, "Test passed...")
	}
	
	func test_ValidateAmount() {
		let eneteredAmount = "5000.00"
		
		let result = keypadViewModel.validateEnteredAmount(currentEnteredAmount: eneteredAmount)
		XCTAssertTrue(result, "Test passed...")
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

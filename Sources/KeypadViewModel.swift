//
//  KeypadViewModel.swift
//  Keypad
//
//  Created by Nirmit Dagly on 20/12/2023.
//

import Foundation
import SwiftUI

struct KeyPadButtons: Hashable {
	var buttonText: String
	var isImage: Bool
	var buttonTag: Int
}

public class KeypadViewModel: ObservableObject {
	
	@Published var infoMessage: AlertInfo?
	
	@Published public var itemDetails = [String: Any]()
	
	public init() {
		//Define memberwise initializers here...
	}

	func displayAlertWithMessage(withID id: AlertType, andTitle title: String, withMessage message: String) {
		infoMessage = AlertInfo(id: id, title: title, message: message)
	}
	
	//MARK: Update text in the Item price text field when the keypad button clicked every time.
	func updatePriceOnButtonClick(currentEnteredPrice currentPrice: String, andSelectedAmount selectedAmount: String) -> String {
		let amount = currentPrice.components(separatedBy: ".")
		var intValue: String = amount[0]
		var decimalValue: String = amount[1]
		
		//Need to consider if user paste value
		if selectedAmount.count > 2 {
			decimalValue = String(selectedAmount.suffix(2))
			intValue = String(selectedAmount.dropLast(2))
		} else if selectedAmount.count == 2 {
			decimalValue = amount[1] + selectedAmount
			
			intValue = intValue + String(decimalValue.first!)
			decimalValue = String(decimalValue.dropFirst())
			
			intValue = intValue + String(decimalValue.first!)
			decimalValue = String(decimalValue.dropFirst())
			
			if intValue.first == "0" {
				//Remove 0 from at the first position in intValue
				intValue.remove(at: intValue.startIndex)    //01 -> 1
			}
		} else {
			decimalValue = amount[1] + selectedAmount
			
			//Add to int value (move to the right)
			intValue = intValue + String(decimalValue.first!)
			
			if Int(intValue) == 0 {
				intValue = "0"      //00 -> 0
			} else if intValue.first == "0" {
				//Remove 0 from at the first position in intValue
				intValue.remove(at: intValue.startIndex)    //01 -> 1
			}
			
			//Remove tenth place from decimal value since it goes to Int already
			decimalValue.remove(at: decimalValue.startIndex)
		}
		
		return String(format: "%.2f", Double(intValue + "." + decimalValue)!)
	}
	
	//MARK: When user clicks on 'Back' button, update the current price value in the field.
	func updateValueOnBackspaceClick(currentEnteredPrice currentPrice: String) -> String {
		let amount = currentPrice.components(separatedBy: ".")
		var intValue: String = amount[0]
		var decimalValue: String = amount[1]
		
			//Backspace registered, need to move the number to the right
		decimalValue.remove(at: decimalValue.index(before: decimalValue.endIndex))
		decimalValue = String(intValue.last!) + decimalValue
		intValue.remove(at: intValue.index(before: intValue.endIndex))
		if intValue.isEmpty {
			intValue = "0"
		}
		
		return intValue + "." + decimalValue
	}
	
	//MARK: Validate that the amount entered is within limit. Max. can be added as $10,000 for one transaction.
	func validateEnteredAmount(currentEnteredAmount currentPrice: String) -> Bool {
		return Double(currentPrice)! <= 10000.00 ? true : false
	}
	
	//MARK: When User clicks on add button, after all validations took in place
	func addItemsToCart(forItem itemDescription: String, withPrice itemPrice: String) {
		itemDetails = ["itemDescreption": itemDescription, "itemPrice": itemPrice]
		print("The items that needs to be added to the cart is: \(itemDetails)")
	}
}

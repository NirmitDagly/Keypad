//
//  KeypadView.swift
//  Keypad
//
//  Created by Nirmit Dagly on 20/12/2023.
//

import SwiftUI

#Preview {
	KeypadView(itemDescription: "", itemPrice: "0.00")
}

public struct KeypadView: View {
	@State var itemDescription: String
	@State var itemPrice: String
	@StateObject private var keypadViewModel = KeypadViewModel()
	
	public var body: some View {
		GeometryReader { geometryReader in
			VStack(spacing: 0) {
				ItemDescriptionView(itemDescription: $itemDescription)
				
				ItemPriceView(itemPrice: $itemPrice)
				
				KeypadView1(itemPrice: $itemPrice,
							keypadViewModel: keypadViewModel)
					.padding(.top, 40)
				
				HorizontalDividerViewForKeypad()
				
				KeypadView2(itemPrice: $itemPrice,
							keypadViewModel: keypadViewModel)
				
				HorizontalDividerViewForKeypad()
				
				HStack(spacing: 0) {
					VStack(spacing: 0) {
						KeypadView3(itemPrice: $itemPrice,
									keypadViewModel: keypadViewModel)
						
						HorizontalDividerViewForKeypad()
						
						KeypadView4(itemPrice: $itemPrice,
									keypadViewModel: keypadViewModel)
					}
					
					AddButton(itemDescription: $itemDescription, itemPrice: $itemPrice, keypadViewModel: keypadViewModel)
						.frame(width: geometryReader.size.width / 4)
				}
				.frame(height: 240)
			}
			.alert(item: $keypadViewModel.infoMessage, content: { info in
				Alert(title: Text(info.title), message: Text(info.message))
			})
		}
		.background(Color.black)
	}
	
	public init(itemDescription: String, itemPrice: String) {
		self.itemDescription = itemDescription
		self.itemPrice = itemPrice
	}
}

struct ItemDescriptionView: View {
	@Binding var itemDescription: String
	var body: some View {
		TextField("", text: $itemDescription, prompt: Text("Item Description"))
			.frame(height: 50)
			.font(.customFont(withWeight: .demibold, withSize: 20))
			.multilineTextAlignment(.center)
			.padding(.horizontal, 20)
			.background(Color.white)
			.cornerRadius(8, corners: .allCorners)
			.overlay {
				RoundedRectangle(cornerRadius: 8)
					.stroke(Color.init(uiColor: .lightGray), lineWidth: 1)
			}
			.padding([.leading, .top, .trailing, .bottom], 20)
	}
}

struct ItemPriceView: View {
	@Binding var itemPrice: String
	var body: some View {
		TextField("", text: $itemPrice, prompt: Text("0.00"))
			.frame(height: 80)
			.font(.customFont(withWeight: .demibold, withSize: 30))
			.multilineTextAlignment(.trailing)
			.padding(.horizontal, 20)
			.background(Color.white)
			.cornerRadius(8, corners: .allCorners)
			.overlay {
				RoundedRectangle(cornerRadius: 8)
					.stroke(Color.init(uiColor: .lightGray), lineWidth: 1)
			}
			.padding([.leading, .trailing], 20)
			.allowsHitTesting(false)
	}
}

struct KeypadView1: View {
	@Binding var itemPrice: String
	@ObservedObject var keypadViewModel: KeypadViewModel
	
	var body: some View {
		ButtonView(valueToDisplay: [KeyPadButtons(buttonText: "1", isImage: false, buttonTag: 1),
									KeyPadButtons(buttonText: "2", isImage: false, buttonTag: 2),
									KeyPadButtons(buttonText: "3", isImage: false, buttonTag: 3),
									KeyPadButtons(buttonText: "c", isImage: false, buttonTag: 12)], 
				   itemPrice: $itemPrice,
				   keypadViewModel: keypadViewModel)
			.frame(height: 120)
	}
}

struct KeypadView2: View {
	@Binding var itemPrice: String
	@ObservedObject var keypadViewModel: KeypadViewModel
	
	var body: some View {
		ButtonView(valueToDisplay: [KeyPadButtons(buttonText: "4", isImage: false, buttonTag: 4), 
									KeyPadButtons(buttonText: "5", isImage: false, buttonTag: 5),
									KeyPadButtons(buttonText: "6", isImage: false, buttonTag: 6),
									KeyPadButtons(buttonText: "delete.backward", isImage: true, buttonTag: 13)], 
				   itemPrice: $itemPrice,
				   keypadViewModel: keypadViewModel)
			.frame(height: 120)
	}
}

struct KeypadView3: View {
	@Binding var itemPrice: String
	@ObservedObject var keypadViewModel: KeypadViewModel
	
	var body: some View {
		ButtonViewWithAdd1(valueToDisplay: [KeyPadButtons(buttonText: "7", isImage: false, buttonTag: 7), 
											KeyPadButtons(buttonText: "8", isImage: false, buttonTag: 8),
											KeyPadButtons(buttonText: "9", isImage: false, buttonTag: 9)],
						   itemPrice: $itemPrice,
						   keypadViewModel: keypadViewModel)
			.frame(height: 120)
	}
}

struct KeypadView4: View {
	@Binding var itemPrice: String
	@ObservedObject var keypadViewModel: KeypadViewModel
	
	var body: some View {
		ButtonViewWithAdd2(valueToDisplay: [KeyPadButtons(buttonText: "0", isImage: false, buttonTag: 10), 
											KeyPadButtons(buttonText: "00", isImage: false, buttonTag: 11)],
						   itemPrice: $itemPrice,
						   keypadViewModel: keypadViewModel)
			.frame(height: 120)
	}
}

struct ButtonView: View {
	@State var valueToDisplay = [KeyPadButtons]()
	@Binding var itemPrice: String
	@ObservedObject var keypadViewModel: KeypadViewModel
	
	var body: some View {
		GeometryReader { geometryReader in
			HStack(spacing: 0) {
				ForEach(valueToDisplay, id: \.buttonTag) { button in
					Button {
						print("User pressed on \(button.buttonText)")
						print("User pressed on Button which has tag: \(button.buttonTag)")
						if button.buttonTag == 12 {
							itemPrice = "0.00"
						} else if button.buttonTag == 13 {
							itemPrice = keypadViewModel.updateValueOnBackspaceClick(currentEnteredPrice: itemPrice)
						} else {
							itemPrice = keypadViewModel.updatePriceOnButtonClick(currentEnteredPrice: itemPrice, andSelectedAmount: button.buttonText)
						}
					} label: {
						if button.isImage == false {
							Text(button.buttonText)
								.foregroundStyle(Color.white)
								.font(.customFont(withWeight: .demibold, withSize: 24))
								.frame(width: geometryReader.size.width / 4, height: 120)
						} else {
							Image(systemName: button.buttonText)
								.frame(width: geometryReader.size.width / 4, height: 120)
								.tint(Color.white)
						}
					}
					.frame(width: geometryReader.size.width / 4)
					.tag(button.buttonTag)
					
					if button != valueToDisplay.last {
						VerticalDividerViewForKeypad()
					}
				}
			}
			.frame(width: geometryReader.size.width, height: 120)
			.background(Color.gray.opacity(0.4))
		}
	}
}

struct ButtonViewWithAdd1: View {
	@State var valueToDisplay = [KeyPadButtons]()
	@Binding var itemPrice: String
	@ObservedObject var keypadViewModel: KeypadViewModel
	
	var body: some View {
		GeometryReader { geometryReader in
			HStack(spacing: 0) {
				ForEach(valueToDisplay, id: \.buttonTag) { button in
					Button {
						print("User pressed on \(button.buttonText)")
						print("User pressed on Button which has tag: \(button.buttonTag)")
						
						itemPrice = keypadViewModel.updatePriceOnButtonClick(currentEnteredPrice: itemPrice, andSelectedAmount: button.buttonText)
					} label: {
						if button.isImage == false {
							Text(button.buttonText)
								.foregroundStyle(Color.white)
								.font(.customFont(withWeight: .demibold, withSize: 24))
								.frame(width: geometryReader.size.width / 3, height: 120)
						}
					}
					.frame(height: 120)
					.tag(button.buttonTag)
					
					VerticalDividerViewForKeypad()
				}
			}
			.frame(width: geometryReader.size.width, height: 120)
			.background(Color.gray.opacity(0.4))
		}
	}
}

struct ButtonViewWithAdd2: View {
	@State var valueToDisplay = [KeyPadButtons]()
	@Binding var itemPrice: String
	@ObservedObject var keypadViewModel: KeypadViewModel
	
	var body: some View {
		GeometryReader { geometryReader in
			HStack(spacing: 0) {
				ForEach(valueToDisplay, id: \.buttonTag) { button in
					Button {
						print("User pressed on \(button.buttonText)")
						print("User pressed on Button which has tag: \(button.buttonTag)")
						
						itemPrice = keypadViewModel.updatePriceOnButtonClick(currentEnteredPrice: itemPrice, andSelectedAmount: button.buttonText)
					} label: {
						if button.isImage == false {
							Text(button.buttonText)
								.foregroundStyle(Color.white)
								.font(.customFont(withWeight: .demibold, withSize: 24))
								.frame(width: geometryReader.size.width / 2, height: 120)
						}
					}
					.frame(height: 120)
					.tag(button.buttonTag)
					
					VerticalDividerViewForKeypad()
				}
			}
			.frame(width: geometryReader.size.width, height: 120)
			.background(Color.gray.opacity(0.4))
		}
	}
}

struct AddButton: View {
	@Binding var itemDescription: String
	@Binding var itemPrice: String
	@ObservedObject var keypadViewModel: KeypadViewModel
	@State var info: AlertInfo?
	
	var body: some View {
		GeometryReader { geometryReader in
			Button {
				guard itemDescription != "", itemPrice != "0.00" else {
					keypadViewModel.displayAlertWithMessage(withID: .one, andTitle: "ALERT", withMessage: "Please enter item description and item price.")
					return
				}
				
				guard keypadViewModel.validateEnteredAmount(currentEnteredAmount: itemPrice) else  {
					itemPrice = "0.00"
					keypadViewModel.displayAlertWithMessage(withID: .one, andTitle: "ALERT", withMessage: "Please enter an amount less than $10,000.")
					return
				}
				
				_ = doSomething()
			} label: {
				Text("Add")
					.foregroundStyle(Color.white)
					.frame(width: geometryReader.size.width, height: 240)
					.font(.customFont(withWeight: .demibold, withSize: 24))
					.tag(14)
					.background(Color.blue)
			}
			.frame(width: geometryReader.size.width, height: 240)
		}
	}
	
	public func doSomething() -> [String: Any] {
		return keypadViewModel.addItemsToCart(forItem: itemDescription, withPrice: itemPrice)
	}
}

struct HorizontalDividerViewForKeypad: View {
	
	var body: some View {
		Divider()
			.frame(height: 2)
			.background(Color.gray.opacity(0.5))
	}
}

struct VerticalDividerViewForKeypad: View {
	
	var body: some View {
		Divider()
			.frame(width: 2, height: 120)
			.background(Color.gray.opacity(0.5))
	}
}

//
//  KeypadApp.swift
//  Keypad
//
//  Created by Nirmit Dagly on 20/12/2023.
//

import SwiftUI

struct KeypadApp: App {
	
    var body: some Scene {
        WindowGroup {
			KeypadView(itemDescription: "", itemPrice: "0.00")
        }
    }
}

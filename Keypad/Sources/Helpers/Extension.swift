//
//  Extension.swift
//  Keypad
//
//  Created by Nirmit Dagly on 20/12/2023.
//

import Foundation
import SwiftUI

extension View {
	@ViewBuilder func stackNavigationView() -> some View {
		self.navigationViewStyle(.stack)
	}
	
	func statusBarStyle(color: Color = .clear, material: Material = .bar, hidden: Bool = false) -> some View {
		self.modifier(StatusBarStyleModifier(color: color, material: material, hidden: hidden))
	}
	
	func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
		clipShape( RoundedCorner(radius: radius, corners: corners) )
	}
}

extension Color {
	static let qikiColor = Color("QikiColor")
	static let qikiColorSelected = Color("QikiColorSelected")
	static let qikiColorDisabled = Color("QikiColorDisabled")
	static let qikiGreen = Color("QikiGreen")
	static let qikiGreenSelected = Color("QikiGreenSelected")
	static let qikiYellow = Color("QikiYellow")
	static let qikiYellowSelected = Color("QikiYellowSelected")
	static let qikiRed = Color("QikiRed")
	static let qikiRedSelected = Color("QikiRedSelected")
}

extension CGColor {
	static let qikiColor: CGColor = UIColor(named: "QikiColor")!.cgColor
	static let qikiColorSelected: CGColor = UIColor(named: "QikiColorSelected")!.cgColor
	static let qikiColorDisabled: CGColor = UIColor(named: "QikiColorDisabled")!.cgColor
	static let qikiGreen: CGColor = UIColor(named: "QikiGreen")!.cgColor
	static let qikiGreenSelected: CGColor = UIColor(named: "QikiGreenSelected")!.cgColor
	static let qikiYellow: CGColor = UIColor(named: "QikiYellow")!.cgColor
	static let qikiYellowSelected: CGColor = UIColor(named: "QikiYellowSelected")!.cgColor
	static let qikiRed: CGColor = UIColor(named: "QikiRed")!.cgColor
	static let qikiRedSelected: CGColor = UIColor(named: "QikiRedSelected")!.cgColor
}

extension Font {
	static func customFont(withWeight weight: FontWeight, withSize size: CGFloat) -> Font {
		switch weight {
			case .regular:
				return Font.custom("AvenirNext-Regular", size: size)
			case .medium:
				return Font.custom("AvenirNext-Medium", size: size)
			case .demibold:
				return Font.custom("AvenirNext-Demibold", size: size)
			case .bold:
				return Font.custom("AvenirNext-Bold", size: size)
			case .heavy:
				return Font.custom("AvenirNext-Heavy", size: size)
		}
	}
}

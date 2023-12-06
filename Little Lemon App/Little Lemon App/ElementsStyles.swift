//
//  ElementsStyles.swift
//  Little Lemon App
//
//  Created by Louis Fischer on 06/12/2023.
//

import Foundation
import SwiftUI

struct OnboardingTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .frame(width: 250, height: 40)
            .padding(5)
            .background(Color("ApprovedWhite"))
            .cornerRadius(20)
    }
}


//Style for the call to action buttons, typically "Register" or "Log out"

struct CallToActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 180)
            .foregroundColor(Color("ApprovedBlack"))
            .background(Color("PrimaryYellow"))
            .cornerRadius(15)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 1.5), value: 1)
    }
}

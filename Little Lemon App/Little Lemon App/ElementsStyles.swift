//
//  ElementsStyles.swift
//  Little Lemon App
//
//  Created by Louis Fischer on 06/12/2023.
//

import Foundation
import SwiftUI

//Style used for the TextFields of the Onboarding View
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


//Style used for the Text elements displaying user information
struct profileInfoStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Karla-Regular", size: 18))
            .padding(.bottom, 30)
            .foregroundColor(Color("ApprovedBlack"))
            .padding([.leading, .trailing], 40)
            .background(Color("ApprovedWhite"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("ApprovedBlack"), lineWidth: 1)
            )
    }
}

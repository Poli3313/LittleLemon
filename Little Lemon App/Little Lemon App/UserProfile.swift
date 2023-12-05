//
//  UserProfile.swift
//  Little Lemon App
//
//  Created by Louis Fischer on 05/12/2023.
//

import SwiftUI

let firstName = UserDefaults.standard.string(forKey: kFirstName)
let lastName = UserDefaults.standard.string(forKey: kLastName)
let email = UserDefaults.standard.string(forKey: kEmail)

struct UserProfile: View {
  
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Image("Profile Picture Placeholder")
                .scaleEffect(0.75)
            Text("Personal Information")
            
            Text(firstName ?? "")
            Text(lastName ?? "")
            Text(email ?? "")
            
            Button("Logout"){
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}

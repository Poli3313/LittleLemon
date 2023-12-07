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
        ZStack {
            VStack {
                Image("Profile Picture Placeholder")
                    .scaleEffect(0.75)
                
                Text("Personal Information")
                    .font(.custom("Karla-Bold", size: 33))
                    .foregroundStyle(Color("ApprovedBlack"))
                
                VStack (alignment: .leading) {
                
                    Text("First name")
                        .font(.custom("Karla-ExtraBold", size: 18))
                        .foregroundStyle(Color("PrimaryGreen"))
                        .padding(.bottom, 5)
                        .padding(.top, 15)
                    Text(firstName ?? "")
                        .modifier(profileInfoStyle())
                    
                    Text("Last name")
                        .font(.custom("Karla-ExtraBold", size: 18))
                        .foregroundStyle(Color("PrimaryGreen"))
                        .padding(.bottom, 5)
                    Text(lastName ?? "")
                        .modifier(profileInfoStyle())
                    
                    Text("Email")
                        .font(.custom("Karla-ExtraBold", size: 18))
                        .foregroundStyle(Color("PrimaryGreen"))
                        .padding(.bottom, 5)
                    Text(email ?? "")
                        .modifier(profileInfoStyle())
                }
                .frame(width : 200, height : 200)
                .padding(.leading, -200)
                
                Button("Logout"){
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    self.presentation.wrappedValue.dismiss()
                }
                .foregroundStyle(Color("ApprovedBlack"))
                .font(.custom("Karla-Regular", size: 24))
                .buttonStyle(CallToActionButtonStyle())
                .padding(.top, 50)
                
                Spacer()
            }
        }
        .background(Image("pattern").opacity(0.1))
    }
}

#Preview {
    UserProfile()
}

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
            Image("pattern")
                .opacity(0.1)
                .ignoresSafeArea()
            
            VStack (spacing: 30){
                Image("Profile Picture Placeholder")
                    .scaleEffect(0.75)
                    .padding(.top, 50)
                    .overlay(
                       Circle()
                        .stroke(Color("PrimaryGreen"), lineWidth: 2)
                        .scaleEffect(0.75)
                        .padding(.top, 50)
                    )
                
                Text("Personal Information")
                    .font(.custom("Karla-Bold", size: 33))
                    .foregroundStyle(Color("ApprovedBlack"))
                    .padding()
                
                VStack (alignment: .leading){
                
                    Text("First name")
                        .font(.custom("Karla-ExtraBold", size: 18))
                        .foregroundStyle(Color("PrimaryGreen"))
                        .padding(.top, 30)
                    Text(firstName ?? "")
                        .modifier(profileInfoStyle())
                    
                    Text("Last name")
                        .font(.custom("Karla-ExtraBold", size: 18))
                        .foregroundStyle(Color("PrimaryGreen"))
                        .padding(.top, 15)
                    Text(lastName ?? "")
                        .modifier(profileInfoStyle())
                    
                    Text("Email")
                        .font(.custom("Karla-ExtraBold", size: 18))
                        .foregroundStyle(Color("PrimaryGreen"))
                        .padding(.top, 15)
                    Text(email ?? "")
                        .modifier(profileInfoStyle())
                }
                .frame(width : 200, height : 200)
                .padding(.leading, -110)
                
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
    }
}

#Preview {
    UserProfile()
}

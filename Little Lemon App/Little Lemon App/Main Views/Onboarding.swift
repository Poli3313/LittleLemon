//
//  Onboarding.swift
//  Little Lemon App
//
//  Created by Louis Fischer on 05/12/2023.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"

let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    
    let karlaTitle = Font.custom("Karla-Regular", size: 50)
    let markaziTitle = Font.custom("MarkaziText-Regular", size: 64)
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @State var isLoggedIn = false
    @State var formError = false
    
    var body: some View {        
        NavigationView {
            ZStack {
                Color("PrimaryGreen")
                
                VStack {
                    
                    NavigationLink(destination: Home(), isActive: $isLoggedIn) {EmptyView()} //button changes the value of the bool State var, which in turn triggers the NavigationLink due to the trailing closure. But this ones remains hidden!
                    
                    Text("Welcome to")
                        .foregroundColor(Color("ApprovedWhite"))
                        .font(markaziTitle)
                        .padding(.top, -100)
                    
                    Text("Little Lemon")
                        .foregroundColor(Color("PrimaryYellow"))
                        .font(markaziTitle)
                        .padding(.top, -90)
                        .padding(.bottom, 50)
                    
                    Text("Please log in")
                        .foregroundColor(Color("ApprovedWhite"))
                        .font(.custom("Karla-Regular", size: 24))
                    
                    TextField("First Name",
                              text: $firstName)
                        .textFieldStyle(OnboardingTextFieldStyle())
                        .padding(.bottom, 5)
                    TextField("Last Name",
                              text: $lastName)
                        .textFieldStyle(OnboardingTextFieldStyle())
                        .padding(.bottom, 5)
                    TextField("Email",
                              text: $email)
                        .textFieldStyle(OnboardingTextFieldStyle())
                        .padding(.bottom, 5)
                    
                    Button(action: {
                        if firstName.isEmpty || lastName.isEmpty || email.isEmpty {
                            formError.toggle()
                        } else {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            
                            isLoggedIn = true
                           
                        }
                    }, label: {
                        Text("Register")
                            .foregroundStyle(Color("ApprovedBlack"))
                            .font(.custom("Karla-Regular", size: 24))
                    })
                    .buttonStyle(CallToActionButtonStyle())
                    .padding(20)
                    
                    if formError == true {
                        Text("Please fill in all log-in fields")
                            .padding(.top, 10)
                            .foregroundStyle(Color.red)
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                }
                .onAppear {
                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) == true {
                        isLoggedIn = true
                    }
            }
            }
        }
        .frame(width: 438, height: 750)
    }
}

#Preview {
    Onboarding()
}

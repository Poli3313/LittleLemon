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
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @State var isLoggedIn = false
    
    @State var formError = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red:73/255, green: 94/255, blue: 84/255)
                
                VStack {
                    if formError == true {
                        Text("Please fill in all form fields")
                    }
                    
                    NavigationLink(destination: Home(), isActive: $isLoggedIn) {EmptyView()} //button changes the value of the bool State var, which in turn triggers the NavigationLink due to the trailing closure. But this ones remains hidden!
                    
                    TextField("First Name",
                              text: $firstName)
                        .padding()
                        .frame(width: 300, height: 40)
                        .background(Color.white)
                        .cornerRadius(20)
                    TextField("Last Name",
                              text: $lastName)
                        .padding()
                        .frame(width: 300, height: 40)
                        .background(Color.white)
                        .cornerRadius(20)
                    TextField("Email",
                              text: $email)
                        .padding()
                        .frame(width: 300, height: 40)
                        .background(Color.white)
                        .cornerRadius(20)
                    
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
                    })
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.yellow)
                    .cornerRadius(10)
                }
                .onAppear {
                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) == true {
                        isLoggedIn = true
                    }
            }
            }
        }
        .frame(width: 438, height: 600)
        .border(Color.black)
        
    }
}

#Preview {
    Onboarding()
}

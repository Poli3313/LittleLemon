//
//  CartView.swift
//  Little Lemon App
//
//  Created by Louis Fischer on 08/12/2023.
//

import SwiftUI

struct CartView: View {
    @State var counter : Int = 0
    
    var body: some View {
        VStack {
            Text("Thank you for ordering at Little Lemon")
                .font(.custom("Karla-ExtraBold", size: 40))
                .foregroundStyle(Color("PrimaryYellow"))
                .padding()
            
            Text("We will take care of your order shortly")
                .font(.custom("Karla-ExtraBold", size: 24))
                .foregroundStyle(Color("ApprovedWhite"))
            
            Text("Your ordered \(counter) items.")
                .font(.custom("Karla-ExtraBold", size: 24))
                .foregroundStyle(Color("ApprovedWhite"))
                .padding(.top, 20)
            
            Text("Tap anywhere to dismiss")
                .font(.custom("Karla-Italic", size: 18))
                .foregroundStyle(Color("ApprovedWhite"))
                .padding(.top, 250)
        }
        .frame(width : 400, height: 750)
        .background(Color("PrimaryGreen"))
    }
}

#Preview {
    CartView()
}

//
//  Home.swift
//  Little Lemon App
//
//  Created by Louis Fischer on 05/12/2023.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Menu()
                .tabItem {Label ("Menu", systemImage : "list.dash")}
            UserProfile()
                .tabItem {Label ("Profile", systemImage : "square.and.pencil")}
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}

//
//  Home.swift
//  Little Lemon App
//
//  Created by Louis Fischer on 05/12/2023.
//

import SwiftUI

struct Home: View {
    
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            Menu()
                .tabItem {Label ("Menu", systemImage : "list.dash")}
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .onDisappear {
                    PersistenceController.shared.clear()
                }
            UserProfile()
                .tabItem {Label ("Profile", systemImage : "square.and.pencil")}
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}

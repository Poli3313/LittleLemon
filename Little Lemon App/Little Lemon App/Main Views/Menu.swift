//
//  Menu.swift
//  Little Lemon App
//
//  Created by Louis Fischer on 05/12/2023.
//

import SwiftUI

struct Menu: View {
   
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText : String = ""
    
    @State var isTapped = false
    
    func buildSortDescriptors () -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                ascending: true,
                                selector:
                                   #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        return searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    
    var body: some View {
        
        let markaziTitle = Font.custom("MarkaziText-Regular", size: 64)
       
            VStack {
                HStack {
                    Spacer()
                    Image("Logo")
                        .scaleEffect(1)
                        .padding(.leading, 55)
                    Spacer()
                    Image("Profile Picture Placeholder")
                        .resizable()
                        .frame(width:40, height: 40)
                        .padding(.trailing, 30)
                        .onTapGesture {
                            isTapped.toggle()
                        }
                }
                
                VStack (alignment: .leading, spacing : -40) {
                    Text("Little Lemon")
                        .foregroundColor(Color("PrimaryYellow"))
                        .font(markaziTitle)
                        .padding(.leading, 25)
                    
                    HStack (spacing: 25) {
                        
                        VStack (alignment: .leading){
                            Text("Chicago")
                                .foregroundColor(Color("ApprovedWhite"))
                                .font(Font.custom("MarkaziText-Regular", size: 40))
                                .padding(.leading, 25)
                            
                            Text("We are a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                .foregroundColor(Color("ApprovedWhite"))
                                .font(.custom("Karla-Regular", size: 18))
                                .padding(.bottom, 30)
                                .padding(.leading, 25)
                        }
                        .frame(height: 250)
                        
                        Image("Hero image")
                            .resizable()
                            .frame(width: 150, height : 180)
                            .cornerRadius(30)
                            .padding(.trailing, 15)
                            .padding(.top, 5)
                        
                    }
                    .frame(height:270)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("ApprovedWhite"))
                        
                        
                        TextField("Search Menu...", text: $searchText)
                            .padding(20)
                            .frame(width: 300, height: 40, alignment: .center)
                            .background(Color("ApprovedWhite"))
                            .cornerRadius(20)
                        Spacer()
                    }
                    .padding(.top, -50)
                    .frame(height: 50)
                    
                }
                .background(Color("PrimaryGreen"))
                .frame(height: 365)
                .padding(10)
                
                VStack (alignment: .leading){
                    Text("Order Now")
                        .font(Font.custom("Karla-Bold", size : 28))
                        .foregroundStyle(Color("PrimaryGreen"))
                }
                .frame(height: 30)
                
                
                
                
                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    List {
                        ForEach(dishes){ dish in
                            NavigationLink(destination: DishDetailsView(dish: dish)) {
                                HStack {
                                    VStack (alignment: .leading, spacing: 5){
                                        Text(dish.title ?? "")
                                            .font(Font.custom("Karla-Bold", size:18))
                                        Text(dish.description1 ?? "")
                                            .font(.custom("Karla-Regular", size: 16))
                                        Text("$" + "\(dish.price ?? "")")
                                            .font(.custom("Karla-Regular", size: 18))
                                    }
                                    AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    } //Displays a rotating loading wheel while the images are being retrieved from the server
                                    .frame(width: 100, height: 100)
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .onAppear {getMenuData()}
    }
    
    func getMenuData() {
        
        PersistenceController.shared.clear()
        
        let url = URL(string:"https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")
        
        let request = URLRequest(url: url!)
        
        let urlSession = URLSession.shared
        
        let fullMenu = urlSession.dataTask(with: url!) { data, _, _ in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let finalMenu = try decoder.decode(MenuList.self, from: data)
                        let menuArray = finalMenu.menu
                        
                        for item in menuArray {
                            let dish = Dish(context: viewContext)
                            dish.title = item.title
                            dish.image = item.image
                            dish.price = item.price
                            dish.category = item.category
                            dish.description1 = item.description
                        }
                        
                        try? viewContext.save()
                        
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
        
        fullMenu.resume()
    }
}

#Preview {
    Menu()
}

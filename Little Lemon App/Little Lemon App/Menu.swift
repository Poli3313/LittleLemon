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
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            
            TextField("Search Menu", text: $searchText)
                .padding()
                .frame(width: 300, height: 40)
                .background(Color.gray)
                .cornerRadius(20)
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes){ dish in
                        NavigationLink(destination: DishDetailsView(dish: dish)) {
                            HStack {
                                Text(dish.title ?? "")
                                Text(dish.price ?? "")
                                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                            }
                        }
                    }
                }
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

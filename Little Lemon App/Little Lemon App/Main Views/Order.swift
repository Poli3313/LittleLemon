//
//  Order.swift
//  Little Lemon App
//
//  Created by Louis Fischer on 08/12/2023.
//

import SwiftUI

struct Order: View {
    
     @Environment(\.managedObjectContext) private var viewContext
     
     @State var searchText : String = ""
     @State var address : String = ""
     @State var isCartVisible = false
     @State var counter = 0
        
     private let screenWidth = UIScreen.main.bounds.width
     
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
         
         let markaziTitle = Font.custom("MarkaziText-Regular", size: 48)
        
         if isCartVisible {
             CartView(counter: counter)
                             .frame(width: UIScreen.main.bounds.width / 2)
                             .transition(.move(edge: .leading))
                             .edgesIgnoringSafeArea(.vertical)
                             .onTapGesture {
                                 isCartVisible.toggle()
                             }
                     } else {
             
             ZStack {
                 VStack (spacing : 0) {
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
                     }.padding(.bottom, 10)
                     
                     Image("Restaurant")
                         .resizable()
                         .frame(height: 150)
                     
                     VStack (alignment: .leading) {
                         Text("Ordered, Delivered")
                             .foregroundColor(Color("PrimaryYellow"))
                             .font(markaziTitle)
                             .padding(.leading, 25)
                         
                         Text("We deliver all around the Chicago Bay Area, right to your door-step")
                             .foregroundColor(Color("ApprovedWhite"))
                             .font(Font.custom("Karla-Italic", size: 18))
                             .padding([.leading, .trailing], 25)
                         
                         HStack (spacing: 5){
                             Text("Delivery Address : ")
                                 .foregroundColor(Color("ApprovedWhite"))
                                 .font(Font.custom("Karla-Regular", size: 18))
                                 .padding([.leading, .trailing], 25)
                                 .padding(.top, 5)
                             
                             TextField("Your Adress", text: $address)
                                 .padding()
                                 .frame(width: 150, height: 20, alignment: .leading)
                                 .background(Color("ApprovedWhite"))
                                 .cornerRadius(20)
                         }
                         .frame(width: 350)
                         
                         Spacer()
                         
                         HStack {
                             VStack {
                                 Text("Delivery Cost")
                                     .font(Font.custom("Karla-Regular", size: 18))
                                 Text("$3.99")
                                     .font(Font.custom("Karla-Regular", size: 18))
                             }
                             Spacer()
                             VStack {
                                 Text("Delivery Time")
                                     .font(Font.custom("Karla-Regular", size: 18))
                                 Text("> 20 mins")
                                     .font(Font.custom("Karla-Regular", size: 18))
                             }
                         }
                         .frame(width: 280, height: 60)
                         .padding([.leading, .trailing], 25)
                         .background(Color("ApprovedWhite"))
                         .cornerRadius(20)
                         .offset(x:50)
                         
                         Spacer()
                         
                     }
                     .background(Color("PrimaryGreen"))
                     .frame(height: 250)
                     
                     VStack (alignment: .leading){
                         Text("Our Menu")
                             .font(Font.custom("Karla-Bold", size : 28))
                             .foregroundStyle(Color("PrimaryGreen"))
                     }
                     .frame(height: 30)
                     .padding()
                     
                     FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                         List {
                             ForEach(dishes){ dish in
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
                                     
                                     Spacer()
                                     
                                     Button("Add To Cart"){
                                         counter += 1
                                     }
                                     .font(.custom("Karla-Regular", size: 16))
                                 }
                             }
                         }.scrollContentBackground(.hidden)
                     }
                 }
                 
                 VStack {
                     Spacer()
                     Button ("See cart (\(counter))") {
                         withAnimation {
                             isCartVisible.toggle()
                         }
                     }
                     .font(.custom("Karla-ExtraBold", size: 18))
                     .buttonStyle(CallToActionButtonStyle())
                     .padding(.bottom, 10)
                 }
             }
             .onAppear {getMenuData()}
         }
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
    Order()
}

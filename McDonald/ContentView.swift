//
//  ContentView.swift
//  McDonald
//
//  Created by Agata Przykaza on 01/10/2024.
//

import SwiftUI
import FirebaseFirestore

class MenuItemFactory {
    func createBurger(name: String, price: Double,itemNumber: Int, ingredients: [String], sauce: Burger.Sauce, meat: Burger.Meat, bun: Burger.Bun) -> Burger {
        return Burger(name: name, price: price, itemNumber: itemNumber, ingredients: ingredients, sauce: sauce, meat: meat, bun: bun)
    }

    func createWrap(name: String, price: Double,itemNumber: Int, ingredients: [String]) -> Wrap {
        return Wrap(name: name, price: price, itemNumber: itemNumber, ingredients: ingredients,tortilla: .corn,filling: .beef,sauce: .ranch)
    }

    func createDrink(name: String, price: Double, itemNumber: Int,ingredients: [String], ice: Bool) -> Drink {
        return Drink(name: name, price: price, itemNumber: itemNumber, ingredients: ingredients, isIced: ice, category: .drink)
    }
    func createCoffee(name: String, price: Double,itemNumber: Int, ingredients: [String], ice: Bool,milk:Coffee.Milk,sugar:Bool) -> Coffee {
        return Coffee(name: name, price: price, itemNumber: itemNumber, isIced: ice, ingredients: ingredients, milk: milk, sugar: sugar)
    }
    
    func createMealSet(mainItem: MenuItem, sideItem: MenuItem, drink: MenuItem,itemNumber: Int) -> MealSet{
        return MealSet(mainItem: mainItem, sideItem: sideItem, drink: drink, itemNumber: itemNumber)
    }
    
    func creatFries(name: String, price: Double,itemNumber: Int, hasKetchup: Bool, hasSalt: Bool) -> Fries{
        return Fries(name: name, price: price, itemNumber: itemNumber, hasKetchup: hasKetchup, hasSalt: hasSalt)
    }
}



struct ContentView: View {
    
    @Environment(ViewModel.self) private var vmodel
    
    let menuService = FirestoreService()
   @State  var menuItems: [MenuItem] = []
   
    
   @State  var user: User?
    
    func fetchMenu() async {
        
        let menuService = FirestoreService()
        do {
            let items = try await menuService.fetchMenu()
          
                self.menuItems = items
                print(menuItems.count)
            
        } catch {
                 print("wrong went")
            
        }
    }
    
    func saveUser() async{
        let user = User(id: 200, name: "alla", points: 234, cupons: [], email: "asld@.gmail.com")
        do{
            
            try await menuService.saveUser(user)
        }
        catch{
            print("nie dalo sie zapisac usera")
        }
    }
    
     func fethcUser() async{
        do{
            let user = try await menuService.fetchUser(mail: "asld@.gmail.com")
           
                self.user = user
                print(menuItems.count)
            
        } catch {
           
                print("wrong went")
            
        }
        
    }
    
  
    
    
    func save() async{
        
        let menuService = FirestoreService()
        
        let factory = MenuItemFactory()
        
        let b = factory.createBurger(name: "Grander", price: 13.4, itemNumber: Int.random(in: 20...100), ingredients: ["sałata","pomidor"], sauce: .bbq, meat: .beef, bun: .sesame)
        
        let coffe = factory.createCoffee(name: "Latte", price: 11.2, itemNumber: Int.random(in: 20...100), ingredients: ["coffe","milk"], ice: false, milk: Coffee.Milk.cowMilk, sugar: true)
        
        let side = factory.creatFries(name: "Fryyki duze", price: 19.2, itemNumber: Int.random(in: 20...100), hasKetchup: true, hasSalt: true)
        
        
        
        let set = factory.createMealSet(mainItem: b, sideItem: side, drink: coffe, itemNumber:Int.random(in: 20...100)
        )
        
        do{
            
            try await menuService.saveMenuItem(side)
        }
        catch{
            print("nie dalo sie zapisac")
        }
    }
    
    var body: some View {
        VStack {
                 Button("Save") {
                     Task{
                         await fethcUser()
                     }
                   
                 }
                 .buttonStyle(.bordered)
                 
            ForEach(menuItems) { item in
                     Text(item.name)
                 }
            
            Text("Total: \(user?.email),\(user?.name)")
             }
             .padding()
             .task {
                await fetchMenu()
             }
        
       
    }
}

#Preview {
    ContentView()
        .environment(ViewModel())
}

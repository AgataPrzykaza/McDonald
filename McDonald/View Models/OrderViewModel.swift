
import Foundation
import SwiftUI


enum ViewState {
    case map, order, searchLocation,intro,cart, orderType
}

@Observable
class OrderViewModel{
    
    var order: Order?
    var mapModel: MapViewModel
    var rootView: ViewState
    var navigationPath: NavigationPath
    
    var orderType: OrderType = .onPlace
    
    var selectedRestaurant: RestaurantLocation?
    var errorMessage: String? = nil
    
    var menuItems: [MenuItem] = []
    var categories: [Category] = []
   
   
    
    init() {
        self.mapModel = MapViewModel()
        self.rootView = .intro
        self.navigationPath = NavigationPath()
       
    }
    
   
    
    func removeFromCart(menuItem: MenuItem) {
        print("Próba usunięcia przedmiotu: \(menuItem.name)")
        order?.remove(menuItem)
        print("Zamówienie: \(order?.items.count ?? 0) elementów, suma: \(order?.sum ?? 0) zł")
    }
    
    
    func addCouponToCart(coupon: Coupon){
        
        
        if order == nil {
          
            order = Order(
                id: UUID().uuidString,
                oderNumber: 1,
                order: [],
                customerID: "",
                restaurantID: "",
                orderType: orderType,
                sum: 0
            )
        }
        
        let items = menuItems.filter { item in
            item.category == .coupons
        }
        
        if let item = items.first(where: { item in
            item.menuID == coupon.menuID
        }){
            order?.addCoupon(item: item)
        }
        
        
    }
    
    
    func addPrizeToCart(prize: MPrize) {
        
        
        
        if order == nil {
          
            order = Order(
                id: UUID().uuidString,
                oderNumber: 1,
                order: [],
                customerID: "",
                restaurantID: "",
                orderType: orderType,
                sum: 0
            )
        }
        
       if let item = menuItems.first(where: { item in
           item.menuID == prize.menuID
       }){
           item.price = 0
           order?.addPrize(item: item)
       }
       
       
        
       
    }
    
    func addToCart(menuItem: MenuItem, customerID: String, restaurantID: String) {
        print("Próba dodania przedmiotu: \(menuItem.name)")

        if order == nil {
            print("Tworzenie nowego zamówienia...")
            order = Order(
                id: UUID().uuidString,
                oderNumber: 1,
                order: [],
                customerID: "",
                restaurantID: "",
                orderType: orderType,
                sum: 0
            )
        }
        
        print("Dodawanie przedmiotu: \(menuItem.name)")
        order?.add(menuItem)
        print("Zamówienie: \(order?.items.count ?? 0) elementów, suma: \(order?.sum ?? 0) zł")
    }


    
    func fetchMenu() async{
        
        do{
            menuItems = try await MenuManager.shared.fetchMenu() 
            
        }catch{
            print("Error: \(error.localizedDescription)")
        }
        
    }
    
    func fetchCategories() async{
        do{
            categories = try await CategoriesManager.shared.getCategories()
            let preferredOrder = ["burgery", "wrapy i sałatki", "kurczak", "Dodatki", "Napoje", "cafe","Desery"]
                        
            categories.sort { first, second in
                            let firstIndex = preferredOrder.firstIndex(of: first.name.lowercased()) ?? Int.max
                            let secondIndex = preferredOrder.firstIndex(of: second.name.lowercased()) ?? Int.max
                            return firstIndex < secondIndex
                        }
            
        }
        catch{
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func itemsForCategory(category: Category) -> [MenuItem] {
        menuItems.filter { item in
            item.category.rawValue == category.category.rawValue
        }
    }

    
}

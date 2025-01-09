
import Foundation
import SwiftUI


enum ViewState {
    case map, order, searchLocation,intro,cart
}

@Observable
class OrderViewModel{
    
    var order: Order?
    var mapModel: MapViewModel
    var rootView: ViewState
    var navigationPath: NavigationPath
    
    var selectedRestaurant: RestaurantLocation?
    var errorMessage: String? = nil
    
    var menuItems: [MenuItem] = []
    var categories: [Category] = []
   
    
    init() {
        self.mapModel = MapViewModel()
        self.rootView = .intro
        self.navigationPath = NavigationPath()
       
    }
    
    
    func fetchMenu() async{
        
        do{
            menuItems = try await MenuManager.shared.fetchMenu() ?? []
            
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
    

    
}

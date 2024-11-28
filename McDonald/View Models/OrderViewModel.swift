
import Foundation
import SwiftUI

enum ViewState {
    case map, order, searchLocation,intro
}

@Observable
class OrderViewModel{
    
    var mapModel: MapViewModel
    var rootView: ViewState
    var navigationPath: NavigationPath
    
    var selectedRestaurant: RestaurantLocation?
    
    
    init() {
        self.mapModel = MapViewModel()
        self.rootView = .intro
        self.navigationPath = NavigationPath()
    }
    
    
}

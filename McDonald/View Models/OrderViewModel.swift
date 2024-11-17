
import Foundation
import SwiftUI

enum ViewState {
    case map, order
}

@Observable
class OrderViewModel{
    
    var mapModel: MapViewModel
    var rootView: ViewState
    var navigationPath: NavigationPath
    
    init() {
        self.mapModel = MapViewModel()
        self.rootView = .map
        self.navigationPath = NavigationPath()
    }
    
    
}

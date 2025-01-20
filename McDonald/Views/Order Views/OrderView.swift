//
//  OrderView.swift
//  McDonald
//
//  Created by Agata Przykaza on 07/10/2024.
//

import SwiftUI

struct OrderView: View {
    
    @State var showNextView: Bool = false
    @State var viewModel: OrderViewModel = .init()
    
  
    
    var body: some View {
        
        
    
        NavigationStack(path: $viewModel.navigationPath){
            
            VStack {
                if viewModel.rootView == .intro{
                    OrderIntroView()
                }
                else if viewModel.rootView == .order {
                    OrderMenuView()
                        
                }
            }
            .navigationDestination(for: ViewState.self) { route in
                switch route {
                case .map:
                    // Widok mapy
                    MapView()
                case .order:
                    // Widok zamówienia
                    Text("Here we are in the order view")
                        .font(.title)
                case .searchLocation:
                    SearchLocationView()
                case .intro:
                    OrderIntroView()
                case .cart:
                    CartView()
                case .orderType:
                    OrderTypeView()
                case .summary:
                    SummaryOrderView()
                case .orderNumber:
                    OrderNumberView()
                }
            }
            
            
        }
        .environment(viewModel)
        
        
        
        
        
        
    }
}

#Preview {
    
    OrderView()
        .environment(OrderViewModel())
}

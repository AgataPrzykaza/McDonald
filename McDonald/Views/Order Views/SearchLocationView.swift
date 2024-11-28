//
//  SearchLocationView.swift
//  McDonald
//
//  Created by Agata Przykaza on 13/11/2024.
//

import SwiftUI

struct SearchLocationView: View {
    
    @Environment(OrderViewModel.self) var orderModel
    
    @State var showSheetMoreFIlters: Bool = false
    @State var searchText: String = ""
    
    
    var body: some View {
        VStack{
          
            HStack {
                TextField("Search...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            
            Filter(showSheetMoreFIlters: $showSheetMoreFIlters)
                .onChange(of: orderModel.mapModel.selectedFilters) {
                    orderModel.mapModel.updateFilteredLocations()
                }
                .fullScreenCover(isPresented: $showSheetMoreFIlters) {
                    
                    FilterServiceSheetView(showFilterServiceSheet: $showSheetMoreFIlters)
                }
                .padding(.horizontal)
                
            ScrollView{
                VStack{
                    ForEach(orderModel.mapModel.filteredLocations.filter({ location in
                        searchText.isEmpty || location.name.lowercased().contains(searchText.lowercased())
                    } )){ restaurant in
                        
                        LocationCardView(restaurant: restaurant, buttonPosition: .right)
                            .padding()
                        
                        Divider()
                        
                        
                        
                    }
                   
                    
                }
            }
            
        }
        .navigationTitle("Znajdź restaurację")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        SearchLocationView()
            .environment(OrderViewModel())
            
    }
}

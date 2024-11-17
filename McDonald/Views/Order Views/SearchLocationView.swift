//
//  SearchLocationView.swift
//  McDonald
//
//  Created by Agata Przykaza on 13/11/2024.
//

import SwiftUI

struct SearchLocationView: View {
    
    var location: [RestaurantLocation]
    
    
    
    var body: some View {
        VStack{
          
            Text("search bar")
                
            ScrollView{
                VStack{
                    ForEach(location){ restaurant in
                        
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
        SearchLocationView(location: mockRestaurants)
            
    }
}

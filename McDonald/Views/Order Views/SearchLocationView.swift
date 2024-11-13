//
//  SearchLocationView.swift
//  McDonald
//
//  Created by Agata Przykaza on 13/11/2024.
//

import SwiftUI


struct LocationCardView: View {
    
    var restaurant: RestaurantLocation
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Text(restaurant.name)
                    .font(.headline)
                    .fontWeight(.heavy)
                
                Spacer()
                
                Text("odleglosc")
                    .padding(3)
                    .background(.gray.opacity(0.3),in: .rect(cornerRadius: 10))
            }
           
            
            Text(restaurant.address)
                .foregroundStyle(.secondary)
                .frame(width: 300,alignment: .leading)
                .multilineTextAlignment(.leading)
            
            HStack{
                Text("Serwisy")
            }
            
            HStack{
                Text("Zobacz szczegóły")
                    .underline(color: .blue)
                    .foregroundStyle(.blue)
                
                Spacer()
                Text("Zamów tutaj")
                    .font(.subheadline)
                    .padding(.horizontal)
                    .padding(6)
                    .background(.accent.mix(with: .orange, by: 0.2), in: .rect(cornerRadius: 10))
                
                
            }
        }
        .frame(height: 100)
        .padding([.bottom,.top])
    }
}

struct SearchLocationView: View {
    
    var location: [RestaurantLocation]
    
    var body: some View {
        VStack{
          
            Text("search bar")
            
            List{
                ForEach(location){ restaurant in
                    
                    LocationCardView(restaurant: restaurant)
                    
                   
                    
                    
                }
            }
            .listStyle(.plain)
            
            
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

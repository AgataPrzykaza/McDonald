//
//  LocationCardView.swift
//  McDonald
//
//  Created by Agata Przykaza on 17/11/2024.
//

import SwiftUI
import MapKit

enum ButtonPosition{
    case center
    case right
}

struct LocationCardView: View {
    @Environment(OrderViewModel.self) var orderModel
    var restaurant: RestaurantLocation
    var buttonPosition: ButtonPosition
    
    @State private var distance: String = "##"
   
    func haversineDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
            let R = 6371.0 // Promień Ziemi w kilometrach
            
            let φ1 = lat1 * .pi / 180
            let φ2 = lat2 * .pi / 180
            let Δφ = (lat2 - lat1) * .pi / 180
            let Δλ = (lon2 - lon1) * .pi / 180
            
            let a = sin(Δφ / 2) * sin(Δφ / 2) +
                    cos(φ1) * cos(φ2) *
                    sin(Δλ / 2) * sin(Δλ / 2)
            let c = 2 * atan2(sqrt(a), sqrt(1 - a))
            
            return R * c
        }
        
    func updateDistance() {
         
           
           let dist = haversineDistance(
            lat1: orderModel.mapModel.currentLocation.latitude,
            lon1: orderModel.mapModel.currentLocation.longitude,
               lat2: restaurant.latitude,
               lon2: restaurant.longitude
           )
           
           distance = String(format: "%.2f km", dist)
       }
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Text(restaurant.name)
                    .font(.headline)
                    .fontWeight(.heavy)
                
                Spacer()
                
                Text(distance)
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
                
                if buttonPosition == .right{
                    Button{
                        
                        orderModel.selectedRestaurant = restaurant
                      
                        orderModel.rootView = .order
                        
                        orderModel.navigationPath.removeLast(orderModel.navigationPath.count)
                        
                        
                    } label: {
                        Text("Zamów tutaj")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                            .padding(6)
                            .background(.accent.mix(with: .orange, by: 0.2), in: .rect(cornerRadius: 10))
                    
                    }
                    .contentShape(Rectangle())
                }
             
                   

                
            }
            
            if buttonPosition == .center{
                Button{
                    
                    orderModel.selectedRestaurant = restaurant
                    orderModel.rootView = .order
                    
                    orderModel.navigationPath.removeLast(orderModel.navigationPath.count)
                    
                    
                } label: {
                    ButtonView(title: "Zamów tutaj", color: .yellow)
                
                }
            }
          
            
            
        }
        .frame(height: 100)
        .padding([.bottom,.top])
        .onAppear(){
            updateDistance()
        }
    }
}
//
//#Preview {
//    LocationCardView( restaurant: mockRestaurants.first!, buttonPosition: .right)
//        .padding()
//        .environment(OrderViewModel())
//}

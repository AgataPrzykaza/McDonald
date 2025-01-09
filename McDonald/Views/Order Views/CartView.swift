//
//  CartView.swift
//  McDonald
//
//  Created by Agata Przykaza on 09/01/2025.
//

import SwiftUI

struct CartView: View {
    
    @Environment(OrderViewModel.self) var orderModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack{
               
                
                Button {
                    orderModel.rootView = .order
                    
                    orderModel.navigationPath.removeLast(orderModel.navigationPath.count)
                    
                } label: {
                    Image(systemName: "xmark")
                }

                Spacer()
            }
           
           Text("Twoje zamówienie")
               .font(.title)
               .bold()
               .padding()
            
            restaurant
                .padding()
            
            items
                .padding()
            
            
            Divider()
            HStack{
                Text("Do zapłaty")
                Spacer()
                Text("zł")
            }
            .font(.headline)
            .bold()
            .padding()
            
            Divider()
              

            HStack(alignment: .center){
                
                Rectangle()
                    .foregroundStyle(.white)
                    .overlay {
                        Text("Zamów więcej")
                             .padding(.horizontal)
                    }
            
                Spacer()
                
                Rectangle()
                    .foregroundStyle(.yellow)
                    .overlay {
                        Text("Wybierz miejsce odbioru")
                             
                             
                    }
              
                    
            }
            .frame(height: 75)
            .padding(.top,-7)
            
           
            Divider()
                .padding(.top,-8)
                
            
            
        }
       .frame(maxWidth: .infinity,alignment: .leading)
      
       .navigationBarBackButtonHidden()
    }
}

extension CartView {
    var restaurant : some View{
        HStack{
            
            Image("icon")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
                .clipShape(.circle)
            
            VStack(alignment: .leading){
                
                Text(orderModel.selectedRestaurant?.name ?? "Brak")
                    .fontWeight(.bold)
                Text(orderModel.selectedRestaurant?.openHours.first?.1 ?? "Brak godziny")
                    .foregroundStyle(.secondary)
            }
            Spacer()
            
            Button {
                orderModel.mapModel.selectedLocation = nil
                orderModel.navigationPath.append(ViewState.map)
                orderModel.selectedRestaurant = nil
                
                
            } label: {
                
                Text("Zmień restauracje")
                    .underline(color: .blue)
                    .foregroundStyle(.blue)
            }
        }

    }
    
    var items: some View {
        ScrollView{
            
        }
    }
}

#Preview {
    NavigationStack{
        CartView()
    }
    .environment(OrderViewModel())

}

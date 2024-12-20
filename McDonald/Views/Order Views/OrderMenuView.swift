//
//  OrderMenuView.swift
//  McDonald
//
//  Created by Agata Przykaza on 19/11/2024.
//

import SwiftUI

struct OrderMenuView: View {
    
    @Environment(OrderViewModel.self) var orderModel
    
    
    var body: some View {
        
       
            VStack(alignment: .leading){
                
                Group{
                    
                    Text("Zamów")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
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
                .padding(.horizontal)
                .padding(.bottom)
                
                Divider()
                
                ScrollView{
                    VStack(alignment: .leading){
                        Text("Odkryj nasze menu")
                            .padding()
                            .bold()
                        
                        VStack{
                            ForEach(orderModel.categories, id: \.self){ category in
                                
                               NavigationLink(value: category) {
                                    CategoryHeadline(category: category)
                                }
                              
                                
                                
                                
                            }
                            
                        }
                        
                        
                    }
                }
                .padding(.top)
                .navigationDestination(for: Category.self) { category in
                    CategoryView()
                        .navigationTitle(category.name)
                        .navigationBarTitleDisplayMode(.inline)
                }
                
                
                
                
            }
          
            .frame(maxWidth: .infinity,alignment: .leading)
            .onAppear(){
                Task{
                    await orderModel.fetchCategories()
                }
                
            }
        
    }
}



#Preview {
    NavigationStack{
        OrderMenuView()
            .environment(OrderViewModel())
    }
}



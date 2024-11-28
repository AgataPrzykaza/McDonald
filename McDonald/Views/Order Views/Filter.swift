//
//  Filter.swift
//  McDonald
//
//  Created by Agata Przykaza on 14/11/2024.
//

import SwiftUI

struct Filter: View {
    @Environment(OrderViewModel.self) var orderModel
    
    @Binding var showSheetMoreFIlters: Bool

    
    func toggleFilter(_ filter: String) {
         
          DispatchQueue.main.async {
              if orderModel.mapModel.selectedFilters.contains(filter) {
                  orderModel.mapModel.selectedFilters.removeAll { $0 == filter }
              } else {
                  orderModel.mapModel.selectedFilters.append(filter)
              }
          }
      }
    
    func showBadge() -> Bool{
        orderModel.mapModel.selectedFilters.isEmpty ? false : true
    }
    
    var body: some View {
        
        
        HStack{
            ZStack(alignment: .topLeading){
                Image(systemName: "slider.horizontal.3")
                    .imageScale(.large)
                
                if showBadge(){
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width:8)
                        .foregroundStyle(.red.mix(with: .black, by: 0.1))
                }
            }
            .padding(.trailing)
            .onTapGesture {
                
                showSheetMoreFIlters = true
            }
            
            
            ScrollView(.horizontal,showsIndicators: false) {
                
                HStack{
                    
                    ForEach(orderModel.mapModel.filters.filter { orderModel.mapModel.filters.firstIndex(of: $0)! < 3 || orderModel.mapModel.selectedFilters.contains($0) }, id: \.self) { filter in
                        
                        Button {
                            toggleFilter(filter)
                            
                        } label: {
                            FilterButton(name: filter, isSelected: orderModel.mapModel.selectedFilters.contains(filter))
                        }
                        .id(filter)
                        
                        
                        
                        
                    }
                    
                }
              
            }
            
        
            
            Spacer()
            
        }
       
    }
}


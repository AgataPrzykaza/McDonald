//
//  Filter.swift
//  McDonald
//
//  Created by Agata Przykaza on 14/11/2024.
//

import SwiftUI

struct Filter: View {
    
    @Binding var showSheetMoreFIlters: Bool
    let filters: [String]
    @Binding var selectedFilters: [String]
    
    func toggleFilter(_ filter: String) {
         
          DispatchQueue.main.async {
              if self.selectedFilters.contains(filter) {
                  self.selectedFilters.removeAll { $0 == filter }
              } else {
                  self.selectedFilters.append(filter)
              }
          }
      }
    
    var body: some View {
        
        
        HStack{
            Image(systemName: "slider.horizontal.3")
                .imageScale(.large)
                .padding(.trailing)
                .onTapGesture {

                    showSheetMoreFIlters = true
                }
            
            
            ScrollView(.horizontal,showsIndicators: false) {
                
                HStack{
                    
                    ForEach(filters.filter { filters.firstIndex(of: $0)! < 3 || selectedFilters.contains($0) }, id: \.self) { filter in
                        
                        Button {
                            toggleFilter(filter)
                            
                        } label: {
                            FilterButton(name: filter, isSelected: selectedFilters.contains(filter))
                        }
                        .id(filter)
                        
                        
                        
                        
                    }
                    
                }
              
            }
            
        
            
            Spacer()
            
        }
       
    }
}


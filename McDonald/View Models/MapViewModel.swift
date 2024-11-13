//
//  MapViewModel.swift
//  McDonald
//
//  Created by Agata Przykaza on 10/11/2024.
//

import Foundation


@Observable
class MapViewModel{
    
    var selectedFilters: [String] = []
    
    var filters: [String] = ["McCafe", "McDrive", "Otwarte", "Śniadania", "McDelivery", "Zamów i odbierz"]
    var filteredLocations: [RestaurantLocation] = mockRestaurants
    
     func toggleFilter(_ filter: String) {
          
           DispatchQueue.main.async {
               if self.selectedFilters.contains(filter) {
                   self.selectedFilters.removeAll { $0 == filter }
               } else {
                   self.selectedFilters.append(filter)
               }
           }
       }
    
     func updateFilteredLocations() {
         if self.selectedFilters.isEmpty {
             self.filteredLocations = mockRestaurants
               } else {
                   self.filteredLocations = mockRestaurants.filter { location in
                       !Set(self.selectedFilters).isDisjoint(with: location.services)
                   }
               }
           }
    
}

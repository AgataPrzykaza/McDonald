//
//  MapView.swift
//  McDonald
//
//  Created by Agata Przykaza on 08/11/2024.
//

import SwiftUI
import MapKit




struct Service: Hashable{
    var name: String
    var isSelected: Bool
}

struct MapView: View {
    

    @State var showSheetMoreFIlters = false
    @State var showSearchView = false
 

    @Bindable  var vm: MapViewModel = .init()
    
   
       
    

    var body: some View {
        
        VStack{
            
            VStack{
                
                navigationBar
                
                filtersView
                   
                    
                
                
            }
            .padding(.horizontal)
            .padding([.top,.bottom],7)
            
            
            map
                .padding(.bottom)
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
        
        
    }
}

struct FilterButton:  View {
    
    var name: String
    
    var isSelected: Bool = false
    
    var body: some View {
        Text(name)
            .tint(.black)
            .font(.caption)
            .padding(8)
            .padding(.horizontal, 8)
            .background(isSelected ? .accent : .white, in: Capsule())
            .padding(1)
            .background(.gray, in: .capsule)

    }
}


extension MapView {
    
    
    var filtersView: some View {
        
        
        HStack{
            Image(systemName: "slider.horizontal.3")
                .imageScale(.large)
                .padding(.trailing)
                .onTapGesture {

                    showSheetMoreFIlters = true
                }
            
            
            ScrollView(.horizontal,showsIndicators: false) {
                
                HStack{
                    
                    ForEach(vm.filters.filter { vm.filters.firstIndex(of: $0)! < 3 || vm.selectedFilters.contains($0) }, id: \.self) { filter in
                        
                        Button {
                            vm.toggleFilter(filter)
                            
                        } label: {
                            FilterButton(name: filter, isSelected: vm.selectedFilters.contains(filter))
                        }
                        .id(filter)
                        
                        
                        
                        
                    }
                    
                }
                .onChange(of: vm.selectedFilters) {
                    vm.updateFilteredLocations()
                }
            }
            
        
            
            Spacer()
            
        }
        .fullScreenCover(isPresented: $showSheetMoreFIlters) {
            
            FilterServiceSheetView(showFilterServiceSheet: $showSheetMoreFIlters, selectedFilters: $vm.selectedFilters,filters: vm.filters)
        }
    }
    
    var navigationBar: some View{
        HStack{
            
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .tint(.black)
            }
            Spacer()
            
            Text("Restauracje")
                .bold()
            
            Spacer()
            
            Button {
                
                showSearchView.toggle()
                
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                    .tint(.black)
            }
            .navigationDestination(isPresented: $showSearchView) {
                
            }
            
            
        }
    }
    
    
    
    
    
    
    var map: some View {
        ZStack(alignment: .bottomTrailing){
            
            Map(){
                if !vm.filteredLocations.isEmpty{
                    ForEach(vm.filteredLocations) { location in
                        
                        Annotation("", coordinate: location.coordinate) {
                            Image(systemName: "m.circle.fill")
                        }
                        
                        
                    }
                }
            }

          
            
            Button {
                
            } label: {
                Image(systemName: "location.fill")
                    .imageScale(.large)
                    .tint(.white)
                    .padding()
            }
            .background(.yellow,in: .circle)
            .padding()
            
            
        }
    }
}



#Preview {
    NavigationStack{
        MapView()
    }
    
}

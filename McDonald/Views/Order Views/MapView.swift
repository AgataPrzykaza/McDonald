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
    
    @Environment(OrderViewModel.self) var orderModel
    @State var showSheetMoreFIlters = false
    @State var showSearchView = false
 
    @Bindable  var vm: MapViewModel = .init()
   
   

    var body: some View {
        
        VStack{
            
            VStack{
                
                navigationBar
                
                Filter(showSheetMoreFIlters: $showSheetMoreFIlters, filters: vm.filters, selectedFilters: $vm.selectedFilters)
                    .onChange(of: vm.selectedFilters) {
                        vm.updateFilteredLocations()
                    }
                    .fullScreenCover(isPresented: $showSheetMoreFIlters) {
                        
                        FilterServiceSheetView(showFilterServiceSheet: $showSheetMoreFIlters, selectedFilters: $vm.selectedFilters,filters: vm.filters)
                    }
                
              
            }
            .padding(.horizontal)
            .padding([.top,.bottom],7)
            
            
            map
                .padding(.bottom)
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
        
        
    }
}


extension MapView {
    
    
    var navigationBar: some View{
        HStack{
            
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .tint(.black)
            }
            Spacer()
                .onAppear{
                    print(orderModel.rootView)
                }
            
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
                SearchLocationView(location: mockRestaurants)
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

            if orderModel.rootView == .order{
                Text("HALLLLLLLLOOOOOOO")
                    .bold()
                    .foregroundStyle(.red)
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

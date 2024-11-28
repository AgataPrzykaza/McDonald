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
 
    //@Bindable  var vm: MapViewModel = .init()
   
    @State var selectedRestaurant: RestaurantLocation?
    @State var showLocationPreview: Bool = false
   

    var body: some View {
        
        VStack{
            
            VStack{
                
                navigationBar
                
                Filter(showSheetMoreFIlters: $showSheetMoreFIlters)
                    .onChange(of: orderModel.mapModel.selectedFilters) {
                        orderModel.mapModel.updateFilteredLocations()
                    }
                    .fullScreenCover(isPresented: $showSheetMoreFIlters) {
                        
                        FilterServiceSheetView(showFilterServiceSheet: $showSheetMoreFIlters)
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
                orderModel.navigationPath.removeLast()
                
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
                
                orderModel.navigationPath.append(ViewState.searchLocation)
                
               // showSearchView.toggle()
                
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                    .tint(.black)
            }
            
            
        }
    }
    
    
    
    var map: some View {
        ZStack(alignment: .bottomTrailing){
            
            Map(){
                if !orderModel.mapModel.filteredLocations.isEmpty{
                    ForEach(orderModel.mapModel.filteredLocations) { location in
                        
                        Annotation("", coordinate: location.coordinate) {
                            Image("icon")
                                .resizable()
                                .scaledToFit()
                                .frame(height:30)
                                .clipShape(.circle)
                                .scaleEffect( location.name == selectedRestaurant?.name ?? "" ? 1.2 : 0.9)
                                .shadow(radius: 10)
                                .onTapGesture{
                                    
                                    selectedRestaurant = location
                                    
                                    withAnimation(.bouncy) {
                                        showLocationPreview = true
                                    }
                              
                                }
                        }
                        
                        
                        
                    }
                }
                
            }
          

            VStack(alignment: .center){
                HStack{
                    Spacer()
                    Button {
                        
                        
                        
                    } label: {
                        Image(systemName: "location.fill")
                            .imageScale(.large)
                            .tint(.white)
                            .padding()
                    }
                    .background(.yellow,in: .circle)
                   
                }
                
                if showLocationPreview , let location = selectedRestaurant{
                    VStack{
                        
                        HStack{
                            
                            Image("icon")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                                .clipShape(.circle)
                                
                            
                            Spacer()
                            Button {
                                showLocationPreview = false
                                selectedRestaurant = nil
                            } label: {
                                Image(systemName: "xmark")
                                    .imageScale(.large)
                                    .tint(.black)
                            }

                            
                        }
                        .padding(10)
                        
                        LocationCardView(restaurant: location, buttonPosition: .center)
                            .padding()
                           
                           
                            
                    }
                    .padding([.top,.bottom])
                    .background(.white, in: .rect(cornerRadius: 10))
                   
                   
                }
                
            }
            .frame(width:.infinity)
            .padding()
            
        }
    }
}



#Preview {
    NavigationStack{
        MapView()
            .environment(OrderViewModel())
    }
    
}

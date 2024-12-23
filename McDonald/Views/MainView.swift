//
//  MainView.swift
//  McDonald
//
//  Created by Agata Przykaza on 07/10/2024.
//

import SwiftUI

enum Tabs: Equatable, Hashable, Identifiable {
    
    case homePage
    case myM
    case order
    case mcdelivery
    case settings
    var id: Self { self }
}




struct MainView: View {
   
    
    @State  var selectedTab: Tabs = .homePage
   
    @Environment(MainViewModel.self) var mViewModel
    
    
    
    
    var body: some View {
        
        @Bindable var  mainViewModel = mViewModel
        
        TabView(selection: $mainViewModel.selectedTab){
            
            Tab("Main page", systemImage: "house.fill",value: .homePage){
                HomeView()
            }
            
            Tab("MyM",systemImage: "star.fill",value: .myM){
                MyMView()
            }
            
        
            Tab("Order",systemImage: "takeoutbag.and.cup.and.straw.fill" ,value: .order){
                OrderView()
                   
            }
            
            Tab("McDelivery",systemImage: "truck.box.fill",value: .mcdelivery){
                DeliveryView()
            }
            
            Tab("Settings",systemImage: "heart",value: .settings){
                SettingsView()
            }
            
            Tab("McDelivery",systemImage: "heart",value: .settings){
                McDelivery()
            }
        
        }
        .task{
            try? await mainViewModel.loadCurrentUser()
        }
        .onAppear{
            let authuser = try? AuthManager.shared.getAuthenticatedUser()
            mainViewModel.showSignInView = authuser == nil
        }
       
        
        
        
    }
}



#Preview {
    MainView()
        .environment(OrderViewModel())
        .environment(MainViewModel())
        
}

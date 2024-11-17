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
    case obb
    var id: Self { self }
}

struct MainView: View {
    
    @State  var selectedTab: Tabs = .homePage
    
    
    
    var body: some View {
        
        TabView(selection: $selectedTab){
            
            Tab("Main page", systemImage: "house.fill",value: .homePage){
                HomeView(selectionTab: $selectedTab)
            }
            
            Tab("MyM",systemImage: "star.fill",value: .myM){
                MyMView()
            }
            
        
            Tab("Order",systemImage: "takeoutbag.and.cup.and.straw.fill" ,value: .order){
                OrderView()
                   
            }
            
            Tab("McDelivery",systemImage: "truck.box.fill",value: .mcdelivery){
                McDelivery()
            }
            
            Tab("McDelivery",systemImage: "heart",value: .obb){
                McDelivery()
            }
            
            Tab("McDelivery",systemImage: "heart",value: .obb){
                McDelivery()
            }
        }
        
    }
}

#Preview {
    MainView()
        .environment(OrderViewModel())
}

//
//  CategoryView.swift
//  McDonald
//
//  Created by Agata Przykaza on 20/12/2024.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(OrderViewModel.self) var orderModel
    
    
    var category: Category
    @State var items: [MenuItem] = []
    
    var body: some View {
        VStack(alignment: .leading){
           
            Text(category.name)
                .font(.title)
                .bold()
            
            ScrollView{
                VStack(alignment: .leading){
                   
                    
                    VStack{
                        ForEach(orderModel.menuItems.filter { item in
                            item.category.rawValue == category.category.rawValue
                        }, id: \.menuID) { item in
                            
                            NavigationLink(value: item) {
                                MenuItemHeadline(item: item)
                                Divider()
                            }
                          
                        }

                    }
                    .navigationDestination(for: MenuItem.self) { item in
                        MeunItemView( item: item)
                    }
                    
                    
                }
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity,alignment: .leading)
        .overlay(alignment: .bottomTrailing, content: {
            Button {
                orderModel.navigationPath.append(ViewState.cart)
            } label: {
                CartIconView()
            }

            
           
        })
        //.modifier(CartModifier())
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                }

            }
        }
        
    }
}

#Preview {
    NavigationStack{
        CategoryView( category: Category(name: "Burgery", imagePath: "", category: .burgers))
            .environment(OrderViewModel())
    }

}

struct MenuItemHeadline: View {
    
    let item : MenuItem
    
    var body: some View {
        HStack{
            Rectangle()
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .bold()
                    .font(.headline)
                Text(String(format: "%.2f zł", item.price))
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .foregroundStyle(.black)
    }
}

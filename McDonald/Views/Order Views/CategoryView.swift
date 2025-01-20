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
    
    @State var imageURL: URL?
    
    func loadImage() async {
        do {
            imageURL = try await FirestoreService().fetchImageURL(for: item.imagePath)
        } catch {
            print("Error fetching image URL: \(error)")
        }
    }
    
    var body: some View {
        HStack{
            
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .frame(width: 60, height: 50)
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 10))
                
            } placeholder: {
                Rectangle()
                    .foregroundStyle(.white)
                    .frame( height: 50)
                    .scaledToFit()
                    .overlay {
                        ProgressView()
                    }
            }
            
            VStack(alignment: .leading) {
                HStack{
                    Text(item.name)
                        
                    
                    if item.size != nil{
                        if let size = item.size {
                            Text("\(size.rawValue.prefix(1).uppercased())")
                        }
                    }
                }
                .bold()
                .font(.headline)
                
                Text(String(format: "%.2f zł", item.price))
                    .font(.subheadline)
            }
            .task {
                await loadImage()
            }
            
            Spacer()
        }
        .foregroundStyle(.black)
    }
}

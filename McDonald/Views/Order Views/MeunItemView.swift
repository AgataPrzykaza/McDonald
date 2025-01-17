//
//  MeunItemView.swift
//  McDonald
//
//  Created by Agata Przykaza on 13/01/2025.
//

import SwiftUI

struct MeunItemView: View {
    
    @Environment(OrderViewModel.self) var orderModel
    @Environment(MainViewModel.self) var mViewModel
    @Environment(\.dismiss) var dismiss
    
    let item: MenuItem
    
    var body: some View {
        VStack{
            ScrollView{
                VStack(alignment:.leading){
                    
                    Rectangle()
                        .frame(height: 300)
                    
                    HStack{
                        Text(item.name)
                           
                        
                        if item.size != nil{
                            if let size = item.size {
                                Text("\(size.rawValue.prefix(1).uppercased())")
                            }
                        }
                    }
                    .font(.title)
                    .fontWeight(.heavy)
                    
                    Text(String(format: "%.2f zł", item.price))
                        .font(.title)
                    
                    if (item.ingredients != nil){
                        HStack {
                            ForEach(item.ingredients!, id: \.self){ ingredient in
                                Text("\(ingredient),")
                                    .font(.headline)
                                    .foregroundStyle(.gray)
                                
                            }
                        }
                    }
                    
                    
                    
                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            
           
                

            
        }
        .padding()
        
        
        Divider()
          

        HStack(alignment: .center){
           
           
            Button {
                guard let user = mViewModel.user,
                      let location = orderModel.selectedRestaurant else {
                    print("Błąd: użytkownik lub lokalizacja nie są dostępne.")
                    return
                }
                
                print("Dodawanie przedmiotu: \(item.name) dla użytkownika: \(user.userId), restauracja: \(location.id)")
                orderModel.addToCart(menuItem: item, customerID: user.userId, restaurantID: location.id)
                
                dismiss()
                
            } label: {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .overlay {
                        Text("Dodaj do zamówienia")
                            .foregroundStyle(.black)
                    }
            }
            .disabled(mViewModel.user == nil)
            .opacity(mViewModel.user == nil ? 0.5 : 1)

          
                
        }
        .frame(height: 75)
        .padding(.top,-7)
        
        
       
        Divider()
            .padding(.top,-8)
    }
}

#Preview {
    MeunItemView(item:  MenuItem(
        itemNumber: "005-S",
        name: "Coca-Cola",
        price: 5.99,
        category: .drink,
        ingredients: ["sada","sad","sad"],
        imagePath: "https://example.com/images/coca-cola-small.jpg",
        size: .small
    ))
    .environment(MainViewModel())
    .environment(OrderViewModel())
}

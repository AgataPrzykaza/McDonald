//
//  CartView.swift
//  McDonald
//
//  Created by Agata Przykaza on 09/01/2025.
//

import SwiftUI

struct CartView: View {
    
    @Environment(OrderViewModel.self) var orderModel
    @Environment(MainViewModel.self) var mViewModel

  
    func getPrizes(){
        
        for prize in mViewModel.usedPrizes{
            orderModel.addPrizeToCart(prize: prize)
        }
        
        mViewModel.usedPrizes.removeAll()
        
        for coupon in mViewModel.usedCoupons{
            orderModel.addCouponToCart(coupon: coupon)
        }
        mViewModel.usedCoupons.removeAll()
                
    }
    
    
    
    var body: some View {
        
        @Bindable var  viewModel = orderModel
        
        VStack(alignment: .leading) {
            
            HStack{
                
                
                Button {
                    orderModel.rootView = .order
                    
                    orderModel.navigationPath.removeLast(orderModel.navigationPath.count)
                    
                } label: {
                    Image(systemName: "xmark")
                }
                
                Spacer()
            }
            
            Text("Twoje zamówienie")
                .font(.title)
                .bold()
                .padding()
            
            restaurant
                .padding()
            
            VStack{
                
                ScrollView{
                    if viewModel.order != nil, viewModel.order!.items.count > 0{
                        
                        ForEach(viewModel.order!.items){ item in
                            
                            CartItem( item: item)
                            
                        }
                    }
                    else {
                        Text("Brak zamówień")
                    }
                    
                   
                    
                }
                
                
            }
            .padding()
            .onAppear{
                getPrizes()
            }
            
            
            Divider()
            HStack{
                Text("Do zapłaty")
                Spacer()
                if let order = viewModel.order {
                    Text(String(format: "%.2f zł", order.sum))
                }
                else{
                    Text(String(format: "%.2f zł",0))
                }
                
            }
            .font(.headline)
            .bold()
            .padding()
            
            Divider()
            
            
            HStack(alignment: .center){
                
                
                Button {
                    orderModel.rootView = .order
                    
                    orderModel.navigationPath.removeLast(orderModel.navigationPath.count)
                    
                } label: {
                    Rectangle()
                        .foregroundStyle(.white)
                        .overlay {
                            Text("Zamów więcej")
                                .padding(.horizontal)
                                .foregroundStyle(.black)
                        }
                }
                
              
                
                Spacer()
                
                
                
                
                Button{
                    
                    orderModel.navigationPath.append(ViewState.orderType)
                    
                    
                }label: {
                    Rectangle()
                        .foregroundStyle(.yellow)
                        .overlay {
                            Text("Wybierz miejsce odbioru")
                                .foregroundStyle(.black)
                            
                            
                        }
                }
                .disabled(
                    orderModel.order == nil || (orderModel.order?.sum ?? 0) == 0
                )
                .opacity(orderModel.order == nil || (orderModel.order?.sum ?? 0) == 0 ? 0.5 : 1)
                
               
                
                
            }
            .frame(height: 75)
            .padding(.top,-7)
            
            
            Divider()
                .padding(.top,-8)
            
            
            
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .navigationBarBackButtonHidden()
        
       
    }
}

extension CartView {
    var restaurant : some View{
        HStack{
            
            Image("icon")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
                .clipShape(.circle)
            
            VStack(alignment: .leading){
                
                Text(orderModel.selectedRestaurant?.name ?? "Brak")
                    .fontWeight(.bold)
                Text(orderModel.selectedRestaurant?.openHours.first?.1 ?? "Brak godziny")
                    .foregroundStyle(.secondary)
            }
            Spacer()
            
            Button {
                orderModel.mapModel.selectedLocation = nil
                orderModel.navigationPath.append(ViewState.map)
                orderModel.selectedRestaurant = nil
                
                
            } label: {
                
                Text("Zmień restauracje")
                    .underline(color: .blue)
                    .foregroundStyle(.blue)
            }
        }
        
    }
    
    
}

#Preview {
    NavigationStack{
        CartView()
    }
    .environment(OrderViewModel())
    .environment(MainViewModel())
    
}

struct CartItem: View {
    
    @Environment(OrderViewModel.self) var orderModel
    
    var item: MenuItem
    
    
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
                    .frame(width: 50, height: 40)
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
            
            Text(item.name)
                .fontWeight(.heavy)
            
            Text(String(format: "%.2f zł",item.price))
                .bold()
            
            if item.size != nil{
                if let size = item.size {
                    Text("\(size.rawValue.prefix(1).uppercased())")
                        .bold()
                }
            }
            
            
            Spacer()
            Button(role: .destructive) {
                orderModel.removeFromCart(menuItem: item)
                
            } label: {
                Image(systemName: "minus")
            }
        }
        .padding(.horizontal)
        .task {
            await loadImage()
        }
    }
}

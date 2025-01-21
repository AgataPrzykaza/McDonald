//
//  SummaryOrderView.swift
//  McDonald
//
//  Created by Agata Przykaza on 20/01/2025.
//

import SwiftUI

struct SummaryOrderView: View {
    @Environment(OrderViewModel.self) var orderModel
    @Environment(MainViewModel.self) var mModel
    
   
        func processOrder() async {
            do {
                orderModel.order?.orderType = orderModel.orderType
                try await OrderManager.shared.makeOrder(orderModel.order!)
                print("Zamówienie zostało zapisane pomyślnie.")
            } catch {
                print("Błąd podczas zapisywania zamówienia: \(error)")
            }
        }

    func updatePoints(for userID: String,prize points: Int) async {
        do {
           
            
            try await PointsManager.shared.updatePoints(for: userID, points: points, historyRecord: HistoryRecord(gained: true, date: Date(), points: points))
            
        } catch {
            
            print("Error: \(error)")
        }
    }
    
    func pointsForOrder(_ price: Double) -> Int {
        let points = Int(ceil(price / 3.0))
        return points
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Podsumowanie zamówienia")
                .font(.title)
                .bold()
            
            ScrollView{
                
                VStack{
                    
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
                        
                      
                    }
                    .padding(.bottom)
                    
                    HStack{
                        Text("Rodzaj zamówienia: ")
                            .bold()
                        
                        Text(orderModel.orderType.rawValue)
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Rectangle()
                        .frame(height: 5)
                        .foregroundStyle(.accent)
                    
                    
                    
                }
                
                
                if orderModel.order != nil{
                    
                    ForEach(orderModel.order!.items){ item in
                        
                        SummaryItem( item: item)
                        
                    }
                }
                    
               
                    
                   
                
                
            }
            
            Spacer()
            
            HStack{
                Text("Razem:")
                
                Text(String(format: "%.2f zł", orderModel.order?.sum ?? 0))
                
            }
            .font(.title2)
            .padding(.bottom)
            
           
            
            Button{
                
               
                Task {
                    
                    orderModel.order?.restaurantID = orderModel.selectedRestaurant!.id
                    orderModel.order?.customerID = mModel.user!.userId
                    
                    await processOrder()
                    await updatePoints(for: mModel.user!.userId, prize: pointsForOrder(orderModel.order!.sum))
                    
                    orderModel.lastOrderNumber = orderModel.order!.orderNumber
                    orderModel.resetOrder()
                    
                    orderModel.navigationPath.append(ViewState.orderNumber)
                }

                
            }label: {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .overlay {
                        Text("Zapłać")
                            .foregroundStyle(.black)
                        
                        
                    }
            }
            .frame(height: 50)
            
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding()
    }
}

struct SummaryItem: View {
    
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
            
            if item.size != nil{
                if let size = item.size {
                    Text("\(size.rawValue.prefix(1).uppercased())")
                        .bold()
                }
            }
            
            Text(String(format: "%.2f zł",item.price))
                .bold()
            
            
            
            
            Spacer()
           
        }
        .padding(.horizontal)
        .task {
            await loadImage()
        }
    }
}


#Preview {
    SummaryOrderView()
        .environment(OrderViewModel())
        .environment(MainViewModel())
}

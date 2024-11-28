//
//  MyMView.swift
//  McDonald
//
//  Created by Agata Przykaza on 07/10/2024.
//

import SwiftUI


struct MyMView: View {
    
    @State  var points: Points = Points(userId: "1234", currentPoints: 2000, history: [])
    
    
    @State var myService: MyMService = MyMService()
    
    
    var body: some View {
        
        
        NavigationStack{
            ScrollView{
                VStack{
                    Text("QR code")
                    
                    prizeHeaders
                        .padding(.bottom)
                    
                    couponsHeaders
                    
                    Spacer()
                }
                
            }
            .padding()
            .navigationDestination(for: Points.self) { points in
                Text("Details for Points")
            }
            .onAppear{
                Task{
                    await myService.fetchPrizes()
                    await myService.fetchCoupons()
                   
                }
            }
            .toolbar{
                MyViewToolbar(points: $points)
               
            }
            .toolbarBackground(.clear, for: .navigationBar)
            
            
        }
       
        
    }
}




#Preview {
    MyMView()
}



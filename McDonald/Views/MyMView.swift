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
    
    @State var showQRSheet: Bool = false
    
    let userID = "M23423434"
    
    var body: some View {
        
        
        NavigationStack{
            ScrollView{
                VStack{
                    
                    
                    
                    UserQRCodeView(userID: userID)
                        .background(content: {
                            Color.white
                                .clipShape(.rect(cornerRadius: 15))
                                .shadow(radius: 2)
                        })
                        .padding()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showQRSheet.toggle()
                            }
                         
                        }
                    
                       
                    
                    prizeHeaders
                        .padding(.bottom)
                    
                    couponsHeaders
                    
                    Spacer()
                }
                .sheet(isPresented: $showQRSheet) {
                    QRSheet(userID: userID)
                }
                
            }
            .padding(.horizontal)
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
            .scrollIndicators(.hidden)
            
        }
       
        
    }
}




#Preview {
    MyMView()
}



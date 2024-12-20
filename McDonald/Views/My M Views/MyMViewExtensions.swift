//
//  MyMViewExtensions.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/11/2024.
//
import SwiftUI

extension MyMView{
    
    
    
    var couponsHeaders: some View{
        
        VStack(alignment:.leading){
            
            Text("MojeM okazYEAH!")
                .font(.title2)
                .fontWeight(.bold)
            
            ForEach(myService.coupons, id: \.self){ coupon in
                
                NavigationLink {
                    CouponView(coupon: coupon)
                } label: {
                    CouponCardView(coupon: coupon)
                    
                }
          

               
                
            }
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}
extension MyMView{
    
    var prizeHeaders: some View{
        VStack(alignment: .leading) {
            
            HStack{
                Text("MojeM Nagrody")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                
                NavigationLink {
                    PrizeListView(prizes: myService.prizes)
                } label: {
                    HStack{
                        Text("Zobacz więcej")
                            .underline()
                        Image(systemName: "arrow.right")
                            .fontWeight(.bold)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                }

              
                
                
            }
            if myService.prizes.isEmpty {
                       // Placeholder, gdy brak nagród
                       Text("Brak dostępnych nagród.")
                           .font(.subheadline)
                           .foregroundColor(.gray)
                           .padding()
                           .frame(height: 200)
            } else {
                ScrollView(.horizontal){
                    LazyHStack{
                        
                        ForEach(myService.prizes, id: \.self){ prize in
                            
                            NavigationLink {
                                PrizeView(prize: prize)
                            } label: {
                                PrizeCardView(prize: prize)
                                   
                            }

                           
                            
                            
                            
                            
                        }
                        
                        NavigationLink {
                            PrizeListView(prizes: myService.prizes)
                        } label: {
                            VStack{
                                
                                Image(systemName: "arrow.right")
                                    .imageScale(.medium)
                                    .foregroundStyle(.black)
                                    .padding(15)
                                    .background(.yellow,in: .circle)
                                
                                Text("Zobacz wszystkie")
                                    .font(.footnote)
                                    .foregroundStyle(.black)
                               
                            }
                        }

                        
                       
                        
                    }
                    .frame(maxHeight: 250)
                }
                .scrollIndicators(.hidden)
                
            }
                
           
        }
    }
    
}

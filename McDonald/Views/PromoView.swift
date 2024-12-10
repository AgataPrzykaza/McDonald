//
//  PromoView.swift
//  McDonald
//
//  Created by Agata Przykaza on 31/10/2024.
//

import SwiftUI

struct PromoView: View {
    
    var promo: Promo
    @Environment(MainViewModel.self) var mViewModel

    
    @State var promoViewModel: PromoViewModel = PromoViewModel()
    
    var body: some View {
        
        
        ScrollView{
            LazyVStack {
                
            
                if promoViewModel.details != nil  && !promoViewModel.images.isEmpty{
                    
                    Text(promoViewModel.details!.header)
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    // first promo image
                    AsyncImageView(imageData: promoViewModel.images[0])
                    
                   
                        Text("ZAMÓW PRZEZ APLIKACJĘ!")
                            .fontWeight(.heavy)
                            .foregroundStyle(.black)
                            .padding()
                            .background(.yellow,in: .capsule)
                            .onTapGesture {
                               
                                mViewModel.selectTab(.order)
                               
                                
                            }
                         
                
                    if let description = promoViewModel.arrayDescription.first {
                     
                     //description
                        let (title, descript) = promoViewModel.splitTitleAndDescription(from: description)
                     Text(title)
                         .multilineTextAlignment(.center)
                         .font(.title)
                         .fontWeight(.heavy)
                     
                     Text(descript)
                         .multilineTextAlignment(.center)
                         .fontWeight(.heavy)
                         .padding()
                    }
                   
                    aboutPromo
                    

                }
                
            }
        }
        .navigationTitle(promoViewModel.details?.fullTitle ?? "brak")
        .navigationBarTitleDisplayMode(.inline)
        .task {
           await fetchDetails()
            await promoViewModel.loadImages()
            promoViewModel.description()
           
            
        }
       
       
       
    }
    

    func fetchDetails() async {
            if let promoID = promo.promoDetail {
                promoViewModel.details = await FirestoreService().fetchPromoDetailsFromFirestore(for: promoID)
            } else {
                print("Brak dostępnego identyfikatora promoDetail dla tej promocji")
            }
        }
}

extension PromoView {
    var aboutPromo: some View {
        ForEach(promoViewModel.images.dropFirst().indices, id: \.self) { index in
            
            AsyncImageView(imageData: promoViewModel.images[index])
            if index < promoViewModel.arrayDescription.count {
                
                let (title, descript) = promoViewModel.splitTitleAndDescription(from: promoViewModel.arrayDescription[index])
                
                Text(title)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text(descript)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                

            }
            
        }
    }
}




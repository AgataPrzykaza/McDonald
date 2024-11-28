//
//  CouponView.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/11/2024.
//

import SwiftUI

struct CouponView: View {
    
    let coupon: Coupon
    let rules = ["Do użycia 1x na transakcje","Zaloguj się / złóż konto"]
    @State var imageURL: URL?
    
    var body: some View {
        VStack{
            
            ScrollView{
               
                    
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .frame(width: .infinity, height: 250)
                            .scaledToFit()
                        
                    } placeholder: {
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame( height: 250)
                            .scaledToFit()
                            .overlay {
                                ProgressView()
                            }
                    }
                    
                VStack(alignment: .leading){
                    
                    Text(coupon.title)
                        .font(.title)
                        .bold()
                    
                    Text("Zasady")
                        .font(.headline)
                        .bold()
                        .padding(.top)
                    
                    ForEach(rules,id: \.self){ rule in
                        Text(rule)
                            .font(.subheadline)
                        Divider()
                            .padding(.horizontal)
                        
                    }
                    .padding(.top,5)
                    
                }
                .padding()
            
            }
            Spacer()
            
            Text("Odbierz")
                 .padding()
                 .frame(maxWidth: .infinity)
                 .background(.yellow, in: .rect)
            
            
        }
        .task {
            await loadImage()
        }
    }
    
    func loadImage() async {
        do {
            imageURL = try await FirestoreService().fetchImageURL(for: coupon.imagePath)
        } catch {
            print("Error fetching image URL: \(error)")
        }
    }
}


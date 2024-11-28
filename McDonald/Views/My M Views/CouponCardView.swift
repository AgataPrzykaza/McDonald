//
//  CouponCardView.swift
//  McDonald
//
//  Created by Agata Przykaza on 26/11/2024.
//

import SwiftUI

struct CouponCardView: View {
    
    var coupon: Coupon
    @State private var imageURL: URL?
    
    var body: some View {
        VStack(alignment: .leading){
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .frame(height: 175)
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                
                
            } placeholder: {
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(height: 175)
                    .scaledToFit()
                    .overlay {
                        ProgressView()
                    }
            }
            
            Text(coupon.title)
                .fontWeight(.bold)
                .foregroundStyle(.black)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
            
        )
        .padding(5)
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

#Preview {
    CouponCardView(coupon: Coupon(title: "chikker", imagePath: "coupons/fries2f1.jpg", menuID: "123"))
}

//
//  CouponCardView.swift
//  McDonald
//
//  Created by Agata Przykaza on 26/11/2024.
//

import SwiftUI

@MainActor
@Observable class CouponCardViewModel{
    
    var couponTakenToday: Bool = false
    
    func checkIfPrizeTakenToday(for userID: String, coupon: Coupon) async {
        let rewards = await RewardManager.shared.getCoupons(for: userID) ?? []
        
        let today = Date()
        let calendar = Calendar.current
        
        
        let alreadyTaken = rewards.contains { reward in
            guard reward.prizeId == coupon.menuID else {
                return false
            }
            
            return calendar.isDate(reward.lastTaken!, inSameDayAs: today)
        }
        
        couponTakenToday =  alreadyTaken
    }
}

struct CouponCardView: View {
    @Environment(MainViewModel.self) var mViewModel
    @State var vmodel : CouponCardViewModel = CouponCardViewModel()
    
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
        .overlay(content: {
            Color.gray.opacity(vmodel.couponTakenToday ? 0.5 : 0)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if vmodel.couponTakenToday {
                Text("Wykorzystany")
                    .font(.title)
                    .foregroundStyle(.black)
                    .bold()
                   

            }
        })
        .padding(5)
        .task {
            await loadImage()
            if let user = mViewModel.user {
                await vmodel.checkIfPrizeTakenToday(for: user.userId, coupon: coupon)
            }
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

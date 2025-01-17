//
//  CouponView.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/11/2024.
//

import SwiftUI


@MainActor
@Observable class CouponViewModel{
    
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
    
    func upadateCoupons(for userID: String, coupon: Coupon) async {
        await  RewardManager.shared.addCoupon(for: userID, coupon: coupon)
    }
    
}

struct CouponView: View {
    @Environment(MainViewModel.self) var mViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var vmodel: CouponViewModel = CouponViewModel()
    
    let coupon: Coupon
    let rules = ["Do użycia 1x na transakcje","Zaloguj się / złóż konto"]
    @State var imageURL: URL?
    
    var body: some View {
        VStack{
            
            ScrollView{
               
                    
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            
                        
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
            .overlay(alignment: .topTrailing) {
                if mViewModel.user == nil {
                    Image(systemName: "lock.fill")
                        .foregroundStyle(.gray)
                        .padding()
                }
                
               
            }
            
            Spacer()
            
            Text("Odbierz")
                 .padding()
                 .frame(maxWidth: .infinity)
                 .background(mViewModel.user != nil && !vmodel.couponTakenToday ? .yellow : .gray, in: .rect)
                 .disabled(mViewModel.user == nil || vmodel.couponTakenToday)
                 .onTapGesture {
                     if let userId = mViewModel.user?.userId {
                         
                         mViewModel.usedCoupons.append(coupon)
                         
                         Task {
                          
                             await vmodel.upadateCoupons(for: userId, coupon: coupon)
                             dismiss()
                           
                         }
                     }
                     
                     
                     
                 }

            
            
        }
        .overlay(content: {
            Color.gray.opacity(vmodel.couponTakenToday ? 0.5 : 0)
        })
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


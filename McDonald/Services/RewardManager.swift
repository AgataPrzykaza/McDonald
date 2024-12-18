//
//  RewardManager.swift
//  McDonald
//
//  Created by Agata Przykaza on 17/12/2024.
//

import Foundation

import FirebaseFirestore

final class RewardManager {
    
    static let shared = RewardManager()
    
    private init() {}
    
    private let rewardsCollection = Firestore.firestore().collection("rewards")
    
    private func pointsDocument(for userId: String) -> DocumentReference {
        rewardsCollection.document(userId)
    }
    
   
   
    // MARK: - Nagrody (Rewards)
    
    func setRewardTaken(for userID: String, prize: MPrize) async {
        do {
            let document = try await rewardsCollection.document(userID).getDocument()
            
            var rewardsArray: [[String: Any]] = []
            let newReward = Reward(prizeId: prize.menuID, lastTaken: Date()).toDictionary()
            
            if document.exists, let data = document.data(), let existingRewards = data["rewards"] as? [[String: Any]] {
                
                rewardsArray = existingRewards.filter { $0["prize_Id"] as? String != prize.menuID }
            }
            
          
            rewardsArray.append(newReward)
            
          
            try await rewardsCollection.document(userID).setData(["rewards": rewardsArray], merge: true)
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }


    
    func getRewards(for userID: String) async -> [Reward]? {
        do {
            let document = try await rewardsCollection.document(userID).getDocument()
            
            if document.exists, let data = document.data(), let rewardsData = data["rewards"] as? [[String: Any]] {
                
                let rewards = rewardsData.compactMap { dict -> Reward? in
                    guard let prizeId = dict["prize_Id"] as? String,
                          let lastTakenTimestamp = dict["last_taken"] as? Timestamp else {
                        return nil
                    }
                    return Reward(prizeId: prizeId, lastTaken: lastTakenTimestamp.dateValue())
                }
                return rewards
            } else {
                return []
            }
        } catch {
            print("Błąd podczas pobierania nagród: \(error.localizedDescription)")
            return nil
        }
    }

    // MARK: - Kupony (Coupons)
        
    func addCoupon(for userID: String, coupon: Coupon) async {
        do {
            let document = try await rewardsCollection.document(userID).getDocument()
            
            var couponsArray: [[String: Any]] = []
            let newCoupon = Reward(prizeId: coupon.menuID, lastTaken: Date()).toDictionary()
            
            
            if document.exists, let data = document.data(), let existingCoupons = data["coupons"] as? [[String: Any]] {
                
                couponsArray = existingCoupons.filter { $0["prize_Id"] as? String != coupon.menuID }
            }
            
            
            couponsArray.append(newCoupon)
            
            
            try await rewardsCollection.document(userID).setData(["coupons": couponsArray], merge: true)
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

        
    func getCoupons(for userID: String) async -> [Reward]? {
            do {
                let document = try await rewardsCollection.document(userID).getDocument()
                
                if document.exists, let data = document.data(), let couponsData = data["coupons"] as? [[String: Any]] {
                    let coupons = couponsData.compactMap { dict -> Reward? in
                        guard let couponId = dict["prize_Id"] as? String,
                              let lastUsedTimestamp = dict["last_taken"] as? Timestamp else {
                            return nil
                        }
                        return Reward(prizeId: couponId, lastTaken: lastUsedTimestamp.dateValue())
                    }
                    return coupons
                } else {
                    return []
                }
            } catch {
                print("Błąd podczas pobierania kuponów: \(error.localizedDescription)")
                return nil
            }
        }
    
    
}

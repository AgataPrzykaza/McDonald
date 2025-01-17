//
//  MainViewModel.swift
//  McDonald
//
//  Created by Agata Przykaza on 11/12/2024.
//
import Foundation

@MainActor
@Observable class MainViewModel{
    
    var showSignInView = false
    
     var selectedTab: Tabs = .homePage
    
    var user: UserDB? = nil
    
    var usedPrizes: [MPrize] = []
    var usedCoupons: [Coupon] = []
    
    func selectTab(_ tab: Tabs){
        selectedTab = tab
    }
    
    func shoSignInToggle(){
        showSignInView.toggle()
    }
    
    
    
    
    func loadCurrentUser() async throws {
        
        let authDataResult = try AuthManager.shared.getAuthenticatedUser()
        
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
        
    }
    
}

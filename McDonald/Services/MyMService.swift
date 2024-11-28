//
//  MyMService.swift
//  McDonald
//
//  Created by Agata Przykaza on 26/11/2024.
//
import Foundation


@Observable
class MyMService{
    
    var coupons: [Coupon] = []
    var prizes: [MPrize] = []
    
    
    
    func fetchCoupons() async {
        coupons = await FirestoreService().fetchCollection(from: "coupons", as: Coupon.self)
    }
    
    func fetchPrizes() async {
        prizes = await FirestoreService().fetchCollection(from: "prizes", as: MPrize.self)
    }
    
    
}

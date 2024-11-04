//
//  Promo.swift
//  McDonald
//
//  Created by Agata Przykaza on 29/10/2024.
//

struct Promo: Codable, Hashable {
    let title: String
    let type: String
    let imagePath: String
    let promoDetail: String?
    
    init(title: String, type: String, imagePath: String, promoDetail: String? = nil) {
        self.title = title
        self.type = type
        self.imagePath = imagePath
        self.promoDetail = promoDetail
    }
    
}

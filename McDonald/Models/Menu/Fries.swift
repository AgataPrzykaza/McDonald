////
////  Fries.swift
////  McDonald
////
////  Created by Agata Przykaza on 01/10/2024.
////
//
//class Fries: MenuItem {
//    var hasKetchup: Bool
//    var salt: Bool
//    
//    init(name: String, price: Double,itemNumber: String, hasKetchup: Bool, hasSalt: Bool) {
//        self.hasKetchup = hasKetchup
//        self.salt = hasSalt
//        super.init(name: name, itemNumber: itemNumber, price: price, category: .fries, ingredients: ["fries"])
//    }
//    
//    enum FriesCodingKeys: String, CodingKey {
//        case hasKetchup
//        case salt
//    }
//     required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: FriesCodingKeys.self)
//        self.hasKetchup = try container.decode(Bool.self, forKey: .hasKetchup)
//        self.salt = try container.decode(Bool.self, forKey: .salt)
//        try super.init(from: decoder)
//    }
//   
//    override func encode(to encoder: any Encoder) throws {
//        try super.encode(to: encoder)
//        var container = encoder.container(keyedBy: FriesCodingKeys.self)
//        try container.encode(hasKetchup, forKey: .hasKetchup)
//        try container.encode(salt, forKey: .salt)
//    }
//}

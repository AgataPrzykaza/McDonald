////
////  Salad.swift
////  McDonald
////
////  Created by Agata Przykaza on 01/10/2024.
////
//
//class Salad: MenuItem {
//    var dressing: Dressing
//    var hasChicken: Bool
//    
//    
//    init(name: String, price: Double,itemNumber: String, ingredients: [String], dressing: Dressing, hasChicken: Bool) {
//        self.dressing = dressing
//        self.hasChicken = hasChicken
//       
//        super.init(name: name, itemNumber: itemNumber, price: price, category: .salad, ingredients: ingredients)
//    }
//    
//    enum SaladCodingKeys: String, CodingKey {
//        case dressing
//        case hasChicken
//    }
//    
//    required init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: SaladCodingKeys.self)
//        self.dressing = try container.decode(Dressing.self, forKey: .dressing)
//        self.hasChicken = try container.decode(Bool.self, forKey: .hasChicken)
//        try super.init(from: decoder)
//    }
//    
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//        var container = encoder.container(keyedBy: SaladCodingKeys.self)
//        try container.encode(dressing, forKey: .dressing)
//        try container.encode(hasChicken, forKey: .hasChicken)
//    }
//    
//    
//    enum Dressing : String, Codable {
//        case caesar
//        case italian
//        case vinaigrette
//    }
//   
//    
//
//}
//

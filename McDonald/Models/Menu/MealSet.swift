////
////  MealSet.swift
////  McDonald
////
////  Created by Agata Przykaza on 01/10/2024.
////
//
//class MealSet: MenuItem {
//    var mainItem: MenuItem
//    var sideItem: MenuItem
//    var drink: MenuItem
//    
//    init(mainItem: MenuItem, sideItem: MenuItem, drink: MenuItem,itemNumber: String) {
//        self.mainItem = mainItem
//        self.sideItem = sideItem
//        self.drink = drink
//        
//        // Cena zestawu jest sumą cen poszczególnych produktów
//        let totalPrice = mainItem.price + sideItem.price + drink.price
//        super.init(name: "Zestaw \(mainItem.name)", itemNumber: itemNumber, price: 0.8*totalPrice, category: .set,ingredients: [mainItem.name,sideItem.name,drink.name])
//    }
//    enum MealSetCodingKeys: String, CodingKey {
//        case mainItem
//        case sideItem
//        case drink
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: MealSetCodingKeys.self)
//        self.mainItem = try container.decode(MenuItem.self, forKey: .mainItem)
//        self.sideItem = try container.decode(MenuItem.self, forKey: .sideItem)
//        self.drink = try container.decode(MenuItem.self, forKey: .drink)
//        try super.init(from: decoder)
//    }
//    
//    override func encode(to encoder: any Encoder) throws {
//        try super.encode(to: encoder)
//        var container = encoder.container(keyedBy: MealSetCodingKeys.self)
//        try container.encode(mainItem, forKey: .mainItem)
//        try container.encodeIfPresent(sideItem, forKey: .sideItem)
//        try container.encodeIfPresent(drink, forKey: .drink)
//    }
//}

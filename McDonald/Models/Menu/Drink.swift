////
////  Drink.swift
////  McDonald
////
////  Created by Agata Przykaza on 01/10/2024.
////
//
//class Drink: MenuItem {
//    var isIced: Bool
//    
//    init(name: String, price: Double,itemNumber:String,  ingredients: [String],isIced: Bool,category: Category) {
//        self.isIced = isIced
//        super.init(name: name, itemNumber: itemNumber, price: price, category: category, ingredients: ingredients)
//    }
//    enum DrinkCodingKeys: String, CodingKey {
//        case isIced
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: DrinkCodingKeys.self)
//        self.isIced = try container.decode(Bool.self, forKey: .isIced)
//        try super.init(from: decoder)
//    }
//    
//    override func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: DrinkCodingKeys.self)
//        try container.encode(isIced, forKey: .isIced)
//        try super.encode(to: encoder)
//    }
//    
//}
//
//
//class Coffee: Drink {
//    var milk : Milk
//    var sugar: Bool
//    
//    init(name: String, price: Double,itemNumber:String, isIced: Bool, ingredients: [String],milk: Milk, sugar: Bool) {
//        self.milk = milk
//        self.sugar = sugar
//        super.init(name: name, price: price, itemNumber: itemNumber, ingredients: ingredients, isIced: isIced, category: .coffee)
//    }
//    
//    enum CoffeeCodingKeys: String, CodingKey {
//        case milk
//        case sugar
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CoffeeCodingKeys.self)
//        self.milk = try container.decode(Milk.self, forKey: .milk)
//        self.sugar = try container.decode(Bool.self, forKey: .sugar)
//        try super.init(from: decoder)
//    }
//    
//    override func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CoffeeCodingKeys.self)
//        try container.encode(milk, forKey: .milk)
//        try container.encode(sugar, forKey: .sugar)
//        try super.encode(to: encoder)
//    }
//    
//    enum Milk: String, Codable{
//        case none
//        case cowMilk
//        case oatMilk
//    }
//
//}
//
//

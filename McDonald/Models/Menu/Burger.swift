//
//  BurgerModel.swift
//  McDonald
//
//  Created by Agata Przykaza on 01/10/2024.
//

class Burger: MenuItem {
    
    var sauce: Sauce
    var meat: Meat
    var bun: Bun
        
    init(name: String, price: Double, itemNumber: Int,ingredients: [String], sauce: Sauce, meat: Meat, bun: Bun) {
            self.sauce = sauce
            self.meat = meat
            self.bun = bun
        super.init(name: name, itemNumber: itemNumber, price: price, category: .burger, ingredients: ingredients)
        }
    
    enum BurgerCodingKeys: String, CodingKey {
        case sauce
        case meat
        case bun
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BurgerCodingKeys.self)
        self.sauce = try container.decode(Sauce.self, forKey: .sauce)
        self.meat = try container.decode(Meat.self, forKey: .meat)
        self.bun = try container.decode(Bun.self, forKey: .bun)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: BurgerCodingKeys.self)
        try container.encode(sauce, forKey: .sauce)
        try container.encode(meat, forKey: .meat)
        try container.encode(bun, forKey: .bun)
    }
    enum Sauce: String,Codable{
        case mayo = "Mayo"
        case mustard = "Mustard"
        case ketchup = "Ketchup"
        case bbq = "BBQ"
    }

    enum Meat: String,Codable {
        case beef = "Beef"
        case chicken = "Chicken"
        case veggie = "Veggie"
    }
    enum Bun: String,Codable {
        case sesame
        case wholeGrain
        case glutenFree
    }

 
}


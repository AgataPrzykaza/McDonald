//
//  Wrap.swift
//  McDonald
//
//  Created by Agata Przykaza on 01/10/2024.
//

class Wrap: MenuItem {
    var tortilla: Tortilla
    var filling: Filling
    var sauce: Sauce?
    
    init(name: String, price: Double,itemNumber: Int, ingredients: [String], tortilla: Tortilla, filling: Filling, sauce: Sauce?) {
        self.tortilla = tortilla
        self.filling = filling
        self.sauce = sauce
        super.init(name: name, itemNumber: itemNumber, price: price, category: .wrap, ingredients: ingredients)
    }
    
    enum WrapCodingKeys: String, CodingKey {
        case tortilla
        case filling
        case sauce
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WrapCodingKeys.self)
        self.tortilla = try container.decode(Tortilla.self, forKey: .tortilla)
        self.filling = try container.decode(Filling.self, forKey: .filling)
        self.sauce = try container.decodeIfPresent(Sauce.self, forKey: .sauce)
        try super.init(from: decoder)
    }
    
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: WrapCodingKeys.self)
        try container.encode(tortilla, forKey: .tortilla)
        try container.encode(filling, forKey: .filling)
        try container.encodeIfPresent(sauce, forKey: .sauce)
    }
    enum Tortilla: String, Codable {
        case wheat
        case corn
        case glutenFree
    }
    
    enum Filling: String, Codable {
        case chicken
        case beef
        case veggie
    }
    
    enum Sauce: String, Codable {
        case ranch
        case spicy
        case none
    }
    
   
}

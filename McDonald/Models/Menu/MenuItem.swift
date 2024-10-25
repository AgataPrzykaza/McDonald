//
//  MenuItem.swift
//  McDonald
//
//  Created by Agata Przykaza on 01/10/2024.
//

import FirebaseFirestore

class MenuItem: Codable, Identifiable{
   
    var ItemNumber: Int
    var name: String
    var price: Double
    var ingredients: [String]?
    var category: Category
    
    enum Category: String, Codable {
        case burger
        case drink
        case coffee
        case wrap
        case salad
        case chicken
        case fries
        case set
    }
    
    init(name: String,itemNumber: Int, price: Double, category: Category,ingredients: [String]) {
        self.ItemNumber = itemNumber
        self.name = name
        self.price = price
        self.ingredients = ingredients
        self.category = category
    }
    
    init(name: String,itemNumer: Int, price: Double, category: Category){
        self.ItemNumber = itemNumer
        self.name = name
        self.price = price
        self.category = category
    }
    
    enum CodingKeys: String, CodingKey {
        case id,name, price, ingredients, category, itemNumber
    }
  
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ItemNumber = try container.decode(Int.self, forKey: .itemNumber)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.ingredients = try container.decode([String].self, forKey: .ingredients)
        self.category = try container.decode(Category.self, forKey: .category)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(ItemNumber, forKey: .itemNumber)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(category, forKey: .category)
    }
}


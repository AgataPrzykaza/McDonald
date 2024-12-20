//
//  MenuItem.swift
//  McDonald
//
//  Created by Agata Przykaza on 01/10/2024.
//

import FirebaseFirestore

class MenuItem: Codable, Identifiable{
   
    var menuID: String
    var name: String
    var price: Double
    var ingredients: [String]?
    var category: Category
    var sauce: [String]?
    
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
    
    init(name: String,itemNumber: String, price: Double, category: Category,ingredients: [String], sauce: [String]? = nil) {
        self.menuID = itemNumber
        self.name = name
        self.price = price
        self.ingredients = ingredients
        self.category = category
        self.sauce = sauce
    }
    
    init(name: String,itemNumer: String, price: Double, category: Category){
        self.menuID = itemNumer
        self.name = name
        self.price = price
        self.category = category
    }
    
    
    enum CodingKeys: String, CodingKey {
           case menuID = "menuID"
           case name = "name"
           case price = "price"
           case ingredients = "ingredients"
           case category = "category"
           case sauce = "sauce"
       }
  
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.menuID = try container.decode(String.self, forKey: .menuID)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.ingredients = try container.decodeIfPresent([String].self, forKey: .ingredients) ?? []
        self.category = try container.decode(Category.self, forKey: .category)
        self.sauce = try container.decodeIfPresent([String].self, forKey: .sauce) 
    }

    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(menuID, forKey: .menuID)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(category, forKey: .category)
        try container.encodeIfPresent(sauce, forKey: .sauce)
    }
}


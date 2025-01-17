//
//  MenuItem.swift
//  McDonald
//
//  Created by Agata Przykaza on 01/10/2024.
//

import FirebaseFirestore

class MenuItem: Codable, Identifiable, Hashable{
   
    var menuID: String
    var name: String
    var price: Double
    var ingredients: [String]?
    var category: Category
    var sauce: [String]?
    var imagePath: String?
    var size: Size?
   
 
    
    enum Category: String, Codable {
        case burgers
        case drink
        case coffee
        case wrap
        case salad
        case chicken
        case fries
        case set
        case sides
        case desserts
        case coupons
    }
    enum Size: String, Codable {
           case small
           case medium
           case large
       }
    
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
            lhs.menuID == rhs.menuID
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(menuID)
        }
    
    init(itemNumber: String,name: String, price: Double, category: Category,ingredients: [String], sauce: [String]? = nil, imagePath: String? = nil,size: Size? = nil) {
        self.menuID = itemNumber
        self.name = name
        self.price = price
        self.ingredients = ingredients
        self.category = category
        self.sauce = sauce
        self.imagePath = imagePath
        self.size = size
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
            case imagePath = "imagePath"
            case size = "size"
       
       }
  
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.menuID = try container.decode(String.self, forKey: .menuID)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.ingredients = try container.decodeIfPresent([String].self, forKey: .ingredients) ?? []
        self.category = try container.decode(Category.self, forKey: .category)
        self.sauce = try container.decodeIfPresent([String].self, forKey: .sauce)
        self.imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath)
        self.size = try container.decodeIfPresent(Size.self, forKey: .size)
        
    }

    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(menuID, forKey: .menuID)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(category, forKey: .category)
        try container.encodeIfPresent(sauce, forKey: .sauce)
        try container.encodeIfPresent(imagePath, forKey: .imagePath)
        try container.encodeIfPresent(size, forKey: .size)
      
        
    }
}


 

let menuItems: [MenuItem] = [
    MenuItem(
        itemNumber: "005-S",
        name: "Coca-Cola",
        price: 5.99,
        category: .drink,
        ingredients: [],
        imagePath: "https://example.com/images/coca-cola-small.jpg",
        size: .small
    ),
    MenuItem(
        itemNumber: "005-M",
        name: "Coca-Cola",
        price: 6.99,
        category: .drink,
        ingredients: [],
        imagePath: "https://example.com/images/coca-cola-medium.jpg",
        size: .medium
    ),
    MenuItem(
        itemNumber: "005-L",
        name: "Coca-Cola",
        price: 7.99,
        category: .drink,
        ingredients: [],
        imagePath: "https://example.com/images/coca-cola-large.jpg",
        size: .large
    ),
    MenuItem(
        itemNumber: "003-S",
        name: "Frytki",
        price: 4.99,
        category: .fries,
        ingredients: ["Ziemniaki", "Sól"],
        imagePath: "https://example.com/images/fries-small.jpg",
        size: .small
    ),
    MenuItem(
        itemNumber: "003-M",
        name: "Frytki",
        price: 6.99,
        category: .fries,
        ingredients: ["Ziemniaki", "Sól"],
        imagePath: "https://example.com/images/fries-medium.jpg",
        size: .medium
    ),
    MenuItem(
        itemNumber: "003-L",
        name: "Frytki",
        price: 8.99,
        category: .fries,
        ingredients: ["Ziemniaki", "Sól"],
        imagePath: "https://example.com/images/fries-large.jpg",
        size: .large
    )
]

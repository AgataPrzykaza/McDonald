//
//  Chicken.swift
//  McDonald
//
//  Created by Agata Przykaza on 02/10/2024.
//

class Chicken: MenuItem{
    
    var sauces: [Sauce] = []
    var numberOfSauce : Int
    
    enum Sauce: String,Codable{
        case sweetSour = "Sweet Sour"
        case garlic = "Garlic"
        case spicy = "Spicy"
        
    }
    
    init(name: String, price: Double,itemNumber: Int, sauces: [Sauce], numOfSauce: Int) {
        self.sauces = sauces
        self.numberOfSauce = numOfSauce
        super.init(name: name, itemNumber: itemNumber, price: price, category: .chicken,ingredients: ["chicken"])
    }
    
    enum SauceCodingKeys: String, CodingKey {
        case sauces
        case numberOfSauce
    }
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: SauceCodingKeys.self)
        self.sauces = try container.decode([Sauce].self, forKey: .sauces)
        self.numberOfSauce = try container.decode(Int.self, forKey: .numberOfSauce)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: any Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: SauceCodingKeys.self)
        try container.encode(sauces, forKey: .sauces)
        try container.encode(numberOfSauce, forKey: .numberOfSauce)
    }
    
}

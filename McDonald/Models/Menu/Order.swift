//
//  Order.swift
//  McDonald
//
//  Created by Agata Przykaza on 03/10/2024.
//

import FirebaseFirestore

class Order: Codable {
    
    var id: Int
    var oderNumber: Int
    var order: [MenuItem] = []
    var customerID: String
    
    init(id: Int, oderNumber: Int, order: [MenuItem], customerID: String) {
        self.id = id
        self.oderNumber = oderNumber
        self.order = order
        self.customerID = customerID
    }
    
    func add(_ item: MenuItem) {
        order.append(item)
    }
    
    func remove(_ item: MenuItem) {
        order.removeAll(where: { $0.id == item.id })
    }
    
    func change(_ item: MenuItem, to newItem: MenuItem) {
        order.removeAll(where: { $0.id == item.id })
        order.append(newItem)
    }
    
    enum OderCodingKeys: String, CodingKey {
        case id
        case oderNumber
        case order
        case customerID
    }
    
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: OderCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.oderNumber = try container.decode(Int.self, forKey: .oderNumber)
        self.order = try container.decode([MenuItem].self, forKey: .order)
        self.customerID = try container.decode(String.self, forKey: .customerID)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: OderCodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(oderNumber, forKey: .oderNumber)
        try container.encode(order, forKey: .order)
        try container.encode(customerID, forKey: .customerID)
    }
    
}

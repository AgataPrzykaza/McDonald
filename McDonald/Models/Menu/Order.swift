//
//  Order.swift
//  McDonald
//
//  Created by Agata Przykaza on 03/10/2024.
//

import FirebaseFirestore
import Foundation
enum OrderType: String, Codable {
    case takeAway
    case delivery
    case onPlace
}

@Observable
class Order: Codable {
    
    var id: String
    var orderNumber: Int
    var items: [MenuItem ] = []
    var customerID: String
    var restaurantID: String
    var orderType: OrderType
    var sum: Double = 0
    
    init() {
        id = ""
        orderNumber = 0
        orderType = .onPlace
        items = []
        customerID = ""
        restaurantID = ""
        sum = 0
        
    }
    
    init(id: String, oderNumber: Int, order: [MenuItem], customerID: String,restaurantID: String, orderType: OrderType,sum: Double) {
        self.id = id
        self.orderNumber = oderNumber
        self.items = order
        self.customerID = customerID
        self.restaurantID = restaurantID
        self.orderType = orderType
        self.sum = sum
    }
    
    func add(_ item: MenuItem) {
        
        items.append(item)

           sum += item.price
       }
    
    func addPrize( item: MenuItem){
        items.append(item)
    }
    
    func addCoupon(item: MenuItem){
        items.append(item)

        sum += item.price
    }
    
    func remove(_ item: MenuItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
            sum -= item.price
        }
    }
    
    func change(_ item: MenuItem, to newItem: MenuItem) {
        items.removeAll(where: { $0.id == item.id })
        items.append(newItem)
    }
    
    enum OderCodingKeys: String, CodingKey {
        case id
        case oderNumber
        case order
        case customerID
        case restaurantID
        case orderType
        case sum
    }
    
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: OderCodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.orderNumber = try container.decode(Int.self, forKey: .oderNumber)
        self.items = try container.decode([MenuItem ].self, forKey: .order)
        self.customerID = try container.decode(String.self, forKey: .customerID)
        self.restaurantID = try container.decode(String.self, forKey: .restaurantID)
        self.orderType = try container.decode(OrderType.self, forKey: .orderType)
        self.sum = try container.decode(Double.self, forKey: .sum)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: OderCodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(orderNumber, forKey: .oderNumber)
        try container.encode(items, forKey: .order)
        try container.encode(customerID, forKey: .customerID)
        try container.encode(restaurantID, forKey: .restaurantID)
        try container.encode(orderType, forKey: .orderType)
        try container.encode(sum, forKey: .sum)
    }
    
}

//
//  OrderManager.swift
//  McDonald
//
//  Created by Agata Przykaza on 20/01/2025.
//

import Foundation
import FirebaseFirestore

struct RestaurantOrders: Codable {
    var restaurantID: String
    var date: Date
    var ordersByDate: [DailyOrder]

   
}

struct DailyOrder: Codable{
   
    
    var restaurantOrderNumber: Int
    var orderID: String
}

struct RestaurantOrder:  Codable {
    
    var restaurantID: String
    var date: Date
    var restaurantOrderNumber: Int
    var orderID: String
  

    enum CodingKeys: String, CodingKey {
       
        case restaurantID
        case date
        case restaurantOrderNumber
        case orderID
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.restaurantID = try container.decode(String.self, forKey: .restaurantID)
        self.date = try container.decode(Date.self, forKey: .date)
        self.restaurantOrderNumber = try container.decode(Int.self, forKey: .restaurantOrderNumber)
        self.orderID = try container.decode(String.self, forKey: .orderID)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(restaurantID, forKey: .restaurantID)
        try container.encode(date, forKey: .date)
        try container.encode(restaurantOrderNumber, forKey: .restaurantOrderNumber)
        try container.encode(orderID, forKey: .orderID)
    }
    
}


final class OrderManager{
    static let shared = OrderManager()
    
    private init() {}
    
    private let db = Firestore.firestore()
    private let orderCollection = Firestore.firestore().collection("orders")
    private let restaurantOrdersCollection = Firestore.firestore().collection("restaurantOrders")
    
    func makeOrder(_ order: Order) async throws {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: Date())
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: startOfDay)
            let restaurantDocID = "\(order.restaurantID)_\(dateString)"
            
            let restaurantDocRef = restaurantOrdersCollection.document(restaurantDocID)
            
            try await db.runTransaction({ (transaction, errorPointer) -> Any? in
                var currentOrders: [DailyOrder] = []
                var nextOrderNumber = 1

                // Próba pobrania istniejącego dokumentu
                if let restaurantSnapshot = try? transaction.getDocument(restaurantDocRef),
                   let restaurantData = restaurantSnapshot.data(),
                   let ordersByDateData = restaurantData["ordersByDate"] as? [[String: Any]] {

                    let decoder = Firestore.Decoder()
                    currentOrders = ordersByDateData.compactMap { dict in
                        return try? decoder.decode(DailyOrder.self, from: dict)
                    }

                    if let lastOrder = currentOrders.last {
                        nextOrderNumber = lastOrder.restaurantOrderNumber + 1
                    }
                }

                let newDailyOrder = DailyOrder(restaurantOrderNumber: nextOrderNumber, orderID: order.id)
                currentOrders.append(newDailyOrder)

                let restaurantOrders = RestaurantOrders(
                    restaurantID: order.restaurantID,
                    date: startOfDay,
                    ordersByDate: currentOrders
                )

                do {
                    try transaction.setData(from: restaurantOrders, forDocument: restaurantDocRef)
                    order.orderNumber = nextOrderNumber
                    let newOrderRef = self.orderCollection.document()
                    try transaction.setData(from: order, forDocument: newOrderRef)
                } catch let setDataError as NSError {
                    errorPointer?.pointee = setDataError
                    return nil
                }

                return nil
            })
        }
    
   
       
    
    
      
    
}

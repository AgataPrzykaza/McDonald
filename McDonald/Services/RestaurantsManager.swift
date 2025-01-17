//
//  RestaurantsManager.swift
//  McDonald
//
//  Created by Agata Przykaza on 08/01/2025.
//

import Foundation
import FirebaseFirestore



final class RestaurantsManager {
    static let shared = RestaurantsManager()
    
    private init() {}
    let db = Firestore.firestore()
   
    
//    func saveRestaurants() async {
//       
//        
//        for restaurant in mockRestaurants {
//            do {
//             
//                let docRef = db.collection("restaurants").document()
//                
//       
//                var restaurantWithID = restaurant
//                restaurantWithID.id = docRef.documentID
//                
//               
//                try docRef.setData(from: restaurantWithID)
//                
//                print("Saved restaurant with ID: \(docRef.documentID)")
//            } catch let error {
//                print("Error writing restaurant to Firestore: \(error)")
//            }
//        }
//    }
    
    func getRestaurants() async  throws -> [RestaurantLocation]{
        
       
            let snapshot = try await db.collection("restaurants").getDocuments()
            
            let items = snapshot.documents.compactMap { document in
                try? document.data(as: RestaurantLocation.self)
            }
            
            return items
        
    }
}

//
//  FirestoreService.swift
//  McDonald
//
//  Created by Agata Przykaza on 03/10/2024.
//

import FirebaseFirestore
import FirebaseStorage

class FirestoreService {
    
    let db = Firestore.firestore()
    
    
    func fetchPromoDetailsFromFirestore(for promoID: String) async -> PromoDetails? {
        
        do{
            let document = try await db.collection("promoDetails").document(promoID).getDocument()
            return try document.data(as: PromoDetails.self)
        }
        catch{
            print("Error getting promo details: \(error)")
        }
        
        return nil
    }
    
    
    func fetchCollection<T: Decodable>(
        from collectionName: String,
        as type: T.Type,
        filter: ((Query) -> Query)? = nil
    ) async -> [T] {
        var results: [T] = []
        
        do {
            var query: Query = db.collection(collectionName)
            if let filter = filter {
                query = filter(query)
            }
            
            let querySnapshot = try await query.getDocuments()
            
            for document in querySnapshot.documents {
                if let object = try? document.data(as: T.self) {
                    results.append(object)
                } else {
                    print("Nie udało się zdekodować dokumentu: \(document.documentID)")
                }
            }
        } catch {
            print("Błąd podczas pobierania danych z kolekcji \(collectionName): \(error)")
        }
        
        return results
    }

    
   
    
    
    func fetchMainPromo() async -> Promo? {
        do {
           
            
            let querySnapshot = try await db.collection("currentPromotions")
                .whereField("type", isEqualTo: "mainPromo")
                .getDocuments()
            
           
            guard let document = querySnapshot.documents.first else {
                print("No document found with type == mainPromo")
                return nil
            }
             
      
            guard let promoId = document.data()["promoID"] as? String else {
                print("Field 'promoId' not found in mainPromo document")
                return nil
            }
            
            
          
            let promoDocument = try await db.collection("mainHeaders").document(promoId).getDocument()
            
           
            if let promo = try? promoDocument.data(as: Promo.self) {
               
                return promo
            } else {
                print("Failed to decode promo document.")
                return nil
            }
            
        } catch {
            print("Error fetching mainPromo: \(error)")
            return nil
        }
    }

    
    func fetchMainPromosFromFirestore() async -> [Promo] {
        var promos: [Promo] = []
        
        do {
          let querySnapshot = try await db.collection("mainHeaders").getDocuments()
          for document in querySnapshot.documents {
            
              if let promoData = try? document.data(as: Promo.self) {
                  
                 
                  promos.append(promoData)
              }
          }
        } catch {
          print("Error getting promos: \(error)")
        }
        
        return promos
        
        
    }
    
    func fetchImageURL(for imagePath: String) async throws -> URL {
        let storageRef = Storage.storage().reference(withPath: imagePath)
        let downloadURL = try await storageRef.downloadURL()
        return downloadURL
    }
    

    
    func fetchImagesFromFirebaseStorage() async -> [URL] {
        var imageURLs: [URL] = []
        
        let storage = Storage.storage()
        let storageRef = storage.reference().child("promo")
        
        do {
           
            let result = try await storageRef.listAll()
            
            for item in result.items {
                do {
                   
                    let url = try await item.downloadURL()
                    imageURLs.append(url)
                } catch {
                    print("Błąd podczas pobierania URL: \(error)")
                }
            }
        } catch {
            print("Błąd podczas listowania plików: \(error)")
        }
        
        return imageURLs
    }
    
    
   
//        func fetchMenu() async throws -> [MenuItem] {
//               
//                let snapshot = try await db.collection("menu").getDocuments()
//                
//                var menuItems: [MenuItem] = []
//                
//                
//                for document in snapshot.documents {
//                    let data = document.data()
//                    
//                    if let categoryString = data["category"] as? String,
//                       let category = MenuItem.Category(rawValue: categoryString) {
//                        
//                        switch category {
//                        case .burger:
//                            if let burgerData = try? document.data(as: Burger.self) {
//                                menuItems.append(burgerData)
//                            }
//                        case .drink:
//                            if let drinkData = try? document.data(as: Drink.self) {
//                                menuItems.append(drinkData)
//                            }
//                        case .wrap:
//                            if let wrapData = try? document.data(as: Wrap.self) {
//                                menuItems.append(wrapData)
//                            }
//                        case .fries:
//                            if let friesData = try? document.data(as: Fries.self) {
//                                menuItems.append(friesData)
//                            }
//                        case .set:
//                            if let setData = try? document.data(as: MealSet.self) {
//                                menuItems.append(setData)
//                            }
//                        case .salad:
//                            if let saladData = try? document.data(as: Salad.self){
//                                menuItems.append(saladData)
//                            }
//                        case .chicken:
//                            if let chickenData = try? document.data(as: Chicken.self){
//                                menuItems.append(chickenData)
//                            }
//                        case .coffee:
//                            if let coffeeData = try? document.data(as: Coffee.self){
//                                menuItems.append(coffeeData)
//                            }
//                            
//                        }
//                    }
//                }
//                
//                return menuItems
//            }
    
    
    func saveMenuItem(_ item: MenuItem) async throws {
            do {
               
                let _ = try  db.collection("menu").addDocument(from: item)
                print("Successfully saved menu item")
            } catch {
                throw error
            }
        }
    
    
    
    func saveOrder(){
        
    }
    
    func fetchUserData(){
        
    }
    
    func saveUserData(){
        
    }
    
   
    
    
}

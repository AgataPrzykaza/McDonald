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
            // Pobierz wszystkie pliki w folderze "promo"
            let result = try await storageRef.listAll()
            
            for item in result.items {
                do {
                    // Pobierz URL każdego pliku
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
    
    
    func fetchUser(mail: String) async throws -> User?{
        
        var user: User?
        do {
            let querySnapshot = try await db.collection("users")
                .whereField("email", isEqualTo: mail)
                .getDocuments()
            
           
           if let document = querySnapshot.documents.first
            {
               if let u = try? document.data(as: User.self){
                   user = u
                   print("User found: \(String(describing: user))")
               }
           }
            
        } catch {
            print("Error getting documents: \(error)")
        }

        return user
        
        
    }
        func fetchMenu() async throws -> [MenuItem] {
               
                let snapshot = try await db.collection("menu").getDocuments()
                
                var menuItems: [MenuItem] = []
                
                
                for document in snapshot.documents {
                    let data = document.data()
                    
                    if let categoryString = data["category"] as? String,
                       let category = MenuItem.Category(rawValue: categoryString) {
                        
                        switch category {
                        case .burger:
                            if let burgerData = try? document.data(as: Burger.self) {
                                menuItems.append(burgerData)
                            }
                        case .drink:
                            if let drinkData = try? document.data(as: Drink.self) {
                                menuItems.append(drinkData)
                            }
                        case .wrap:
                            if let wrapData = try? document.data(as: Wrap.self) {
                                menuItems.append(wrapData)
                            }
                        case .fries:
                            if let friesData = try? document.data(as: Fries.self) {
                                menuItems.append(friesData)
                            }
                        case .set:
                            if let setData = try? document.data(as: MealSet.self) {
                                menuItems.append(setData)
                            }
                        case .salad:
                            if let saladData = try? document.data(as: Salad.self){
                                menuItems.append(saladData)
                            }
                        case .chicken:
                            if let chickenData = try? document.data(as: Chicken.self){
                                menuItems.append(chickenData)
                            }
                        case .coffee:
                            if let coffeeData = try? document.data(as: Coffee.self){
                                menuItems.append(coffeeData)
                            }
                            
                        }
                    }
                }
                
                return menuItems
            }
    
    
    func saveMenuItem(_ item: MenuItem) async throws {
            do {
               
                let _ = try await db.collection("menu").addDocument(from: item)
                print("Successfully saved menu item")
            } catch {
                throw error
            }
        }
    
    func saveUser(_ user: User) async throws{
        do{
            let _ = try await db.collection("users").addDocument(from: user)
            print("Successfully saved user")
        }
        catch{
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

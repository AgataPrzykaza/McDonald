//
//  MenuManager.swift
//  McDonald
//
//  Created by Agata Przykaza on 19/12/2024.
//

import Foundation

import FirebaseFirestore


final class MenuManager{
    
    static let shared = MenuManager()
    
    private init() {}
    
    private let menuCollection = Firestore.firestore().collection("menu")
    
  
    func fetchMenu() async throws-> [MenuItem]? {
      
        let snapshot = try await menuCollection.getDocuments()
            
            
            let menuItems = snapshot.documents.compactMap { document in
                try? document.data(as: MenuItem.self)
            }
            
            return menuItems
       
    }
    
    


    
}

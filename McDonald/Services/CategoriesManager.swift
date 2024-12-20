//
//  CategoriesManager.swift
//  McDonald
//
//  Created by Agata Przykaza on 20/12/2024.
//
import Foundation
import FirebaseFirestore

struct Category: Codable, Hashable{
    let name: String
    let imagePath: String
}

final class CategoriesManager{
    static let shared = CategoriesManager()
    
    private init() {}
    
    private let categoriesCollection = Firestore.firestore().collection("categories")
    
    func getCategories() async throws -> [Category] {
        let snapshot = try await categoriesCollection.getDocuments()
            
            
            let categoryItems = snapshot.documents.compactMap { document in
                try? document.data(as: Category.self)
            }
            
            return categoryItems
    }
    
    
}

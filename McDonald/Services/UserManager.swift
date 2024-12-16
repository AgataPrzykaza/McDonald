//
//  UserManager.swift
//  McDonald
//
//  Created by Agata Przykaza on 11/12/2024.
//

import Foundation
import FirebaseFirestore



final class UserManager {
    
    static let shared = UserManager()
    
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
  
    
    func createNewUser(user: UserDB) async throws{
        try  userDocument(userId: user.userId).setData(from: user,merge: false)
    }
    
   
    
    func getUser(userId: String) async throws -> UserDB{
        try await userDocument(userId: userId).getDocument(as: UserDB.self)
    }
    
    
   
    
}

//
//  AuthManager.swift
//  McDonald
//
//  Created by Agata Przykaza on 05/12/2024.
//


import Foundation
import FirebaseAuth


struct AuthResultModel{
    let uid: String
    let email: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
    }
}

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    @discardableResult
    func createUser(with email: String, password: String) async throws -> AuthResultModel{
        
       let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthResultModel(user: authDataResult.user)
    }
    
    func getAuthenticatedUser()  throws -> AuthResultModel{
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthResultModel(user: user)
    }
    
    func signInUser(email: String, password: String) async throws -> AuthResultModel{
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthResultModel(user: authDataResult.user)
    }
   
    
    func signOut() throws {
      try Auth.auth().signOut()
    }
}

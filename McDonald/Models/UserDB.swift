//
//  UserDB.swift
//  McDonald
//
//  Created by Agata Przykaza on 16/12/2024.
//


import Foundation
import FirebaseFirestore




struct UserDB: Codable{
    let userId: String
    let name: String?
    let email: String?
    let dateCreated: Date?
   
    
    init(auth: AuthResultModel, name: String){
        self.userId = auth.uid
        self.name = name
        self.email = auth.email
        self.dateCreated = Date()
        
        
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name = "name"
        case email = "email"
        case dateCreated = "date_created"
    }
    
    init(userId: String, name: String?, email: String?, dateCreated: Date?){
        self.userId = userId
        self.name = name
        self.email = email
        self.dateCreated = dateCreated
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(dateCreated, forKey: .dateCreated)
    }
    
    func decode(from decoder: any Decoder) throws -> UserDB {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userId = try container.decode(String.self, forKey: .userId)
        let name = try container.decodeIfPresent(String.self, forKey: .name)
        let email = try container.decodeIfPresent(String.self, forKey: .email)
        let dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        return UserDB(userId: userId, name: name, email: email, dateCreated: dateCreated)
    }
    
  
}

//
//  User.swift
//  McDonald
//
//  Created by Agata Przykaza on 03/10/2024.
//

import FirebaseFirestore

class User: Codable, Identifiable {
    
    var id: Int
    var name: String
    var points: Int
    var cupons: [String]
    var email: String
    
    init( id: Int,name: String, points: Int, cupons: [String], email: String) {
        self.id = id
        self.name = name
        self.points = points
        self.cupons = cupons
        self.email = email
    }
    
    enum UserCodingKeys: String, CodingKey {
        case name, points, cupons, email , id
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.cupons = try container.decode([String].self, forKey: .cupons)
        self.email = try container.decode(String.self, forKey: .email)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(points, forKey: .points)
        try container.encode(cupons, forKey: .cupons)
        try container.encode(email, forKey: .email)
    }
}

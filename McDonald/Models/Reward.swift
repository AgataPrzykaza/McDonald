//
//  Reward.swift
//  McDonald
//
//  Created by Agata Przykaza on 17/12/2024.
//


import Foundation
import FirebaseFirestore

struct Reward: Codable{
    var prizeId: String
    var lastTaken: Date?
    
    func toDictionary() -> [String: Any] {
           var dictionary: [String: Any] = [
               "prize_Id": prizeId
           ]
           
           if let lastTaken = lastTaken {
               dictionary["last_taken"] = Timestamp(date: lastTaken)
           }
           
           return dictionary
       }
    
    init(prizeId: String, lastTaken: Date? = nil) {
        self.prizeId = prizeId
        self.lastTaken = lastTaken
    }
    
    enum CodingKeys: String, CodingKey {
        case prizeId = "prize_Id"
        case lastTaken = "last_taken"
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(prizeId, forKey: .prizeId)
        try container.encodeIfPresent(lastTaken, forKey: .lastTaken)
    }
    
     func decode(from decoder: any Decoder) throws -> Reward {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let prizeId = try container.decode(String.self, forKey: .prizeId)
        let lastTaken = try container.decodeIfPresent(Date.self, forKey: .lastTaken)
         return Reward(prizeId: prizeId, lastTaken: lastTaken)
    }
}

//
//  Points.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/11/2024.
//

import Foundation

struct HistoryRecord: Codable,Hashable {
    
    var gained: Bool
    var date: Date
    var points: Int
    
    init(gained: Bool, date: Date, points: Int) {
        self.gained = gained
        self.date = date
        self.points = points
    }
    
    enum CodingKeys: String, CodingKey {
        case gained
        case date
        case points
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gained, forKey: .gained)
        try container.encode(date, forKey: .date)
        try container.encode(points, forKey: .points)
    }
    
    func decode(from decoder: Decoder) throws -> HistoryRecord {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let gained = try container.decode(Bool.self, forKey: .gained)
        let date = try container.decode(Date.self, forKey: .date)
        let points = try container.decode(Int.self, forKey: .points)
        
        return HistoryRecord(gained: gained, date: date, points: points)
    }
}

struct Points: Codable, Hashable {
   
    var currentPoints: Int
    var history: [HistoryRecord]
   
    
    init(currentPoints: Int, history: [HistoryRecord]) {
      
        self.currentPoints = currentPoints
        self.history = history
    }
    
    enum CodingKeys: String, CodingKey {
        case currentPoints = "current_Points"
        case history = "history"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(currentPoints, forKey: .currentPoints)
        try container.encode(history, forKey: .history)
    }
    
    func decode(from decoder: Decoder) throws -> Points {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let currentPoints = try container.decode(Int.self, forKey: .currentPoints)
        let history = try container.decode([HistoryRecord].self, forKey: .history)
        
        return Points(currentPoints: currentPoints, history: history)
    }
   
}

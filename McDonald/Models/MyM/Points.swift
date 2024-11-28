//
//  Points.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/11/2024.
//

import Foundation

struct HistoryRecord: Codable, Hashable {
    
    var gained: Bool
    var date: Date
    var points: Int
    
}

class Points: Codable, Identifiable, Hashable {
    var userId: String
    var currentPoints: Int
    var history: [HistoryRecord]
    
    static func == (lhs: Points, rhs: Points) -> Bool {
        return lhs.userId == rhs.userId
    }
    
    init(userId: String, currentPoints: Int, history: [HistoryRecord]) {
        self.userId = userId
        self.currentPoints = currentPoints
        self.history = history
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(userId)
        
    }
}

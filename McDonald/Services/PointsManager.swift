//
//  PointsManger.swift
//  McDonald
//
//  Created by Agata Przykaza on 12/12/2024.
//
import Foundation
import FirebaseFirestore




final class PointsManager {
    
    static let shared = PointsManager()
    
    private init() {}
    
    private let pointsCollection = Firestore.firestore().collection("points")
    
    private func pointsDocument(for userId: String) -> DocumentReference {
        pointsCollection.document(userId)
    }
    
    func createNewPointsDocument(for userId: String) async throws {
       
        let points = Points( currentPoints: 0, history: [])
        try pointsDocument(for: userId).setData(from: points)
    }
    
    func getPoints(for userId: String) async throws -> Points {
        try await pointsDocument(for: userId).getDocument(as: Points.self)
    }
    
    func updatePoints(for userId: String, points: Int, historyRecord: HistoryRecord) async throws {
        try await pointsDocument(for: userId).updateData([
            "current_Points": historyRecord.gained ? FieldValue.increment(Int64(points)) : FieldValue.increment(-Int64(points)), 
            "history": FieldValue.arrayUnion([historyRecord.toDictionary()])
        ])
    }

    
}

extension HistoryRecord {
    func toDictionary() -> [String: Any] {
        return [
            "gained": gained,
            "date": Timestamp(date: date),
            "points": points
        ]
    }
}

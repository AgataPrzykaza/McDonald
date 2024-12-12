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
       
    }
}

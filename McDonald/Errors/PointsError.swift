//
//  PointsError.swift
//  McDonald
//
//  Created by Agata Przykaza on 16/12/2024.
//


import SwiftUI
import FirebaseFirestore

enum PointsError: LocalizedError{
    case invalidPoints
    case notEnoughPoints
    case networkError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidPoints: 
            return "Niewłaściwe liczba punktów"
        case .notEnoughPoints: 
            return "Brak wystajczającej liczby punktów"
        case .networkError: 
            return "Problem z połączeniem"
        case .unknown:
                    return "Wystąpił nieznany błąd."
        }
    }
}
//
//  LoginError.swift
//  McDonald
//
//  Created by Agata Przykaza on 10/12/2024.
//
import Foundation

enum AutheticationError: LocalizedError {
    case invalidEmail
    case invalidPassword
    case networkError
    case unknownError
    case noSuchUser
    case wrongPassword
    case userMismatch
    case emailInUse
    case weakPassword

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Nieprawidłowy adres e-mail."
        case .invalidPassword:
            return "Hasło musi mieć co najmniej 6 znaków."
        case .networkError:
            return "Brak połączenia z serwerem. Spróbuj ponownie później."
        case .unknownError:
            return "Wystąpił nieznany błąd. Spróbuj ponownie."
        case .noSuchUser:
            return "Nie ma takiego użytkownika."
        case .wrongPassword:
            return "Niewłaściowe hasło."
        case .userMismatch:
            return "Niepoprawne dane uwierzytelniające. Spróbuj ponownie."
        case .emailInUse:
            return "Adres e-mail jest już zajęty."
        case .weakPassword:
            return "Hasło jest zbyt słabe."

        }
    }
}

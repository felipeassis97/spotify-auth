//
//  AuthenticationError.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 20/02/24.
//

import Foundation
import FirebaseAuth

enum AuthenticationError: Error {
    case emailAlreadyInUse
    case userNotFound
    case tooManyRequests
    case invalidCredential
    case invalidUserToken
    case networkRequestError
    case unknownError(error: String)
    
    
    static func handleFirebaseError(error: Error) -> AuthenticationError {
        if let error = error as NSError? {
            let code =  AuthErrorCode.Code(rawValue: error.code)
            switch code {
            case .invalidEmail, .wrongPassword, .weakPassword, .invalidCredential:
                return .invalidCredential
                
            case .userNotFound, .userDisabled, .operationNotAllowed:
                return .userNotFound
                
            case .invalidUserToken, .userTokenExpired, .sessionExpired:
                return .invalidUserToken
                
            case .emailAlreadyInUse:
                return .emailAlreadyInUse
                
            case .tooManyRequests:
                return .tooManyRequests
                
            case .networkError:
                return .networkRequestError
                
            default:
                return .unknownError(error: error.localizedDescription)
            }
        }
        return .unknownError(error: error.localizedDescription)
    }
}


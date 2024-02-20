//
//  FirebaseAutentication.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 20/02/24.
//

import Foundation
import FirebaseAuth


struct FirebaseAuthentication: IAuthentication {
    let auth = Auth.auth()
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws -> Result<Bool, AuthenticationError> {
        do {
            try await auth.createUser(withEmail: email, password: password)
            return .success(true)
        }
        catch {
            return .failure(.handleFirebaseError(error: error))
        }
    }
    
    func signin(withEmail email: String, password: String) async throws -> Result<Bool, AuthenticationError> {
        do {
            try await auth.createUser(withEmail: email, password: password)
            return .success(true)
        }
        catch {
            return .failure(.handleFirebaseError(error: error))
        }
    }
    
    func deleteCurrentUser() async throws -> Result<Bool, AuthenticationError> {
        do {
            try await auth.currentUser?.delete()
            return .success(true)
        }
        catch {
            return .failure(.handleFirebaseError(error: error))
        }
    }
}



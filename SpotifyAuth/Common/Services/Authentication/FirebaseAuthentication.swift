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
    
    func createUser(withEmail email: String, password: String) async throws -> Result<Bool, AuthenticationError> {
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
            try await auth.signIn(withEmail: email, password: password)
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
    
    func signout() throws -> Result<Bool, AuthenticationError> {
        do {
            try auth.signOut()
            return .success(true)
        }
        catch {
            return .failure(.handleFirebaseError(error: error))
        }
    }
    
    func getUserID() throws -> Result<String, AuthenticationError> {
        guard let uid = auth.currentUser?.uid else {
            return .failure(.userNotFound)
        }
        return .success(uid)
    }
    
    func currentUser() -> User?  {
        guard let firebaseUser = auth.currentUser else {
            return nil
        }
        
        let currentUser = User(id: firebaseUser.uid,                               
                               email: firebaseUser.email ?? "",
                               profileImagePath: nil,
                               fullName: firebaseUser.displayName ?? ""
                               )
        return currentUser
    }
}



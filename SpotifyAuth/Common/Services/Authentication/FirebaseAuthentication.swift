//
//  FirebaseAutentication.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 20/02/24.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift


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
    
    func authWithGoogle(rootViewController: UIViewController) async throws -> Result<User, AuthenticationError> {
        let clientID = "377095490944-28qruq3qtgrjqr1unalbg73f24ujtfop.apps.googleusercontent.com"
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else {
                print("ID Token missing")
                return .failure(.invalidUserToken)
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            let result = try await auth.signIn(with: credential)
            let userResponse =  User(id: result.user.uid, email: result.user.email ?? "", fullName: result.user.displayName)
            return .success(userResponse)
        } catch {
            print("ERROR authWithGoogle: \(error.localizedDescription)")
            return .failure(.unknownError(error: error.localizedDescription))
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



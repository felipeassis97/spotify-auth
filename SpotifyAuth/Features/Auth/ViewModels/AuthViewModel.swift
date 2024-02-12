//
//  SignupViewModel.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 12/02/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

@Observable 
class AuthViewModel {
    var userSession: FirebaseAuth.User?
    var currentUser: User?
    
    init() {
        
    }
    
    func signin(withEmail email: String, password: String) async throws {
        print("email: \(email)")
        print("password: \(password)")
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            guard let encodedUser = 
        } catch {}
        
    }
    
    func signout() {}
    
    func deleteAccount() {}
    
    
    func fetchUserData() async {}
    
    
}

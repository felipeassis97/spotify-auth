//
//  IAuthentication.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 20/02/24.
//

import Foundation

protocol IAuthentication {
    func createUser(withEmail email: String, password: String) async throws -> Result<Bool, AuthenticationError>
    func signin(withEmail email: String, password: String) async throws -> Result<Bool, AuthenticationError>
    func deleteCurrentUser() async throws -> Result<Bool, AuthenticationError>
    func signout() throws -> Result<Bool, AuthenticationError>
    func getUserID() throws -> Result<String, AuthenticationError>
    func currentUser() -> User?
}




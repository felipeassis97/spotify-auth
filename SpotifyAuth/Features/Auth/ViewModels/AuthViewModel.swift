//
//  SignupViewModel.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 12/02/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import PhotosUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift



protocol ValidateForm {
    var isValid: Bool { get }
}


@Observable class AuthViewModel {
    let authService: IAuthentication = FirebaseAuthentication()
    let databaseService: IDatabase = FirestoreDatabase()
    let storage = Storage.storage()
    var currentUser: User?
    
    init() {
        Task {
            try await fetchUserData()
        }
    }
    
    func googleAuth() async throws {
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootViewController = await window.rootViewController else {
            print("There is not root view controller")
            return
        }
        let response = try await authService.authWithGoogle(rootViewController: rootViewController)
        switch response {
        case .success(let user):
            let existsUserData = try await databaseService.checkIfExistsDoc(collectionID: "users", documentID: user.id)
            if !existsUserData {
                self.currentUser = user
                try await setUser()
            } else {
                try await fetchUserData()
            }
        case .failure(let error):
            print("ERROR: Failed to auth with Google \(error)")
        }
    }
    
    func signin(withEmail email: String, password: String) async throws {
        let response = try await authService.signin(withEmail: email, password: password)
        switch response {
        case .success:
            try  await fetchUserData()
        case .failure(let error):
            print("ERROR: Failed to sign in user \(error)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        let response = try await authService.createUser(withEmail: email, password: password)
        switch response {
        case .success:
            self.currentUser = authService.currentUser()
            self.currentUser?.fullName = fullName
            try await setUser()
        case .failure(let error):
            print("ERROR: Failed to create user \(error.localizedDescription)")
        }
    }
    
    func signout() async throws {
        let response = try authService.signout()
        switch response {
        case .success:
            self.currentUser = nil
        case .failure(let error):
            print("ERROR: Failed to sign out user \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async throws {
        let response = try await authService.deleteCurrentUser()
        switch response {
        case .success:
            try await Firestore.firestore().collection("users").document(self.currentUser?.id ?? "").delete()
            self.currentUser = nil
        case .failure(let error):
            print("ERROR: Failed to delete user \(error.localizedDescription)")
        }
    }
    
    func editProfileInfo(name: String) async throws {
        try await fetchUserData()
        if self.currentUser != nil {
            let response = try await databaseService.editData(collectionID: "users", documentID: currentUser?.id ?? "", data: ["fullName": name])
            switch response {
            case .success:
                try await fetchUserData()
            case .failure(let error):
                print("ERROR: Failed to edit profile Info \(error.localizedDescription)")
            }
        }
    }
    
    func saveImageToStorage(pickerImage: PhotosPickerItem) async throws {
        guard let uid = try fetchUserID() else {
            return
        }
        if let imageData = try await pickerImage.loadTransferable(type: Data.self) {
            let saved = try await databaseService.setImageData(collectionID: "users", documentID: uid, imageData: imageData)
            switch saved {
            case .success(_):
                try await fetchUserData()
            case.failure(let error):
                print("ERROR: Failed to save image to storage \(error.localizedDescription)")
                return
            }
        }
    }
    
    //MARK: Private functions
    private func fetchUserData() async throws {
        do {
            guard let uid = try fetchUserID() else {
                return
            }
            guard let user = try await fetchUser(userID: uid) else {
                return
            }
            self.currentUser = user
            if self.currentUser?.profileImagePath != nil {
                await retrieveProfileImage(uid: uid, imagePath: self.currentUser?.profileImagePath ?? "")
            }
        }
    }
    
    private func fetchUserID() throws -> String? {
        let uid = try authService.getUserID()
        switch uid {
        case .success(let uid):
            return uid
        case .failure(let error):
            print("ERROR: Failed to fetch user id \(error.localizedDescription)")
            return nil
        }
    }
    
    private func fetchUser(userID: String) async throws -> User? {
        let user = try await databaseService.getByID(collectionID: "users", documentID: userID, collection: User.self)
        switch user {
        case .success(let response):
            return response
        case .failure(let error):
            print("ERROR: Failed to fetch user data \(error.localizedDescription)")
            return nil
        }
    }
    
    private func setUser() async throws {
        let response = try await databaseService.setData(collectionID: "users", documentID: self.currentUser?.id ?? "", collection: currentUser)
        switch response {
        case .success:
            try await fetchUserData()
        case .failure(let error):
            print("ERROR: Failed to set user data \(error.localizedDescription)")
        }
        
    }
    
    private func retrieveProfileImage(uid: String, imagePath: String) async {
        let storageRef = storage.reference()
        let ref = storageRef.child(imagePath)
        ref.getData(maxSize: 1 * 2024 * 2048) { data, error in
            if let error = error {
                print("ERROR: Failed to get profile image \(error.localizedDescription)")
            } else {
                self.currentUser?.profileImage = data
            }
        }
    }
}

//
//  SignupViewModel.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 12/02/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import PhotosUI


protocol ValidateForm {
    var isValid: Bool { get }
}


@Observable class AuthViewModel {
    let authService: IAuthentication = FirebaseAuthentication()
    let databaseService: IDatabase = FirestoreDatabase()
    
    var userSession: FirebaseAuth.User?
    var currentUser: User?
    let storage = Storage.storage()
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            try await fetchUserData()
        }
    }
    
    func signin(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try  await fetchUserData()
        } catch{
            print("ERROR: Failed to signin user with error \(error.localizedDescription)")
            
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email, profileImagePath: nil, profileImage: nil)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            try await fetchUserData()
        } catch {
            print("ERROR: Failed to create user with error \(error.localizedDescription)")
            print("ERROR:error \(error.self)")
            
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("ERROR: Failed to signout user with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try await Auth.auth().currentUser?.delete()
            try await Firestore.firestore().collection("users").document(uid).delete()
        } catch {
            print("ERROR: Failed to delete user with error \(error.localizedDescription)")
        }
    }
    
    func editProfileInfo(name: String) async {
        do {
            let userCollection = Firestore.firestore().collection("users").document(userSession?.uid ?? "")
            try await userCollection.updateData(["fullName": name])
            try await fetchUserData()
        } catch {
            print("ERROR: Failed edit profile Info \(error.localizedDescription)")
            
        }
    }
    
    //MARK: Refactored functions
    func fetchUserData() async throws {
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
                print("ERROR: saveImageToStorage \(error.localizedDescription)")
                return
            }
        }
    }
    
    //MARK: Private functions
    private func fetchUserID() throws -> String? {
        let uid = try authService.getUserID()
        switch uid {
        case .success(let uid):
            return uid
        case .failure(let error):
            print("ERROR: fetchUserID \(error.localizedDescription)")
            return nil
        }
    }
    
    private func fetchUser(userID: String) async throws -> User? {
        let user = try await databaseService.getByID(collectionID: "users", documentID: userID, collection: User.self)
        switch user {
        case .success(let response):
            return response
        case .failure(let error):
            print("ERROR: fetchUser \(error.localizedDescription)")
            return nil
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
    
    //    private func retrieve(documentID: String, String: String) async throws -> Data? {
    //        return try await databaseService.retrieveImageData(documentID: documentID, path: String)
    //        var imageData: Data?
    //        let storageRef = storage.reference()
    //        let ref = storageRef.child(path)
    //        ref.getData(maxSize: 1 * 2024 * 2048) { data, error in
    //            if let _ = error {
    //            } else {
    //                print("Success: retrieve")
    //                imageData = data
    //            }
    //        }
    ////        if errorResponse != nil {
    ////            return .failure(errorResponse!)
    ////        }
    ////
    ////        if imageData != nil {
    ////            return .success(imageData!)
    ////        }
    ////        return .failure(.retrieveImage)
    //        return imageData
    //    }
    
    
    //    func saveToStorage(pickerImage: PhotosPickerItem) async {
    //        do {
    //            if let imageData = try await pickerImage.loadTransferable(type: Data.self) {
    //                let uiImage = UIImage(data: imageData)
    //                let imageCompressed = uiImage?.jpegData(compressionQuality: 0.7)
    //                guard imageCompressed != nil else {
    //                    return
    //                }
    //                guard let uid = Auth.auth().currentUser?.uid else { return }
    //                let storageRef = storage.reference()
    //                let path = "profileImages/\(uid).jpg"
    //                let fileRef = storageRef.child(path)
    //                fileRef.putData(imageCompressed!, metadata: nil) { metadata, error in
    //                    if error == nil && metadata != nil {
    //                        Firestore.firestore().collection("users")
    //                            .document(uid)
    //                            .updateData(["profileImagePath": path])
    //                    }
    //                }
    //            }
    //            try await fetchUserData()
    //        }
    //        catch {
    //            print("ERROR: Failed to save user image with error \(error.localizedDescription)")
    //        }
    //    }
}

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
    var userSession: FirebaseAuth.User?
    var currentUser: User?
    let storage = Storage.storage()
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUserData()
        }
    }
    
    func signin(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUserData()
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
            await fetchUserData()
        } catch {
            print("ERROR: Failed to create user with error \(error.localizedDescription)")
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
    
    func fetchUserData() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        await retrieveProfileImage(uid: uid)
    }
    
    func saveToStorage(pickerImage: PhotosPickerItem) async {
        do {
            if let imageData = try await pickerImage.loadTransferable(type: Data.self) {
                let uiImage = UIImage(data: imageData)
                let imageCompressed = uiImage?.jpegData(compressionQuality: 0.7)
                guard imageCompressed != nil else {
                    return
                }
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let storageRef = storage.reference()
                let path = "profileImages/\(uid).jpg"
                let fileRef = storageRef.child(path)
                fileRef.putData(imageCompressed!, metadata: nil) { metadata, error in
                    if error == nil && metadata != nil {
                        Firestore.firestore().collection("users")
                            .document(uid)
                            .updateData(["profileImagePath": path])
                    }
                }
            }
            await fetchUserData()
        }
        catch {
            print("ERROR: Failed to save user image with error \(error.localizedDescription)")
        }
    }
    
    func retrieveProfileImage(uid: String) async {
        if self.currentUser?.profileImagePath != nil {
            let storageRef = storage.reference()
            let ref = storageRef.child(self.currentUser!.profileImagePath!)
            
            ref.getData(maxSize: 1 * 2024 * 2048) { data, error in
                if let error = error {
                    print("ERROR: Failed to get profile image \(error.localizedDescription)")
                } else {
                    self.currentUser?.profileImage = data
                }
            }
        }
    }
    
    func editProfileInfo(name: String) async {
        do {
            let userCollection = Firestore.firestore().collection("users").document(userSession?.uid ?? "")
            try await userCollection.updateData(["fullName": name])
            await fetchUserData()
        } catch {
            print("ERROR: Failed edit profile Info \(error.localizedDescription)")
            
        }
    }
}

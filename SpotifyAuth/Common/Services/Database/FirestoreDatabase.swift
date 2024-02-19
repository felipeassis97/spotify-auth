//
//  FirestoreDatabase.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 19/02/24.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FirestoreDatabase: IDatabase {

    let firestore = Firestore.firestore()
    let fisrestoreEncoder = Firestore.Encoder()
    let storage = Storage.storage()
    
    func getByID<T>(collectionID: String, documentID: String) async throws -> Result<T?, DatabaseError> where T : Decodable {
        guard let snapshot = try? await firestore.collection(collectionID).document(documentID).getDocument() else {
            return .failure(.collectionNotFound)
        }
        
        guard let decodedResponse = try? snapshot.data(as: T.self) else {
            return .failure(.decodeError)
        }
        return .success(decodedResponse)
    }
    
    
    func setData<T>(collectionID: String, documentID: String, collection: T) async throws -> Result<Bool, DatabaseError> where T : Encodable {
        guard let encodedData = try? fisrestoreEncoder.encode(collection) else {
            return .failure(.encodeError)
        }
        guard let _ = try? await firestore.collection(collectionID).document(documentID).setData(encodedData) else {
            return .failure(.collectionNotFound)
        }
        return .success(true)
    }
    
    func editData(collectionID: String, documentID: String, data: [String : Any]) async throws -> Result<Bool, DatabaseError> {
        let collection = firestore.collection(collectionID).document(documentID)
        guard let _ = try? await collection.updateData(data) else {
            return .failure(.collectionNotFound)
        }
        return .success(true)
    }
    
    func setImageData(collectionID: String, documentID: String, imageData: Data) async throws -> Result<Bool, DatabaseError> {
        let uiImage = UIImage(data: imageData)
        guard let compress = uiImage?.jpegData(compressionQuality: 0.7) else {
            return .failure(.compressedImage)
        }
        let storageRef = storage.reference()
        let path = "Images/\(documentID).jpg"
        let fileRef = storageRef.child(path)
        fileRef.putData(compress, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                firestore.collection(collectionID)
                    .document(documentID)
                    .updateData(["profileImagePath": path])
            }
        }
        return .success(true)
    }
    
    func retrieveImageData(documentID: String, path: String) async throws -> Result<Data, DatabaseError> {
        var imageData: Data?
        var errorResponse: DatabaseError?
        let storageRef = storage.reference()
        let ref = storageRef.child(path)
        ref.getData(maxSize: 1 * 2024 * 2048) { data, error in
            if let error = error {
                errorResponse = DatabaseError.retrieveImage
            } else {
                imageData = data
            }
        }
        if errorResponse != nil {
            return .failure(errorResponse!)
        }
        
        if imageData != nil {
            return .success(imageData!)
        }
        return .failure(.retrieveImage)
    }
}


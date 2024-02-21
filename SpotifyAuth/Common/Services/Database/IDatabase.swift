//
//  IDatabase.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 19/02/24.
//

import Foundation

protocol IDatabase {
    func getByID<T: Decodable>(collectionID: String, documentID: String, collection: T.Type) async throws -> Result<T, DatabaseError>
    func setData<T: Encodable>(collectionID: String, documentID: String, collection: T) async throws -> Result<Bool, DatabaseError>
    func editData(collectionID: String, documentID: String, data: [String: Any]) async throws -> Result<Bool, DatabaseError>
    func setImageData(collectionID: String, documentID: String, imageData: Data) async throws -> Result<Bool, DatabaseError>
    func retrieveImageData(documentID: String, path: String) async throws -> Result<Data, DatabaseError>
}





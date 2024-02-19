//
//  DatabaseError.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 19/02/24.
//

import Foundation

enum DatabaseError: Error {
    case collectionNotFound
    case decodeError
    case encodeError
    case compressedImage
    case saveImage
    case retrieveImage
    case unknownError(error: String)
}

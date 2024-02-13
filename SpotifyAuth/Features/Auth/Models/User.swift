//
//  User.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 12/02/24.
//

import SwiftUI

struct User: Codable, Identifiable {
    let id: String
    let fullName: String
    let email: String
    let profileImagePath: String?
    var profileImage: Data?
    
    var initials:  String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Felipe Assis", email: "felipeassis97@gmail.com", profileImagePath: nil, profileImage: nil)
}

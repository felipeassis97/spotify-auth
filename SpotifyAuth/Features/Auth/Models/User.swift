//
//  User.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 12/02/24.
//

import SwiftUI

struct User: Codable, Identifiable {
    let id: String
    let email: String
    var profileImagePath: String?
    var fullName: String?
    var profileImage: Data?
    
    var initials:  String {
        if fullName != nil {
            let formatter = PersonNameComponentsFormatter()
            if let components = formatter.personNameComponents(from: fullName ?? "") {
                formatter.style = .abbreviated
                return formatter.string(from: components)
            }
        }
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, email: "felipeassis97@gmail.com", profileImagePath: nil, fullName: "Felipe Assis", profileImage: nil)
}

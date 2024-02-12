//
//  SpotifyAuthApp.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 07/02/24.
//

import SwiftUI
import FirebaseCore

@main
struct SpotifyAuthApp: App {
    init() {
        FirebaseApp.configure()
    }
    var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authViewModel)
        }
    }
}

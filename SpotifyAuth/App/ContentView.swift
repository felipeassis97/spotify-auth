//
//  ContentView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 07/02/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @Environment(AuthViewModel.self) var authViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                HomeView()
            } else {
                AuthOptionsView()
            }
        }
    }
}

#Preview {
    ContentView()
}

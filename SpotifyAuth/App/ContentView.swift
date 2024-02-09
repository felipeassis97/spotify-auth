//
//  ContentView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 07/02/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        NavigationStack {
            AuthOptionsView()
        }
    }
}

#Preview {
    ContentView()
}

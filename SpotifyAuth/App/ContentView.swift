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
            if authViewModel.currentUser != nil {
                BottomNavigation()
            } else {
                AuthOptionsView()
            }
        }
    }
}

struct BottomNavigation: View {
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label {
                    Text("Home")
                        .font(.customStyle(style: .medium, size: 14))
                        .foregroundStyle(.onBackground)
                } icon: {
                    Image(.homeIcon)
                        .resizable()
                        .scaledToFit()
                }
            }
            .tag(0)
            
            NavigationStack {
                LibraryView()
            }
            .tabItem {
                Label {
                    Text("Library")
                        .font(.customStyle(style: .medium, size: 14))
                        .foregroundStyle(.onBackground)
                } icon: {
                    Image(.libraryIcon)
                        .resizable()
                        .scaledToFit()
                }
            }
            .tag(1)
        }
    }
}

#Preview {
    BottomNavigation()
}

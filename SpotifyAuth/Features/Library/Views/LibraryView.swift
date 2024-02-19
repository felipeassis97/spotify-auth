//
//  LibraryView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 13/02/24.
//

import SwiftUI
import PhotosUI

struct LibraryView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var showEditSheet = false
    
    var body: some View {
        VStack(spacing: 24) {
            UserPhotoComponentView()
            Button {
                showEditSheet = true
            } label: {
                Text("Edit profile")
                    .font(.customStyle(style: .bold, size: 16))
            }
            .buttonStyle(PrimaryButtonStyle(backgroundColor: .gray.opacity(0.8),
                                            foregroundColor: .white,
                                            fontSize: 12))
            Spacer()
        }
        .sheet(isPresented: $showEditSheet, content: {
            EditProfileView(email: authViewModel.currentUser?.email ?? "", name: authViewModel.currentUser?.fullName ?? "")
        })
    }
}

#Preview {
    LibraryView()
}

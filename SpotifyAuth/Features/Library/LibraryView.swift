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
    
    var body: some View {
        VStack(spacing: 24) {
            ProfileImageView()
            Button {
                print("")
            } label: {
                Text("Edit profile")
                    .font(.customStyle(style: .bold, size: 16))
            }
            .buttonStyle(PrimaryButtonStyle(backgroundColor: .gray.opacity(0.8),
                                            foregroundColor: .white,
                                            fontSize: 12))
            Spacer()
        }
        
    }
}


struct ProfileImageView: View {
    @Environment(AuthViewModel.self) var authViewModel
    var body: some View {
        if authViewModel.currentUser?.profileImage != nil {
            if let profile = UIImage(data: authViewModel.currentUser!.profileImage!)  {
                Image(uiImage: profile)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)
                    .clipShape(Circle())
            }
        } else {
            Circle()
                .scaledToFit()
                .frame(maxWidth: 100)
                .foregroundStyle(.gray.opacity(0.8))

        }
    }
}


//struct ProfileImageView: View {
//    @Environment(AuthViewModel.self) var authViewModel
//    @State private var selectedPhoto: PhotosPickerItem?
//
//    var body: some View {
//        VStack {
//
//            ZStack {
//                if authViewModel.currentUser?.profileImage != nil {
//                    if let profile = UIImage(data: authViewModel.currentUser!.profileImage!)  {
//                        Image(uiImage: profile)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(maxWidth: 100)
//                            .clipShape(Circle())
//                            .padding(.bottom, 16)
//                    }
//                } else {
//                    Circle()
//                        .foregroundStyle(.gray)
//                        .scaledToFit()
//                        .frame(width: 100)
//                        .padding(.bottom, 16)
//                }
//
//                PhotosPicker(selection: $selectedPhoto, matching: .images) {
//                    Image(systemName: "pencil")
//                }
//                .onChange(of: selectedPhoto)  {
//                    if selectedPhoto != nil {
//                        Task {
//                            authViewModel.currentUser?.profileImage = try await selectedPhoto?.loadTransferable(type: Data.self)
//                        }
//                    }
//                }
//            }
//
//            if selectedPhoto != nil {
//                Button {
//                    Task {
//                        await authViewModel.saveToStorage(pickerImage: selectedPhoto!)
//                        selectedPhoto = nil
//                    }
//                } label: {
//                    Text("Save changes")
//                }
//                .buttonStyle(PrimaryButtonStyle())
//            }
//        }
//    }
//}

#Preview {
    LibraryView()
}

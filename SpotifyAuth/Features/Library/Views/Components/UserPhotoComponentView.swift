//
//  UserPhotoComponentView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 16/02/24.
//

import SwiftUI
import PhotosUI

struct UserPhotoComponentView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @State private var selectedPhoto: PhotosPickerItem?
    var isEditPicture: Bool = false

    var body: some View {
        VStack {
            ZStack {
                if authViewModel.currentUser?.profileImage != nil {
                    if let profile = UIImage(data: authViewModel.currentUser!.profileImage!)  {
                        Image(uiImage: profile)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 150)
                            .clipShape(Circle())
                            .padding(.bottom, 16)
                    }
                } else {
                    Circle()
                        .foregroundStyle(.gray)
                        .scaledToFit()
                        .frame(width: 120)
                        .padding(.bottom, 16)
                }
                
                if isEditPicture {
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        Image(systemName: "person.crop.square.badge.camera.fill")
                            .foregroundColor(.onBackground)
                            .font(.title)
                            .padding(.top, 56)
                        
                    }
                    .onChange(of: selectedPhoto)  {
                        if selectedPhoto != nil {
                            Task {
                                authViewModel.currentUser?.profileImage = try await selectedPhoto?.loadTransferable(type: Data.self)
                            }
                        }
                    }
                    .frame(maxWidth: 120, alignment: .bottomTrailing)
                    
                    if selectedPhoto != nil {
                        Button {
                            Task {
                                await authViewModel.saveToStorage(pickerImage: selectedPhoto!)
                                selectedPhoto = nil
                            }
                        } label: {
                            Text("Save changes")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }
                }
            }
        }
    }
}

#Preview {
    UserPhotoComponentView()
}


//struct ProfileImageView2: View {
//    @Environment(AuthViewModel.self) var authViewModel
//    @State private var selectedPhoto: PhotosPickerItem?
//
//    var body: some View {
//        VStack {
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

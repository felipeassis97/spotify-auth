//
//  HomeView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 12/02/24.
//

import SwiftUI
import PhotosUI

struct HomeView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var image: UIImage?
    
    var body: some View {
        VStack {
            if authViewModel.currentUser?.profileImage != nil {
                if let im = UIImage(data: authViewModel.currentUser!.profileImage!)  {
                    Image(uiImage: im)
                        .resizable()
                        .scaledToFit()
                }
            }
                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    Label("Select a photo", systemImage: "person")
                }
                
                
                if selectedPhoto != nil {
                    Button {
                        Task {
                           try await authViewModel.saveImageToStorage(pickerImage: selectedPhoto!)
                        }
                    } label: {
                        Text("Upload")
                    }
                }
                
                Text(authViewModel.currentUser?.fullName ?? "")
                    .font(.customStyle(style: .medium, size: 14))
                    .foregroundStyle(.onBackground)
                    .padding(.bottom, 8)
                
                Text(authViewModel.currentUser?.email ?? "")
                    .font(.customStyle(style: .medium, size: 14))
                    .foregroundStyle(.onBackground)
                    .padding(.bottom, 8)
                
                Text(authViewModel.currentUser?.id ?? "")
                    .font(.customStyle(style: .medium, size: 14))
                    .foregroundStyle(.onBackground)
                    .padding(.bottom, 8)
                
                
                Button(action: {
                    Task {
                        authViewModel.signout()
                    }
                }, label: {
                    Text("Log out")
                })
            }
        }
    }

#Preview {
    HomeView()
}

//
//  SignupImageProfileView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 13/02/24.
//

import SwiftUI

struct SignupImageProfileView: View {
    var body: some View {
        @Environment(AuthViewModel.self) var authViewModel
        
        VStack {
            if authViewModel.currentUser?.profileImage != nil {
                if let im = UIImage(data: authViewModel.currentUser!.profileImage!)  {
                    Image(uiImage: im)
                        .resizable()
                        .scaledToFit()
                }
            } else {
                Circle()
                    .foregroundStyle(.gray)
                    .scaledToFit()
                    .frame(width: 50)
            }
            
            Text(authViewModel.currentUser?.fullName ?? "")
                .font(.customStyle(style: .bold, size: 16))
        }
    }
}

#Preview {
    SignupImageProfileView()
}

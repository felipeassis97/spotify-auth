//
//  EditProfileView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 16/02/24.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @State private var email: String = ""
    @State private var name: String = ""

    var body: some View {
        VStack(spacing: 16) {
            UserPhotoComponentView(isEditPicture: true)
            CustomTextField(text: $name,
                            title: "What's your name?")
            CustomTextField(text: $email,
                            title: "What's your email?",
                            keyboardType: .emailAddress)
            Spacer()
            Button {
               print("")
            } label: {
                Text("Confirm changes")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
    }
}

#Preview {
    EditProfileView()
}

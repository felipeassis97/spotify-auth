//
//  EditProfileView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 16/02/24.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(\.dismiss) var dismiss
    @State var email: String
    @State var name: String

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
                Task {
                    await authViewModel.editProfileInfo(name: name)
                }
                dismiss()
            } label: {
                Text("Confirm changes")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
    }
}

#Preview {
    EditProfileView(email: "ddf", name: "sds")
}

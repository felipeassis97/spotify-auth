//
//  SignupNameView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 09/02/24.
//

import SwiftUI

struct SignupNameView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AuthViewModel.self) var authViewModel
    @State private var name = ""
    @Binding var email: String
    @Binding var password: String
    @Binding var gender: String

    
//    init() {
//        customNavBarAppearance()
//    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                CustomTextField(text: $name,
                                title: "What's your name?")
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                Spacer()
                HStack {
                   Spacer()
                    Button {
                        Task {
                            try await authViewModel.createUser(withEmail: email, password: password, fullName: name)
                        }
                    } label: {
                        Text("Create account")
                            .padding(.horizontal, 16)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    Spacer()
                }
            }
        }
        .navigationTitle("Create account")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(.arrowBack)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                })
            }
        }
    }
}

#Preview {
    SignupNameView(email: .constant("felipeassis97@gmail.com"), password: .constant("123"), gender: .constant("Male"))
}

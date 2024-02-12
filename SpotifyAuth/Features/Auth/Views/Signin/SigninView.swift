//
//  SigninView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 12/02/24.
//

import SwiftUI

struct SigninView: View {
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    @Environment(AuthViewModel.self) var authViewModel
    
    init() {
        customNavBarAppearance()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomTextField(text: $email,
                            title: "Email or username",
                            keyboardType: .emailAddress)
            .padding(.bottom, 8)
            
            CustomTextField(text: $password,
                            title: "Password",
                            isSecureField: true)
            .padding(.bottom, 24)
    
            HStack {
               Spacer()
                Button(action: {
                    Task {
                        try await authViewModel.signin(withEmail: email, password: password)
                    }
                }, label: {
                    Text("Log in")
                        .padding(.horizontal, 16)
                })
                .buttonStyle(PrimaryButtonStyle())
                Spacer()
            }
           Spacer()
        }
        .padding(.all, 24)
        .navigationTitle("Log in")
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
    SigninView()
}

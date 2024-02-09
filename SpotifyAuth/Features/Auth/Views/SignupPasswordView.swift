//
//  SignupPasswordView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 08/02/24.
//

import SwiftUI

struct SignupPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    
    init() {
        customNavBarAppearance()
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                CustomTextField(text: $email,
                                title: "Create a password",
                                isSecureField: true)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                HStack {
                   Spacer()
                    NavigationLink(destination: SignupGenderView()) {
                        Text("Next")
                            .padding(.horizontal, 16)
                            .buttonStyle(PrimaryButtonStyle())
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    Spacer()
                }
                Spacer()
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
    SignupPasswordView()
}

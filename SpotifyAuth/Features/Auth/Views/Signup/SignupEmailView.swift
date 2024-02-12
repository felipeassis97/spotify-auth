//
//  SignupView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 08/02/24.
//

import SwiftUI

struct SignupEmailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    
    init() {
        customNavBarAppearance()
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                CustomTextField(text: $email, 
                                title: "What's your email?",
                                keyboardType: .emailAddress)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                HStack {
                    Spacer()
                    NavigationLink(destination: SignupPasswordView(email: $email)) {
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
    SignupEmailView()
}

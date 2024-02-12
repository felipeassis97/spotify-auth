//
//  SignupPasswordView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 08/02/24.
//

import SwiftUI

struct SignupPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var password = ""
    @Binding var email: String
    
//    init() {
//        customNavBarAppearance()
//    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                CustomTextField(text: $password,
                                title: "Create a password",
                                isSecureField: true)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                HStack {
                   Spacer()
                    NavigationLink(destination: SignupGenderView(email: $email, password: $password)) {
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
    SignupPasswordView(email: .constant("felipeassis97@gmail.com"))
}

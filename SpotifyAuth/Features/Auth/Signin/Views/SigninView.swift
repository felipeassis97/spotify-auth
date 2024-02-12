//
//  SigninView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 12/02/24.
//

import SwiftUI

struct SigninView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    
    init() {
        customNavBarAppearance()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomTextField(text: $email,
                            title: "Email or username",
                            keyboardType: .emailAddress)
            .padding(.bottom, 8)
            
            
            CustomTextField(text: $email,
                            title: "Password",
                            isSecureField: true)
            .padding(.bottom, 24)

            
            HStack {
               Spacer()
                NavigationLink(destination: SignupGenderView()) {
                    Text("Log in")
                        .padding(.horizontal, 16)
                        .buttonStyle(PrimaryButtonStyle())
                }
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

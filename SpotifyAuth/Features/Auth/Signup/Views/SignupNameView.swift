//
//  SignupNameView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 09/02/24.
//

import SwiftUI

struct SignupNameView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    
    init() {
        customNavBarAppearance()
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                CustomTextField(text: $email,
                                title: "What's your name?")
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                Spacer()
                HStack {
                   Spacer()
                    NavigationLink(destination: {}) {
                        Text("Create account")
                            .padding(.horizontal, 16)
                            .buttonStyle(PrimaryButtonStyle())
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
    SignupNameView()
}

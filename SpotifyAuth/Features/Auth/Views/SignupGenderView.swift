//
//  SignupGenderView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 09/02/24.
//

import SwiftUI

struct SignupGenderView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State var selection1: String? = nil

    
    init() {
        customNavBarAppearance()
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                DropDownPicker(
                    selection: $selection1,
                    options: ["Female", "Male"],
                    title: "What's your gender?"
                )
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
                
                HStack {
                   Spacer()
                    NavigationLink(destination: SignupNameView()) {
                        Text("Next")
                            .padding(.horizontal, 16)
                            .buttonStyle(PrimaryButtonStyle())
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    Spacer()
                }
                .padding(.top, 24)

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
    SignupGenderView()
}

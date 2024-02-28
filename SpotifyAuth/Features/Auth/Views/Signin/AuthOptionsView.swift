//
//  AuthOptionsView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 08/02/24.
//

import SwiftUI

struct AuthOptionsView: View {
    @Environment(AuthViewModel.self) var authViewModel

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack {
                    Image(.banner)
                        .resizable()
                        .scaledToFit()
                        .opacity(0.4)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 500, alignment: .top)
                        .shadow(color: .onBackground, radius: 100, y: 400)
                    Spacer()
                }
                VStack {
                    Spacer()
                    Image(.spotifyLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56, alignment: .top)
                        .padding(.vertical, 16)
                    
                    Text("Millions of Songs.")
                        .font(.customStyle(style: .bold, size: 28))
                    Text("Free on Spotify")
                        .font(.customStyle(style: .bold, size: 28))
                        .padding(.bottom, 16)
 
                    NavigationLink(destination: SignupEmailView()) {
                        Text("Sign up free")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .buttonStyle(PrimaryButtonStyle())
                    }                    .buttonStyle(PrimaryButtonStyle())
                    Button(action: {
                        Task {
                            try await authViewModel.googleSignin()
                        }
                    }, label: {
                        HStack {
                            Image(.googleLogo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18)
                            
                            Text("Continue with Google")
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, 16)
                    })
                    .buttonStyle(OutlineButtonStyle())
                    
                    Button(action: {
                    }, label: {
                        HStack {
                            Image(.facebookLogo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18)
                            
                            Text("Continue with Facebook")
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, 16)
                    })
                    .buttonStyle(OutlineButtonStyle())
                    
                    Button(action: {}, label: {
                        HStack {
                            Image(.appleLogo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18)
                            
                            Text("Continue with Apple")
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, 16)
                    })
                    .buttonStyle(OutlineButtonStyle())
                    
                    NavigationLink("Log in") {
                        SigninView()
                    }
                    .font(.customStyle(style: .bold, size: 16))
                    .foregroundStyle(.onBackground)
                    .padding(.top, 8)
                }
                .padding(.all, 24)
            }
        }
    }
}

#Preview {
    AuthOptionsView()
}

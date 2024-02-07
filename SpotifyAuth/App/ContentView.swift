//
//  ContentView.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 07/02/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    var body: some View {
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
                
                Button(action: {
                    Auth.auth().createUser(withEmail: "felipeassis97@gmail.com", password: "123456") { authResult, error in
                        print(authResult?.user.email)
                    }
                    
                }, label: {
                    Text("Sign up free")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                })
                .buttonStyle(PrimaryButtonStyle())
                
                Button(action: {
                    Auth.auth().signIn(withEmail: "felipeassis97@gmail.com", password: "123456") {  authResult, error in
                        print(authResult?.user.email)
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
                    let user = Auth.auth().currentUser?.email
                    print(user)
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
            }
            .padding(.all, 24)
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.customStyle(style: .bold, size: 16))
            .padding()
            .background(.primaryGreen)
            .foregroundColor(.black)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

struct OutlineButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.customStyle(style: .bold, size: 16))
            .padding()
            .background(RoundedRectangle(cornerRadius: 50, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .stroke(.onBackground, lineWidth: 2)
            )
            .foregroundColor(.onBackground)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

struct OutlineButtonStyle2: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.customStyle(style: .bold, size: 16))
            .padding()
            .background(RoundedRectangle(cornerRadius: 50, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .stroke(.onBackground, lineWidth: 2)
            )
            .foregroundColor(.onBackground)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

#Preview {
    ContentView()
}

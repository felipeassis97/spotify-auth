//
//  OutlineButtonStyle.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 08/02/24.
//

import SwiftUI

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

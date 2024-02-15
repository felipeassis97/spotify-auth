//
//  PrimaryButtonStyle.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 08/02/24.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var backgroundColor: Color = .primaryGreen
    var foregroundColor: Color = .black
    var fontSize: CGFloat = 16
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.customStyle(style: .bold, size: fontSize))
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

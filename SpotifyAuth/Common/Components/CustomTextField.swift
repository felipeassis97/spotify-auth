//
//  CustomTextField.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 08/02/24.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let title: String
    var keyboardType: UIKeyboardType = .default
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.customStyle(style: .bold, size: 18))
                .foregroundStyle(.onBackground)
            
            if isSecureField {
                SecureField("", text: $text)
                    .padding()
                    .background(.primaryGray)
                    .foregroundStyle(.onBackground)
                    .clipShape(.buttonBorder)
                    .font(.customStyle(style: .demi, size: 16))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.none)
            } else {
                TextField("", text: $text)
                    .padding()
                    .background(.primaryGray)
                    .foregroundStyle(.onBackground)
                    .clipShape(.buttonBorder)
                    .font(.customStyle(style: .demi, size: 16))
                    .autocorrectionDisabled()
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(.never)
            }
        }
    }
}

#Preview {
    CustomTextField( text: .constant(""), title: "Whats your email?")
}

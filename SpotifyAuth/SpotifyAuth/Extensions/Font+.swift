//
//  Font+.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 05/02/24.
//

import Foundation
import SwiftUI

extension Font {
    enum FontStyle: String {
        case bold = "-Bold"
        case medium = "-Medium"
        case demi = "-Demi"
    }
    
    static func customStyle(style: FontStyle, size: CGFloat, isScaled: Bool = true) -> Font {
        let fontName: String = "Avenir" + style.rawValue
        return Font.custom(fontName, size: size)
    }
}

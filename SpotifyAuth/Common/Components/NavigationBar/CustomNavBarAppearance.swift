//
//  CustomNavBarAppearance.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 08/02/24.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
func customNavBarAppearance() {
    let appear = UINavigationBarAppearance()
    let atters: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "AvenirNextLTPro-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14)
    ]
    appear.titleTextAttributes = atters
    appear.largeTitleTextAttributes = atters
    UINavigationBar.appearance().standardAppearance = appear
    UINavigationBar.appearance().compactAppearance = appear
    UINavigationBar.appearance().compactAppearance = appear
}

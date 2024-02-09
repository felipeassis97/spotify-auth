//
//  CustomPicker.swift
//  SpotifyAuth
//
//  Created by Felipe Assis on 09/02/24.
//

import SwiftUI

struct DropDownPicker: View {
    
    @Binding var selection: String?
    var state: DropDownPickerState = .bottom
    let options: [String]
    var maxWidth: CGFloat = 350
    let title: String

    
    @State var showDropdown = false
    
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State var zindex = 1000.0
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .font(.customStyle(style: .bold, size: 18))
                .foregroundStyle(.onBackground)
            
            GeometryReader {
                let size = $0.size
                
                VStack(spacing: 0) {
                    if state == .top && showDropdown {
                        OptionsView()
                    }
                    
                    HStack {
                        Text(selection == nil ? "" : selection!)
                            .font(.customStyle(style: .demi, size: 16))
                            .foregroundStyle(.onBackground)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: state == .top ? "chevron.up" : "chevron.down")
                            .font(.customStyle(style: .demi, size: 16))
                            .foregroundStyle(.onBackground)
                            .rotationEffect(.degrees((showDropdown ? -180 : 0)))
                    }
                    .padding(.horizontal, 15)
                    .frame(width: 350, height: 48)
                    .background(.primaryGray)
                    .contentShape(.rect)
                    .onTapGesture {
                        index += 1
                        zindex = index
                        withAnimation(.snappy) {
                            showDropdown.toggle()
                        }
                    }
                    .zIndex(10)
                    
                    if state == .bottom && showDropdown {
                        OptionsView()
                    }
                }
                .clipped()
                .background(.primaryGray)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.primaryGray)
                }
                .frame(height: size.height, alignment: state == .top ? .bottom : .top)
                
            }
        }
        .frame(width: maxWidth, height: 48)
        .zIndex(zindex)
    }
    
    
    func OptionsView() -> some View {
        VStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                HStack {
                    Text(option)
                        .font(.customStyle(style: .demi, size: 16))
                        .foregroundStyle(selection == option ? .onBackground : .onBackground.opacity(0.8))
                    Spacer()
                    Image(systemName: "checkmark")
                        .opacity(selection == option ? 1 : 0)
                }
                .animation(.none, value: selection)
                .frame(height: 40)
                .contentShape(.rect)
                .padding(.horizontal, 15)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selection = option
                        showDropdown.toggle()
                    }
                }
            }
        }
        .transition(.move(edge: state == .top ? .bottom : .top))
        .zIndex(1)
    }
}

enum DropDownPickerState {
    case top
    case bottom
}

#Preview {
    DropDownPicker(selection: .constant("Selected"), options: [
        "Apple",
        "Google",
        "Amazon",
        "Facebook",
        "Instagram"
    ], title: "What's your gender?")
}

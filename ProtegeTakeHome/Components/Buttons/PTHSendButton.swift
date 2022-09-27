//
//  PTHSendButton.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/22/22.
//

import SwiftUI

struct PTHFilledButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        var foregroundColor: Color {
            if isEnabled {
                return configuration.isPressed ? .white.opacity(0.5) : .white
            } else {
                return .white.opacity(0.5)
            }
        }
        
        var backgroundColor: Color {
            if isEnabled {
                return configuration.isPressed ? .blue.opacity(0.5) : .blue
            } else {
                return .blue.opacity(0.5)
            }
        }
        
        return configuration
            .label
            .foregroundColor(foregroundColor)
            .padding(8)
            .background(backgroundColor)
            .clipShape(Circle())
    }
}

struct PTHSendButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: SFSymbols.send)
        }
        .buttonStyle(PTHFilledButton())
    }
}

struct PTHSendButton_Previews: PreviewProvider {
    private static func previewFunc() {}
    
    static var previews: some View {
        PTHSendButton(action: previewFunc)
    }
}

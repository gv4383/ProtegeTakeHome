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
            configuration.isPressed ? .white.opacity(0.5) : .white
        }
        
        var backgroundColor: Color {
            configuration.isPressed ? .blue.opacity(0.5) : .blue
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

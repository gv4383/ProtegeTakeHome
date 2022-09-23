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
        return configuration
            .label
            .foregroundColor(.white)
            .padding(8)
            .background(.blue)
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

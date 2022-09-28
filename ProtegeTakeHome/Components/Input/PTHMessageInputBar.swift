//
//  PTHMessageInputBar.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/22/22.
//

import SwiftUI

struct PTHMessageInputBar: View {
    let sendMessageAction: (String) -> Void
    
    @State private var messageInput = ""
    @FocusState var messageInputIsFocused: Bool
    
    var body: some View {
        HStack {
            TextField(MessageInputTextField.placeholder, text: $messageInput)
                .focused($messageInputIsFocused)
            
            Spacer()
            
            PTHSendButton {
                sendMessageAction(messageInput)
                messageInput = ""
                messageInputIsFocused = false
            }
            .disabled(messageInput.isEmpty)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .border(width: 1, edges: [.top], color: .gray.opacity(0.5))
    }
}

struct PTHMessageInputBar_Previews: PreviewProvider {
    static private func sendMessageAction(_ message: String) {}
    
    static var previews: some View {
        PTHMessageInputBar(sendMessageAction: sendMessageAction)
    }
}

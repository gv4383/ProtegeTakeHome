//
//  PTHMessageInputBar.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/22/22.
//

import SwiftUI

struct PTHMessageInputBar: View {
    @State private var messageInput = ""
    
    private func sendMessage() {
        print("Sending message...")
    }
    
    var body: some View {
        HStack {
            TextField("Message", text: $messageInput)
            
            Spacer()
            
            PTHSendButton(action: sendMessage)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .border(width: 1, edges: [.top], color: .gray.opacity(0.5))
    }
}

struct PTHMessageInputBar_Previews: PreviewProvider {
    static var previews: some View {
        PTHMessageInputBar()
    }
}

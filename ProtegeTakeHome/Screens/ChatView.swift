//
//  ChatView.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/22/22.
//

import SwiftUI

struct ChatView: View {
    @State private var isLoadingChatMessages = true
    
    let mockChatAPI = MockChatAPI()
    
    var body: some View {
        if isLoadingChatMessages {
            PTHLoadingView()
                .task {
                    do {
                        let chat = Chat(primarySender: MessageSender.lia, secondarySender: MessageSender.christina)
                        let start = Calendar.current.date(byAdding: .hour, value: -1, to: Date())!
                        let end = Date()
                        let chatMessages = try await mockChatAPI.fetchMessages(for: chat, interval: DateInterval(start: start, end: end))
                        print(chatMessages)
                        isLoadingChatMessages = false
                    } catch {
                        print("Something went wrong loading the chat messgages")
                    }
                }
        } else {
            VStack {
                Text("Chat messages loaded!")
                
                Spacer()
                
                PTHMessageInputBar()
            }
            .navigationTitle("Joe Toe")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView()
        }
    }
}

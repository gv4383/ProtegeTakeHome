//
//  ChatViewModel.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/26/22.
//

import Foundation

extension ChatView {
    final class ChatViewModel: ObservableObject {
        @Published var isLoadingChatMessages = true
        @Published var chatMessages = [Message]()
        
        let primaryMessenger = MessageSender.lia
        let secondaryMessenger = MessageSender.christina
        
        func fetchChatMessages() async throws {
            let mockChatAPI = MockChatAPI()
            let chat = Chat(primarySender: MessageSender.lia, secondarySender: MessageSender.christina)
            let start = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            let end = Calendar.current.date(byAdding: .hour, value: -2, to: Date())!
            let chatMessages = try await mockChatAPI.fetchMessages(for: chat, interval: DateInterval(start: start, end: end))
            
            // TODO: Is this correct?
            DispatchQueue.main.async {
                self.isLoadingChatMessages = false
                self.chatMessages = chatMessages
            }
            
            print(chatMessages)
        }
        
        func sendMessage(_ message: String) {
            let newMessage = Message(date: Date(), content: message, sender: primaryMessenger)
            chatMessages.append(newMessage)
        }
    }
}

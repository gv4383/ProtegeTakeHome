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
        @Published var lastMessageId = UUID()
        
        let primaryMessenger = MessageSender.greg
        var secondaryMessenger: MessageSender {
            let contacts = [
                MessageSender.christina,
                MessageSender.lia,
                MessageSender.katie,
                MessageSender.kelly
            ]

            return contacts.randomElement()!
        }
        
        var contactName: String {
            let firstName = secondaryMessenger.name.givenName ?? ""
            let lastName = secondaryMessenger.name.familyName ?? ""
            
            guard firstName != "" && lastName != "" else {
                return "N/A"
            }
            
            return "\(firstName) \(lastName)"
        }
        
        func fetchChatMessages(before date: Date = Date()) async throws {
            let mockChatAPI = MockChatAPI()
            let chat = Chat(primarySender: primaryMessenger, secondarySender: secondaryMessenger)
            let start = Calendar.current.date(byAdding: .day, value: -1, to: date)!
            let end = date
//            let end = Calendar.current.date(byAdding: .hour, value: -2, to: date)!
            let chatMessages = try await mockChatAPI.fetchMessages(for: chat, interval: DateInterval(start: start, end: end))
            
            DispatchQueue.main.async {
                self.isLoadingChatMessages = false
                self.chatMessages.insert(contentsOf: chatMessages, at: 0)
                
                if let lastMessageId = chatMessages.last?.id {
                    self.lastMessageId = lastMessageId
                }
            }
            
            print(chatMessages)
        }
        
        func sendMessage(_ message: String) {
            let newMessage = Message(date: Date(), content: message, sender: primaryMessenger)
            chatMessages.append(newMessage)
            
            if let lastMessageId = chatMessages.last?.id {
                self.lastMessageId = lastMessageId
            }
        }
    }
}

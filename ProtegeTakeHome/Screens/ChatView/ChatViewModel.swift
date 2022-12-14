//
//  ChatViewModel.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/26/22.
//

import Foundation

extension ChatView {
    final class ChatViewModel: ObservableObject {
        @Published var chatMessages = [Message]()
        @Published var isFetchingInitialMessages = true
        @Published var isFetchingPreviousMessages = false
        @Published var lastMessageId = UUID()
        @Published var previousFirstMessageIndex = 0
        
        let primaryMessenger = MessageSender.greg
        let secondaryMessenger = MessageSender.lia
        
        var contactName: String {
            let firstName = secondaryMessenger.name.givenName ?? ""
            let lastName = secondaryMessenger.name.familyName ?? ""
            
            guard firstName != "" && lastName != "" else {
                return "N/A"
            }
            
            return "\(firstName) \(lastName)"
        }
        
        func sendMessage(_ message: String) {
            let newMessage = Message(date: Date(), content: message, sender: primaryMessenger)
            chatMessages.append(newMessage)
            
            if let lastMessageId = chatMessages.last?.id {
                self.lastMessageId = lastMessageId
            }
        }
        
        func fetchInitialMessages() async throws {
            isFetchingInitialMessages = true
            try await fetchChatMessages()
            
            DispatchQueue.main.async {
                self.isFetchingInitialMessages = false
            }
        }
        
        func fetchPreviousMessages() async throws {
            isFetchingPreviousMessages = true
            
            if let currentFirstMessage = chatMessages.first {
                let dateOfCurrentFirstMessage = currentFirstMessage.date
                try await fetchChatMessages(before: dateOfCurrentFirstMessage)
            }
        }
        
        private func fetchChatMessages(before date: Date = Date()) async throws {
            let mockChatAPI = MockChatAPI()
            let chat = Chat(primarySender: primaryMessenger, secondarySender: secondaryMessenger)
            let start = Calendar.current.date(byAdding: .hour, value: -12, to: date)!
            let end = date
            let chatMessages = try await mockChatAPI.fetchMessages(for: chat, interval: DateInterval(start: start, end: end))
            let sortedChatMessages = chatMessages.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
            
            DispatchQueue.main.async {
                self.chatMessages.insert(contentsOf: sortedChatMessages, at: 0)
                self.previousFirstMessageIndex = sortedChatMessages.count + 2
                
                if let lastMessageId = sortedChatMessages.last?.id {
                    self.lastMessageId = lastMessageId
                }
            }
        }
    }
}

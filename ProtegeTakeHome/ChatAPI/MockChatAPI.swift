//
//  MockChatAPI.swift
//  ProtegeTakeHome
//

import Foundation

/// Simulates a remote chat API by generating random messages.
final class MockChatAPI: ChatAPI {
    
    func fetchMessages(for chat: Chat, interval: DateInterval) async throws -> [Message] {
        let delay = UInt64.random(in: 0..<2)
        try await Task.sleep(nanoseconds: 1_000_000_000 * delay)
        let messages = Message.generateFakeMessages(startDate: interval.start,
                                                    endDate: interval.end,
                                                    primarySender: chat.primarySender,
                                                    secondarySender: chat.secondarySender)
        return messages
    }
}

fileprivate extension Message {
    
    static func makeRandom(date: Date, sender: MessageSender) -> Message {
        let sentence = TextGenerator.shared.randomSentence(count: Int.random(in: 1...7))
        let message = Message(date: date, content: sentence, sender: sender)
        return message
    }
    
    static func generateFakeMessages(
        startDate: Date,
        endDate: Date,
        primarySender: MessageSender,
        secondarySender: MessageSender,
        interval: TimeInterval = 30 * 60,
        variation: TimeInterval = 60 * 60
    ) -> [Message] {
        let dates = stride(from: startDate.timeIntervalSince1970,
                           to: endDate.timeIntervalSince1970,
                           by: interval)

        return dates.map { time in
            let randomVariation = Double.random(in: -(variation)...(variation))
            let fakeTime = max(startDate.timeIntervalSince1970, min(time + randomVariation, endDate.timeIntervalSince1970))
            let fakeDate = Date(timeIntervalSince1970: fakeTime)
            let sender = Bool.random() ? primarySender : secondarySender
                
            return Message.makeRandom(date: fakeDate, sender: sender)
        }
    }
}

fileprivate struct TextGenerator {
    static let shared = TextGenerator()
    
    private let words: [String]
    
    init() {
        let languageList = Locale.isoLanguageCodes.compactMap { Locale.current.localizedString(forLanguageCode: $0) }
        let countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
        let emojis = (0x1F601...0x1F64F).map({ String(UnicodeScalar($0) ?? "-") })
        self.words = languageList + countryList + emojis
    }
    
    func randomWord() -> String {
        words.randomElement()!
    }
    
    func randomSentence(count: Int) -> String {
        return String(
            (0..<count)
            .map({ _ in randomWord() })
            .joined(separator: " ")
            .appending(["", "", ".", "!", "?"].randomElement()!)
            .capitalizingFirstLetter()
        )
    }
}

fileprivate extension String {
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

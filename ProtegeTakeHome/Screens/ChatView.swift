//
//  ChatView.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/22/22.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        if viewModel.isLoadingChatMessages {
            PTHLoadingView()
                .task {
                    do {
                        try await viewModel.fetchChatMessages()
                    } catch {
                        print(PTHError.unableToFetchMessages)
                    }
                }
        } else {
            VStack {
                ScrollView {
                    VStack {
                        ForEach(viewModel.chatMessages) { message in
                            if message.sender == viewModel.primaryMessenger {
                                PTHPrimaryMessageContainerView(messageText: message.content)
                            } else {
                                PTHSecondaryMessageContainerView(messageText: message.content)
                            }
                        }
                    }
                    .padding()
                }
                
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
